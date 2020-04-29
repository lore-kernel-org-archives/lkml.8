Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C190DC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E64721BE5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ndqcocg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgD2Phl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2Phk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:37:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EECC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=sXpSQC80RbJimIFn7k9QnjpYkcm1HA9C9A9y23lRpTY=; b=Ndqcocg1le7/ChGlnYeLJyN28J
        cLh+LiNAuPfdjgp9Mk5uCbnO+94oCx/7r0E9U82FrroQPjA2+7ijOcnapaL8G2rLaLJxF2Rt2CH8a
        4fBTKCjyJDf+1el10ZDQ9QJio54MCesFPQnDgKE4YKV6107E+3M3a1y5qEiOdxFHZ8w+c00tW5eWo
        nEYaPHSUPOK9H/W8PteGlzRuAL06UNZzIQzz9bTbcYJXoK6nkNiOmZ2YEQBu0A/6mPhDX67Y2sCNF
        Np18PXMQrDYzQcQLB2Ay0MQ1l+ltYPKLXG7Jui7aP7ZMVnR0s+1I12dWuEHFwt4fYpWeVlbNfaN1t
        ykBOGYVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTomE-0006Kg-NZ; Wed, 29 Apr 2020 15:37:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 14ABB306118;
        Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D53C8236D79F0; Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Message-Id: <20200429153549.067459899@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Apr 2020 17:33:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [RFC][PATCH 2/7] rbtree, sched/fair: Use rb_add_cached()
References: <20200429153258.563269446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   46 ++++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -533,12 +533,15 @@ static inline u64 min_vruntime(u64 min_v
 	return min_vruntime;
 }
 
-static inline int entity_before(struct sched_entity *a,
+static inline bool entity_before(struct sched_entity *a,
 				struct sched_entity *b)
 {
 	return (s64)(a->vruntime - b->vruntime) < 0;
 }
 
+#define __node_2_se(node) \
+	rb_entry((node), struct sched_entity, run_node)
+
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
@@ -554,8 +557,7 @@ static void update_min_vruntime(struct c
 	}
 
 	if (leftmost) { /* non-empty tree */
-		struct sched_entity *se;
-		se = rb_entry(leftmost, struct sched_entity, run_node);
+		struct sched_entity *se = __node_2_se(leftmost);
 
 		if (!curr)
 			vruntime = se->vruntime;
@@ -571,37 +573,17 @@ static void update_min_vruntime(struct c
 #endif
 }
 
+static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
+{
+	return entity_before(__node_2_se(a), __node_2_se(b));
+}
+
 /*
  * Enqueue an entity into the rb-tree:
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct rb_node **link = &cfs_rq->tasks_timeline.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct sched_entity *entry;
-	bool leftmost = true;
-
-	/*
-	 * Find the right place in the rbtree:
-	 */
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct sched_entity, run_node);
-		/*
-		 * We dont care about collisions. Nodes with
-		 * the same key stay together.
-		 */
-		if (entity_before(se, entry)) {
-			link = &parent->rb_left;
-		} else {
-			link = &parent->rb_right;
-			leftmost = false;
-		}
-	}
-
-	rb_link_node(&se->run_node, parent, link);
-	rb_insert_color_cached(&se->run_node,
-			       &cfs_rq->tasks_timeline, leftmost);
+	rb_add_cached(&cfs_rq->tasks_timeline, &se->run_node, __entity_less);
 }
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -616,7 +598,7 @@ struct sched_entity *__pick_first_entity
 	if (!left)
 		return NULL;
 
-	return rb_entry(left, struct sched_entity, run_node);
+	return __node_2_se(left);
 }
 
 static struct sched_entity *__pick_next_entity(struct sched_entity *se)
@@ -626,7 +608,7 @@ static struct sched_entity *__pick_next_
 	if (!next)
 		return NULL;
 
-	return rb_entry(next, struct sched_entity, run_node);
+	return __node_2_se(next);
 }
 
 #ifdef CONFIG_SCHED_DEBUG
@@ -637,7 +619,7 @@ struct sched_entity *__pick_last_entity(
 	if (!last)
 		return NULL;
 
-	return rb_entry(last, struct sched_entity, run_node);
+	return __node_2_se(last);
 }
 
 /**************************************************************


