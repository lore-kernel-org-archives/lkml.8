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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E95C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2D0206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="JoTG8PpH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jFA2qhOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgIBSHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34171 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727923AbgIBSGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 86FAE5C01A9;
        Wed,  2 Sep 2020 14:06:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=clFcHF8RSMWnt
        gVxpYKMJOSLAdjV1uGHbUSJNEeaPm0=; b=JoTG8PpHCt6+MSuCBazIZdfaAO886
        st903/gbM04E2nYNv8727gPF9HMBh/oqKFgx1YmRs84dnUSNs/omDvdmPpX4gwG/
        Ew4Uh4RGJ0fETazGEuI+cM5vbwgnGSYkQfET8StsjilICk/J9PlJqpnRBjLtuuwE
        BCjfUSEVtbYMUTkrSm7bH16yPjuMvxGTwmXYtm5EAtYmepVM+02YKgqljUtZYV/Z
        yCKbbHDoLDZtWTWFygbC3/hMzadv+COQfC05AqSECv1sTi8svldpXn5SCRxW9m8i
        CPUxH9XwY78LZ1QuX76yuy7LK31PFU1lsLazJv3gxOMPBvFGmEAJNSahg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=clFcHF8RSMWntgVxpYKMJOSLAdjV1uGHbUSJNEeaPm0=; b=jFA2qhOu
        FrMd+jy72pdOO8/f5IEk4cde1d2AYkQ/c0RGD5QBuAQAEfkgFXD9EYoQR5jIDK0l
        gC9JNi8W/jE3TB1bZrrB8IP2rYmkvfRmzTiOmdNIlOXYWOkWUBqokj1mR/9tmd/e
        jarC8xIX9RSNkaryI9WsfbMxB0CwmtQ9iI7CN6p1QaSFpyG85Rp3AQp5+cyqOwBL
        1fMvaiT+jdoEfsX86CLN7DCiqpE3zVy3tfd2ziuXMHB0TQymw3s3TCd/c2cn77N7
        FvXfmOZrGyL3qy+TTU5XfX4OicNdx+GB7kc3CvO+/qFowjEZFJN24LBRfZws0VrX
        43aIJ6WAOuqCKA==
X-ME-Sender: <xms:J99PX9ozFgcMZGAntC_Quo1Xi32HYB3lyYo1yrDv24b_ihBEtqZa9g>
    <xme:J99PX_oL-BfKtv6QjZ5a7C_xQNXf_QJbsjjBFxXYyYggswGRm2PwV8kyiAfTe_KkQ
    kAM6_5AWEYUAgiK7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:KN9PX6MNON3H1iJHzH8MryWY7LB22bxWlIryR5bjsv92JT2nxAX3zA>
    <xmx:KN9PX46sRb5iWMBvM34wD4mN3ueUj8wRwZ8mID8B3ubCZREWxc8dyg>
    <xmx:KN9PX87Q3Q_eDPz_I2y33rpRkkQPPVKnZOOb35nfv-MTG_QozFOb7A>
    <xmx:KN9PX7aIxCViBYh5mGLOxIBMtG_q3IZVa0EZChh0iGidXFYUkC06pg>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7D5C3060067;
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
Subject: [RFC PATCH 04/16] mm: thp: 1GB THP copy on write implementation.
Date:   Wed,  2 Sep 2020 14:06:16 -0400
Message-Id: <20200902180628.4052244-5-zi.yan@sent.com>
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

COW on 1GB THPs will fall back to 2MB THPs if 1GB THP is not available.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/include/asm/pgalloc.h |  9 ++++++
 include/linux/huge_mm.h        |  5 ++++
 mm/huge_memory.c               | 54 ++++++++++++++++++++++++++++++++++
 mm/memory.c                    |  2 +-
 mm/swapfile.c                  |  4 ++-
 5 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index fae13467d3e1..31221269c387 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -98,6 +98,15 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 #define pmd_pgtable(pmd) pmd_page(pmd)
 
+static inline void pud_populate_with_pgtable(struct mm_struct *mm, pud_t *pud,
+				struct page *pte)
+{
+	unsigned long pfn = page_to_pfn(pte);
+
+	paravirt_alloc_pmd(mm, pfn);
+	set_pud(pud, __pud(((pteval_t)pfn << PAGE_SHIFT) | _PAGE_TABLE));
+}
+
 #if CONFIG_PGTABLE_LEVELS > 2
 static inline pmd_t *pmd_alloc_one_page_with_ptes(struct mm_struct *mm, unsigned long addr)
 {
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7528652400e4..0c20a8ea6911 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -19,6 +19,7 @@ extern int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 extern void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud);
 extern int do_huge_pud_anonymous_page(struct vm_fault *vmf);
+extern vm_fault_t do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud);
 #else
 static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 {
@@ -27,6 +28,10 @@ extern int do_huge_pud_anonymous_page(struct vm_fault *vmf)
 {
 	return VM_FAULT_FALLBACK;
 }
+extern vm_fault_t do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud)
+{
+	return VM_FAULT_FALLBACK;
+}
 #endif
 
 extern vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ec3847392208..6da9b02501b7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1334,6 +1334,60 @@ void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 unlock:
 	spin_unlock(vmf->ptl);
 }
+
+vm_fault_t do_huge_pud_wp_page(struct vm_fault *vmf, pud_t orig_pud)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct page *page = NULL;
+	unsigned long haddr = vmf->address & HPAGE_PUD_MASK;
+
+	vmf->ptl = pud_lockptr(vma->vm_mm, vmf->pud);
+	VM_BUG_ON_VMA(!vma->anon_vma, vma);
+
+	if (is_huge_zero_pud(orig_pud))
+		goto fallback;
+
+	spin_lock(vmf->ptl);
+
+	if (unlikely(!pud_same(*vmf->pud, orig_pud))) {
+		spin_unlock(vmf->ptl);
+		return 0;
+	}
+
+	page = pud_page(orig_pud);
+	VM_BUG_ON_PAGE(!PageCompound(page) || !PageHead(page), page);
+
+	/* Lock page for reuse_swap_page() */
+	if (!trylock_page(page)) {
+		get_page(page);
+		spin_unlock(vmf->ptl);
+		lock_page(page);
+		spin_lock(vmf->ptl);
+		if (unlikely(!pud_same(*vmf->pud, orig_pud))) {
+			unlock_page(page);
+			put_page(page);
+			return 0;
+		}
+		put_page(page);
+	}
+	if (reuse_swap_page(page, NULL)) {
+		pud_t entry;
+
+		entry = pud_mkyoung(orig_pud);
+		entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
+		if (pudp_set_access_flags(vma, haddr, vmf->pud, entry,  1))
+			update_mmu_cache_pud(vma, vmf->address, vmf->pud);
+		unlock_page(page);
+		spin_unlock(vmf->ptl);
+		return VM_FAULT_WRITE;
+	}
+	unlock_page(page);
+	spin_unlock(vmf->ptl);
+fallback:
+	__split_huge_pud(vma, vmf->pud, vmf->address);
+	return VM_FAULT_FALLBACK;
+}
+
 #endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
 void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
diff --git a/mm/memory.c b/mm/memory.c
index 6f86294438fd..b88587256bc1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4165,7 +4165,7 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vmf->vma))
-		return VM_FAULT_FALLBACK;
+		return do_huge_pud_wp_page(vmf, orig_pud);
 	if (vmf->vma->vm_ops->huge_fault)
 		return vmf->vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 20012c0c0252..e3f771c2ad83 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1635,7 +1635,9 @@ static int page_trans_huge_map_swapcount(struct page *page, int *total_mapcount,
 	/* hugetlbfs shouldn't call it */
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 
-	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!PageTransCompound(page))) {
+	if (!IS_ENABLED(CONFIG_THP_SWAP) ||
+	    unlikely(compound_order(compound_head(page)) == HPAGE_PUD_ORDER) ||
+	    likely(!PageTransCompound(page))) {
 		mapcount = page_trans_huge_mapcount(page, total_mapcount);
 		if (PageSwapCache(page))
 			swapcount = page_swapcount(page);
-- 
2.28.0

