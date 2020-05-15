Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59945C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3339B20759
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgEOMrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:47:17 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:37530 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgEOMrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:47:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tyco77Q_1589546832;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tyco77Q_1589546832)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 May 2020 20:47:13 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <David.Woodhouse@intel.com>,
        Rik van Riel <riel@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/2] rbtree_latch: quit searching when reaching to maximum depth
Date:   Fri, 15 May 2020 12:47:06 +0000
Message-Id: <20200515124710.16439-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lib/rbtree.c has ensured that there is not possible to
inadvertently cause (temporary) loops in the tree structure
as seen in program order of the modifier. But loop is still
possible to be seen in searcher due to CPU's reordering.

for example:
modifier				searcher

left rotate at parent
parent->rb_right is node
					search to parent
					parent->rb_right is node
				     +->see node->rb_left changed
WRITE_ONCE(parent->rb_right, tmp);-+ |  node->rb_left is parennt
no smp_wmb(), some arch can        | |
reorder these two writes           | |  loop long between
WRITE_ONCE(node->rb_left, parent);-+-+  parent and node
				   |
				   +--->finally see
					parent->rb_right

The long loop won't stop until the modifer's CPU flushes
its writes. Too avoid it, we should limit the searching depth.
There are no more than (1<<BITS_PER_LONG)-1 nodes in the tree.
And the max_depth of a tree is no more than 2*lg(node_count+1),
which is no mare than 2*BITS_PER_LONG.

So the serarch should stop when diving down up to
2*BITS_PER_LONG depth.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Michel Lespinasse <walken@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <David.Woodhouse@intel.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/rbtree_latch.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/rbtree_latch.h b/include/linux/rbtree_latch.h
index 7d012faa509a..b012bd95eabf 100644
--- a/include/linux/rbtree_latch.h
+++ b/include/linux/rbtree_latch.h
@@ -107,10 +107,11 @@ __lt_find(void *key, struct latch_tree_root *ltr, int idx,
 	  int (*comp)(void *key, struct latch_tree_node *node))
 {
 	struct rb_node *node = rcu_dereference_raw(ltr->tree[idx].rb_node);
+	int depth = 2 * BITS_PER_LONG;
 	struct latch_tree_node *ltn;
 	int c;
 
-	while (node) {
+	while (node && depth > 0) {
 		ltn = __lt_from_rb(node, idx);
 		c = comp(key, ltn);
 
@@ -120,6 +121,7 @@ __lt_find(void *key, struct latch_tree_root *ltr, int idx,
 			node = rcu_dereference_raw(node->rb_right);
 		else
 			return ltn;
+		depth--;
 	}
 
 	return NULL;
-- 
2.20.1

