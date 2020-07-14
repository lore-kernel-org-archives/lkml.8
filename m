Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F408CC433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9343207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgGNHeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:34:14 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:6966 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgGNHeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:34:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U2hiN69_1594712046;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U2hiN69_1594712046)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Jul 2020 15:34:07 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH] mm/hugetlb: hide nr_nodes in the internal of for_each_node_mask_to_[alloc|free]
Date:   Tue, 14 Jul 2020 15:34:04 +0800
Message-Id: <20200714073404.84863-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The second parameter of for_each_node_mask_to_[alloc|free] is a loop
variant, which is not used outside of loop iteration.

Let's hide this.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/hugetlb.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74e3aae..9c3d15fb317e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1196,17 +1196,19 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
 	return nid;
 }
 
-#define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)		\
-	for (nr_nodes = nodes_weight(*mask);				\
-		nr_nodes > 0 &&						\
+#define for_each_node_mask_to_alloc(hs, node, mask)			\
+	int __nr_nodes;							\
+	for (__nr_nodes = nodes_weight(*mask);				\
+		__nr_nodes > 0 &&					\
 		((node = hstate_next_node_to_alloc(hs, mask)) || 1);	\
-		nr_nodes--)
+		__nr_nodes--)
 
-#define for_each_node_mask_to_free(hs, nr_nodes, node, mask)		\
-	for (nr_nodes = nodes_weight(*mask);				\
-		nr_nodes > 0 &&						\
+#define for_each_node_mask_to_free(hs, node, mask)			\
+	int __nr_nodes;							\
+	for (__nr_nodes = nodes_weight(*mask);				\
+		__nr_nodes > 0 &&					\
 		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
-		nr_nodes--)
+		__nr_nodes--)
 
 #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
 static void destroy_compound_gigantic_page(struct page *page,
@@ -1403,7 +1405,7 @@ static void __free_huge_page(struct page *page)
 	 * reservation.  If the page was associated with a subpool, there
 	 * would have been a page reserved in the subpool before allocation
 	 * via hugepage_subpool_get_pages().  Since we are 'restoring' the
-	 * reservtion, do not call hugepage_subpool_put_pages() as this will
+	 * reservation, do not call hugepage_subpool_put_pages() as this will
 	 * remove the reserved page from the subpool.
 	 */
 	if (!restore_reserve) {
@@ -1760,10 +1762,10 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 				nodemask_t *node_alloc_noretry)
 {
 	struct page *page;
-	int nr_nodes, node;
+	int node;
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
-	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
+	for_each_node_mask_to_alloc(h, node, nodes_allowed) {
 		page = alloc_fresh_huge_page(h, gfp_mask, node, nodes_allowed,
 						node_alloc_noretry);
 		if (page)
@@ -1787,10 +1789,10 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 							 bool acct_surplus)
 {
-	int nr_nodes, node;
+	int node;
 	int ret = 0;
 
-	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
+	for_each_node_mask_to_free(h, node, nodes_allowed) {
 		/*
 		 * If we're returning unused surplus pages, only examine
 		 * nodes with surplus pages.
@@ -2481,9 +2483,9 @@ int alloc_bootmem_huge_page(struct hstate *h)
 int __alloc_bootmem_huge_page(struct hstate *h)
 {
 	struct huge_bootmem_page *m;
-	int nr_nodes, node;
+	int node;
 
-	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
+	for_each_node_mask_to_alloc(h, node, &node_states[N_MEMORY]) {
 		void *addr;
 
 		addr = memblock_alloc_try_nid_raw(
@@ -2662,17 +2664,17 @@ static inline void try_to_free_low(struct hstate *h, unsigned long count,
 static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 				int delta)
 {
-	int nr_nodes, node;
+	int node;
 
 	VM_BUG_ON(delta != -1 && delta != 1);
 
 	if (delta < 0) {
-		for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
+		for_each_node_mask_to_alloc(h, node, nodes_allowed) {
 			if (h->surplus_huge_pages_node[node])
 				goto found;
 		}
 	} else {
-		for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
+		for_each_node_mask_to_free(h, node, nodes_allowed) {
 			if (h->surplus_huge_pages_node[node] <
 					h->nr_huge_pages_node[node])
 				goto found;
-- 
2.20.1 (Apple Git-117)

