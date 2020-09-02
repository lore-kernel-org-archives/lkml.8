Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C62C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50EF2083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="W993RT4Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYCdfcFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgIBSH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60475 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727940AbgIBSGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id F26395C021E;
        Wed,  2 Sep 2020 14:06:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=x0au+BqqFQ547
        Y2Nkd3x3yYveCHO8htqJqOYoJY8xgY=; b=W993RT4Z+UfTDB8hiyR98Nncw3Zum
        Nwo2R/KiaS/dSOvMsrxY2lD6MfMTqZ5uuTobCfqclpiM6V2Rg3D0VraBdyzWhlgI
        E4C1btPcssm+aEnqm1fNTk7kT3k/WSMZUoetoDZf+7qVOq34zGcttnjQvT5mPcOe
        BBi3WuXoaa3y5b91zYnCzdN1+aDZmocGL3VD6wYRPGP4hJy+vSqLZAZEI9HiET9M
        S90/ryHmIX1RENjtB12gYJJfpbTqdrrchEriHYuAl7nXgwdCuRy2b5UuCzGntGmH
        v2XjOeQpbNZ7wDSBKQ1mKh03kNRiIX4bjAXpy1nQqNo7B0HJNtS4PVqDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=x0au+BqqFQ547Y2Nkd3x3yYveCHO8htqJqOYoJY8xgY=; b=JYCdfcFh
        kC1U+EmfPS6SePapwBIkljtrpgHC/x7tgGdsQpelqsvYbZn1pgZ+y+iypQvA+jz+
        QfTvci54nM2T7V90I/ETySUO5Iv6+ThkUhmSuO6sIvSU/VNK72LxozhGdB32TKrs
        JcEAnHPlI4Pn9bVoG3EXpvhA4MafmZMttJGhmi2947QtkiNXPxdgnFVrK75K9h2f
        yc1kpnsEgk1KzweTIyt+1m2ph8z5tLDmZoe7Kd1I+5NnXRPrEqPtlBsOi19gEnH+
        7j1VH0DbrAPTlZVSKQWWrWPYJfvjObRxthL/iZ6lO9evrSCuPnmuqNwmkbbYDpTZ
        SouX2dHQsi4CXQ==
X-ME-Sender: <xms:Kd9PX8Y8pT02OsjZ5x0hG8QukN2BBfPm_9T9ORLAAvdcoZNEI_huMg>
    <xme:Kd9PX3bgcrZbox20795Y7GpKYrSa3MYJDz5xibvYm-ZHVIlAoUwHjul8C4Yq0cShJ
    PZIgV0_vztLHtvETw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:Kd9PX2_uuxwnHlDFx8fd0NQ3B8EZqWLNL2vMxrwWlH--Ba-T3vDW7Q>
    <xmx:Kd9PX2qrc2mnZZPpnfqrdJeKYp7VGqiqLbrs12ooW3pN5oxoWTQOwA>
    <xmx:Kd9PX3r8PAABIYVJdIBJ3DhBTeoR4U4oNHsQKJ3fCo7OvWGXGXYR3Q>
    <xmx:Kd9PXzJ0zSCx0BRBnBmNHvE5UOxjDFJdpOU9Cht4OLzvMbzp7t6Glw>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 23F1430600B4;
        Wed,  2 Sep 2020 14:06:33 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 10/16] mm: thp: split 1GB THPs at page reclaim.
Date:   Wed,  2 Sep 2020 14:06:22 -0400
Message-Id: <20200902180628.4052244-11-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902180628.4052244-1-zi.yan@sent.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

We cannot swap 1GB THPs, so split them before swap them out.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/swap_slots.c |  2 ++
 mm/vmscan.c     | 58 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 3e6453573a89..65b8742a0446 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -312,6 +312,8 @@ swp_entry_t get_swap_page(struct page *page)
 	entry.val = 0;
 
 	if (PageTransHuge(page)) {
+		if (compound_order(page) == HPAGE_PUD_ORDER)
+			return entry;
 		if (IS_ENABLED(CONFIG_THP_SWAP))
 			get_swap_pages(1, &entry, HPAGE_PMD_NR);
 		goto out;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 99e1796eb833..617d15a041f8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1240,23 +1240,49 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				if (!(sc->gfp_mask & __GFP_IO))
 					goto keep_locked;
 				if (PageTransHuge(page)) {
-					/* cannot split THP, skip it */
-					if (!can_split_huge_page(page, NULL))
-						goto activate_locked;
-					/*
-					 * Split pages without a PMD map right
-					 * away. Chances are some or all of the
-					 * tail pages can be freed without IO.
-					 */
-					if (!compound_mapcount(page) &&
-					    split_huge_page_to_list(page,
-								    page_list))
+					if (compound_order(page) == HPAGE_PUD_ORDER) {
+						/* cannot split THP, skip it */
+						if (!can_split_huge_pud_page(page, NULL))
+							goto activate_locked;
+						/*
+						 * Split pages without a PUD map right
+						 * away. Chances are some or all of the
+						 * tail pages can be freed without IO.
+						 */
+						if (!compound_mapcount(page) &&
+							split_huge_pud_page_to_list(page,
+										page_list))
+							goto activate_locked;
+					}
+					if (compound_order(page) == HPAGE_PMD_ORDER) {
+						/* cannot split THP, skip it */
+						if (!can_split_huge_page(page, NULL))
+							goto activate_locked;
+						/*
+						 * Split pages without a PMD map right
+						 * away. Chances are some or all of the
+						 * tail pages can be freed without IO.
+						 */
+						if (!compound_mapcount(page) &&
+							split_huge_page_to_list(page,
+										page_list))
+							goto activate_locked;
+					}
+				}
+				/* Split PUD THPs before swapping */
+				if (compound_order(page) == HPAGE_PUD_ORDER) {
+					if (split_huge_pud_page_to_list(page, page_list))
 						goto activate_locked;
+					else {
+						sc->nr_scanned -= (nr_pages - HPAGE_PMD_NR);
+						nr_pages = HPAGE_PMD_NR;
+					}
 				}
 				if (!add_to_swap(page)) {
 					if (!PageTransHuge(page))
 						goto activate_locked_split;
 					/* Fallback to swap normal pages */
+					VM_BUG_ON_PAGE(compound_order(page) != HPAGE_PMD_ORDER, page);
 					if (split_huge_page_to_list(page,
 								    page_list))
 						goto activate_locked;
@@ -1273,6 +1299,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				mapping = page_mapping(page);
 			}
 		} else if (unlikely(PageTransHuge(page))) {
+			VM_BUG_ON_PAGE(compound_order(page) != HPAGE_PMD_ORDER, page);
 			/* Split file THP */
 			if (split_huge_page_to_list(page, page_list))
 				goto keep_locked;
@@ -1298,9 +1325,12 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
 			bool was_swapbacked = PageSwapBacked(page);
 
-			if (unlikely(PageTransHuge(page)))
-				flags |= TTU_SPLIT_HUGE_PMD;
-
+			if (unlikely(PageTransHuge(page))) {
+				if (compound_order(page) == HPAGE_PMD_ORDER)
+					flags |= TTU_SPLIT_HUGE_PMD;
+				else if (compound_order(page) == HPAGE_PUD_ORDER)
+					flags |= TTU_SPLIT_HUGE_PUD;
+			}
 			if (!try_to_unmap(page, flags)) {
 				stat->nr_unmap_fail += nr_pages;
 				if (!was_swapbacked && PageSwapBacked(page))
-- 
2.28.0

