Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87A5C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B3820663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgF3VZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:25:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:43377 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbgF3VZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:25:28 -0400
IronPort-SDR: uokXXvGJZMbKtjWjojvTQITMQUXpRU0ICWeeDH9ufBLLpRXZZjHNDgfmJmASlnzE59Es2Osxab
 o/IoaFWpVlgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134676818"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="134676818"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:25 -0700
IronPort-SDR: 4+7cRLuAWyAT8sTbObsbjZgxHy7VffO0F4uOKj3ndsLDqqlKVCgamUHtvDiFuekZHQLoLUR5I0
 ZtfbCNfNp09Q==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481336277"
Received: from schittin-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.132.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:24 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 07/12] mm/mempolicy: handle MPOL_PREFERRED_MANY like BIND
Date:   Tue, 30 Jun 2020 14:25:12 -0700
Message-Id: <20200630212517.308045-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630212517.308045-1-ben.widawsky@intel.com>
References: <20200630212517.308045-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch begins the real plumbing for handling this new policy. Now
that the internal representation for preferred nodes and bound nodes is
the same, and we can envision what multiple preferred nodes will behave
like, there are obvious places where we can simply reuse the bind
behavior.

In v1 of this series, the moral equivalent was:
"mm: Finish handling MPOL_PREFERRED_MANY". Like that, this attempts to
implement the easiest spots for the new policy. Unlike that, this just
reuses BIND.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e71ebc906ff0..3b38c9c4e580 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -950,8 +950,6 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	switch (p->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		*nodes = p->nodes;
-		break;
 	case MPOL_PREFERRED_MANY:
 		*nodes = p->nodes;
 		break;
@@ -1938,7 +1936,8 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 {
 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
-	if (unlikely(policy->mode == MPOL_BIND) &&
+	if (unlikely(policy->mode == MPOL_BIND ||
+		     policy->mode == MPOL_PREFERRED_MANY) &&
 	    apply_policy_zone(policy, gfp_zone(gfp)) &&
 	    cpuset_nodemask_valid_mems_allowed(&policy->nodes))
 		return &policy->nodes;
@@ -1995,7 +1994,6 @@ unsigned int mempolicy_slab_node(void)
 		return node;
 
 	switch (policy->mode) {
-	case MPOL_PREFERRED_MANY:
 	case MPOL_PREFERRED:
 		/*
 		 * handled MPOL_F_LOCAL above
@@ -2005,6 +2003,7 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
 
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND: {
 		struct zoneref *z;
 
@@ -2020,6 +2019,7 @@ unsigned int mempolicy_slab_node(void)
 		return z->zone ? zone_to_nid(z->zone) : node;
 	}
 
+
 	default:
 		BUG();
 	}
@@ -2130,9 +2130,6 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	task_lock(current);
 	mempolicy = current->mempolicy;
 	switch (mempolicy->mode) {
-	case MPOL_PREFERRED_MANY:
-		*mask = mempolicy->nodes;
-		break;
 	case MPOL_PREFERRED:
 		if (mempolicy->flags & MPOL_F_LOCAL)
 			nid = numa_node_id();
@@ -2143,6 +2140,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_MANY:
 		*mask = mempolicy->nodes;
 		break;
 
@@ -2186,12 +2184,11 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 		 * Thus, it's possible for tsk to have allocated memory from
 		 * nodes in mask.
 		 */
-		break;
-	case MPOL_PREFERRED_MANY:
 		ret = nodes_intersects(mempolicy->nodes, *mask);
 		break;
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_MANY:
 		ret = nodes_intersects(mempolicy->nodes, *mask);
 		break;
 	default:
@@ -2415,7 +2412,6 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	switch (a->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_PREFERRED_MANY:
 		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_PREFERRED:
@@ -2569,6 +2565,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 			polnid = first_node(pol->nodes);
 		break;
 
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 
 		/*
@@ -2585,8 +2582,6 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		polnid = zone_to_nid(z->zone);
 		break;
 
-	/* case MPOL_PREFERRED_MANY: */
-
 	default:
 		BUG();
 	}
@@ -3099,15 +3094,13 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	switch (mode) {
 	case MPOL_DEFAULT:
 		break;
-	case MPOL_PREFERRED_MANY:
-		WARN_ON(flags & MPOL_F_LOCAL);
-		fallthrough;
 	case MPOL_PREFERRED:
 		if (flags & MPOL_F_LOCAL)
 			mode = MPOL_LOCAL;
 		else
 			nodes_or(nodes, nodes, pol->nodes);
 		break;
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		nodes = pol->nodes;
-- 
2.27.0

