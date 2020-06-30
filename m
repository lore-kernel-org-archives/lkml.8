Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C73C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D40B20874
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgF3VZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:25:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:43380 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730376AbgF3VZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:25:28 -0400
IronPort-SDR: e/4eHNX08WzayR0hovcQGTiYGuDWrzaNmEM5zxOtCuVTIJ6Oxbf5Y0GCSq6ddnm5dzQat1Kuab
 oj4QO4UY1PJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134676819"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="134676819"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:25 -0700
IronPort-SDR: jiH7xBlVLhLIbymLk1VPjHyNfRig7LjaND1D47uVIY79yl6f1VN84qqwM4SZDL/oeYdj6uXFnR
 nc9G6savvdFA==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481336282"
Received: from schittin-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.132.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:25 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 08/12] mm/mempolicy: Create a page allocator for policy
Date:   Tue, 30 Jun 2020 14:25:13 -0700
Message-Id: <20200630212517.308045-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630212517.308045-1-ben.widawsky@intel.com>
References: <20200630212517.308045-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a helper function which takes care of handling multiple
preferred nodes. It will be called by future patches that need to handle
this, specifically VMA based page allocation, and task based page
allocation. Huge pages don't quite fit the same pattern because they use
different underlying page allocation functions. This consumes the
previous interleave policy specific allocation function to make a one
stop shop for policy based allocation.

For now, only interleaved policy will be used so there should be no
functional change yet. However, if bisection points to issues in the
next few commits, it was likely the fault of this patch.

Similar functionality is offered via policy_node() and
policy_nodemask(). By themselves however, neither can achieve this
fallback style of sets of nodes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 60 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3b38c9c4e580..1009cf90ad37 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2199,22 +2199,56 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 	return ret;
 }
 
-/* Allocate a page in interleaved policy.
-   Own path because it needs to do special accounting. */
-static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
-					unsigned nid)
+/* Handle page allocation for all but interleaved policies */
+static struct page *alloc_pages_policy(struct mempolicy *pol, gfp_t gfp,
+				       unsigned int order, int preferred_nid)
 {
 	struct page *page;
+	gfp_t gfp_mask = gfp;
 
-	page = __alloc_pages(gfp, order, nid);
-	/* skip NUMA_INTERLEAVE_HIT counter update if numa stats is disabled */
-	if (!static_branch_likely(&vm_numa_stat_key))
+	if (pol->mode == MPOL_INTERLEAVE) {
+		page = __alloc_pages(gfp, order, preferred_nid);
+		/* skip NUMA_INTERLEAVE_HIT counter update if numa stats is disabled */
+		if (!static_branch_likely(&vm_numa_stat_key))
+			return page;
+		if (page && page_to_nid(page) == preferred_nid) {
+			preempt_disable();
+			__inc_numa_state(page_zone(page), NUMA_INTERLEAVE_HIT);
+			preempt_enable();
+		}
 		return page;
-	if (page && page_to_nid(page) == nid) {
-		preempt_disable();
-		__inc_numa_state(page_zone(page), NUMA_INTERLEAVE_HIT);
-		preempt_enable();
 	}
+
+	VM_BUG_ON(preferred_nid != NUMA_NO_NODE);
+
+	preferred_nid = numa_node_id();
+
+	/*
+	 * There is a two pass approach implemented here for
+	 * MPOL_PREFERRED_MANY. In the first pass we pretend the preferred nodes
+	 * are bound, but allow the allocation to fail. The below table explains
+	 * how this is achieved.
+	 *
+	 * | Policy                        | preferred nid | nodemask   |
+	 * |-------------------------------|---------------|------------|
+	 * | MPOL_DEFAULT                  | local         | NULL       |
+	 * | MPOL_PREFERRED                | best          | NULL       |
+	 * | MPOL_INTERLEAVE               | ERR           | ERR        |
+	 * | MPOL_BIND                     | local         | pol->nodes |
+	 * | MPOL_PREFERRED_MANY           | best          | pol->nodes |
+	 * | MPOL_PREFERRED_MANY (round 2) | local         | NULL       |
+	 * +-------------------------------+---------------+------------+
+	 */
+	if (pol->mode == MPOL_PREFERRED_MANY)
+		gfp_mask |= __GFP_RETRY_MAYFAIL;
+
+	page = __alloc_pages_nodemask(gfp_mask, order,
+				      policy_node(gfp, pol, preferred_nid),
+				      policy_nodemask(gfp, pol));
+
+	if (unlikely(!page && pol->mode == MPOL_PREFERRED_MANY))
+		page = __alloc_pages_nodemask(gfp, order, preferred_nid, NULL);
+
 	return page;
 }
 
@@ -2256,8 +2290,8 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		unsigned nid;
 
 		nid = interleave_nid(pol, vma, addr, PAGE_SHIFT + order);
+		page = alloc_pages_policy(pol, gfp, order, nid);
 		mpol_cond_put(pol);
-		page = alloc_page_interleave(gfp, order, nid);
 		goto out;
 	}
 
@@ -2341,7 +2375,7 @@ struct page *alloc_pages_current(gfp_t gfp, unsigned order)
 	 * nor system default_policy
 	 */
 	if (pol->mode == MPOL_INTERLEAVE)
-		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
+		page = alloc_pages_policy(pol, gfp, order, interleave_nodes(pol));
 	else
 		page = __alloc_pages_nodemask(gfp, order,
 				policy_node(gfp, pol, numa_node_id()),
-- 
2.27.0

