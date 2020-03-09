Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661A2C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A8220828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583783322;
	bh=Qn10r7wDKeypNpswGyjvqlxGn6R2+JzdLyxqbNYaR5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=gPIXFr8UMbG0TJpsGQyaH3svMw7O4WVsdILb6etDxDDgaHGvyltZxRlFdidFdl1IN
	 RSAy9lSuL78Jt8+KWE5q0//GQ7qlzaWRgURijfp7G6/Ts8nXRUoEUXDjuGTsktmfyt
	 QaRuLuzUYnyQ38deh9+cZtJ8oHHgjTx8Vtg4b0mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCITsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgCITsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:48:16 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5DE524656;
        Mon,  9 Mar 2020 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583783295;
        bh=Qn10r7wDKeypNpswGyjvqlxGn6R2+JzdLyxqbNYaR5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ej7ZwgcZQjIGEm4uJBDf7OGbLnonIrkQj41AShxp7CMw0Vz4lm7eggXB4sn/ibb9r
         A2qR5kejQs/yUCO3GsXD3sbsR12zuGA5FJIYqwXp2xrsEC9Yqp+xz++/nnEsbIGTxZ
         9bbeRBTi+rdHjPcGF9AHbNf99VyNKYHy0A73Zcbw=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     stable-rt@vger.kernel.org
Subject: [PATCH RT 1/8] userfaultfd: Use a seqlock instead of seqcount
Date:   Mon,  9 Mar 2020 14:47:46 -0500
Message-Id: <ef275aaeea4c9c1a75514eed061e29cb78a929c3.1583783251.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
In-Reply-To: <cover.1583783251.git.zanussi@kernel.org>
References: <cover.1583783251.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.172-rt78-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit dc952a564d02997330654be9628bbe97ba2a05d3 ]

On RT write_seqcount_begin() disables preemption which leads to warning
in add_wait_queue() while the spinlock_t is acquired.
The waitqueue can't be converted to swait_queue because
userfaultfd_wake_function() is used as a custom wake function.

Use seqlock instead seqcount to avoid the preempt_disable() section
during add_wait_queue().

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 fs/userfaultfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e2b2196fd9428..71886a8e8f71b 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -51,7 +51,7 @@ struct userfaultfd_ctx {
 	/* waitqueue head for events */
 	wait_queue_head_t event_wqh;
 	/* a refile sequence protected by fault_pending_wqh lock */
-	struct seqcount refile_seq;
+	seqlock_t refile_seq;
 	/* pseudo fd refcounting */
 	atomic_t refcount;
 	/* userfaultfd syscall flags */
@@ -1047,7 +1047,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			 * waitqueue could become empty if this is the
 			 * only userfault.
 			 */
-			write_seqcount_begin(&ctx->refile_seq);
+			write_seqlock(&ctx->refile_seq);
 
 			/*
 			 * The fault_pending_wqh.lock prevents the uwq
@@ -1073,7 +1073,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			list_del(&uwq->wq.entry);
 			__add_wait_queue(&ctx->fault_wqh, &uwq->wq);
 
-			write_seqcount_end(&ctx->refile_seq);
+			write_sequnlock(&ctx->refile_seq);
 
 			/* careful to always initialize msg if ret == 0 */
 			*msg = uwq->msg;
@@ -1246,11 +1246,11 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 	 * sure we've userfaults to wake.
 	 */
 	do {
-		seq = read_seqcount_begin(&ctx->refile_seq);
+		seq = read_seqbegin(&ctx->refile_seq);
 		need_wakeup = waitqueue_active(&ctx->fault_pending_wqh) ||
 			waitqueue_active(&ctx->fault_wqh);
 		cond_resched();
-	} while (read_seqcount_retry(&ctx->refile_seq, seq));
+	} while (read_seqretry(&ctx->refile_seq, seq));
 	if (need_wakeup)
 		__wake_userfault(ctx, range);
 }
@@ -1915,7 +1915,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 	init_waitqueue_head(&ctx->fault_wqh);
 	init_waitqueue_head(&ctx->event_wqh);
 	init_waitqueue_head(&ctx->fd_wqh);
-	seqcount_init(&ctx->refile_seq);
+	seqlock_init(&ctx->refile_seq);
 }
 
 /**
-- 
2.14.1

