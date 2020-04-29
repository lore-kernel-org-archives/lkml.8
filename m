Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B99C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03EBD206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cx9jxRo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgD2Pht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgD2Phl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:37:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F3CC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=e6RG21hibKQUUosSx/k+oShE0hH8STODGZgHMeTiyfo=; b=Cx9jxRo6zZ+rUbLIyU0GxzjR+J
        f4MOoUlKfG43PQzzE3rYmm4zbFTuRK2u2w/HlRoFs4a8nH/8Xh6zaXIYCCB2EA4jPwylBHfnMoNv2
        eclHtVJeifLFqXImBy/hrqBF3wQGTD8Fyo6xtH4EpPay5NgOjqt/cY1H3sG7QGMaSw/RuiTEdZrg4
        5J9oCMM+l20G4XFXvmzA42duj6w0JN5nIEWBXkscoLr8RMJ4siXJVE4j9f1HoBvp3ESKGUddmUz95
        YOZJLZYWOtexOQSQm+DmLd+qDDLdqEfUD9MAmFvY6WeyGzozmpxdWkZHGKQ97cCsSjZyBrwfg56Nq
        +OgbEQVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTomG-0006LM-EY; Wed, 29 Apr 2020 15:37:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13B22305C11;
        Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DD2AE236D79F1; Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Message-Id: <20200429153549.191480567@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Apr 2020 17:33:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [RFC][PATCH 4/7] rbtree, perf: Use new rbtree helpers
References: <20200429153258.563269446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |  178 +++++++++++++++++++++++----------------------------
 1 file changed, 81 insertions(+), 97 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1581,44 +1581,84 @@ static void perf_event_groups_init(struc
  * Implements complex key that first sorts by CPU and then by virtual index
  * which provides ordering when rotating groups for the same CPU.
  */
-static bool
-perf_event_groups_less(struct perf_event *left, struct perf_event *right)
-{
-	if (left->cpu < right->cpu)
-		return true;
-	if (left->cpu > right->cpu)
-		return false;
+static __always_inline int
+perf_event_groups_cmp(const int left_cpu, const struct cgroup *left_cgroup,
+		      const u64 left_group_index, const struct perf_event *right)
+{
+	if (left_cpu < right->cpu)
+		return -1;
+	if (left_cpu > right->cpu)
+		return 1;
 
 #ifdef CONFIG_CGROUP_PERF
-	if (left->cgrp != right->cgrp) {
-		if (!left->cgrp || !left->cgrp->css.cgroup) {
+	{
+	struct cgroup *right_cgroup = right->cgrp ? right->cgrp->css.cgroup : NULL;
+
+	if (left_cgroup != right_cgroup) {
+		if (!left_cgroup) {
 			/*
 			 * Left has no cgroup but right does, no cgroups come
 			 * first.
 			 */
-			return true;
+			return -1;
 		}
-		if (!right->cgrp || !right->cgrp->css.cgroup) {
+		if (!right->cgroup) {
 			/*
 			 * Right has no cgroup but left does, no cgroups come
 			 * first.
 			 */
-			return false;
+			return 1;
 		}
 		/* Two dissimilar cgroups, order by id. */
-		if (left->cgrp->css.cgroup->kn->id < right->cgrp->css.cgroup->kn->id)
-			return true;
+		if (cgroup_id(left_cgroup) < cgroup_id(right_cgroup))
+			return -1;
 
-		return false;
+		return 1;
+	}
 	}
 #endif
 
-	if (left->group_index < right->group_index)
-		return true;
-	if (left->group_index > right->group_index)
-		return false;
+	if (left_group_index < right->group_index)
+		return -1;
+	if (left_group_index > right->group_index)
+		return 1;
 
-	return false;
+	return 0;
+}
+
+static inline struct cgroup *event_cgroup(struct perf_event *event)
+{
+	struct cgroup *cgroup = NULL;
+
+#ifdef CONFIG_CGROUP_PERF
+	if (event->cgrp)
+		cgroup = event->cgrp->css.cgroup;
+#endif
+
+	return cgroup;
+}
+
+#define __node_2_pe(node) \
+	rb_entry((node), struct perf_event, group_node)
+
+static inline bool __group_less(struct rb_node *a, const struct rb_node *b)
+{
+	struct perf_event *e = __node_2_pe(a);
+	return perf_event_groups_cmp(e->cpu, event_cgroup(e), e->group_index,
+				     __node_2_pe(b)) < 0;
+}
+
+struct __group_key {
+	int cpu;
+	struct cgroup *cgroup;
+};
+
+static inline int __group_cmp(const void *key, const struct rb_node *node)
+{
+	const struct __group_key *a = key;
+	const struct perf_event *b = __node_2_pe(node);
+
+	return perf_event_groups_cmp(a->cpu, a->cgroup, b->group_index, b);
 }
 
 /*
@@ -1630,27 +1670,9 @@ static void
 perf_event_groups_insert(struct perf_event_groups *groups,
 			 struct perf_event *event)
 {
-	struct perf_event *node_event;
-	struct rb_node *parent;
-	struct rb_node **node;
-
 	event->group_index = ++groups->index;
 
-	node = &groups->tree.rb_node;
-	parent = *node;
-
-	while (*node) {
-		parent = *node;
-		node_event = container_of(*node, struct perf_event, group_node);
-
-		if (perf_event_groups_less(event, node_event))
-			node = &parent->rb_left;
-		else
-			node = &parent->rb_right;
-	}
-
-	rb_link_node(&event->group_node, parent, node);
-	rb_insert_color(&event->group_node, &groups->tree);
+	rb_add(&groups->tree, &event->group_node, __group_less);
 }
 
 /*
@@ -1698,45 +1720,17 @@ static struct perf_event *
 perf_event_groups_first(struct perf_event_groups *groups, int cpu,
 			struct cgroup *cgrp)
 {
-	struct perf_event *node_event = NULL, *match = NULL;
-	struct rb_node *node = groups->tree.rb_node;
-#ifdef CONFIG_CGROUP_PERF
-	u64 node_cgrp_id, cgrp_id = 0;
-
-	if (cgrp)
-		cgrp_id = cgrp->kn->id;
-#endif
-
-	while (node) {
-		node_event = container_of(node, struct perf_event, group_node);
+	struct __group_key key = {
+		.cpu = cpu,
+		.cgroup = cgrp,
+	};
+	struct rb_node *node;
+
+	node = rb_find_first(&groups->tree, &key, __group_cmp);
+	if (node)
+		return __node_2_pe(node);
 
-		if (cpu < node_event->cpu) {
-			node = node->rb_left;
-			continue;
-		}
-		if (cpu > node_event->cpu) {
-			node = node->rb_right;
-			continue;
-		}
-#ifdef CONFIG_CGROUP_PERF
-		node_cgrp_id = 0;
-		if (node_event->cgrp && node_event->cgrp->css.cgroup)
-			node_cgrp_id = node_event->cgrp->css.cgroup->kn->id;
-
-		if (cgrp_id < node_cgrp_id) {
-			node = node->rb_left;
-			continue;
-		}
-		if (cgrp_id > node_cgrp_id) {
-			node = node->rb_right;
-			continue;
-		}
-#endif
-		match = node_event;
-		node = node->rb_left;
-	}
-
-	return match;
+	return NULL;
 }
 
 /*
@@ -1745,27 +1739,17 @@ perf_event_groups_first(struct perf_even
 static struct perf_event *
 perf_event_groups_next(struct perf_event *event)
 {
-	struct perf_event *next;
-#ifdef CONFIG_CGROUP_PERF
-	u64 curr_cgrp_id = 0;
-	u64 next_cgrp_id = 0;
-#endif
+	struct __group_key key = {
+		.cpu = event->cpu,
+		.cgroup = event_cgroup(event),
+	};
+	struct rb_node *next;
+
+	next = rb_next_match(&event->group_node, &key, __group_cmp);
+	if (next)
+		return __node_2_pe(next);
 
-	next = rb_entry_safe(rb_next(&event->group_node), typeof(*event), group_node);
-	if (next == NULL || next->cpu != event->cpu)
-		return NULL;
-
-#ifdef CONFIG_CGROUP_PERF
-	if (event->cgrp && event->cgrp->css.cgroup)
-		curr_cgrp_id = event->cgrp->css.cgroup->kn->id;
-
-	if (next->cgrp && next->cgrp->css.cgroup)
-		next_cgrp_id = next->cgrp->css.cgroup->kn->id;
-
-	if (curr_cgrp_id != next_cgrp_id)
-		return NULL;
-#endif
-	return next;
+	return NULL;
 }
 
 /*


