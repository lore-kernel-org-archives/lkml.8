Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFBCC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C158F2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338899;
	bh=bs7zV+hgjNQ75C7vmQpMka+XTmvJdnhnoCWjM+jttnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c179M9ozHv0UaepeBScY6D3/5YZuiDIBqVE4RnUI++eNu6dtTiZ8i7D8nTmxz53vs
	 UCcb+DjnREKl+dxDEpmWxRTowJfXzcnVPU0r4Z4CeNeKosdgAkU2jjFkyt3DoijqZB
	 +4zORofz0IxWqD1RHF6DfebSkqaNHF9OVPbDVrt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgBJMr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730176AbgBJMmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:42:11 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 154B924649;
        Mon, 10 Feb 2020 12:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338531;
        bh=bs7zV+hgjNQ75C7vmQpMka+XTmvJdnhnoCWjM+jttnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJab2h2BhRcawG/MEAFlgU1iTecBzIwSMotP9CuGjSb2ASH+fPDqCdppf383outUC
         a4+3h05WqtGXSunYn3eckEhljD3zJWc4Cs1odk13VhDlOkA+v4uH4q6GgJJJ5JqU2f
         iGHvjDWk9VNBtWfgY8nt2jT20FIu80Lh6hIDzFIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 355/367] io_uring: prevent potential eventfd recursion on poll
Date:   Mon, 10 Feb 2020 04:34:28 -0800
Message-Id: <20200210122455.231348976@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit f0b493e6b9a8959356983f57112229e69c2f7b8c ]

If we have nested or circular eventfd wakeups, then we can deadlock if
we run them inline from our poll waitqueue wakeup handler. It's also
possible to have very long chains of notifications, to the extent where
we could risk blowing the stack.

Check the eventfd recursion count before calling eventfd_signal(). If
it's non-zero, then punt the signaling to async context. This is always
safe, as it takes us out-of-line in terms of stack and locking context.

Cc: stable@vger.kernel.org # 5.1+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 131087782bec9..f470fb21467e4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -738,21 +738,28 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
 
 static inline bool io_should_trigger_evfd(struct io_ring_ctx *ctx)
 {
+	if (!ctx->cq_ev_fd)
+		return false;
 	if (!ctx->eventfd_async)
 		return true;
 	return io_wq_current_is_worker() || in_interrupt();
 }
 
-static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
+static void __io_cqring_ev_posted(struct io_ring_ctx *ctx, bool trigger_ev)
 {
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
 	if (waitqueue_active(&ctx->sqo_wait))
 		wake_up(&ctx->sqo_wait);
-	if (ctx->cq_ev_fd && io_should_trigger_evfd(ctx))
+	if (trigger_ev)
 		eventfd_signal(ctx->cq_ev_fd, 1);
 }
 
+static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
+{
+	__io_cqring_ev_posted(ctx, io_should_trigger_evfd(ctx));
+}
+
 /* Returns true if there are no backlogged entries after the flush */
 static bool io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
 {
@@ -2645,6 +2652,14 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 		io_wq_assign_next(workptr, nxt);
 }
 
+static void io_poll_trigger_evfd(struct io_wq_work **workptr)
+{
+	struct io_kiocb *req = container_of(*workptr, struct io_kiocb, work);
+
+	eventfd_signal(req->ctx->cq_ev_fd, 1);
+	io_put_req(req);
+}
+
 static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 			void *key)
 {
@@ -2667,13 +2682,21 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	 * for finalizing the request, mark us as having grabbed that already.
 	 */
 	if (mask && spin_trylock_irqsave(&ctx->completion_lock, flags)) {
+		bool trigger_ev;
+
 		hash_del(&req->hash_node);
 		io_poll_complete(req, mask, 0);
-		req->flags |= REQ_F_COMP_LOCKED;
-		io_put_req(req);
+		trigger_ev = io_should_trigger_evfd(ctx);
+		if (trigger_ev && eventfd_signal_count()) {
+			trigger_ev = false;
+			req->work.func = io_poll_trigger_evfd;
+		} else {
+			req->flags |= REQ_F_COMP_LOCKED;
+			io_put_req(req);
+			req = NULL;
+		}
 		spin_unlock_irqrestore(&ctx->completion_lock, flags);
-
-		io_cqring_ev_posted(ctx);
+		__io_cqring_ev_posted(ctx, trigger_ev);
 	} else {
 		io_queue_async_work(req);
 	}
-- 
2.20.1



