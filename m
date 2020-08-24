Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1F7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C35B22B49
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258411;
	bh=J0/8psHqkcXmla2yHdL0e3lJZ5L+/bmM4h8z9edyFBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T3KFun3a0Z2vZOFtDkQU7Bd/sufkvQ/cVUzN0sR3yp90FhfP5pPDm+sTU7MQnQQOO
	 v1EZf7TNP4lLnctzM2CyDaZstXeX3okbJpyTkp7vNI0e9ZuwTuDW5OSDlzLcvUc+ox
	 iZoiPYDJbsZ5Bj4OeeRqXzuVxEMR2YbtI2c8v0MI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgHXIkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbgHXIjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:39:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58A772177B;
        Mon, 24 Aug 2020 08:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258393;
        bh=J0/8psHqkcXmla2yHdL0e3lJZ5L+/bmM4h8z9edyFBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/JqG199y7//9Aw/gV/V4hybLyy6UBVu+D988aPeO115XDP/O5XmCWph4FjoO3Hsi
         ECY/dwyNh06EmCZe0k2ARm1KUr46ttFuG5CKwlOQihwa3/c+hOLlAd4RV/vNAzaX3v
         Uxps1pTHvQiqqjIB/szEVgYUSCt7oQee+i0T6rfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 030/124] io_uring: cancel all tasks requests on exit
Date:   Mon, 24 Aug 2020 10:29:24 +0200
Message-Id: <20200824082410.897068252@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit 44e728b8aae0bb6d4229129083974f9dea43f50b ]

If a process is going away, io_uring_flush() will cancel only 1
request with a matching pid. Cancel all of them

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io-wq.c    | 14 --------------
 fs/io-wq.h    |  1 -
 fs/io_uring.c | 14 ++++++++++++--
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 6d2e8ccc229e3..2bfa9117bc289 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -1022,20 +1022,6 @@ enum io_wq_cancel io_wq_cancel_work(struct io_wq *wq, struct io_wq_work *cwork)
 	return io_wq_cancel_cb(wq, io_wq_io_cb_cancel_data, (void *)cwork, false);
 }
 
-static bool io_wq_pid_match(struct io_wq_work *work, void *data)
-{
-	pid_t pid = (pid_t) (unsigned long) data;
-
-	return work->task_pid == pid;
-}
-
-enum io_wq_cancel io_wq_cancel_pid(struct io_wq *wq, pid_t pid)
-{
-	void *data = (void *) (unsigned long) pid;
-
-	return io_wq_cancel_cb(wq, io_wq_pid_match, data, false);
-}
-
 struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 {
 	int ret = -ENOMEM, node;
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 8902903831f25..df8a4cd3236db 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -129,7 +129,6 @@ static inline bool io_wq_is_hashed(struct io_wq_work *work)
 
 void io_wq_cancel_all(struct io_wq *wq);
 enum io_wq_cancel io_wq_cancel_work(struct io_wq *wq, struct io_wq_work *cwork);
-enum io_wq_cancel io_wq_cancel_pid(struct io_wq *wq, pid_t pid);
 
 typedef bool (work_cancel_fn)(struct io_wq_work *, void *);
 
diff --git a/fs/io_uring.c b/fs/io_uring.c
index cf32705546773..9bb23edf2363a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7720,6 +7720,13 @@ static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 	}
 }
 
+static bool io_cancel_pid_cb(struct io_wq_work *work, void *data)
+{
+	pid_t pid = (pid_t) (unsigned long) data;
+
+	return work->task_pid == pid;
+}
+
 static int io_uring_flush(struct file *file, void *data)
 {
 	struct io_ring_ctx *ctx = file->private_data;
@@ -7729,8 +7736,11 @@ static int io_uring_flush(struct file *file, void *data)
 	/*
 	 * If the task is going away, cancel work it may have pending
 	 */
-	if (fatal_signal_pending(current) || (current->flags & PF_EXITING))
-		io_wq_cancel_pid(ctx->io_wq, task_pid_vnr(current));
+	if (fatal_signal_pending(current) || (current->flags & PF_EXITING)) {
+		void *data = (void *) (unsigned long)task_pid_vnr(current);
+
+		io_wq_cancel_cb(ctx->io_wq, io_cancel_pid_cb, data, true);
+	}
 
 	return 0;
 }
-- 
2.25.1



