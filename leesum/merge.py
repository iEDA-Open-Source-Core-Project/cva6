import os

# 设置环境变量 CVA6_REPO_DIR
os.environ["CVA6_REPO_DIR"] = "/home/leesum/workhome/cva6"
os.environ["TARGET_CFG"] = "cv64a6_imafdc_sv39"
cva6_repo_dir = os.environ["CVA6_REPO_DIR"]


flist_cva6 = os.path.join(cva6_repo_dir, "leesum", "Flist_leesum.cva6")


def is_comment(line):
    return line.startswith("//") or line.startswith("#") 


read_file = open(flist_cva6, "r")

# 读取文件内容
lines = read_file.readlines()
# 去除空行
lines = filter(lambda line: line.strip(), lines)
# 去除注释行
lines = filter(lambda line: not is_comment(line), lines)
# 更换环境变量
lines = map(lambda line: os.path.expandvars(line), lines)
# # 去掉开头的 +incdir+
# lines = map(lambda line: line.lstrip("+incdir+"), lines)


# for line in lines:
#     print(line.strip())


def write_file(fd, lines):
    for line in lines:
        print(line.strip())
        context = open(line.strip(), "r").read()
        context = remove_include(context)
        fd.write(context)

def remove_include(context):
    lines = context.split("\n")
    lines = filter(lambda line: not line.startswith("`include"), lines)
    return "\n".join(lines)


def get_file_paths(directory):
    file_paths = []
    for file_name in os.listdir(directory):
        print(file_name)
        file_path = os.path.join(directory, file_name)
        if os.path.isfile(file_path) :
            # pakage 文件放在最前面
            if file_path.endswith("_pkg.sv"):
                file_paths.insert(0, file_path)
            else:
                file_paths.append(file_path)
                
    return file_paths




print("start merge:ysyx_cva6.sv")
# 将文件内容写入到新文件中
file_fd = open("ysyx_cva6.sv", "w")
# 读取文件内容
for line in lines:
    if line.startswith("+incdir+"):
        inc_file = get_file_paths(line.lstrip("+incdir+").strip())
        write_file(file_fd, inc_file)
    else:
        write_file(file_fd, [line])
    
print("end merge!")
print("file no exist:")
for line in lines:
    if not os.path.exists(line.strip()):
        print(line.strip())

    
    