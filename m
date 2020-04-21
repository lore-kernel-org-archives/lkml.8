Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70253C55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5383E2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgDUJ1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728587AbgDUJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:27:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A803C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:27:12 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQpBE-00081k-DJ; Tue, 21 Apr 2020 11:27:00 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 8C6BC1002EE;
        Tue, 21 Apr 2020 11:26:59 +0200 (CEST)
Message-Id: <20200421092559.535159540@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 21 Apr 2020 11:20:35 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch V2 08/16] x86/tlb: Move __flush_tlb_one_kernel() out of line
References: <20200421092027.591582014@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_tlbstate is exported because various TLB related functions need access
to it, but cpu_tlbstate is sensitive information which should only be
accessed by well contained kernel functions and not be directly exposed to
modules.

The various TLB flush functions need access to cpu_tlbstate. As forth step
move __flush_tlb_one_kernel() out of line and hide the native function. The
latter can be static when CONFIG_PARAVIRT is disabled.

Consolidate the name space while at it and remove the pointless extra
wrapper in the paravirt code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/pgtable_32.h |    2 -
 arch/x86/include/asm/tlbflush.h   |   41 --------------------------------------
 arch/x86/mm/init_64.c             |    2 -
 arch/x86/mm/ioremap.c             |    2 -
 arch/x86/mm/kmmio.c               |    2 -
 arch/x86/mm/pat/set_memory.c      |    2 -
 arch/x86/mm/pgtable_32.c          |    2 -
 arch/x86/mm/tlb.c                 |   34 ++++++++++++++++++++++++++++++-
 8 files changed, 40 insertions(+), 47 deletions(-)

--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -60,7 +60,7 @@ void sync_initial_page_table(void);
 #define kpte_clear_flush(ptep, vaddr)		\
 do {						\
 	pte_clear(&init_mm, (vaddr), (ptep));	\
-	__flush_tlb_one_kernel((vaddr));		\
+	flush_tlb_one_kernel((vaddr));		\
 } while (0)
 
 #endif /* !__ASSEMBLY__ */
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -143,6 +143,7 @@ static inline unsigned long build_cr3_no
 void flush_tlb_local(void);
 void flush_tlb_global(void);
 void flush_tlb_one_user(unsigned long addr);
+void flush_tlb_one_kernel(unsigned long addr);
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
@@ -318,14 +319,6 @@ static inline void cr4_clear_bits(unsign
 }
 
 /*
- * Mark all other ASIDs as invalid, preserves the current.
- */
-static inline void invalidate_other_asid(void)
-{
-	this_cpu_write(cpu_tlbstate.invalidate_other, true);
-}
-
-/*
  * Save some of cr4 feature set we're using (e.g.  Pentium 4MB
  * enable and PPro Global page enable), so that any CPU's that boot
  * up after us can get the correct flags.  This should only be used
@@ -365,38 +358,6 @@ static inline void __flush_tlb_all(void)
 	}
 }
 
-/*
- * flush one page in the kernel mapping
- */
-static inline void __flush_tlb_one_kernel(unsigned long addr)
-{
-	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ONE);
-
-	/*
-	 * If PTI is off, then __flush_tlb_one_user() is just INVLPG or its
-	 * paravirt equivalent.  Even with PCID, this is sufficient: we only
-	 * use PCID if we also use global PTEs for the kernel mapping, and
-	 * INVLPG flushes global translations across all address spaces.
-	 *
-	 * If PTI is on, then the kernel is mapped with non-global PTEs, and
-	 * __flush_tlb_one_user() will flush the given address for the current
-	 * kernel address space and for its usermode counterpart, but it does
-	 * not flush it for other address spaces.
-	 */
-	flush_tlb_one_user(addr);
-
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		return;
-
-	/*
-	 * See above.  We need to propagate the flush to all other address
-	 * spaces.  In principle, we only need to propagate it to kernelmode
-	 * address spaces, but the extra bookkeeping we would need is not
-	 * worth it.
-	 */
-	invalidate_other_asid();
-}
-
 #define TLB_FLUSH_ALL	-1UL
 
 /*
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -298,7 +298,7 @@ static void __set_pte_vaddr(pud_t *pud,
 	 * It's enough to flush this one mapping.
 	 * (PGE mappings get flushed as well)
 	 */
-	__flush_tlb_one_kernel(vaddr);
+	flush_tlb_one_kernel(vaddr);
 }
 
 void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte)
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -889,5 +889,5 @@ void __init __early_set_fixmap(enum fixe
 		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
 	else
 		pte_clear(&init_mm, addr, pte);
-	__flush_tlb_one_kernel(addr);
+	flush_tlb_one_kernel(addr);
 }
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -173,7 +173,7 @@ static int clear_page_presence(struct km
 		return -1;
 	}
 
-	__flush_tlb_one_kernel(f->addr);
+	flush_tlb_one_kernel(f->addr);
 	return 0;
 }
 
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -340,7 +340,7 @@ static void __cpa_flush_tlb(void *data)
 	unsigned int i;
 
 	for (i = 0; i < cpa->numpages; i++)
-		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
+		flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
 }
 
 static void cpa_flush(struct cpa_data *data, int cache)
--- a/arch/x86/mm/pgtable_32.c
+++ b/arch/x86/mm/pgtable_32.c
@@ -64,7 +64,7 @@ void set_pte_vaddr(unsigned long vaddr,
 	 * It's enough to flush this one mapping.
 	 * (PGE mappings get flushed as well)
 	 */
-	__flush_tlb_one_kernel(vaddr);
+	flush_tlb_one_kernel(vaddr);
 }
 
 unsigned long __FIXADDR_TOP = 0xfffff000;
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -876,7 +876,7 @@ static void do_kernel_range_flush(void *
 
 	/* flush range by one by one 'invlpg' */
 	for (addr = f->start; addr < f->end; addr += PAGE_SIZE)
-		__flush_tlb_one_kernel(addr);
+		flush_tlb_one_kernel(addr);
 }
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
@@ -919,6 +919,38 @@ unsigned long __get_current_cr3_fast(voi
 EXPORT_SYMBOL_GPL(__get_current_cr3_fast);
 
 /*
+ * Flush one page in the kernel mapping
+ */
+void flush_tlb_one_kernel(unsigned long addr)
+{
+	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ONE);
+
+	/*
+	 * If PTI is off, then __flush_tlb_one_user() is just INVLPG or its
+	 * paravirt equivalent.  Even with PCID, this is sufficient: we only
+	 * use PCID if we also use global PTEs for the kernel mapping, and
+	 * INVLPG flushes global translations across all address spaces.
+	 *
+	 * If PTI is on, then the kernel is mapped with non-global PTEs, and
+	 * __flush_tlb_one_user() will flush the given address for the current
+	 * kernel address space and for its usermode counterpart, but it does
+	 * not flush it for other address spaces.
+	 */
+	flush_tlb_one_user(addr);
+
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	/*
+	 * See above.  We need to propagate the flush to all other address
+	 * spaces.  In principle, we only need to propagate it to kernelmode
+	 * address spaces, but the extra bookkeeping we would need is not
+	 * worth it.
+	 */
+	this_cpu_write(cpu_tlbstate.invalidate_other, true);
+}
+
+/*
  * Flush one page in the user mapping
  */
 STATIC_NOPV void native_flush_tlb_one_user(unsigned long addr)

