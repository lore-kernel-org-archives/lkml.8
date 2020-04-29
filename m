Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9E4C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4F32073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PvcpPrhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgD2Phm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgD2Phl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:37:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26080C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hfuhRGMBRFACn0sgDJKzCQTWxYGgWI8wpvkhveph0lA=; b=PvcpPrhUH9VYvA1w5dNLSIZwF+
        OX3l+KXcUug9RpGYcV3KNCyCr+oCPCiSbw1s8AU3aO1OmY5ISiYSlteuX5Rrgc1y3qc+CBVXGq596
        3tjHYvyy3e2YgeeLhy0EnpOt8pQBz0MVhDKsbF2CnpcSYPAEddtwpiVDS6H8ye4oXI1uGKFFbYeH6
        ZtjYEeLf0dvm84eaSbZzMBKY/SEh7lDuh+UktkxT9N6BP+DcW2db6Li6eSZ2NeXwmgNfIkN1wAEQI
        laQSmHMaXT12mRqRu9F8YsZaqdON5tIzTfTAyGiU+fpi9yhHF7Iqp0EFn+sgvUpl/EF1N87Kqj+dg
        6onit4zw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTomE-0006Kd-O9; Wed, 29 Apr 2020 15:37:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 15795306AFB;
        Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DABAA236D79F2; Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Message-Id: <20200429153549.128224664@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Apr 2020 17:33:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [RFC][PATCH 3/7] rbtree, sched/deadline: Use rb_add_cached()
References: <20200429153258.563269446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c |   75 +++++++++++++++---------------------------------
 1 file changed, 24 insertions(+), 51 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -440,58 +440,38 @@ static void dec_dl_migration(struct sche
 	update_dl_migration(dl_rq);
 }
 
+#define __node_2_pdl(node) \
+	rb_entry((node), struct task_struct, pushable_dl_tasks)
+
+static inline bool __pushable_less(struct rb_node *a, const struct rb_node *b)
+{
+	return dl_entity_preempt(&__node_2_pdl(a)->dl, &__node_2_pdl(b)->dl);
+}
+
 /*
  * The list of pushable -deadline task is not a plist, like in
  * sched_rt.c, it is an rb-tree with tasks ordered by deadline.
  */
 static void enqueue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 {
-	struct dl_rq *dl_rq = &rq->dl;
-	struct rb_node **link = &dl_rq->pushable_dl_tasks_root.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct task_struct *entry;
-	bool leftmost = true;
-
 	BUG_ON(!RB_EMPTY_NODE(&p->pushable_dl_tasks));
 
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct task_struct,
-				 pushable_dl_tasks);
-		if (dl_entity_preempt(&p->dl, &entry->dl))
-			link = &parent->rb_left;
-		else {
-			link = &parent->rb_right;
-			leftmost = false;
-		}
-	}
-
-	if (leftmost)
-		dl_rq->earliest_dl.next = p->dl.deadline;
-
-	rb_link_node(&p->pushable_dl_tasks, parent, link);
-	rb_insert_color_cached(&p->pushable_dl_tasks,
-			       &dl_rq->pushable_dl_tasks_root, leftmost);
+	if (rb_add_cached(&rq->dl.pushable_dl_tasks_root, &p->pushable_dl_tasks,
+			  __pushable_less))
+		rq->dl.earliest_dl.next = p->dl.deadline;
 }
 
 static void dequeue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 {
 	struct dl_rq *dl_rq = &rq->dl;
+	struct rb_root_cached *root = &dl_rq->pushable_dl_tasks_root;
 
 	if (RB_EMPTY_NODE(&p->pushable_dl_tasks))
 		return;
 
-	if (dl_rq->pushable_dl_tasks_root.rb_leftmost == &p->pushable_dl_tasks) {
-		struct rb_node *next_node;
+	if (rb_erase_cached(&p->pushable_dl_tasks, root))
+		dl_rq->earliest_dl.next = __node_2_pdl(rb_first_cached(root))->dl.deadline;
 
-		next_node = rb_next(&p->pushable_dl_tasks);
-		if (next_node) {
-			dl_rq->earliest_dl.next = rb_entry(next_node,
-				struct task_struct, pushable_dl_tasks)->dl.deadline;
-		}
-	}
-
-	rb_erase_cached(&p->pushable_dl_tasks, &dl_rq->pushable_dl_tasks_root);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 }
 
@@ -1401,29 +1381,21 @@ void dec_dl_tasks(struct sched_dl_entity
 	dec_dl_migration(dl_se, dl_rq);
 }
 
+#define __node_2_dle(node) \
+	rb_entry((node), struct sched_dl_entity, rb_node)
+
+static inline bool __dl_less(struct rb_node *a, const struct rb_node *b)
+{
+	return dl_time_before(__node_2_dle(a)->deadline, __node_2_dle(b)->deadline);
+}
+
 static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rb_node **link = &dl_rq->root.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct sched_dl_entity *entry;
-	int leftmost = 1;
 
 	BUG_ON(!RB_EMPTY_NODE(&dl_se->rb_node));
 
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct sched_dl_entity, rb_node);
-		if (dl_time_before(dl_se->deadline, entry->deadline))
-			link = &parent->rb_left;
-		else {
-			link = &parent->rb_right;
-			leftmost = 0;
-		}
-	}
-
-	rb_link_node(&dl_se->rb_node, parent, link);
-	rb_insert_color_cached(&dl_se->rb_node, &dl_rq->root, leftmost);
+	rb_add_cached(&dl_rq->root, &dl_se->rb_node, __dl_less);
 
 	inc_dl_tasks(dl_se, dl_rq);
 }
@@ -1436,6 +1408,7 @@ static void __dequeue_dl_entity(struct s
 		return;
 
 	rb_erase_cached(&dl_se->rb_node, &dl_rq->root);
+
 	RB_CLEAR_NODE(&dl_se->rb_node);
 
 	dec_dl_tasks(dl_se, dl_rq);


