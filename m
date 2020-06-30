Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF3EC433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911DC20809
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgF3VZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:25:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:43377 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbgF3VZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:25:24 -0400
IronPort-SDR: Chj7hZZx9MOmBBCAokYR/WO/sacKdpzIH0HAUrq3quqpGghPnav+EPrqiO89ZoG5U8xsZoj6im
 zmGZcm9Rq7UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134676813"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="134676813"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:23 -0700
IronPort-SDR: I9ni+G/Dnh1KF8GPSOcdTvZrp7u/WAgYIveajT861Ki3qAhm/2f/+YSzzxYx3bJKPQDScSFmZR
 +iFiNwR5V7WA==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481336260"
Received: from schittin-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.132.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:22 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH 03/12] mm/mempolicy: Add MPOL_PREFERRED_MANY for multiple preferred nodes
Date:   Tue, 30 Jun 2020 14:25:08 -0700
Message-Id: <20200630212517.308045-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630212517.308045-1-ben.widawsky@intel.com>
References: <20200630212517.308045-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

MPOL_PREFERRED honors only a single node set in the nodemask.  Add the
bare define for a new mode which will allow more than one.

The patch does all the plumbing without actually adding the new policy
type.

v2:
Plumb most MPOL_PREFERRED_MANY without exposing UAPI (Ben)
Fixes for checkpatch (Ben)

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1098995f234d..33bf29ddfab2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -31,6 +31,9 @@
  *                but useful to set in a VMA when you have a non default
  *                process policy.
  *
+ * preferred many Try a set of nodes first before normal fallback. This is
+ *                similar to preferred without the special case.
+ *
  * default        Allocate on the local node first, or when on a VMA
  *                use the process policy. This is what Linux always did
  *		  in a NUMA aware kernel and still does by, ahem, default.
@@ -105,6 +108,8 @@
 
 #include "internal.h"
 
+#define MPOL_PREFERRED_MANY MPOL_MAX
+
 /* Internal flags */
 #define MPOL_MF_DISCONTIG_OK (MPOL_MF_INTERNAL << 0)	/* Skip checks for continuous vmas */
 #define MPOL_MF_INVERT (MPOL_MF_INTERNAL << 1)		/* Invert check for nodemask */
@@ -175,7 +180,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
 static const struct mempolicy_operations {
 	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
 	void (*rebind)(struct mempolicy *pol, const nodemask_t *nodes);
-} mpol_ops[MPOL_MAX];
+} mpol_ops[MPOL_MAX + 1];
 
 static inline int mpol_store_user_nodemask(const struct mempolicy *pol)
 {
@@ -415,7 +420,7 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 	mmap_write_unlock(mm);
 }
 
-static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
+static const struct mempolicy_operations mpol_ops[MPOL_MAX + 1] = {
 	[MPOL_DEFAULT] = {
 		.rebind = mpol_rebind_default,
 	},
@@ -432,6 +437,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.rebind = mpol_rebind_nodemask,
 	},
 	/* [MPOL_LOCAL] - see mpol_new() */
+	[MPOL_PREFERRED_MANY] = {
+		.create = NULL,
+		.rebind = NULL,
+	},
 };
 
 static int migrate_page_add(struct page *page, struct list_head *pagelist,
@@ -915,6 +924,9 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	case MPOL_INTERLEAVE:
 		*nodes = p->v.nodes;
 		break;
+	case MPOL_PREFERRED_MANY:
+		*nodes = p->v.preferred_nodes;
+		break;
 	case MPOL_PREFERRED:
 		if (!(p->flags & MPOL_F_LOCAL))
 			*nodes = p->v.preferred_nodes;
@@ -1910,7 +1922,9 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 static int policy_node(gfp_t gfp, struct mempolicy *policy,
 								int nd)
 {
-	if (policy->mode == MPOL_PREFERRED && !(policy->flags & MPOL_F_LOCAL)) {
+	if ((policy->mode == MPOL_PREFERRED ||
+	     policy->mode == MPOL_PREFERRED_MANY) &&
+	    !(policy->flags & MPOL_F_LOCAL)) {
 		nd = first_node(policy->v.preferred_nodes);
 	} else {
 		/*
@@ -1953,6 +1967,7 @@ unsigned int mempolicy_slab_node(void)
 		return node;
 
 	switch (policy->mode) {
+	case MPOL_PREFERRED_MANY:
 	case MPOL_PREFERRED:
 		/*
 		 * handled MPOL_F_LOCAL above
@@ -2087,6 +2102,9 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	task_lock(current);
 	mempolicy = current->mempolicy;
 	switch (mempolicy->mode) {
+	case MPOL_PREFERRED_MANY:
+		*mask = mempolicy->v.preferred_nodes;
+		break;
 	case MPOL_PREFERRED:
 		if (mempolicy->flags & MPOL_F_LOCAL)
 			nid = numa_node_id();
@@ -2141,6 +2159,9 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 		 * nodes in mask.
 		 */
 		break;
+	case MPOL_PREFERRED_MANY:
+		ret = nodes_intersects(mempolicy->v.preferred_nodes, *mask);
+		break;
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		ret = nodes_intersects(mempolicy->v.nodes, *mask);
@@ -2225,10 +2246,13 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * node and don't fall back to other nodes, as the cost of
 		 * remote accesses would likely offset THP benefits.
 		 *
-		 * If the policy is interleave, or does not allow the current
-		 * node in its nodemask, we allocate the standard way.
+		 * If the policy is interleave or multiple preferred nodes, or
+		 * does not allow the current node in its nodemask, we allocate
+		 * the standard way.
 		 */
-		if (pol->mode == MPOL_PREFERRED && !(pol->flags & MPOL_F_LOCAL))
+		if ((pol->mode == MPOL_PREFERRED ||
+		     pol->mode == MPOL_PREFERRED_MANY) &&
+		    !(pol->flags & MPOL_F_LOCAL))
 			hpage_node = first_node(pol->v.preferred_nodes);
 
 		nmask = policy_nodemask(gfp, pol);
@@ -2364,6 +2388,9 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		return !!nodes_equal(a->v.nodes, b->v.nodes);
+	case MPOL_PREFERRED_MANY:
+		return !!nodes_equal(a->v.preferred_nodes,
+				     b->v.preferred_nodes);
 	case MPOL_PREFERRED:
 		/* a's ->flags is the same as b's */
 		if (a->flags & MPOL_F_LOCAL)
@@ -2532,6 +2559,8 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		polnid = zone_to_nid(z->zone);
 		break;
 
+	/* case MPOL_PREFERRED_MANY: */
+
 	default:
 		BUG();
 	}
@@ -2883,6 +2912,7 @@ static const char * const policy_modes[] =
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
 	[MPOL_LOCAL]      = "local",
+	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
 
 
@@ -2962,6 +2992,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		if (!nodelist)
 			err = 0;
 		goto out;
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 		/*
 		 * Insist on a nodelist
@@ -3044,6 +3075,9 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	switch (mode) {
 	case MPOL_DEFAULT:
 		break;
+	case MPOL_PREFERRED_MANY:
+		WARN_ON(flags & MPOL_F_LOCAL);
+		fallthrough;
 	case MPOL_PREFERRED:
 		if (flags & MPOL_F_LOCAL)
 			mode = MPOL_LOCAL;
-- 
2.27.0

