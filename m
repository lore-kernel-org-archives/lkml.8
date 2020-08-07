Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C48206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CROqrSA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHGHn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:43:26 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB4C061574;
        Fri,  7 Aug 2020 00:43:26 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b79so933699qkg.9;
        Fri, 07 Aug 2020 00:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySf94QLeLbNlGfhC2+SweUefGT4Z5vu0N40qHEzJwo8=;
        b=CROqrSA1SWJ1S3UeuDPgnUy87uUnFdvfQO5tsFGytjhVU+7i+jHjRXm0z2MFURuuO0
         CxfhAdz+7NSd4G7fntYyLLNnDq4fzT3zieX2Dn7ftSe0CfQJSfU9oAz7nfK3Sm5uZD7H
         uUF2bRbPT9gOwjvXmC8kcBhBOuEAsKLWa+aZakzkvazbM2M3vEdFDu8lJj33CihJx55V
         XpVMwYBvWezfc3gcMjQjtio9F1UJMi5DIidqPE12Rx9nIlXOUZ7K32ab4SPgDu6zmeZZ
         DGUkVoU6hL6WQom1EaLvXSUqtMKKcP10LWqSwSkl8Tc+sI/6KV1BVICTB8iVb0NM2i9O
         1a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySf94QLeLbNlGfhC2+SweUefGT4Z5vu0N40qHEzJwo8=;
        b=sFA+JT9h9y3npMdhX4SRV9A246RwsJNByFhENHgX8H6w/0wJT2CSpyzJf3PeKvkkHu
         pi7w1zG//LKBJ9h0o0AAM4xB/7CLqCu+RSGJY5DwHzFXMwUeI8rI1n06Hjg5uRZzxlls
         sTWIIVyGZRc76N813NvmN5LlKlxc+5XNTZkh2mWHtWdN/+aG0tVc8+ErMVUYTbyWf4T0
         UNYkIw34lA0kKcTpus8rnPwu8ejFYmEPDrhz+GMcL+dqzXfThTWBP+ZisLSUALWrHZfQ
         GCK6j1cjiq75R8LohwWXdZKa1iI0fvcLhWvZdlgTxldxuVC10EX+YHTo/G2poXuvrB5g
         xHUQ==
X-Gm-Message-State: AOAM531YiFiw3q1Zos3AC1JBDB0OWHJcC78NIsNDm9bNIYNsMbKquRkO
        wwm/q9XIY13tGKj3moLhanQ=
X-Google-Smtp-Source: ABdhPJyRVvC/TZE4bVMJES1Es5r4aIIvrFv91UoW7N9Kvs3He0eLaHAsQcrciDwTv1g0JR+LzHWffA==
X-Received: by 2002:a05:620a:144e:: with SMTP id i14mr12031065qkl.453.1596786205282;
        Fri, 07 Aug 2020 00:43:25 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s5sm6076567qke.120.2020.08.07.00.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:43:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 690C427C0054;
        Fri,  7 Aug 2020 03:43:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:43:24 -0400
X-ME-Sender: <xms:HAYtX5Ftp1c2-8BCFnRN8y0ba9pAbWOUYtOnY1GxWzq9sRzlxxGiPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:HAYtX-UIXMbBC04kUq3wGCfFpiWrtTPOxSKhVIk2TGE0NYPn8DZ4vA>
    <xmx:HAYtX7LfqeWG5ON5F9DiKE-93WtJQMD2pqSLnIV7_EwPtsn7HnzVvg>
    <xmx:HAYtX_GWSUFF3HR5rA6kVt9sf1TaJwGjTnR7YRG7m9lrn8NYQANtZg>
    <xmx:HAYtX1zgNrKvnhth-ahUSdOe2w1XSU-muWIVcCJ9ESHonNsR63jPnw>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 034DC328005E;
        Fri,  7 Aug 2020 03:43:22 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 03/19] lockdep: Demagic the return value of BFS
Date:   Fri,  7 Aug 2020 15:42:22 +0800
Message-Id: <20200807074238.1632519-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__bfs() could return four magic numbers:

	1: search succeeds, but none match.
	0: search succeeds, find one match.
	-1: search fails because of the cq is full.
	-2: search fails because a invalid node is found.

This patch cleans things up by using a enum type for the return value
of __bfs() and its friends, this improves the code readability of the
code, and further, could help if we want to extend the BFS.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 155 ++++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 66 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index fbcbb6350ce7..8fba156db5ba 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1471,28 +1471,58 @@ static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
 
 	return lock_class + offset;
 }
+/*
+ * Return values of a bfs search:
+ *
+ * BFS_E* indicates an error
+ * BFS_R* indicates a result (match or not)
+ *
+ * BFS_EINVALIDNODE: Find a invalid node in the graph.
+ *
+ * BFS_EQUEUEFULL: The queue is full while doing the bfs.
+ *
+ * BFS_RMATCH: Find the matched node in the graph, and put that node into
+ *             *@target_entry.
+ *
+ * BFS_RNOMATCH: Haven't found the matched node and keep *@target_entry
+ *               _unchanged_.
+ */
+enum bfs_result {
+	BFS_EINVALIDNODE = -2,
+	BFS_EQUEUEFULL = -1,
+	BFS_RMATCH = 0,
+	BFS_RNOMATCH = 1,
+};
+
+/*
+ * bfs_result < 0 means error
+ */
+static inline bool bfs_error(enum bfs_result res)
+{
+	return res < 0;
+}
 
 /*
  * Forward- or backward-dependency search, used for both circular dependency
  * checking and hardirq-unsafe/softirq-unsafe checking.
  */
-static int __bfs(struct lock_list *source_entry,
-		 void *data,
-		 int (*match)(struct lock_list *entry, void *data),
-		 struct lock_list **target_entry,
-		 int offset)
+static enum bfs_result __bfs(struct lock_list *source_entry,
+			     void *data,
+			     int (*match)(struct lock_list *entry, void *data),
+			     struct lock_list **target_entry,
+			     int offset)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
 	struct list_head *head;
 	struct circular_queue *cq = &lock_cq;
-	int ret = 1;
+	enum bfs_result ret = BFS_RNOMATCH;
 
 	lockdep_assert_locked();
 
 	if (match(source_entry, data)) {
 		*target_entry = source_entry;
-		ret = 0;
+		ret = BFS_RMATCH;
 		goto exit;
 	}
 
@@ -1506,7 +1536,7 @@ static int __bfs(struct lock_list *source_entry,
 	while ((lock = __cq_dequeue(cq))) {
 
 		if (!lock->class) {
-			ret = -2;
+			ret = BFS_EINVALIDNODE;
 			goto exit;
 		}
 
@@ -1518,12 +1548,12 @@ static int __bfs(struct lock_list *source_entry,
 				mark_lock_accessed(entry, lock);
 				if (match(entry, data)) {
 					*target_entry = entry;
-					ret = 0;
+					ret = BFS_RMATCH;
 					goto exit;
 				}
 
 				if (__cq_enqueue(cq, entry)) {
-					ret = -1;
+					ret = BFS_EQUEUEFULL;
 					goto exit;
 				}
 				cq_depth = __cq_get_elem_count(cq);
@@ -1536,20 +1566,22 @@ static int __bfs(struct lock_list *source_entry,
 	return ret;
 }
 
-static inline int __bfs_forwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+static inline enum bfs_result
+__bfs_forwards(struct lock_list *src_entry,
+	       void *data,
+	       int (*match)(struct lock_list *entry, void *data),
+	       struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry,
 		     offsetof(struct lock_class, locks_after));
 
 }
 
-static inline int __bfs_backwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+static inline enum bfs_result
+__bfs_backwards(struct lock_list *src_entry,
+		void *data,
+		int (*match)(struct lock_list *entry, void *data),
+		struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry,
 		     offsetof(struct lock_class, locks_before));
@@ -1775,18 +1807,18 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 
 /*
  * Check that the dependency graph starting at <src> can lead to
- * <target> or not. Print an error and return 0 if it does.
+ * <target> or not.
  */
-static noinline int
+static noinline enum bfs_result
 check_path(struct lock_class *target, struct lock_list *src_entry,
 	   struct lock_list **target_entry)
 {
-	int ret;
+	enum bfs_result ret;
 
 	ret = __bfs_forwards(src_entry, (void *)target, class_equal,
 			     target_entry);
 
-	if (unlikely(ret < 0))
+	if (unlikely(bfs_error(ret)))
 		print_bfs_bug(ret);
 
 	return ret;
@@ -1797,13 +1829,13 @@ check_path(struct lock_class *target, struct lock_list *src_entry,
  * lead to <target>. If it can, there is a circle when adding
  * <target> -> <src> dependency.
  *
- * Print an error and return 0 if it does.
+ * Print an error and return BFS_RMATCH if it does.
  */
-static noinline int
+static noinline enum bfs_result
 check_noncircular(struct held_lock *src, struct held_lock *target,
 		  struct lock_trace **const trace)
 {
-	int ret;
+	enum bfs_result ret;
 	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list src_entry = {
 		.class = hlock_class(src),
@@ -1814,7 +1846,7 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 
 	ret = check_path(hlock_class(target), &src_entry, &target_entry);
 
-	if (unlikely(!ret)) {
+	if (unlikely(ret == BFS_RMATCH)) {
 		if (!*trace) {
 			/*
 			 * If save_trace fails here, the printing might
@@ -1836,12 +1868,13 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
  * <target> or not. If it can, <src> -> <target> dependency is already
  * in the graph.
  *
- * Print an error and return 2 if it does or 1 if it does not.
+ * Return BFS_RMATCH if it does, or BFS_RMATCH if it does not, return BFS_E* if
+ * any error appears in the bfs search.
  */
-static noinline int
+static noinline enum bfs_result
 check_redundant(struct held_lock *src, struct held_lock *target)
 {
-	int ret;
+	enum bfs_result ret;
 	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list src_entry = {
 		.class = hlock_class(src),
@@ -1852,11 +1885,8 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 
 	ret = check_path(hlock_class(target), &src_entry, &target_entry);
 
-	if (!ret) {
+	if (ret == BFS_RMATCH)
 		debug_atomic_inc(nr_redundant);
-		ret = 2;
-	} else if (ret < 0)
-		ret = 0;
 
 	return ret;
 }
@@ -1886,17 +1916,14 @@ static inline int usage_match(struct lock_list *entry, void *mask)
  * Find a node in the forwards-direction dependency sub-graph starting
  * at @root->class that matches @bit.
  *
- * Return 0 if such a node exists in the subgraph, and put that node
+ * Return BFS_MATCH if such a node exists in the subgraph, and put that node
  * into *@target_entry.
- *
- * Return 1 otherwise and keep *@target_entry unchanged.
- * Return <0 on error.
  */
-static int
+static enum bfs_result
 find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
 			struct lock_list **target_entry)
 {
-	int result;
+	enum bfs_result result;
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
@@ -1908,18 +1935,12 @@ find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
 /*
  * Find a node in the backwards-direction dependency sub-graph starting
  * at @root->class that matches @bit.
- *
- * Return 0 if such a node exists in the subgraph, and put that node
- * into *@target_entry.
- *
- * Return 1 otherwise and keep *@target_entry unchanged.
- * Return <0 on error.
  */
-static int
+static enum bfs_result
 find_usage_backwards(struct lock_list *root, unsigned long usage_mask,
 			struct lock_list **target_entry)
 {
-	int result;
+	enum bfs_result result;
 
 	debug_atomic_inc(nr_find_usage_backwards_checks);
 
@@ -2247,7 +2268,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	struct lock_list *uninitialized_var(target_entry1);
 	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list this, that;
-	int ret;
+	enum bfs_result ret;
 
 	/*
 	 * Step 1: gather all hard/soft IRQs usages backward in an
@@ -2257,7 +2278,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	this.class = hlock_class(prev);
 
 	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
-	if (ret < 0) {
+	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
@@ -2276,12 +2297,12 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	that.class = hlock_class(next);
 
 	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
-	if (ret < 0) {
+	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-	if (ret == 1)
-		return ret;
+	if (ret == BFS_RNOMATCH)
+		return 1;
 
 	/*
 	 * Step 3: we found a bad match! Now retrieve a lock from the backward
@@ -2291,11 +2312,11 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	backward_mask = original_mask(target_entry1->class->usage_mask);
 
 	ret = find_usage_backwards(&this, backward_mask, &target_entry);
-	if (ret < 0) {
+	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-	if (DEBUG_LOCKS_WARN_ON(ret == 1))
+	if (DEBUG_LOCKS_WARN_ON(ret == BFS_RNOMATCH))
 		return 1;
 
 	/*
@@ -2463,7 +2484,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	       struct lock_trace **const trace)
 {
 	struct lock_list *entry;
-	int ret;
+	enum bfs_result ret;
 
 	if (!hlock_class(prev)->key || !hlock_class(next)->key) {
 		/*
@@ -2494,7 +2515,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * in the graph whose neighbours are to be checked.
 	 */
 	ret = check_noncircular(next, prev, trace);
-	if (unlikely(ret <= 0))
+	if (unlikely(bfs_error(ret) || ret == BFS_RMATCH))
 		return 0;
 
 	if (!check_irq_usage(curr, prev, next))
@@ -2531,8 +2552,10 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * Is the <prev> -> <next> link redundant?
 	 */
 	ret = check_redundant(prev, next);
-	if (ret != 1)
-		return ret;
+	if (bfs_error(ret))
+		return 0;
+	else if (ret == BFS_RMATCH)
+		return 2;
 #endif
 
 	if (!*trace) {
@@ -3436,19 +3459,19 @@ static int
 check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 		     enum lock_usage_bit bit, const char *irqclass)
 {
-	int ret;
+	enum bfs_result ret;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_forwards(&root, lock_flag(bit), &target_entry);
-	if (ret < 0) {
+	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-	if (ret == 1)
-		return ret;
+	if (ret == BFS_RNOMATCH)
+		return 1;
 
 	print_irq_inversion_bug(curr, &root, target_entry,
 				this, 1, irqclass);
@@ -3463,19 +3486,19 @@ static int
 check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 		      enum lock_usage_bit bit, const char *irqclass)
 {
-	int ret;
+	enum bfs_result ret;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_backwards(&root, lock_flag(bit), &target_entry);
-	if (ret < 0) {
+	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-	if (ret == 1)
-		return ret;
+	if (ret == BFS_RNOMATCH)
+		return 1;
 
 	print_irq_inversion_bug(curr, &root, target_entry,
 				this, 0, irqclass);
-- 
2.28.0

