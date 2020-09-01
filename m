Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245E9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA142078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975179;
	bh=Tyu91bH63gG6nmgdD1zZbuSXVaxKlvW0YzojL9UrOcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L8PA2hibgBWFWYfuMu1vkRl3CbuAQf+PvmtD4/fGhDr9EjmfeQoxGLgeoBdFuqpeV
	 vp1VqfXpG7rBYaWcIZAXR2gyLHeMNnHo4DWdCu6Iw0WU3tEF6ueMOnoMN+wsmQ4/eF
	 j1YcSUEOdyPn4XhFnMlpJQZdK1IqX7h5QoXTUjXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbgIAPqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731659AbgIAPnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:43:23 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39F9206EB;
        Tue,  1 Sep 2020 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598975002;
        bh=Tyu91bH63gG6nmgdD1zZbuSXVaxKlvW0YzojL9UrOcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWhjIEb7B4HjzxiFZBqykuoi7Mg/9906cchD1DEtBrt8kM4/U1tv30cNQ+XlIArp/
         WYLxnIS1KpIAwYY7A50O5/ZciM7aFyWFBW2RYPN8qA59QoJQq5oFENoy+IxjZkDru2
         FA1TJFD6bOZl6Oi9jNKPn2zbm0bxBWnXfmt1QHBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <rong.a.chen@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        David Jeffery <djeffery@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.8 171/255] blk-mq: order adding requests to hctx->dispatch and checking SCHED_RESTART
Date:   Tue,  1 Sep 2020 17:10:27 +0200
Message-Id: <20200901151008.889544975@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

commit d7d8535f377e9ba87edbf7fbbd634ac942f3f54f upstream.

SCHED_RESTART code path is relied to re-run queue for dispatch requests
in hctx->dispatch. Meantime the SCHED_RSTART flag is checked when adding
requests to hctx->dispatch.

memory barriers have to be used for ordering the following two pair of OPs:

1) adding requests to hctx->dispatch and checking SCHED_RESTART in
blk_mq_dispatch_rq_list()

2) clearing SCHED_RESTART and checking if there is request in hctx->dispatch
in blk_mq_sched_restart().

Without the added memory barrier, either:

1) blk_mq_sched_restart() may miss requests added to hctx->dispatch meantime
blk_mq_dispatch_rq_list() observes SCHED_RESTART, and not run queue in
dispatch side

or

2) blk_mq_dispatch_rq_list still sees SCHED_RESTART, and not run queue
in dispatch side, meantime checking if there is request in
hctx->dispatch from blk_mq_sched_restart() is missed.

IO hang in ltp/fs_fill test is reported by kernel test robot:

	https://lkml.org/lkml/2020/7/26/77

Turns out it is caused by the above out-of-order OPs. And the IO hang
can't be observed any more after applying this patch.

Fixes: bd166ef183c2 ("blk-mq-sched: add framework for MQ capable IO schedulers")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Jeffery <djeffery@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq-sched.c |    9 +++++++++
 block/blk-mq.c       |    9 +++++++++
 2 files changed, 18 insertions(+)

--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -77,6 +77,15 @@ void blk_mq_sched_restart(struct blk_mq_
 		return;
 	clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 
+	/*
+	 * Order clearing SCHED_RESTART and list_empty_careful(&hctx->dispatch)
+	 * in blk_mq_run_hw_queue(). Its pair is the barrier in
+	 * blk_mq_dispatch_rq_list(). So dispatch code won't see SCHED_RESTART,
+	 * meantime new request added to hctx->dispatch is missed to check in
+	 * blk_mq_run_hw_queue().
+	 */
+	smp_mb();
+
 	blk_mq_run_hw_queue(hctx, true);
 }
 
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1324,6 +1324,15 @@ bool blk_mq_dispatch_rq_list(struct requ
 		spin_unlock(&hctx->lock);
 
 		/*
+		 * Order adding requests to hctx->dispatch and checking
+		 * SCHED_RESTART flag. The pair of this smp_mb() is the one
+		 * in blk_mq_sched_restart(). Avoid restart code path to
+		 * miss the new added requests to hctx->dispatch, meantime
+		 * SCHED_RESTART is observed here.
+		 */
+		smp_mb();
+
+		/*
 		 * If SCHED_RESTART was set by the caller of this function and
 		 * it is no longer set that means that it was cleared by another
 		 * thread and hence that a queue rerun is needed.


