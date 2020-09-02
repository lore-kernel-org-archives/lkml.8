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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8F5C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7FE208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="cP6uhp21";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOjyCc0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgIBSHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57639 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727924AbgIBSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C87BE5C01D8;
        Wed,  2 Sep 2020 14:06:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=ws1j/mKPYHXFd
        qyNwo3xjFGDqqtwldYO4m1W2BzXBgU=; b=cP6uhp21LZjEK3HPsSfdk3nRply0h
        woG1gTdXGPQbDfCEYGO6Hhb10dFnSp8VVRKe9+1IVV5V7bhLhF1PPK792xs36ZUt
        L8E3joubwWsCF++JHZSGekQRv+9IrgJ/ioygr3uIGpJPuseNqP9ZJa3MnU8k9bVX
        CQgI35Z03RXq4oLm+FjkyQc+5B84fccBeknsbX0hNy24xWg+5a1mgDsz+Bt1fB2R
        0VtdIPdZ0eJJNMhK2sO8B/SGs5oFWo4c9aP/+LQ9MuSLOs3Q225GIlqBOtAFj97P
        7Mp+sLPOuu8B9w/8y0k61iJlueJwx/1tPA1IsaXMq0KicxURdmxidpT0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ws1j/mKPYHXFdqyNwo3xjFGDqqtwldYO4m1W2BzXBgU=; b=VOjyCc0p
        eT9nNtSZ0qxyKFx3RSDvo+copPgeDQitDQBqeXndq3dt9cigisVB2HU2cHG/QyvJ
        /d0/wf8Oed8TnJJtHMnix3eQqKi7IbkXMKj9ShSTbuFAV0anLPIGU0E5PJQC3ebV
        W1BvW0y7DFLYdArzDLjDBwh307KyNw1G0rPUyaRu+N9C6VadKVgzuCZh5c1Qc2p/
        gQwySLUjhFrEZbFjwm+d1+yOuaeZQwCvHkmbEHQmGY7uGuvT0/vp0Dg4fvV/eGkg
        cWA+j8Lpi4iotTKfSCsejg+4bCjIX28hHYTIBsNvkEX4ALPQb6JuzdUuzUxbZQaC
        IfpXdivBEOBLmA==
X-ME-Sender: <xms:KN9PX7Rg8zkI6G9n1sThRT9GggTBNH3qlYl65eieMNP1KTro5ezGNw>
    <xme:KN9PX8wAaNvvBYeWYLlVxA_72oGVQxhbXDoMfx3N0cUa1IDvgq2sUEo9408R2r6Kk
    jmksTMY9WDvgPiBlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:KN9PXw33b3cu7Zxzkola4xVgtoX2aID56FJmF4F67-bc9HI161lLLw>
    <xmx:KN9PX7BKgb2RWn9LoFrQ06_h6CHqnOeg2Fqt59ttYkXa60tNp_FQYQ>
    <xmx:KN9PX0ixqo_8sTtbc-ZnANwLYW4MvDwWy5FMoUsnv9hpfTr3emhyIA>
    <xmx:KN9PXwhWQ1T0azYYnMShbh0MW3ZSPQQwmQnibK5up4k0R1hYcr8trA>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id E1AA130600A6;
        Wed,  2 Sep 2020 14:06:31 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 05/16] mm: thp: handling 1GB THP reference bit.
Date:   Wed,  2 Sep 2020 14:06:17 -0400
Message-Id: <20200902180628.4052244-6-zi.yan@sent.com>
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

Add PUD-level TLB flush ops and teach page_vma_mapped_talk about 1GB
THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/include/asm/pgtable.h |  3 +++
 arch/x86/mm/pgtable.c          | 13 +++++++++++++
 include/linux/mmu_notifier.h   | 13 +++++++++++++
 include/linux/pgtable.h        | 14 ++++++++++++++
 include/linux/rmap.h           |  1 +
 mm/page_vma_mapped.c           | 33 +++++++++++++++++++++++++++++----
 mm/rmap.c                      | 12 +++++++++---
 7 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 26255cac78c0..15334f5ba172 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1127,6 +1127,9 @@ extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
 extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
 				  unsigned long address, pmd_t *pmdp);
 
+#define __HAVE_ARCH_PUDP_CLEAR_YOUNG_FLUSH
+extern int pudp_clear_flush_young(struct vm_area_struct *vma,
+				  unsigned long address, pud_t *pudp);
 
 #define pmd_write pmd_write
 static inline int pmd_write(pmd_t pmd)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7be73aee6183..e4a2dffcc418 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -633,6 +633,19 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
 
 	return young;
 }
+int pudp_clear_flush_young(struct vm_area_struct *vma,
+			   unsigned long address, pud_t *pudp)
+{
+	int young;
+
+	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
+
+	young = pudp_test_and_clear_young(vma, address, pudp);
+	if (young)
+		flush_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+
+	return young;
+}
 #endif
 
 /**
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index b8200782dede..4ffa179e654f 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -557,6 +557,19 @@ static inline void mmu_notifier_range_init_migrate(
 	__young;							\
 })
 
+#define pudp_clear_flush_young_notify(__vma, __address, __pudp)		\
+({									\
+	int __young;							\
+	struct vm_area_struct *___vma = __vma;				\
+	unsigned long ___address = __address;				\
+	__young = pudp_clear_flush_young(___vma, ___address, __pudp);	\
+	__young |= mmu_notifier_clear_flush_young(___vma->vm_mm,	\
+						  ___address,		\
+						  ___address +		\
+							PUD_SIZE);	\
+	__young;							\
+})
+
 #define ptep_clear_young_notify(__vma, __address, __ptep)		\
 ({									\
 	int __young;							\
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 255275d5b73e..8ef358c386af 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -240,6 +240,20 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef __HAVE_ARCH_PUDP_CLEAR_YOUNG_FLUSH
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+extern int pudp_clear_flush_young(struct vm_area_struct *vma,
+				  unsigned long address, pud_t *pudp);
+#else
+int pudp_clear_flush_young(struct vm_area_struct *vma,
+				  unsigned long address, pud_t *pudp)
+{
+	BUILD_BUG();
+	return 0;
+}
+#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD  */
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 3a6adfa70fb0..0af61dd193d2 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -206,6 +206,7 @@ struct page_vma_mapped_walk {
 	struct page *page;
 	struct vm_area_struct *vma;
 	unsigned long address;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
 	spinlock_t *ptl;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 5e77b269c330..d9d39ec06e21 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -145,9 +145,12 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	struct page *page = pvmw->page;
 	pgd_t *pgd;
 	p4d_t *p4d;
-	pud_t *pud;
+	pud_t pude;
 	pmd_t pmde;
 
+	if (!pvmw->pte && !pvmw->pmd && pvmw->pud)
+		return not_found(pvmw);
+
 	/* The only possible pmd mapping has been handled on last iteration */
 	if (pvmw->pmd && !pvmw->pte)
 		return not_found(pvmw);
@@ -174,10 +177,31 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	p4d = p4d_offset(pgd, pvmw->address);
 	if (!p4d_present(*p4d))
 		return false;
-	pud = pud_offset(p4d, pvmw->address);
-	if (!pud_present(*pud))
+	pvmw->pud = pud_offset(p4d, pvmw->address);
+
+	/*
+	 * Make sure the pud value isn't cached in a register by the
+	 * compiler and used as a stale value after we've observed a
+	 * subsequent update.
+	 */
+	pude = READ_ONCE(*pvmw->pud);
+	if (pud_trans_huge(pude)) {
+		pvmw->ptl = pud_lock(mm, pvmw->pud);
+		if (likely(pud_trans_huge(*pvmw->pud))) {
+			if (pvmw->flags & PVMW_MIGRATION)
+				return not_found(pvmw);
+			if (pud_page(*pvmw->pud) != page)
+				return not_found(pvmw);
+			return true;
+		} else {
+			/* THP pud was split under us: handle on pmd level */
+			spin_unlock(pvmw->ptl);
+			pvmw->ptl = NULL;
+		}
+	} else if (!pud_present(pude))
 		return false;
-	pvmw->pmd = pmd_offset(pud, pvmw->address);
+
+	pvmw->pmd = pmd_offset(pvmw->pud, pvmw->address);
 	/*
 	 * Make sure the pmd value isn't cached in a register by the
 	 * compiler and used as a stale value after we've observed a
@@ -213,6 +237,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 	} else if (!pmd_present(pmde)) {
 		return false;
 	}
+
 	if (!map_pte(pvmw))
 		goto next_pte;
 	while (1) {
diff --git a/mm/rmap.c b/mm/rmap.c
index 10195a2421cf..77cec0658b76 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -803,9 +803,15 @@ static bool page_referenced_one(struct page *page, struct vm_area_struct *vma,
 					referenced++;
 			}
 		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-			if (pmdp_clear_flush_young_notify(vma, address,
-						pvmw.pmd))
-				referenced++;
+			if (pvmw.pmd) {
+				if (pmdp_clear_flush_young_notify(vma, address,
+							pvmw.pmd))
+					referenced++;
+			} else if (pvmw.pud) {
+				if (pudp_clear_flush_young_notify(vma, address,
+							pvmw.pud))
+					referenced++;
+			}
 		} else {
 			/* unexpected pmd-mapped page? */
 			WARN_ON_ONCE(1);
-- 
2.28.0

