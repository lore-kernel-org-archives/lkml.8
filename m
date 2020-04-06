Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90143C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2532220A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WROy03h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgDFOEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:04:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59450 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgDFOEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MFy6MtPOJYJ0JRsrUCap5yOFgsyxUgDCtcFh+skyuHs=; b=WROy03h2Xf0VNmUYUPKccCMwCH
        qr127QhrZTz/9crvm3VoKuSyvHEOJ3ACdZBsKZJ6kfEsjvPjwHaTYazR3BJoa8A7+Zr82dSQQV+dv
        BE1VCHJLi+nihw9LeLnWYdGsYlD3oKu1uyWhGerf1SXSW4JWePsPirngNrqOIKxPzzYKaDvo5scMd
        ewYH9SdQCS2+lONnasvYt7w+ClOIZA7OOQ4AxhiEg3drld8cMZwohL5xogI1ulttsRW0bf8E3D0KX
        m8C1/pGkfHqI0W+GQfjWS+sOeerDD5RF0uEkaQ/0S6oRwIZSr6Ned8LlJdu5WbBErV/abGsWVT/RE
        MTiCKTtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLSMD-0005tf-Ih; Mon, 06 Apr 2020 14:04:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A09AE304121;
        Mon,  6 Apr 2020 16:04:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 054402BAC6C18; Mon,  6 Apr 2020 16:04:04 +0200 (CEST)
Date:   Mon, 6 Apr 2020 16:04:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [RFC PATCH] x86/split_lock: Disable SLD if an unaware
 (out-of-tree) module enables VMX
Message-ID: <20200406140403.GL20730@hirez.programming.kicks-ass.net>
References: <20200403163007.6463-1-sean.j.christopherson@intel.com>
 <20200406125010.GA29306@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406125010.GA29306@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 05:50:10AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 03, 2020 at 09:30:07AM -0700, Sean Christopherson wrote:
> > Hook into native CR4 writes to disable split-lock detection if CR4.VMXE
> > is toggled on by an SDL-unaware entity, e.g. an out-of-tree hypervisor
> > module.  Most/all VMX-based hypervisors blindly reflect #AC exceptions
> > into the guest, or don't intercept #AC in the first place.  With SLD
> > enabled, this results in unexpected #AC faults in the guest, leading to
> > crashes in the guest and other undesirable behavior.
> 
> Out of tree modules do not matter, so we should not add code just to
> work around broken third party code.  If you really feel strongly just
> make sure something they rely on for their hacks stops being exported
> and they are properly broken.

Something like so then?

I couldn't find any in-tree users for unmap_kernel_range*(), and this
removes __get_vm_area() and with the ability to custom ranges. It also
removes map_vm_area() and replaces it with map_vm_area_nx() which kills
adding executable maps.

---
diff --git a/arch/powerpc/include/asm/pasemi_dma.h b/arch/powerpc/include/asm/pasemi_dma.h
index 712a0b32120f..305c54d56244 100644
--- a/arch/powerpc/include/asm/pasemi_dma.h
+++ b/arch/powerpc/include/asm/pasemi_dma.h
@@ -523,4 +523,6 @@ extern void pasemi_dma_free_fun(int fun);
 /* Initialize the library, must be called before any other functions */
 extern int pasemi_dma_init(void);
 
+extern struct vm_struct *get_phb_area(unsigned long size, unsigned long flags);
+
 #endif /* ASM_PASEMI_DMA_H */
diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 270fa3c0d372..0aae02df061d 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -617,3 +617,10 @@ int pasemi_dma_init(void)
 	return err;
 }
 EXPORT_SYMBOL(pasemi_dma_init);
+
+struct vm_struct *get_phb_area(unsigned long size, unsigned long flags)
+{
+	return __get_vm_area_node(size, 1, flags, PHB_IO_BASE, PHB_IO_END, NUMA_NO_NODE,
+				  GFP_KERNEL, __builtin_return_address(0));
+}
+EXPORT_SYMBOL_GPL(get_phb_area);
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 65c2ecd730c5..0bd5ea46f1d2 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -274,6 +274,11 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
 
 typedef struct { pgdval_t pgd; } pgd_t;
 
+static inline pgprot_t pgprot_nx(pgprot_t prot)
+{
+	return __pgprot(pgprot_val(prot) | _PAGE_NX);
+}
+
 #ifdef CONFIG_X86_PAE
 
 /*
diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index f2741c04289d..42eb242b29f1 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -22,6 +22,8 @@
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 
+#include <asm/pasemi_dma.h>
+
 #include <pcmcia/ss.h>
 
 static const char driver_name[] = "electra-cf";
@@ -204,7 +206,7 @@ static int electra_cf_probe(struct platform_device *ofdev)
 	cf->mem_base = ioremap(cf->mem_phys, cf->mem_size);
 	cf->io_size = PAGE_ALIGN(resource_size(&io));
 
-	area = __get_vm_area(cf->io_size, 0, PHB_IO_BASE, PHB_IO_END);
+	area = get_phb_area(cf->io_size, 0);
 	if (area == NULL) {
 		status = -ENOMEM;
 		goto fail1;
diff --git a/drivers/staging/media/ipu3/ipu3-dmamap.c b/drivers/staging/media/ipu3/ipu3-dmamap.c
index 7431322379f6..fc3fe85c340c 100644
--- a/drivers/staging/media/ipu3/ipu3-dmamap.c
+++ b/drivers/staging/media/ipu3/ipu3-dmamap.c
@@ -124,13 +124,13 @@ void *imgu_dmamap_alloc(struct imgu_device *imgu, struct imgu_css_map *map,
 	}
 
 	/* Now grab a virtual region */
-	map->vma = __get_vm_area(size, VM_USERMAP, VMALLOC_START, VMALLOC_END);
+	map->vma = get_vm_area(size, VM_USERMAP);
 	if (!map->vma)
 		goto out_unmap;
 
 	map->vma->pages = pages;
 	/* And map it in KVA */
-	if (map_vm_area(map->vma, PAGE_KERNEL, pages))
+	if (map_vm_area_nx(map->vma, PAGE_KERNEL, pages))
 		goto out_vunmap;
 
 	map->size = size;
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index e2e2bef07dd2..ee66c1f8b141 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -490,6 +490,10 @@ static inline int arch_unmap_one(struct mm_struct *mm,
 #define flush_tlb_fix_spurious_fault(vma, address) flush_tlb_page(vma, address)
 #endif
 
+#ifndef pgprot_nx
+#define pgprot_nx(prot)	(prot)
+#endif
+
 #ifndef pgprot_noncached
 #define pgprot_noncached(prot)	(prot)
 #endif
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6b8eeb0ecee5..a1c5faa6042e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2029,7 +2029,6 @@ void unmap_kernel_range_noflush(unsigned long addr, unsigned long size)
 {
 	vunmap_page_range(addr, addr + size);
 }
-EXPORT_SYMBOL_GPL(unmap_kernel_range_noflush);
 
 /**
  * unmap_kernel_range - unmap kernel VM area and flush cache and TLB
@@ -2047,7 +2046,6 @@ void unmap_kernel_range(unsigned long addr, unsigned long size)
 	vunmap_page_range(addr, end);
 	flush_tlb_kernel_range(addr, end);
 }
-EXPORT_SYMBOL_GPL(unmap_kernel_range);
 
 int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
 {
@@ -2059,7 +2057,12 @@ int map_vm_area(struct vm_struct *area, pgprot_t prot, struct page **pages)
 
 	return err > 0 ? 0 : err;
 }
-EXPORT_SYMBOL_GPL(map_vm_area);
+
+int map_vm_area_nx(struct vm_struct *area, pgprot prot, struct page **pages)
+{
+	return map_vm_area(area, pgprot_nx(prot), pages);
+}
+EXPORT_SYMBOL_GPL(map_vm_area_nx);
 
 static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 	struct vmap_area *va, unsigned long flags, const void *caller)
@@ -2133,7 +2136,6 @@ struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
 	return __get_vm_area_node(size, 1, flags, start, end, NUMA_NO_NODE,
 				  GFP_KERNEL, __builtin_return_address(0));
 }
-EXPORT_SYMBOL_GPL(__get_vm_area);
 
 struct vm_struct *__get_vm_area_caller(unsigned long size, unsigned long flags,
 				       unsigned long start, unsigned long end,
@@ -2160,6 +2162,7 @@ struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
 				  NUMA_NO_NODE, GFP_KERNEL,
 				  __builtin_return_address(0));
 }
+EXPORT_SYMBOL_GPL(get_vm_area);
 
 struct vm_struct *get_vm_area_caller(unsigned long size, unsigned long flags,
 				const void *caller)
