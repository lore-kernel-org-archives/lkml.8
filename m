Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E1DC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B42E20731
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ko8kSvtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgEARyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729291AbgEARyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:54:01 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BB9C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:53:59 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id m5so5132824ilj.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dNu8cTkVAel6kkIGd2Z1GoaI4LYxnwwQdrPVYtjvHuw=;
        b=Ko8kSvtMTznmK4Pf/hYlBVtXpXbakAslYsizbJWGK6s9mR+8XttduJDjCpzEuhiZkK
         Eaa6sEKnLEMT8WnLO/zYng0Cn/lyszxih7Hi3OvU/kaMp5isJXjd/UNhj4GI980hRNYm
         GwbWdwXet0IrfXdQBDs2EznAzJw5yIgBKUjgo2aIICzbYqU9/t6OEuHoTrGUuj9CZ/N/
         MzGu4UbfL8ahyEum8KspIt3Bb7LKUn6TYm/27wKU7JY2AtvoVKScLE1BW4cXECsw+dgJ
         yNODVmAL8cPoae2PlQpjkM5A8/V7EgWgfkvKrXx359Dq9tTZlYJPUz1baUDPiv5Op+XI
         wJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=dNu8cTkVAel6kkIGd2Z1GoaI4LYxnwwQdrPVYtjvHuw=;
        b=rx//GvzyG8GIZUOgjf5+GPwBMnbXjQ3fD3nNDN3u32vEyhBbEtXx50Dbg1FQ89Pk4S
         XJ57ZOzlJD4U0V5rNG//z+g1I18EtRAN15GxsfRwFGhUImvnnOhG8w+0Q1tzDzDY0SRA
         ztoAk6xYPkY8Ha7mz1obYovVXIVHY3Tdp2fsfOYFvKMXiklIdaZK2SVtOH7DHbFp40qk
         TBkFZj0QyLfwSlPghDkxRyKksXC1rkPvfXXVkAZ8tU8gO1ZEjVaSUMtmG1VSYSUnQMzt
         u28JLI133S0ugx+MUdUQldHm8BuLrs1obX7f0EFTtk1zrWASgSlbvpEPq/qixinK+0Il
         nEog==
X-Gm-Message-State: AGi0Puask7f3dDIBJQozBc4tTkLRjP6rsbpt9bK7cs71327nyLcAy22o
        Yho6qwHlu3thaJWYl+1eIIdtGy9OYpBRoQ==
X-Google-Smtp-Source: APiQypKOBb5wGUM5qyn893wxbiA3WMRiRsUfPWjKE3lKl98+s0INI+P8z8hyG+flyiXESNHGrgJpWA==
X-Received: by 2002:a92:aa0f:: with SMTP id j15mr4792191ili.211.1588355638429;
        Fri, 01 May 2020 10:53:58 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 140sm1506810ilc.44.2020.05.01.10.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:53:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3v] eventfd: convert to f_op->read_iter()
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <7e9c4447-d7b4-2753-ad28-a668e3ce370a@kernel.dk>
Date:   Fri, 1 May 2020 11:53:57 -0600
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

Actually send out the right patch...

Since v2:

- Cleanup eventfd_read() as per Al's suggestions

Since v1:

- Add FMODE_NOWAIT to the eventfd file

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 78e41c7c3d05..c9fa1e9cf5e3 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -216,32 +216,32 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *w
 }
 EXPORT_SYMBOL_GPL(eventfd_ctx_remove_wait_queue);
 
-static ssize_t eventfd_read(struct file *file, char __user *buf, size_t count,
-			    loff_t *ppos)
+static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct eventfd_ctx *ctx = file->private_data;
-	ssize_t res;
 	__u64 ucnt = 0;
 	DECLARE_WAITQUEUE(wait, current);
 
-	if (count < sizeof(ucnt))
+	if (iov_iter_count(to) < sizeof(ucnt))
 		return -EINVAL;
-
 	spin_lock_irq(&ctx->wqh.lock);
-	res = -EAGAIN;
-	if (ctx->count > 0)
-		res = sizeof(ucnt);
-	else if (!(file->f_flags & O_NONBLOCK)) {
+	if (!ctx->count) {
+		if ((file->f_flags & O_NONBLOCK) ||
+		    (iocb->ki_flags & IOCB_NOWAIT)) {
+			spin_unlock_irq(&ctx->wqh.lock);
+			return -EAGAIN;
+		}
 		__add_wait_queue(&ctx->wqh, &wait);
 		for (;;) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (ctx->count > 0) {
-				res = sizeof(ucnt);
+			if (ctx->count)
 				break;
-			}
 			if (signal_pending(current)) {
-				res = -ERESTARTSYS;
-				break;
+				__remove_wait_queue(&ctx->wqh, &wait);
+				__set_current_state(TASK_RUNNING);
+				spin_unlock_irq(&ctx->wqh.lock);
+				return -ERESTARTSYS;
 			}
 			spin_unlock_irq(&ctx->wqh.lock);
 			schedule();
@@ -250,17 +250,14 @@ static ssize_t eventfd_read(struct file *file, char __user *buf, size_t count,
 		__remove_wait_queue(&ctx->wqh, &wait);
 		__set_current_state(TASK_RUNNING);
 	}
-	if (likely(res > 0)) {
-		eventfd_ctx_do_read(ctx, &ucnt);
-		if (waitqueue_active(&ctx->wqh))
-			wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
-	}
+	eventfd_ctx_do_read(ctx, &ucnt);
+	if (waitqueue_active(&ctx->wqh))
+		wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
 	spin_unlock_irq(&ctx->wqh.lock);
-
-	if (res > 0 && put_user(ucnt, (__u64 __user *)buf))
+	if (unlikely(copy_to_iter(&ucnt, sizeof(ucnt), to) != sizeof(ucnt)))
 		return -EFAULT;
 
-	return res;
+	return sizeof(ucnt);
 }
 
 static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t count,
@@ -329,7 +326,7 @@ static const struct file_operations eventfd_fops = {
 #endif
 	.release	= eventfd_release,
 	.poll		= eventfd_poll,
-	.read		= eventfd_read,
+	.read_iter	= eventfd_read,
 	.write		= eventfd_write,
 	.llseek		= noop_llseek,
 };
@@ -427,8 +424,17 @@ static int do_eventfd(unsigned int count, int flags)
 
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

