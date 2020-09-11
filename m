Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0924BC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A308B208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="I6Wa6qSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgIKQfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgIKQfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:35:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14243C061796
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:34:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so12134265wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wulnUlhSwjyVg7HlchQMtmSPVSZJX7Gl9pTHnw54ME=;
        b=I6Wa6qSLug9wEb+0TV6tW9xlypmmgNWh4CFQZm00Syc3U4tMukiAY/znsvfFTwFmB1
         1QYXXx3qf/WNKeIyR6oMx6LYCWuBApznuhNplBl36ycCMaHafe+IsTGMb/u26GQGxZpg
         KPTpobARRAkNGLlG5Fb1HXBEVAXoD2n5Tex57gI9T9W2DPCK3kSlwVkB1+9T9tGbG8yO
         wyrH1BPSZE9Go00wkVl58kLmaOS7facMaXB6iHJTpq/xflw6wvTFbQamKQuyeC25IPnl
         NhpQr4sjyqBhACPw8SrPvt4M9yuNUTYVue5+C48LyRj249xVi4C0lQb8xURL/uvdyDzq
         zfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4wulnUlhSwjyVg7HlchQMtmSPVSZJX7Gl9pTHnw54ME=;
        b=iuN9zL6YE6yvEwwyYpealWEJMeByNbV9epzcC0jEryhcw+HQUVyupfer9c7Q5boe1U
         VjpIsRM06HeoNhdlovoB5lcQNTX7r4YcVMzisEzcbdwsXkZBECiChUe+pTvTl9rvMD1C
         Sej5k4j6WUou/MFRLUAX/Xq2JW2qw5M9J6LcC/EEeuRwQR95PgF+Zki9QLRY43qZ5MRP
         VxWrT5Btn+bDVHyI+rvDRBeTFd/u6v3N+4qeyw23s8WAkb+Wh0+G3kzR6MP0COj2Wtgd
         jNV+258vKLOEQ6GjXgEVaT7Uk2uqwFlQ0qL14awAuIUUlFXQQr1xiTewLdhD3WsX4nMh
         Iisg==
X-Gm-Message-State: AOAM531KTVTlkDaS1RxvCvdbSvDdfZtU1lBif5No5dPJ6TdrsWGQevLo
        9xCfhl97NU6lV4nz4/pcHaxy7A==
X-Google-Smtp-Source: ABdhPJyQWGLtZbe080SwFFjJ3XMNqhwnrXdd/2Ra3CsBQQ2RSwbYfgAsTPhVb4vpmDovfbYT7fKc+A==
X-Received: by 2002:adf:fa0c:: with SMTP id m12mr2807414wrr.406.1599842092777;
        Fri, 11 Sep 2020 09:34:52 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id s2sm5739912wrw.96.2020.09.11.09.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 09:34:52 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V8 3/3] fuse: Handle AIO read and write in passthrough
Date:   Fri, 11 Sep 2020 17:34:03 +0100
Message-Id: <20200911163403.79505-4-balsini@android.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200911163403.79505-1-balsini@android.com>
References: <20200911163403.79505-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the passthrough feature by handling asynchronous IO both for read
and write operations.
When an AIO request is received, targeting a FUSE file with passthrough
functionality enabled, a new identical AIO request is created, the file
pointer of which is updated with the file pointer of the lower file system,
and the completion handler is set with a special AIO passthrough handler.
The lower file system AIO request is allocated in dynamic kernel memory
and, when it completes, the allocated memory is freed and the completion
signal is propagated to the FUSE AIO request by triggering its completion
callback as well.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/passthrough.c | 66 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 44a78e02f45d..87b57b26fd8a 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -2,10 +2,16 @@
 
 #include "fuse_i.h"
 
+#include <linux/aio.h>
 #include <linux/fs_stack.h>
 #include <linux/fsnotify.h>
 #include <linux/uio.h>
 
+struct fuse_aio_req {
+	struct kiocb iocb;
+	struct kiocb *iocb_fuse;
+};
+
 static void fuse_copyattr(struct file *dst_file, struct file *src_file,
 			  bool write)
 {
@@ -20,6 +26,32 @@ static void fuse_copyattr(struct file *dst_file, struct file *src_file,
 	}
 }
 
+static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req)
+{
+	struct kiocb *iocb = &aio_req->iocb;
+	struct kiocb *iocb_fuse = aio_req->iocb_fuse;
+	bool write = !!(iocb->ki_flags & IOCB_WRITE);
+
+	if (write) {
+		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
+				      SB_FREEZE_WRITE);
+		file_end_write(iocb->ki_filp);
+	}
+
+	fuse_copyattr(iocb_fuse->ki_filp, iocb->ki_filp, write);
+	iocb_fuse->ki_pos = iocb->ki_pos;
+	kfree(aio_req);
+}
+
+static void fuse_aio_rw_complete(struct kiocb *iocb, long res, long res2)
+{
+	struct fuse_aio_req *aio_req =
+		container_of(iocb, struct fuse_aio_req, iocb);
+	struct kiocb *iocb_fuse = aio_req->iocb_fuse;
+
+	fuse_aio_cleanup_handler(aio_req);
+	iocb_fuse->ki_complete(iocb_fuse, res, res2);
+}
 
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 				   struct iov_iter *iter)
@@ -42,7 +74,18 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 			fuse_copyattr(fuse_filp, passthrough_filp, false);
 
 	} else {
-		ret = -EIO;
+		struct fuse_aio_req *aio_req;
+
+		aio_req = kmalloc(sizeof(struct fuse_aio_req), GFP_KERNEL);
+		if (!aio_req)
+			return -ENOMEM;
+
+		aio_req->iocb_fuse = iocb_fuse;
+		kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
+		aio_req->iocb.ki_complete = fuse_aio_rw_complete;
+		ret = call_read_iter(passthrough_filp, &aio_req->iocb, iter);
+		if (ret != -EIOCBQUEUED)
+			fuse_aio_cleanup_handler(aio_req);
 	}
 
 	return ret;
@@ -56,6 +99,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 	struct fuse_file *ff = fuse_filp->private_data;
 	struct inode *fuse_inode = file_inode(fuse_filp);
 	struct file *passthrough_filp = ff->passthrough_filp;
+	struct inode *passthrough_inode = file_inode(passthrough_filp);
 
 	if (!iov_iter_count(iter))
 		return 0;
@@ -75,9 +119,25 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 		if (ret > 0)
 			fuse_copyattr(fuse_filp, passthrough_filp, true);
 	} else {
-		ret = -EIO;
-	}
+		struct fuse_aio_req *aio_req;
 
+		aio_req = kmalloc(sizeof(struct fuse_aio_req), GFP_KERNEL);
+		if (!aio_req) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		file_start_write(passthrough_filp);
+		__sb_writers_release(passthrough_inode->i_sb, SB_FREEZE_WRITE);
+
+		aio_req->iocb_fuse = iocb_fuse;
+		kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
+		aio_req->iocb.ki_complete = fuse_aio_rw_complete;
+		ret = call_write_iter(passthrough_filp, &aio_req->iocb, iter);
+		if (ret != -EIOCBQUEUED)
+			fuse_aio_cleanup_handler(aio_req);
+	}
+out:
 	inode_unlock(fuse_inode);
 
 	return ret;
-- 
2.28.0.618.gf4bc123cb7-goog

