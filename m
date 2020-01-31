Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13559C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B24215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580463499;
	bh=Mhj0fBlajapmVh3d62cDZEVlHdcrZHghvIGjV7p6Qsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EMAVyyHPWUIuGMqZ7mNKsdJ15OK70+UpKV6V0xNU2CZerYt09Lu3iznUcHgoYzPW2
	 DHsBoZYLkPjorjvzt6bGJdLFL3o+nomKh8uoKMJ1YlNShO06P4JOX/gjQ9mqcpdq0R
	 Q+8e4bs/ABIxsSkFI9KLaXQ8MDHO5fOEz53XBVd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgAaJiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:38:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728231AbgAaJiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:38:18 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F095E20707;
        Fri, 31 Jan 2020 09:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580463497;
        bh=Mhj0fBlajapmVh3d62cDZEVlHdcrZHghvIGjV7p6Qsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9+ySDNGxannFkqHJGEurUGPlInvH9u1OO8LHJnwBTPtIH0LUxRYR3rOFHJfjDH+5
         hixK/TYkRo696FZPKQ80Vylbkyuvt3cNUcXbydPkomDUK9P+ki6SdcZrkUHsPOZ9vo
         JWDO/NUVnJpw4TbsiCRkzBfVubit03to882MgEys=
Date:   Fri, 31 Jan 2020 09:38:13 +0000
From:   Will Deacon <will@kernel.org>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
Message-ID: <20200131093813.GA3938@willie-the-truck>
References: <20200129103941.304769381@infradead.org>
 <8a81e075-d3bd-80c1-d869-9935fdd73162@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a81e075-d3bd-80c1-d869-9935fdd73162@linux-m68k.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Jan 31, 2020 at 04:31:48PM +1000, Greg Ungerer wrote:
> On 29/1/20 8:39 pm, Peter Zijlstra wrote:
> > In order to faciliate Will's READ_ONCE() patches:
> > 
> >    https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org
> > 
> > we need to fix m68k/motorola to not have a giant pmd_t. These patches do so and
> > are tested using ARAnyM/68040.
> > 
> > It would be very good if someone can either test or tell us what emulator to
> > use for 020/030.
> 
> This series breaks compilation for the ColdFire (with MMU) variant of
> the m68k family:

[...]

> Easy to reproduce. Build for the m5475evb_defconfig.

I've hacked up a fix below, but I don't know how to test whether it actually
works (it does fix the build). However, I also notice that building for
m5475evb_defconfig with vanilla v5.5 triggers this scary looking warning
due to a mismatch between the pgd size and the (8k!) page size:


  | In function 'pgd_alloc.isra.111',
  |     inlined from 'mm_alloc_pgd' at kernel/fork.c:634:12,
  |     inlined from 'mm_init.isra.112' at kernel/fork.c:1043:6:
  | ./arch/m68k/include/asm/string.h:72:25: warning: '__builtin_memcpy' forming offset [4097, 8192] is out of the bounds [0, 4096] of object 'kernel_pg_dir' with type 'pgd_t[1024]' {aka 'struct <anonymous>[1024]'} [-Warray-bounds]
  |  #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
  |                          ^~~~~~~~~~~~~~~~~~~~~~~~~
  | ./arch/m68k/include/asm/mcf_pgalloc.h:93:2: note: in expansion of macro 'memcpy'
  |   memcpy(new_pgd, swapper_pg_dir, PAGE_SIZE);
  |   ^~~~~~


I think the correct fix is to add this:


diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 82ec54c2eaa4..c335e6a381a1 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -90,7 +90,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	new_pgd = (pgd_t *)__get_free_page(GFP_DMA | __GFP_NOWARN);
 	if (!new_pgd)
 		return NULL;
-	memcpy(new_pgd, swapper_pg_dir, PAGE_SIZE);
+	memcpy(new_pgd, swapper_pg_dir, PTRS_PER_PGD * sizeof(pgd_t));
 	memset(new_pgd, 0, PAGE_OFFSET >> PGDIR_SHIFT);
 	return new_pgd;
 }


but maybe it should be done as a separate patch give that it's not caused
by the rework we've been doing.

Will

--->8

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 82ec54c2eaa4..955d54a6e973 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -28,21 +28,22 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
 	return (pmd_t *) pgd;
 }
 
-#define pmd_populate(mm, pmd, page) (pmd_val(*pmd) = \
-	(unsigned long)(page_address(page)))
+#define pmd_populate(mm, pmd, pte) (pmd_val(*pmd) = (unsigned long)(pte))
 
-#define pmd_populate_kernel(mm, pmd, pte) (pmd_val(*pmd) = (unsigned long)(pte))
+#define pmd_populate_kernel pmd_populate
 
-#define pmd_pgtable(pmd) pmd_page(pmd)
+#define pmd_pgtable(pmd) pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT)
 
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t page,
+static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 				  unsigned long address)
 {
+	struct page *page = virt_to_page(pgtable);
+
 	pgtable_pte_page_dtor(page);
 	__free_page(page);
 }
 
-static inline struct page *pte_alloc_one(struct mm_struct *mm)
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *page = alloc_pages(GFP_DMA, 0);
 	pte_t *pte;
@@ -54,20 +55,19 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	}
 
-	pte = kmap(page);
-	if (pte) {
-		clear_page(pte);
-		__flush_page_to_ram(pte);
-		flush_tlb_kernel_page(pte);
-		nocache_page(pte);
-	}
-	kunmap(page);
+	pte = page_address(page);
+	clear_page(pte);
+	__flush_page_to_ram(pte);
+	flush_tlb_kernel_page(pte);
+	nocache_page(pte);
 
-	return page;
+	return pte;
 }
 
-static inline void pte_free(struct mm_struct *mm, struct page *page)
+static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 {
+	struct page *page = virt_to_page(pgtable);
+
 	pgtable_pte_page_dtor(page);
 	__free_page(page);
 }
