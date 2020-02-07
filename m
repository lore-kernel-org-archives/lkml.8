Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A9AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D5A20726
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 19:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xerrw3TJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGTEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 14:04:23 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:38383 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGTEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 14:04:23 -0500
Received: by mail-pl1-f201.google.com with SMTP id t17so151305ply.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 11:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6k2s/kP7P/1oyMoKNfLB/ONi4ScN/Bk9jjz8tyC1cbQ=;
        b=Xerrw3TJoqDXADoGgj2sx6wHvUaaUIArxvt8DrAN0sH7iIlguYclxifJuhAnbJ/Kvh
         i2QngOz24wX0UtYXMQr95SsUCy5nw8VCPF0hMp44ab72te1u01umVExt3rsDeec6lMyq
         R5QEfJUeQH4tb7N+U6zuK90g1EVm2809dqCZXcVA23T1Pt5vQLTMORu1sfxCvovLSh6X
         HxM9VF1izK/ZGABW4J34BWDxh4XcGOxnzTGLe/gHVKu0Mb1k+JI99WpGZ5FP9i+hAwzI
         74879ppofWUivcJlPZuNC3YxTl3Jb5kW81HPW7IAgvLQnXEzAWarx8WCptPuPHxPT6eo
         Phpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6k2s/kP7P/1oyMoKNfLB/ONi4ScN/Bk9jjz8tyC1cbQ=;
        b=dzCugH7VPoEXLjHma0agqBYuq0ZB3QUsRC0UU3QzuQN7J4znyzTkYtFmPckLh5XH6R
         81aNegjiBob45Yu1GKe/ey+BhOIy/aNfegfP1TncwAyq3LZpCDTSzFvvmSm0ti6ewXWK
         wtxJ263Gbi9VV/0AMXiTu6ot+uEFc+SUW37NjGSiQRRRFobGwip8GDHhULqapJE2MY8f
         unf76PC5vgfJIfpkvxib2s6m6DpyGv+4+SRhRaQhXNfRVNikxo7IqoxpCKM5H5DjzllL
         wANj8jtP6a7dL0jhWU9XO/NDwFdo/Bdp+4MVBQIvBqQ1EX0+FC45zPTJdj+vx3wiBtyB
         2AGQ==
X-Gm-Message-State: APjAAAW6FZOkMF4Hu1s/aW73pLsXE29c5EKoAm4A6dasZXqmUbPDKii9
        uHVAZpvYxfRKSaQ/zwVrKFQZczIA1w==
X-Google-Smtp-Source: APXvYqyP+yVA+HDRl9WoIEfnIeP9t5JHk5Hv9UIckjFnXBqmjJ4nXrBlLXicseJ+cqKUZud5pqKHFf6DeQ==
X-Received: by 2002:a63:7b5a:: with SMTP id k26mr706109pgn.406.1581102260764;
 Fri, 07 Feb 2020 11:04:20 -0800 (PST)
Date:   Fri,  7 Feb 2020 11:04:16 -0800
In-Reply-To: <CAKUOC8X0OFqJ09Y+nrPQiMLiRjpKMm0Ucci_33UJEM8HvQ=H1Q@mail.gmail.com>
Message-Id: <20200207190416.99928-1-sqazi@google.com>
Mime-Version: 1.0
References: <CAKUOC8X0OFqJ09Y+nrPQiMLiRjpKMm0Ucci_33UJEM8HvQ=H1Q@mail.gmail.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] block: Limit number of items taken from the I/O scheduler in
 one go
From:   Salman Qazi <sqazi@google.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Salman Qazi <sqazi@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flushes bypass the I/O scheduler and get added to hctx->dispatch
in blk_mq_sched_bypass_insert.  This can happen while a kworker is running
hctx->run_work work item and is past the point in
blk_mq_sched_dispatch_requests where hctx->dispatch is checked.

The blk_mq_do_dispatch_sched call is not guaranteed to end in bounded time,
because the I/O scheduler can feed an arbitrary number of commands.

Since we have only one hctx->run_work, the commands waiting in
hctx->dispatch will wait an arbitrary length of time for run_work to be
rerun.

A similar phenomenon exists with dispatches from the software queue.

The solution is to poll hctx->dispatch in blk_mq_do_dispatch_sched and
blk_mq_do_dispatch_ctx and return from the run_work handler and let it
rerun.

Signed-off-by: Salman Qazi <sqazi@google.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 49 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ca22afd47b3d..3e78c5bbb4d9 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -84,12 +84,17 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
  * its queue by itself in its completion handler, so we don't need to
  * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
+ *
+ * Returns true if hctx->dispatch was found non-empty and
+ * run_work has to be run again.  This is necessary to avoid
+ * starving flushes.
  */
-static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	LIST_HEAD(rq_list);
+	bool ret = false;
 
 	do {
 		struct request *rq;
@@ -97,6 +102,11 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
 			break;
 
+		if (!list_empty_careful(&hctx->dispatch)) {
+			ret = true;
+			break;
+		}
+
 		if (!blk_mq_get_dispatch_budget(hctx))
 			break;
 
@@ -113,6 +123,8 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 */
 		list_add(&rq->queuelist, &rq_list);
 	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
+
+	return ret;
 }
 
 static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
@@ -130,16 +142,26 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
  * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
  * its queue by itself in its completion handler, so we don't need to
  * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
+ *
+ * Returns true if hctx->dispatch was found non-empty and
+ * run_work has to be run again.  This is necessary to avoid
+ * starving flushes.
  */
-static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
+static bool blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	LIST_HEAD(rq_list);
 	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
+	bool ret = false;
 
 	do {
 		struct request *rq;
 
+		if (!list_empty_careful(&hctx->dispatch)) {
+			ret = true;
+			break;
+		}
+
 		if (!sbitmap_any_bit_set(&hctx->ctx_map))
 			break;
 
@@ -165,6 +187,7 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
 
 	WRITE_ONCE(hctx->dispatch_from, ctx);
+	return ret;
 }
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
@@ -172,6 +195,8 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	const bool has_sched_dispatch = e && e->type->ops.dispatch_request;
+	bool run_again;
+	bool restarted = false;
 	LIST_HEAD(rq_list);
 
 	/* RCU or SRCU read lock is needed before checking quiesced flag */
@@ -180,6 +205,9 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 
 	hctx->run++;
 
+again:
+	run_again = false;
+
 	/*
 	 * If we have previous entries on our dispatch list, grab them first for
 	 * more fair dispatch.
@@ -208,19 +236,28 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		blk_mq_sched_mark_restart_hctx(hctx);
 		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
 			if (has_sched_dispatch)
-				blk_mq_do_dispatch_sched(hctx);
+				run_again = blk_mq_do_dispatch_sched(hctx);
 			else
-				blk_mq_do_dispatch_ctx(hctx);
+				run_again = blk_mq_do_dispatch_ctx(hctx);
 		}
 	} else if (has_sched_dispatch) {
-		blk_mq_do_dispatch_sched(hctx);
+		run_again = blk_mq_do_dispatch_sched(hctx);
 	} else if (hctx->dispatch_busy) {
 		/* dequeue request one by one from sw queue if queue is busy */
-		blk_mq_do_dispatch_ctx(hctx);
+		run_again = blk_mq_do_dispatch_ctx(hctx);
 	} else {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
 		blk_mq_dispatch_rq_list(q, &rq_list, false);
 	}
+
+	if (run_again) {
+		if (!restarted) {
+			restarted = true;
+			goto again;
+		}
+
+		blk_mq_run_hw_queue(hctx, true);
+	}
 }
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
-- 
2.25.0.341.g760bfbb309-goog

