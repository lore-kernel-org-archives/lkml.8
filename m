Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D700C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5342820663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbgF3VZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:25:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:43380 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730380AbgF3VZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:25:29 -0400
IronPort-SDR: xR0JErR01yx3enhUg8Uq2pwE+EeEUAEhCvqXrr1hx0D5Vq0nSuQ2rLNYWo1MVYJk9oed6tRwFr
 vWf06vxj4jkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134676822"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="134676822"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:27 -0700
IronPort-SDR: b6SwilEx9q+8Qz2Y8NdZPIh0mgxRNDJuxOvQ6jURPIacvIwNLPbSqGU8YHr8giEm4vKTY4lfys
 5a5jWIF7w+cw==
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="481336298"
Received: from schittin-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.132.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:25:26 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 11/12] mm/mempolicy: huge-page allocation for many preferred
Date:   Tue, 30 Jun 2020 14:25:16 -0700
Message-Id: <20200630212517.308045-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630212517.308045-1-ben.widawsky@intel.com>
References: <20200630212517.308045-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the missing huge page allocation functionality
while obeying the preferred node semantics.

Like the previous patches, this uses a fallback mechanism to try
multiple preferred nodes first, and then all other nodes. It cannot use
the helper function that was introduced because huge page allocation
already has its own helpers and it was more LOC, and effort to try to
consolidate that.

The weirdness in this patch is it cannot yet use MPOL_PREFERRED_MANY
because it is part of the UAPI we haven't yet exposed. Instead of
make that define global, it's simply changed with the UAPI patch.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/hugetlb.c   | 20 +++++++++++++++++---
 mm/mempolicy.c |  3 ++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74e3aae..46e94675de44 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1103,7 +1103,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 				unsigned long address, int avoid_reserve,
 				long chg)
 {
-	struct page *page;
+	struct page *page = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask;
 	nodemask_t *nodemask;
@@ -1124,7 +1124,14 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
+		page = dequeue_huge_page_nodemask(h, gfp_mask | __GFP_RETRY_MAYFAIL,
+						  nid, nodemask);
+		if (!page)
+			page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
+	} else {
+		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	}
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
 		SetPagePrivate(page);
 		h->resv_huge_pages--;
@@ -1972,7 +1979,14 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	nodemask_t *nodemask;
 
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
-	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
+		page = alloc_surplus_huge_page(h, gfp_mask | __GFP_RETRY_MAYFAIL,
+					       nid, nodemask);
+		if (!page)
+			alloc_surplus_huge_page(h, gfp_mask, nid, NULL);
+	} else {
+		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	}
 	mpol_cond_put(mpol);
 
 	return page;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 51ac0d4a2eda..53390c2e0aca 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2097,7 +2097,8 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
 					huge_page_shift(hstate_vma(vma)));
 	} else {
 		nid = policy_node(gfp_flags, *mpol, numa_node_id());
-		if ((*mpol)->mode == MPOL_BIND)
+		if ((*mpol)->mode == MPOL_BIND ||
+		    (*mpol)->mode == MPOL_PREFERRED_MANY)
 			*nodemask = &(*mpol)->nodes;
 	}
 	return nid;
-- 
2.27.0

