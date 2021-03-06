<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>TMS | 编辑售票点</title>
    <%@include file="../include/css.jsp"%>
    <link rel="stylesheet" href="/static/plugins/uploader/webuploader.css">
    <style>
        .photo {
            width: 100%;
            height: 320px;
            border: 2px dashed #ccc;
            margin-top: 20px;
            text-align: center;
            line-height: 320px;
        }
    </style>
</head>
<body class="hold-transition skin-purple sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">

    <%@include file="../include/navhead.jsp"%>

    <!-- =============================================== -->

    <jsp:include page="../include/sider.jsp">
        <jsp:param name="menu" value="ticket_store"/>
    </jsp:include>


    <!-- =============================================== -->

    <!-- 右侧内容部分 -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                编辑售票点
            </h1>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="box">
                <div class="box-body">
                    <form method="post" id="saveForm">
                        <input type="hidden" name="id" value="${ticketStore.id}">
                        <input type="hidden" id="storeManagerAttachment" name="storeManagerAttachment" value="${ticketStore.storeManagerAttachment}">
                        <input type="hidden" id="storeAttachment" name="storeAttachment" value="${ticketStore.storeAttachment}">
                        <input type="hidden" name="storeAccountId" value="${ticketStore.storeAccountId}">
                        <div class="form-group">
                            <label>售票点名称</label>
                            <input type="text" class="form-control" name="storeName" value="${ticketStore.storeName}">
                        </div>
                        <div class="form-group">
                            <label>售票点地址</label>
                            <input type="text" class="form-control" name="storeAddress" value="${ticketStore.storeAddress}">
                        </div>
                        <div class="form-group">
                            <label>联系人</label>
                            <input type="text" class="form-control" name="storeManager" value="${ticketStore.storeManager}">
                        </div>
                        <div class="form-group">
                            <label>联系电话</label>
                            <input type="text" class="form-control" name="storeTel" value="${ticketStore.storeTel}">
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div id="picker">选择联系人身份证照片</div>
                                <div class="photo" id="userPhoto">
                                    <img src="http://p7f6tjc1h.bkt.clouddn.com/${ticketStore.storeManagerAttachment}-preview" alt="">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div id="picker2">选择营业执照照片</div>
                                <div class="photo" id="storePhoto">
                                    <img src="http://p7f6tjc1h.bkt.clouddn.com/${ticketStore.storeAttachment}-preview" alt="">
                                </div>
                            </div>
                        </div>

                    </form>
                </div>
                <div class="box-footer">
                    <button class="btn btn-primary pull-right" id="saveBtn">保存</button>
                </div>
            </div>
        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</div>
<!-- ./wrapper -->

<%@include file="../include/js.jsp"%>
<script src="/static/plugins/uploader/webuploader.min.js"></script>
<script src="/static/plugins/layer/layer.js"></script>
<script>
    $(function () {

        $("#saveBtn").click(function () {
            $("#saveForm").submit();
        });


        // 初始化Web Uploader
        var uploader = WebUploader.create({
            // 选完文件后，是否自动上传。
            auto: true,
            // swf文件路径
            swf: '/static/plugins/uploader/Uploader.swf',
            // 文件接收服务端。
            server: 'http://upload-z1.qiniup.com',
            fileVal:'file',
            formData:{
                "token":"${uploadToken}"
            },
            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#picker',
            // 只允许选择图片文件。
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            }
        });
        var index = -1;

        uploader.on( 'uploadStart', function( file ) {
            index = layer.load(1);
        });

        uploader.on( 'uploadSuccess', function( file,response ) {
            $("#userPhoto").html("");

            var fileName = response.key;
            var $img = $("<img>").attr("src","http://p7f6tjc1h.bkt.clouddn.com/"+fileName+"-preview");
            $img.appendTo($("#userPhoto"));

            //将key存放到隐藏域中
            $("#storeManagerAttachment").val(fileName);
            layer.msg("上传成功");
        });

        uploader.on( 'uploadError', function( file ) {
            layer.msg("服务器异常");
        });

        uploader.on( 'uploadComplete', function( file ) {
            layer.close(index);
        });


        // 初始化Web Uploader
        var uploader2 = WebUploader.create({
            // 选完文件后，是否自动上传。
            auto: true,
            // swf文件路径
            swf: '/static/plugins/uploader/Uploader.swf',
            // 文件接收服务端。
            server: 'http://upload-z1.qiniup.com',
            fileVal:'file',
            formData:{
                "token":"${uploadToken}"
            },
            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#picker2',
            // 只允许选择图片文件。
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            }
        });

        uploader2.on( 'uploadStart', function( file ) {
            index = layer.load(1);
        });

        uploader2.on( 'uploadSuccess', function( file,response ) {
            $("#storePhoto").html("");
            var fileName = response.key;
            var $img = $("<img>").attr("src","http://p7f6tjc1h.bkt.clouddn.com/"+fileName+"-preview");
            $img.appendTo($("#storePhoto"));

            //将key存放到隐藏域中
            $("#storeAttachment").val(fileName);
            layer.msg("上传成功");
        });

        uploader2.on( 'uploadError', function( file ) {
            layer.msg("服务器异常");
        });

        uploader2.on( 'uploadComplete', function( file ) {
            layer.close(index);
        });








    });
</script>
</body>
</html>
