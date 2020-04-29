Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAF2C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B0D206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="loRxoRui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgD2Pho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgD2Phl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:37:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5FBC035493
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=DgqxtBEBoP0v/k46TkTEquZX8im9R6xtOLWfSBKD5+0=; b=loRxoRui8gkH6wYJhb3mOtUe6k
        XzcofnFOdhNfLWvHR1jdjIZ2WQjWkZKlKIwUYP7l/VWdlr8VlE0G3WqgCQwaop81pv98frd5SEyQu
        pVL2CNj2Y8yav6y/KIfkrbihs3DotPduBh412xfA5Lq9zhhBNO+D0Oa8lCqILON1nK64yG6gGKA51
        Z7JvImcXHiNhROBgJfkdefODjBzrvyCghyhFR2HIL3F/1LYd3HcnnZCxnJxgtwGWoDw4Ib06CGUkc
        3PsvTxCl5i+pdaK7snMNSzrbReuzJudMmnDahiofJvB+gF2bgkMBie91qLZThovHiHa/z9G6bbWWE
        rANTJKjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTomE-0006Ke-NG; Wed, 29 Apr 2020 15:37:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1669C306DC5;
        Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D30EA236D79ED; Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Message-Id: <20200429153549.006661686@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Apr 2020 17:32:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [RFC][PATCH 1/7] rbtree: Add generic add and find helpers
References: <20200429153258.563269446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've always been bothered by the endless (fragile) boilerplate for
rbtree, and I recently wrote some rbtree helpers for objtool and
figured I should lift them into the kernel and use them more widely.

Provide:

partial-order; less() based:
 - rb_add(): add a new entry to the rbtree
 - rb_add_cached(): like rb_add(), but for a rb_root_cached

total-order; cmp() based:
 - rb_find(): find an entry in an rbtree
 - rb_find_first(): find the first (leftmost) matching entry
 - rb_next_match(): continue from rb_find_first()
 - rb_for_each(): for loop with rb_find_first() / rb_next_match()

Also make rb_add_cached() / rb_erase_cached() return true when
leftmost.

Inlining and constant propagation should see the compiler inline the
whole thing, including the various compare functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/rbtree.h       |  127 +++++++++++++++++++++++++++++++++++++++++-
 tools/include/linux/rbtree.h |  129 ++++++++++++++++++++++++++++++++++++++++++-
 tools/objtool/elf.c          |   63 ++-------------------
 3 files changed, 257 insertions(+), 62 deletions(-)

--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -141,12 +141,18 @@ static inline void rb_insert_color_cache
 	rb_insert_color(node, &root->rb_root);
 }
 
-static inline void rb_erase_cached(struct rb_node *node,
+static inline bool rb_erase_cached(struct rb_node *node,
 				   struct rb_root_cached *root)
 {
-	if (root->rb_leftmost == node)
+	bool leftmost = false;
+
+	if (root->rb_leftmost == node) {
 		root->rb_leftmost = rb_next(node);
+		leftmost = true;
+	}
 	rb_erase(node, &root->rb_root);
+
+	return leftmost;
 }
 
 static inline void rb_replace_node_cached(struct rb_node *victim,
@@ -158,4 +164,121 @@ static inline void rb_replace_node_cache
 	rb_replace_node(victim, new, &root->rb_root);
 }
 
+static inline bool rb_add_cached(struct rb_root_cached *tree, struct rb_node *node,
+				 bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	bool leftmost = true;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent)) {
+			link = &parent->rb_left;
+		} else {
+			link = &parent->rb_right;
+			leftmost = false;
+		}
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color_cached(node, tree, leftmost);
+
+	return leftmost;
+}
+
+static inline void rb_add(struct rb_root *tree, struct rb_node *node,
+			  bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent))
+			link = &parent->rb_left;
+		else
+			link = &parent->rb_right;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+}
+
+static inline struct rb_node *rb_find_add(struct rb_root *tree, struct rb_node *node,
+			  int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0)
+			link = &parent->rb_left;
+		else if (c > 0)
+			link = &parent->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+	return NULL;
+}
+
+static inline struct rb_node *rb_find(struct rb_root *tree, const void *key,
+				      int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+		if (c < 0) {
+			node = node->rb_left;
+		} else if (c > 0) {
+			node = node->rb_right;
+		} else
+			return node;
+	}
+
+	return NULL;
+}
+
+static inline struct rb_node *rb_find_first(struct rb_root *tree, const void *key,
+					    int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+	struct rb_node *match = NULL;
+
+	while (node) {
+		int c = cmp(key, node);
+		if (c <= 0) {
+			if (!c)
+				match = node;
+			node = node->rb_left;
+		} else if (c > 0) {
+			node = node->rb_right;
+		}
+	}
+
+	return match;
+}
+
+static inline struct rb_node *rb_next_match(struct rb_node *node, const void *key,
+					    int (*cmp)(const void *key, const struct rb_node *))
+{
+	node = rb_next(node);
+	if (node && cmp(key, node))
+		node = NULL;
+	return node;
+}
+
+#define rb_for_each(tree, node, key, cmp) \
+	for ((node) = rb_find_first((tree), (key), (cmp)); \
+	     (node); (node) = rb_next_match((node), (key), (cmp)))
+
+
 #endif	/* _LINUX_RBTREE_H */
--- a/tools/include/linux/rbtree.h
+++ b/tools/include/linux/rbtree.h
@@ -135,12 +135,18 @@ static inline void rb_insert_color_cache
 	rb_insert_color(node, &root->rb_root);
 }
 
-static inline void rb_erase_cached(struct rb_node *node,
+static inline bool rb_erase_cached(struct rb_node *node,
 				   struct rb_root_cached *root)
 {
-	if (root->rb_leftmost == node)
+	bool leftmost = false;
+
+	if (root->rb_leftmost == node) {
 		root->rb_leftmost = rb_next(node);
+		leftmost = true;
+	}
 	rb_erase(node, &root->rb_root);
+
+	return leftmost;
 }
 
 static inline void rb_replace_node_cached(struct rb_node *victim,
@@ -152,4 +158,121 @@ static inline void rb_replace_node_cache
 	rb_replace_node(victim, new, &root->rb_root);
 }
 
-#endif /* __TOOLS_LINUX_PERF_RBTREE_H */
+static inline bool rb_add_cached(struct rb_root_cached *tree, struct rb_node *node,
+				 bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	bool leftmost = true;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent)) {
+			link = &parent->rb_left;
+		} else {
+			link = &parent->rb_right;
+			leftmost = false;
+		}
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color_cached(node, tree, leftmost);
+
+	return leftmost;
+}
+
+static inline void rb_add(struct rb_root *tree, struct rb_node *node,
+			  bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent))
+			link = &parent->rb_left;
+		else
+			link = &parent->rb_right;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+}
+
+static inline struct rb_node *rb_find_add(struct rb_root *tree, struct rb_node *node,
+			  int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0)
+			link = &parent->rb_left;
+		else if (c > 0)
+			link = &parent->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+	return NULL;
+}
+
+static inline struct rb_node *rb_find(struct rb_root *tree, const void *key,
+				      int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+		if (c < 0) {
+			node = node->rb_left;
+		} else if (c > 0) {
+			node = node->rb_right;
+		} else
+			return node;
+	}
+
+	return NULL;
+}
+
+static inline struct rb_node *rb_find_first(struct rb_root *tree, const void *key,
+					    int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+	struct rb_node *match = NULL;
+
+	while (node) {
+		int c = cmp(key, node);
+		if (c <= 0) {
+			if (!c)
+				match = node;
+			node = node->rb_left;
+		} else if (c > 0) {
+			node = node->rb_right;
+		}
+	}
+
+	return match;
+}
+
+static inline struct rb_node *rb_next_match(struct rb_node *node, const void *key,
+					    int (*cmp)(const void *key, const struct rb_node *))
+{
+	node = rb_next(node);
+	if (node && cmp(key, node))
+		node = NULL;
+	return node;
+}
+
+#define rb_for_each(tree, node, key, cmp) \
+	for ((node) = rb_find_first((tree), (key), (cmp)); \
+	     (node); (node) = rb_next_match((node), (key), (cmp)))
+
+
+#endif	/* _LINUX_RBTREE_H */
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -43,75 +43,24 @@ static void elf_hash_init(struct hlist_h
 #define elf_hash_for_each_possible(name, obj, member, key)			\
 	hlist_for_each_entry(obj, &name[hash_min(key, elf_hash_bits())], member)
 
-static void rb_add(struct rb_root *tree, struct rb_node *node,
-		   int (*cmp)(struct rb_node *, const struct rb_node *))
-{
-	struct rb_node **link = &tree->rb_node;
-	struct rb_node *parent = NULL;
-
-	while (*link) {
-		parent = *link;
-		if (cmp(node, parent) < 0)
-			link = &parent->rb_left;
-		else
-			link = &parent->rb_right;
-	}
-
-	rb_link_node(node, parent, link);
-	rb_insert_color(node, tree);
-}
-
-static struct rb_node *rb_find_first(struct rb_root *tree, const void *key,
-			       int (*cmp)(const void *key, const struct rb_node *))
-{
-	struct rb_node *node = tree->rb_node;
-	struct rb_node *match = NULL;
-
-	while (node) {
-		int c = cmp(key, node);
-		if (c <= 0) {
-			if (!c)
-				match = node;
-			node = node->rb_left;
-		} else if (c > 0) {
-			node = node->rb_right;
-		}
-	}
-
-	return match;
-}
-
-static struct rb_node *rb_next_match(struct rb_node *node, const void *key,
-				    int (*cmp)(const void *key, const struct rb_node *))
-{
-	node = rb_next(node);
-	if (node && cmp(key, node))
-		node = NULL;
-	return node;
-}
-
-#define rb_for_each(tree, node, key, cmp) \
-	for ((node) = rb_find_first((tree), (key), (cmp)); \
-	     (node); (node) = rb_next_match((node), (key), (cmp)))
-
-static int symbol_to_offset(struct rb_node *a, const struct rb_node *b)
+static bool symbol_to_offset(struct rb_node *a, const struct rb_node *b)
 {
 	struct symbol *sa = rb_entry(a, struct symbol, node);
 	struct symbol *sb = rb_entry(b, struct symbol, node);
 
 	if (sa->offset < sb->offset)
-		return -1;
+		return true;
 	if (sa->offset > sb->offset)
-		return 1;
+		return false;
 
 	if (sa->len < sb->len)
-		return -1;
+		return true;
 	if (sa->len > sb->len)
-		return 1;
+		return false;
 
 	sa->alias = sb;
 
-	return 0;
+	return false;
 }
 
 static int symbol_by_offset(const void *key, const struct rb_node *node)


