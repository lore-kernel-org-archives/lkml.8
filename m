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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D086C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D96206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="BHObYdXY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jpg7/LhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgIBSHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51695 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727933AbgIBSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BB2405C0062;
        Wed,  2 Sep 2020 14:06:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=CxP3EmNT0ija5
        U7GfdqrSeZNSEhYP1PIMWR4kSDGPAs=; b=BHObYdXYSlL9I8rrCWWVt9kcsmhrn
        GWMe5SZQRUF5gSXWFvFcx/YGAahOtaBu6DYGucDGmLl2vpl+g1hZgc/ocbvjeNjh
        E7SYML3I0DqIF4zgI2zDNRd1RX0uwE/MJBjlDxI5an28o+imB0McBkDoEfJ91t95
        zpR5SJG8JkBaIEwU+UT5qlb3vHZOzPyu+7dILFrLdsy5oJtoqekeoCPmt+JH/v08
        T8+zAjqkGxqT7PyVeQmApMq2Twr0meBoEh253bhlqYRtMgu2MB0Mv/+9GtILw8ZC
        JIIFZ6acVDDV9WCQUiNlHa7Lal18MHoPaJ5Jv0AagFHpOArkNvgJIbMuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=CxP3EmNT0ija5U7GfdqrSeZNSEhYP1PIMWR4kSDGPAs=; b=jpg7/LhL
        OvW0kfEFjAFU+9wGt9zmb/UbPlEsZY6nPgryB9dpJX5yvM6/wtM7sAnTsCoaytPy
        KKYZvBJEysK+IXlp114Bp0a54qsgeu+Hq2nMsv3A9aQV92QvojZ5/z8omcuZaGrE
        5wGpvbf99ZDsn/ot1Z93A5mfJfTXvgZJ6VwAdymghqIFKdoJMkxr7wzw9TYjSfXm
        ldblC/uK/L/HMdacAbsABt/1P2lSjQG0c1/dmDvdudHhAgwOalG0jP7tX35/UWYl
        N7IpZecICXpAzZNSIejCqvRj3NcJv+s1h5g/fBBvDIuk0cRowu4cENGxgSyqnu4x
        LXe2zmxVgj12Cg==
X-ME-Sender: <xms:KN9PX13LdIFlUY-ibq8wS4RhOW7YodF7YFm6zwQWFDVvIwhZrfSeJw>
    <xme:KN9PX8FAInUBQlZblpzuPnF6V4EAcId579v98geSU3bgcW5RaUIuTgvvRxTec5j4z
    ju6tjk3kwP9eDwRzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:Kd9PX15QD609OOORRz3xrtC2I-0k8Hfd3-E1f-NK7KYh7WYVbYrYqg>
    <xmx:Kd9PXy0YRVGVmyKmgh2sjtBT6F4DvcuIlQoOwJeyQmGutlco7VPiCA>
    <xmx:Kd9PX4F94zkpQh8O0qoo7XYJ8WF6YPChWwJwDkdgHZ9VyzIovAogeg>
    <xmx:Kd9PXz19EaygktP_CbZKNP2pPxBBfINdjez8xElmEOFIPE5rwMbDMg>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id A5D2E3060067;
        Wed,  2 Sep 2020 14:06:32 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 08/16] mm: page_vma_walk: teach it about PMD-mapped PUD THP.
Date:   Wed,  2 Sep 2020 14:06:20 -0400
Message-Id: <20200902180628.4052244-9-zi.yan@sent.com>
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

We now have PMD-mapped PUD THP and PTE-mapped PUD THP, page_vma_walk
should handle them properly.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_vma_mapped.c | 116 ++++++++++++++++++++++++++++++-------------
 1 file changed, 82 insertions(+), 34 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index d9d39ec06e21..549e296287fd 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -52,6 +52,22 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
 	return true;
 }
 
+static bool map_pmd(struct page_vma_mapped_walk *pvmw)
+{
+	pmd_t pmde;
+
+	pvmw->pmd = pmd_offset(pvmw->pud, pvmw->address);
+	pmde = READ_ONCE(*pvmw->pmd);
+	if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
+		pvmw->ptl = pmd_lock(pvmw->vma->vm_mm, pvmw->pmd);
+		return true;
+	} else if (!pmd_present(pmde))
+		return false;
+
+	pvmw->ptl = pmd_lock(pvmw->vma->vm_mm, pvmw->pmd);
+	return true;
+}
+
 static inline bool pfn_is_match(struct page *page, unsigned long pfn)
 {
 	unsigned long page_pfn = page_to_pfn(page);
@@ -115,6 +131,38 @@ static bool check_pte(struct page_vma_mapped_walk *pvmw)
 	return pfn_is_match(pvmw->page, pfn);
 }
 
+/* 0: not mapped, 1: pmd_page, 2: pmd  */
+static int check_pmd(struct page_vma_mapped_walk *pvmw)
+{
+	unsigned long pfn;
+
+	if (likely(pmd_trans_huge(*pvmw->pmd))) {
+		if (pvmw->flags & PVMW_MIGRATION)
+			return 0;
+		pfn = pmd_pfn(*pvmw->pmd);
+		if (!pfn_is_match(pvmw->page, pfn))
+			return 0;
+		return 1;
+	} else if (!pmd_present(*pvmw->pmd)) {
+		if (thp_migration_supported()) {
+			if (!(pvmw->flags & PVMW_MIGRATION))
+				return 0;
+			if (is_migration_entry(pmd_to_swp_entry(*pvmw->pmd))) {
+				swp_entry_t entry = pmd_to_swp_entry(*pvmw->pmd);
+
+				pfn = migration_entry_to_pfn(entry);
+				if (!pfn_is_match(pvmw->page, pfn))
+					return 0;
+				return 1;
+			}
+		}
+		return 0;
+	}
+	/* THP pmd was split under us: handle on pte level */
+	spin_unlock(pvmw->ptl);
+	pvmw->ptl = NULL;
+	return 2;
+}
 /**
  * page_vma_mapped_walk - check if @pvmw->page is mapped in @pvmw->vma at
  * @pvmw->address
@@ -146,14 +194,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t pude;
-	pmd_t pmde;
+	int pmd_res;
 
 	if (!pvmw->pte && !pvmw->pmd && pvmw->pud)
 		return not_found(pvmw);
 
 	/* The only possible pmd mapping has been handled on last iteration */
 	if (pvmw->pmd && !pvmw->pte)
-		return not_found(pvmw);
+		goto next_pmd;
 
 	if (pvmw->pte)
 		goto next_pte;
@@ -201,43 +249,43 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	} else if (!pud_present(pude))
 		return false;
 
-	pvmw->pmd = pmd_offset(pvmw->pud, pvmw->address);
-	/*
-	 * Make sure the pmd value isn't cached in a register by the
-	 * compiler and used as a stale value after we've observed a
-	 * subsequent update.
-	 */
-	pmde = READ_ONCE(*pvmw->pmd);
-	if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
-		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-		if (likely(pmd_trans_huge(*pvmw->pmd))) {
-			if (pvmw->flags & PVMW_MIGRATION)
-				return not_found(pvmw);
-			if (pmd_page(*pvmw->pmd) != page)
-				return not_found(pvmw);
+	if (!map_pmd(pvmw))
+		goto next_pmd;
+	/* pmd locked after map_pmd  */
+	while (1) {
+		pmd_res = check_pmd(pvmw);
+		if (pmd_res == 1) /* pmd_page */
 			return true;
-		} else if (!pmd_present(*pvmw->pmd)) {
-			if (thp_migration_supported()) {
-				if (!(pvmw->flags & PVMW_MIGRATION))
-					return not_found(pvmw);
-				if (is_migration_entry(pmd_to_swp_entry(*pvmw->pmd))) {
-					swp_entry_t entry = pmd_to_swp_entry(*pvmw->pmd);
-
-					if (migration_entry_to_page(entry) != page)
-						return not_found(pvmw);
-					return true;
+		else if (pmd_res == 2) /* pmd entry  */
+			goto pte_level;
+next_pmd:
+		/* Only PMD-mapped PUD THP has next pmd  */
+		if (!(PageTransHuge(pvmw->page) && compound_order(pvmw->page) == HPAGE_PUD_ORDER))
+			return not_found(pvmw);
+		do {
+			pvmw->address += HPAGE_PMD_SIZE;
+			if (pvmw->address >= pvmw->vma->vm_end ||
+			    pvmw->address >=
+					__vma_address(pvmw->page, pvmw->vma) +
+					thp_nr_pages(pvmw->page) * PAGE_SIZE)
+				return not_found(pvmw);
+			/* Did we cross page table boundary? */
+			if (pvmw->address % PUD_SIZE == 0) {
+				if (pvmw->ptl) {
+					spin_unlock(pvmw->ptl);
+					pvmw->ptl = NULL;
 				}
+				goto restart;
+			} else {
+				pvmw->pmd++;
 			}
-			return not_found(pvmw);
-		} else {
-			/* THP pmd was split under us: handle on pte level */
-			spin_unlock(pvmw->ptl);
-			pvmw->ptl = NULL;
-		}
-	} else if (!pmd_present(pmde)) {
-		return false;
+		} while (pmd_none(*pvmw->pmd));
+
+		if (!pvmw->ptl)
+			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 	}
 
+pte_level:
 	if (!map_pte(pvmw))
 		goto next_pte;
 	while (1) {
-- 
2.28.0

