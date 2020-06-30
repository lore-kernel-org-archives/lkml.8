Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947DDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B05B2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgF3VZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:25:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:43379 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbgF3VZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:25:29 -0400
IronPort-SDR: GtymgMFP5i6yMeX8gG5Ra6C2B0R50exf7aD6daghq7/Xa8l542mMynwLMvshXb0k85Zn4JPAXF
 YqB9t15LPOWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134676821"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="134676821"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:26 -0700
IronPort-SDR: qWxOIhL7nJJh0zS00TYWJugW1j+mNLWMxg4HVF+3r0kt5FQiYEUuz4ti33qSn8YqMi0x1CXO0f
 6FGbE6q+/+EA==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481336293"
Received: from schittin-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.132.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:26 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 10/12] mm/mempolicy: VMA allocation for many preferred
Date:   Tue, 30 Jun 2020 14:25:15 -0700
Message-Id: <20200630212517.308045-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630212517.308045-1-ben.widawsky@intel.com>
References: <20200630212517.308045-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements MPOL_PREFERRED_MANY for alloc_pages_vma(). Like
alloc_pages_current(), alloc_pages_vma() needs to support policy based
decisions if they've been configured via mbind(2).

The temporary "hack" of treating MPOL_PREFERRED and MPOL_PREFERRED_MANY
can now be removed with this, too.

All the actual machinery to make this work was part of
("mm/mempolicy: Create a page allocator for policy")

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5fb70e6599a6..51ac0d4a2eda 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2281,8 +2281,6 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 {
 	struct mempolicy *pol;
 	struct page *page;
-	int preferred_nid;
-	nodemask_t *nmask;
 
 	pol = get_vma_policy(vma, addr);
 
@@ -2296,6 +2294,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 	}
 
 	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
+		nodemask_t *nmask;
 		int hpage_node = node;
 
 		/*
@@ -2309,10 +2308,26 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * does not allow the current node in its nodemask, we allocate
 		 * the standard way.
 		 */
-		if ((pol->mode == MPOL_PREFERRED ||
-		     pol->mode == MPOL_PREFERRED_MANY) &&
-		    !(pol->flags & MPOL_F_LOCAL))
+		if (pol->mode == MPOL_PREFERRED || !(pol->flags & MPOL_F_LOCAL)) {
 			hpage_node = first_node(pol->nodes);
+		} else if (pol->mode == MPOL_PREFERRED_MANY) {
+			struct zoneref *z;
+
+			/*
+			 * In this policy, with direct reclaim, the normal
+			 * policy based allocation will do the right thing - try
+			 * twice using the preferred nodes first, and all nodes
+			 * second.
+			 */
+			if (gfp & __GFP_DIRECT_RECLAIM) {
+				page = alloc_pages_policy(pol, gfp, order, NUMA_NO_NODE);
+				goto out;
+			}
+
+			z = first_zones_zonelist(node_zonelist(numa_node_id(), GFP_HIGHUSER),
+						 gfp_zone(GFP_HIGHUSER), &pol->nodes);
+			hpage_node = zone_to_nid(z->zone);
+		}
 
 		nmask = policy_nodemask(gfp, pol);
 		if (!nmask || node_isset(hpage_node, *nmask)) {
@@ -2338,9 +2353,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		}
 	}
 
-	nmask = policy_nodemask(gfp, pol);
-	preferred_nid = policy_node(gfp, pol, node);
-	page = __alloc_pages_nodemask(gfp, order, preferred_nid, nmask);
+	page = alloc_pages_policy(pol, gfp, order, NUMA_NO_NODE);
 	mpol_cond_put(pol);
 out:
 	return page;
-- 
2.27.0

