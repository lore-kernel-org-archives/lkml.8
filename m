Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2FFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593D12065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597679169;
	bh=KvOPUuswtjEN64kyvtbe3DNP5BXjGHn9igwDSi8vjr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tM8xlcnjJdjiZ73el7oYMXhkKnHTbQY6bQR2tvxxFws5zR6GkJl0yFoMGt66HYGLo
	 6PhCNKJ4iB/Fm9Op/Ft3TlNSVF1tsEecSOMSEcwm1Xozj/CXJYBTlMM7ytMuqxmErf
	 Y48VL4DLuwVk/+RmRYpFkevZhiGSpY1KZ3YbnepU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbgHQPp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:45:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730598AbgHQPiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:38:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B5422DD6;
        Mon, 17 Aug 2020 15:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678704;
        bh=KvOPUuswtjEN64kyvtbe3DNP5BXjGHn9igwDSi8vjr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTOACrsaquC7JkNBj3K9iYZFlj8EwCv+GrFH2zfEhOILDZmZbUqooHpysRokGHb7V
         HtI7N0fBaDq63a5pdmchSg765s8AbAyDg4QsFKmCvnqInth51ik6uM/2nqc8CZKmWZ
         Cm73gbxU5sTcDT0yXvFy0f+gaKunN84dHTDepKZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a730016dc0bdce4f6ff5@syzkaller.appspotmail.com,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.8 426/464] io_uring: fail poll arm on queue proc failure
Date:   Mon, 17 Aug 2020 17:16:19 +0200
Message-Id: <20200817143854.182187054@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit a36da65c46565d2527eec3efdb546251e38253fd upstream.

Check the ipt.error value, it must have been either cleared to zero or
set to another error than the default -EINVAL if we don't go through the
waitqueue proc addition. Just give up on poll at that point and return
failure, this will fallback to async work.

io_poll_add() doesn't suffer from this failure case, as it returns the
error value directly.

Cc: stable@vger.kernel.org # v5.7+
Reported-by: syzbot+a730016dc0bdce4f6ff5@syzkaller.appspotmail.com
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4483,7 +4483,7 @@ static bool io_arm_poll_handler(struct i
 
 	ret = __io_arm_poll_handler(req, &apoll->poll, &ipt, mask,
 					io_async_wake);
-	if (ret) {
+	if (ret || ipt.error) {
 		io_poll_remove_double(req, apoll->double_poll);
 		spin_unlock_irq(&ctx->completion_lock);
 		if (req->flags & REQ_F_WORK_INITIALIZED)


