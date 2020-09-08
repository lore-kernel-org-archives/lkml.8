Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D96C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6321D2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599589756;
	bh=Z7fcGyBzWC/5EPyO4e2m3x70szWWlKx1AVC3oQn09dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BkjoDENez8XRp3zQ2RIUVOCbADPoNmSpBKmEfYaRq11uwb3Xqdd+0HHSNb3zr/pPv
	 33t6k3uXvOrntwB3lhYVStiRpdQhJs98CyPv5DOFBMhp/oDhy7wWQiYCTx9CCHHph5
	 tVSsdR0472Tx8H5GZO5vfSCmuXR5BBSHchkP4yUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbgIHS3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731416AbgIHQKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:10:25 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C657B24721;
        Tue,  8 Sep 2020 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579639;
        bh=Z7fcGyBzWC/5EPyO4e2m3x70szWWlKx1AVC3oQn09dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHjQHO0aRQGxZEYVBixBXTXnlcLOqFBI63K5BoNjN1NFkzGHPApJpldRXDqiKOPV4
         E7wUa2NvqzDwWsXznt+vkUO806jrZFprI+UINmFwykz7TieC0AkFJx0YUUY+ceyqYx
         ZAOqYxET5SEaAc2D7W0MFc7Z34Y0jpTsP6nKM0mA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.8 160/186] blk-stat: make q->stats->lock irqsafe
Date:   Tue,  8 Sep 2020 17:25:02 +0200
Message-Id: <20200908152249.419945317@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

commit e11d80a849e010f78243bb6f6af7dccef3a71a90 upstream.

blk-iocost calls blk_stat_enable_accounting() while holding an irqsafe lock
which triggers a lockdep splat because q->stats->lock isn't irqsafe. Let's
make it irqsafe.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: cd006509b0a9 ("blk-iocost: account for IO size when testing latencies")
Cc: stable@vger.kernel.org # v5.8+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-stat.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -137,6 +137,7 @@ void blk_stat_add_callback(struct reques
 			   struct blk_stat_callback *cb)
 {
 	unsigned int bucket;
+	unsigned long flags;
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
@@ -147,20 +148,22 @@ void blk_stat_add_callback(struct reques
 			blk_rq_stat_init(&cpu_stat[bucket]);
 	}
 
-	spin_lock(&q->stats->lock);
+	spin_lock_irqsave(&q->stats->lock, flags);
 	list_add_tail_rcu(&cb->list, &q->stats->callbacks);
 	blk_queue_flag_set(QUEUE_FLAG_STATS, q);
-	spin_unlock(&q->stats->lock);
+	spin_unlock_irqrestore(&q->stats->lock, flags);
 }
 
 void blk_stat_remove_callback(struct request_queue *q,
 			      struct blk_stat_callback *cb)
 {
-	spin_lock(&q->stats->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->stats->lock, flags);
 	list_del_rcu(&cb->list);
 	if (list_empty(&q->stats->callbacks) && !q->stats->enable_accounting)
 		blk_queue_flag_clear(QUEUE_FLAG_STATS, q);
-	spin_unlock(&q->stats->lock);
+	spin_unlock_irqrestore(&q->stats->lock, flags);
 
 	del_timer_sync(&cb->timer);
 }
@@ -183,10 +186,12 @@ void blk_stat_free_callback(struct blk_s
 
 void blk_stat_enable_accounting(struct request_queue *q)
 {
-	spin_lock(&q->stats->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&q->stats->lock, flags);
 	q->stats->enable_accounting = true;
 	blk_queue_flag_set(QUEUE_FLAG_STATS, q);
-	spin_unlock(&q->stats->lock);
+	spin_unlock_irqrestore(&q->stats->lock, flags);
 }
 EXPORT_SYMBOL_GPL(blk_stat_enable_accounting);
 


