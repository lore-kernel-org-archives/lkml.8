Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87789C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE802137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FpzpiJAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbgEARSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729246AbgEARSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:18:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C11BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:18:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l20so4805808pgb.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QDlWf9LzZNbk9dgJ+RBVnfsnQ3+A0mxSDEKIw0bzaco=;
        b=FpzpiJAjtrsI5WVV4SKUJKHzij1rnmdtadoDsR0qqk+CXqE/hUHWXsPL2oRuS5hZOA
         aONes5w4zEx6gmkZDZ6e+DDNyY6oF1sBt8OTtkCNHUF7lIpD793t1sJeXqTogQzRv1FF
         rQVS4UbK3usuavte361SjI3SyujPmUqmJQaBjPO2z569bDBeC1Au4je5MaiW2UZo7e0A
         c0t+3N2zecfZcjev5eK3OlU9k0rqur4pKZOp57pJMLMFZVQ2Gcq8V9DtbUU15VXWgiWb
         aAODoOXCfGrarLxotuNODA72LF/1aktUrRpZ0A499uAy6tKJ+aez5X8Cu3PlM0p5KlhW
         15gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QDlWf9LzZNbk9dgJ+RBVnfsnQ3+A0mxSDEKIw0bzaco=;
        b=Cq9J+EWng1zagK1sf6Acb3rNm5zjDLq2cl3eiB020oCu3umErDumnfBuKhb4oW1sYM
         y2eW58KZVqhEs7GBgBkivr+btl26MSouMLgmkx/MB5atpSO2xUdQEHYpk0awXgHFgMf9
         fxPvspt8bDp6UZN15GJAePsmPK0mC8XGAHFpk22rWLwOtroig2i7NNoMuo8DGA9VdD/8
         S7nmX37SurtN67UQyrVDpda8QG5TixUrpLTmki7tHhBtp/sUrtIyPsICCZKwzV5n6A60
         3UN0bUWe4jT+SyVnKeHRjV6lge8PESrOGkRTszzTEgTeHRkPFpVl4rXaxfw1OmaojqL7
         b4Jg==
X-Gm-Message-State: AGi0Puah44S18KFEnOSMCzOzfOZdEXaOXwPgFDdHJtO/cIuYKhSEhjK1
        FLYKnoQavEP6H9hNkFlr026Nul7skl9QXg==
X-Google-Smtp-Source: APiQypIbVNlKonsbj1FeJLncadYmaCauJ4vAfbpeDxwqDEqE4vTJNbAUdn7MtIgDmvTSQ6gmVXXCGQ==
X-Received: by 2002:aa7:9a87:: with SMTP id w7mr5070915pfi.47.1588353487288;
        Fri, 01 May 2020 10:18:07 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c1::158c? ([2620:10d:c090:400::5:bb5c])
        by smtp.gmail.com with ESMTPSA id i72sm2915863pfe.104.2020.05.01.10.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:18:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] eventfd: convert to f_op->read_iter()
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <c71b2091-a86e-cc81-056d-de2f1e839f50@kernel.dk>
Date:   Fri, 1 May 2020 11:18:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eventfd is using ->read() as it's file_operations read handler, but
this prevents passing in information about whether a given IO operation
is blocking or not. We can only use the file flags for that. To support
async (-EAGAIN/poll based) retries for io_uring, we need ->read_iter()
support. Convert eventfd to using ->read_iter().

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Since v1:

- Add FMODE_NOWAIT to the eventfd file

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 78e41c7c3d05..d590c2141d39 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -216,10 +216,11 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *w
 }
 EXPORT_SYMBOL_GPL(eventfd_ctx_remove_wait_queue);
 
-static ssize_t eventfd_read(struct file *file, char __user *buf, size_t count,
-			    loff_t *ppos)
+static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *iov)
 {
+	struct file *file = iocb->ki_filp;
 	struct eventfd_ctx *ctx = file->private_data;
+	size_t count = iov_iter_count(iov);
 	ssize_t res;
 	__u64 ucnt = 0;
 	DECLARE_WAITQUEUE(wait, current);
@@ -231,7 +232,8 @@ static ssize_t eventfd_read(struct file *file, char __user *buf, size_t count,
 	res = -EAGAIN;
 	if (ctx->count > 0)
 		res = sizeof(ucnt);
-	else if (!(file->f_flags & O_NONBLOCK)) {
+	else if (!(file->f_flags & O_NONBLOCK) &&
+		 !(iocb->ki_flags & IOCB_NOWAIT)) {
 		__add_wait_queue(&ctx->wqh, &wait);
 		for (;;) {
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -257,7 +259,7 @@ static ssize_t eventfd_read(struct file *file, char __user *buf, size_t count,
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
 
-	if (res > 0 && put_user(ucnt, (__u64 __user *)buf))
+	if (res > 0 && copy_to_iter(&ucnt, res, iov) < res)
 		return -EFAULT;
 
 	return res;
@@ -329,7 +331,7 @@ static const struct file_operations eventfd_fops = {
 #endif
 	.release	= eventfd_release,
 	.poll		= eventfd_poll,
-	.read		= eventfd_read,
+	.read_iter	= eventfd_read,
 	.write		= eventfd_write,
 	.llseek		= noop_llseek,
 };
@@ -427,8 +429,17 @@ static int do_eventfd(unsigned int count, int flags)
 
 	fd = anon_inode_getfd("[eventfd]", &eventfd_fops, ctx,
 			      O_RDWR | (flags & EFD_SHARED_FCNTL_FLAGS));
-	if (fd < 0)
+	if (fd < 0) {
 		eventfd_free_ctx(ctx);
+	} else {
+		struct file *file;
+
+		file = fget(fd);
+		if (file) {
+			file->f_mode |= FMODE_NOWAIT;
+			fput(file);
+		}
+	}
 
 	return fd;
 }

-- 
Jens Axboe

