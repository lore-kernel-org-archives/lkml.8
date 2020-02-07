Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACADAC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AD9217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBGSON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:14:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:39464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgBGSOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:14:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8D5A8ADB3;
        Fri,  7 Feb 2020 18:14:09 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/5] regmap: optimize sync() and drop() regcache callbacks
Date:   Fri,  7 Feb 2020 10:03:03 -0800
Message-Id: <20200207180305.11092-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200207180305.11092-1-dave@stgolabs.net>
References: <20200207180305.11092-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At a higher memory footprint (two additional pointers per node) we
can get branchless O(1) tree iterators which can optimize in-order
tree walks/traversals. For example, on my laptop looking at the rbtree
debugfs entries:

before:
    60 nodes, 165 registers, average 2 registers, used 4036 bytes
after:
    60 nodes, 165 registers, average 2 registers, used 5004 bytes

Cc: broonie@kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/base/regmap/regcache-rbtree.c | 62 +++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index cfa29dc89bbf..d55f6b6c87b4 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -8,7 +8,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
-#include <linux/rbtree.h>
+#include <linux/ll_rbtree.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 
@@ -28,11 +28,11 @@ struct regcache_rbtree_node {
 	/* number of registers available in the block */
 	unsigned int blklen;
 	/* the actual rbtree node holding this block */
-	struct rb_node node;
+	struct llrb_node node;
 };
 
 struct regcache_rbtree_ctx {
-	struct rb_root root;
+	struct llrb_root root;
 	struct regcache_rbtree_node *cached_rbnode;
 };
 
@@ -75,9 +75,9 @@ static struct regcache_rbtree_node *regcache_rbtree_lookup(struct regmap *map,
 			return rbnode;
 	}
 
-	node = rbtree_ctx->root.rb_node;
+	node = rbtree_ctx->root.rb_root.rb_node;
 	while (node) {
-		rbnode = rb_entry(node, struct regcache_rbtree_node, node);
+		rbnode = llrb_entry(node, struct regcache_rbtree_node, node);
 		regcache_rbtree_get_base_top_reg(map, rbnode, &base_reg,
 						 &top_reg);
 		if (reg >= base_reg && reg <= top_reg) {
@@ -93,18 +93,20 @@ static struct regcache_rbtree_node *regcache_rbtree_lookup(struct regmap *map,
 	return NULL;
 }
 
-static int regcache_rbtree_insert(struct regmap *map, struct rb_root *root,
+static int regcache_rbtree_insert(struct regmap *map, struct llrb_root *root,
 				  struct regcache_rbtree_node *rbnode)
 {
 	struct rb_node **new, *parent;
+	struct llrb_node *prev = NULL;
 	struct regcache_rbtree_node *rbnode_tmp;
 	unsigned int base_reg_tmp, top_reg_tmp;
 	unsigned int base_reg;
 
 	parent = NULL;
-	new = &root->rb_node;
+	new = &root->rb_root.rb_node;
 	while (*new) {
-		rbnode_tmp = rb_entry(*new, struct regcache_rbtree_node, node);
+		rbnode_tmp = llrb_entry(*new,
+					struct regcache_rbtree_node, node);
 		/* base and top registers of the current rbnode */
 		regcache_rbtree_get_base_top_reg(map, rbnode_tmp, &base_reg_tmp,
 						 &top_reg_tmp);
@@ -115,15 +117,16 @@ static int regcache_rbtree_insert(struct regmap *map, struct rb_root *root,
 		if (base_reg >= base_reg_tmp &&
 		    base_reg <= top_reg_tmp)
 			return 0;
-		else if (base_reg > top_reg_tmp)
+		else if (base_reg > top_reg_tmp) {
+			prev = llrb_from_rb(parent);
 			new = &((*new)->rb_right);
-		else if (base_reg < base_reg_tmp)
+		} else if (base_reg < base_reg_tmp)
 			new = &((*new)->rb_left);
 	}
 
 	/* insert the node into the rbtree */
-	rb_link_node(&rbnode->node, parent, new);
-	rb_insert_color(&rbnode->node, root);
+	rb_link_node(&rbnode->node.rb_node, parent, new);
+	llrb_insert(root, &rbnode->node, prev);
 
 	return 1;
 }
@@ -134,7 +137,7 @@ static int rbtree_show(struct seq_file *s, void *ignored)
 	struct regmap *map = s->private;
 	struct regcache_rbtree_ctx *rbtree_ctx = map->cache;
 	struct regcache_rbtree_node *n;
-	struct rb_node *node;
+	struct llrb_node *node;
 	unsigned int base, top;
 	size_t mem_size;
 	int nodes = 0;
@@ -145,8 +148,8 @@ static int rbtree_show(struct seq_file *s, void *ignored)
 
 	mem_size = sizeof(*rbtree_ctx);
 
-	for (node = rb_first(&rbtree_ctx->root); node != NULL;
-	     node = rb_next(node)) {
+	for (node = llrb_first(&rbtree_ctx->root); node != NULL;
+	     node = llrb_next(node)) {
 		n = rb_entry(node, struct regcache_rbtree_node, node);
 		mem_size += sizeof(*n);
 		mem_size += (n->blklen * map->cache_word_size);
@@ -192,7 +195,7 @@ static int regcache_rbtree_init(struct regmap *map)
 		return -ENOMEM;
 
 	rbtree_ctx = map->cache;
-	rbtree_ctx->root = RB_ROOT;
+	rbtree_ctx->root = LLRB_ROOT;
 	rbtree_ctx->cached_rbnode = NULL;
 
 	for (i = 0; i < map->num_reg_defaults; i++) {
@@ -212,7 +215,7 @@ static int regcache_rbtree_init(struct regmap *map)
 
 static int regcache_rbtree_exit(struct regmap *map)
 {
-	struct rb_node *next;
+	struct llrb_node *next;
 	struct regcache_rbtree_ctx *rbtree_ctx;
 	struct regcache_rbtree_node *rbtree_node;
 
@@ -222,11 +225,11 @@ static int regcache_rbtree_exit(struct regmap *map)
 		return 0;
 
 	/* free up the rbtree */
-	next = rb_first(&rbtree_ctx->root);
+	next = llrb_first(&rbtree_ctx->root);
 	while (next) {
 		rbtree_node = rb_entry(next, struct regcache_rbtree_node, node);
-		next = rb_next(&rbtree_node->node);
-		rb_erase(&rbtree_node->node, &rbtree_ctx->root);
+		next = llrb_next(&rbtree_node->node);
+		llrb_erase(&rbtree_node->node, &rbtree_ctx->root);
 		kfree(rbtree_node->cache_present);
 		kfree(rbtree_node->block);
 		kfree(rbtree_node);
@@ -400,10 +403,10 @@ static int regcache_rbtree_write(struct regmap *map, unsigned int reg,
 		max = reg + max_dist;
 
 		/* look for an adjacent register to the one we are about to add */
-		node = rbtree_ctx->root.rb_node;
+		node = rbtree_ctx->root.rb_root.rb_node;
 		while (node) {
-			rbnode_tmp = rb_entry(node, struct regcache_rbtree_node,
-					      node);
+			rbnode_tmp = llrb_entry(node,
+					      struct regcache_rbtree_node, node);
 
 			regcache_rbtree_get_base_top_reg(map, rbnode_tmp,
 				&base_reg, &top_reg);
@@ -466,15 +469,17 @@ static int regcache_rbtree_sync(struct regmap *map, unsigned int min,
 				unsigned int max)
 {
 	struct regcache_rbtree_ctx *rbtree_ctx;
-	struct rb_node *node;
+	struct llrb_node *node;
 	struct regcache_rbtree_node *rbnode;
 	unsigned int base_reg, top_reg;
 	unsigned int start, end;
 	int ret;
 
 	rbtree_ctx = map->cache;
-	for (node = rb_first(&rbtree_ctx->root); node; node = rb_next(node)) {
-		rbnode = rb_entry(node, struct regcache_rbtree_node, node);
+	for (node = llrb_first(&rbtree_ctx->root); node;
+	     node = llrb_next(node)) {
+		rbnode = rb_entry(node,
+				  struct regcache_rbtree_node, node);
 
 		regcache_rbtree_get_base_top_reg(map, rbnode, &base_reg,
 			&top_reg);
@@ -508,12 +513,13 @@ static int regcache_rbtree_drop(struct regmap *map, unsigned int min,
 {
 	struct regcache_rbtree_ctx *rbtree_ctx;
 	struct regcache_rbtree_node *rbnode;
-	struct rb_node *node;
+	struct llrb_node *node;
 	unsigned int base_reg, top_reg;
 	unsigned int start, end;
 
 	rbtree_ctx = map->cache;
-	for (node = rb_first(&rbtree_ctx->root); node; node = rb_next(node)) {
+	for (node = llrb_first(&rbtree_ctx->root); node;
+	     node = llrb_next(node)) {
 		rbnode = rb_entry(node, struct regcache_rbtree_node, node);
 
 		regcache_rbtree_get_base_top_reg(map, rbnode, &base_reg,
-- 
2.16.4

