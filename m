Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2545FC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5E120659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eA4qP6F2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgBFTV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:21:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:59045 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgBFTV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:21:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48D7bQ5yPCz9tx2j;
        Thu,  6 Feb 2020 20:21:54 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eA4qP6F2; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id u5YvdLrNcwVZ; Thu,  6 Feb 2020 20:21:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48D7bQ4jTfz9tx2C;
        Thu,  6 Feb 2020 20:21:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581016914; bh=VG0VhbYQuAfDWPMKE2lgKw3iWBAVfeVCbcPDNU4BlEI=;
        h=From:Subject:To:Cc:Date:From;
        b=eA4qP6F2wWlut4SdtEbtcfqFej9EqeeBWdsc72/wVjvWZcKaCmQse844duitNqbUq
         imPPpXQSb1F9yqThuSQAGXz2jRlKuUgIO+wiukY4NQQop6OyFhXvrm7LbgeryvhSSl
         38HKVqhZB/ORZQKZyk4VFlELXDU5waQ+5mGEfj8M=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CEBC38B8A5;
        Thu,  6 Feb 2020 20:21:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id M2OH8G-5PC74; Thu,  6 Feb 2020 20:21:54 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 92D238B8A4;
        Thu,  6 Feb 2020 20:21:54 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2B7EA652B0; Thu,  6 Feb 2020 19:21:54 +0000 (UTC)
Message-Id: <4ad03047ac61bfbdad3edb92542dedc807fc3cf4.1581011735.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/2] powerpc/8xx: Merge 8M hugepage slice and basepage slice
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  6 Feb 2020 19:21:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8xx, slices are used because hugepages (512k or 8M) and small
pages (4k or 16k) cannot share the same PGD entry. However, as 8M
entirely covers two PGD entries (One PGD entry covers 4M), there
will implicitely be no conflict between 8M pages and any other size.
So 8M is compatible with the basepage size as well.

Remove the struct slice_mask mask_8m from mm_context_t and make
vma_mmu_pagesize() rely on vma_kernel_pagesize() as the base
slice can now host several sizes.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 7 ++-----
 arch/powerpc/mm/hugetlbpage.c                | 3 ++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index 76af5b0cb16e..54f7f3362edb 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -215,9 +215,8 @@ typedef struct {
 	unsigned char low_slices_psize[SLICE_ARRAY_SIZE];
 	unsigned char high_slices_psize[0];
 	unsigned long slb_addr_limit;
-	struct slice_mask mask_base_psize; /* 4k or 16k */
+	struct slice_mask mask_base_psize; /* 4k or 16k or 8M */
 	struct slice_mask mask_512k;
-	struct slice_mask mask_8m;
 #endif
 	void *pte_frag;
 } mm_context_t;
@@ -257,10 +256,8 @@ static inline struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psiz
 {
 	if (psize == MMU_PAGE_512K)
 		return &ctx->mask_512k;
-	if (psize == MMU_PAGE_8M)
-		return &ctx->mask_8m;
 
-	BUG_ON(psize != mmu_virtual_psize);
+	BUG_ON(psize != mmu_virtual_psize && psize != MMU_PAGE_8M);
 
 	return &ctx->mask_base_psize;
 }
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index edf511c2a30a..0b4ab741bf09 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -551,7 +551,8 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
 {
 	/* With radix we don't use slice, so derive it from vma*/
-	if (IS_ENABLED(CONFIG_PPC_MM_SLICES) && !radix_enabled()) {
+	if (IS_ENABLED(CONFIG_PPC_MM_SLICES) && !IS_ENABLED(CONFIG_PPC_8xx) &&
+	    !radix_enabled()) {
 		unsigned int psize = get_slice_psize(vma->vm_mm, vma->vm_start);
 
 		return 1UL << mmu_psize_to_shift(psize);
-- 
2.25.0

