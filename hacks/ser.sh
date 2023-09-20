# 来源于网络，用于获取当前shell文件的路径
SOURCE="$0"
while [ -h "$SOURCE"  ]; do
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

cd "$DIR/../"

CGO_ENABLED=1 go build -trimpath -ldflags "$FLAGS" -v -o "bin/" ./cmd/...

cd "$DIR/../bin"



# PPROFLISTEN=localhost:65432 DENDRITE_TRACE_SQL=1 
./dendrite -really-enable-open-registration --tls-cert config/server.crt --tls-key config/server.key --config config/dev.yaml