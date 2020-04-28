Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D624BC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11D1205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IsqZV3ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgD1TXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728721AbgD1TXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:23:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA09C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:23:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so1730071pjw.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=OVHn25m1rXONeTdBuF77i6ynAjN0Wbhww5ld++Llzz8=;
        b=IsqZV3cawkDUt/TDgeoP8vH3TtAjDUbo78l/2J8Xy9HAkL7h3ua1Z5AQWwOlVZgaPD
         hxT/FmGNproQ/dGSMSwGS15sk5kXE1+1gw3FB4AmgCZKcSXBLGrcPoaY5xjsDffPlnNY
         A42sSAAprmblMA0o3l7WNyN5E2ZLxGif2UGftk/Gw2WjFDQ+cLFVKL9wJDyqZ7FJCZKV
         2tqUO3FACCrdr2kNUf2j3rkXS2nvbFvmtvtvRIwcZ2FShCyQmERGSQ7ruCxLJ7SpF1jK
         cYP8rA5+jn525BettZ+MR2NTvOvlaYMQ4KgW49CUssQjtPjqvBJpA+emypk0jhHQ12pv
         YTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=OVHn25m1rXONeTdBuF77i6ynAjN0Wbhww5ld++Llzz8=;
        b=dLjDBfBvIdvsZzMazSEZf2iftRnnwA8JRA+8vFrdk7GoguT/y8p6OAeMh5YfoMRc7e
         Cd6x+keTml2fqYZivBcq5xKkduFwD4M9hYd6x8pa0cKar67e5rsPsRgLmeWLSKB9AGv6
         sNxgB8XVub2XgHD3dq/q02UITu0pIjNWikAkKFGgFeVIoNyqW58yX1huIGSRSoX9UGN1
         z4z12w1luKNK63pLRf3gprh73lt5Sw9SKlO4T6TXf1L2YOr9ce0qG7AlOpxHrbH3tA+X
         TksMq46dSFzwGd65hZjSjQHzjv9FBdaF5lgruzy+LOlsk/GPw4NgRV5MYi+G0wRIxUAq
         sVDA==
X-Gm-Message-State: AGi0PuYX1WDCoEazTYTkWmdGZ6sZZwbiqsSgrGjGw1pzzkCyN0NmtO5F
        KALYJNlH80mro24FfuPOp43VD0aBO6OWJw==
X-Google-Smtp-Source: APiQypIBs40wPHOpqo5F5u5+a2SFDpOPxGam1zVCq3znDZcP8g99aYqr75JkPShIKhdOLL3yr0+4/w==
X-Received: by 2002:a17:902:784c:: with SMTP id e12mr29906609pln.191.1588101821124;
        Tue, 28 Apr 2020 12:23:41 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21cf::1225? ([2620:10d:c090:400::5:7a1a])
        by smtp.gmail.com with ESMTPSA id i4sm3321793pgd.9.2020.04.28.12.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 12:23:40 -0700 (PDT)
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] eventfd: convert to f_op->read_iter()
Message-ID: <3c9c3541-c97c-76a8-086d-59a8b2ae95de@kernel.dk>
Date:   Tue, 28 Apr 2020 13:23:39 -0600
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

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 78e41c7c3d05..a4507424e80c 100644
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

-- 
Jens Axboe

