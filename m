Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756DDC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E81A208FE
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgDZSnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgDZSm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:42:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9B7C061A10;
        Sun, 26 Apr 2020 11:42:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEu-0007CB-1B; Sun, 26 Apr 2020 20:42:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A7C8C1C0330;
        Sun, 26 Apr 2020 20:42:51 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:51 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tlb: Move __flush_tlb_one_kernel() out of line
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092559.535159540@linutronix.de>
References: <20200421092559.535159540@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792657115.28353.18292823361689514322.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     58430c5dba7bfe1d132b3c07f0d7a596852ef55c
Gitweb:        https://git.kernel.org/tip/58430c5dba7bfe1d132b3c07f0d7a596852ef55c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:35 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 26 Apr 2020 11:01:22 +02:00

x86/tlb: Move __flush_tlb_one_kernel() out of line

cpu_tlbstate is exported because various TLB-related functions need
access to it, but cpu_tlbstate is sensitive information which should
only be accessed by well-contained kernel functions and not be directly
exposed to modules.

As a fourth step, move __flush_tlb_one_kernel() out of line and hide
the native function. The latter can be static when CONFIG_PARAVIRT is
disabled.

Consolidate the name space while at it and remove the pointless extra
wrapper in the paravirt code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092559.535159540@linutronix.de
---
 arch/x86/include/asm/pgtable_32.h |  2 +-
 arch/x86/include/asm/tlbflush.h   | 41 +------------------------------
 arch/x86/mm/init_64.c             |  2 +-
 arch/x86/mm/ioremap.c             |  2 +-
 arch/x86/mm/kmmio.c               |  2 +-
 arch/x86/mm/pat/set_memory.c      |  2 +-
 arch/x86/mm/pgtable_32.c          |  2 +-
 arch/x86/mm/tlb.c                 | 34 ++++++++++++++++++++++++-
 8 files changed, 40 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 0dca7f7..bd2ed47 100644
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
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 14c5b98..bbb94f0 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -143,6 +143,7 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 void flush_tlb_local(void);
 void flush_tlb_global(void);
 void flush_tlb_one_user(unsigned long addr);
+void flush_tlb_one_kernel(unsigned long addr);
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
@@ -318,14 +319,6 @@ static inline void cr4_clear_bits(unsigned long mask)
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
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 9a497ba..c7a1c6c 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -298,7 +298,7 @@ static void __set_pte_vaddr(pud_t *pud, unsigned long vaddr, pte_t new_pte)
 	 * It's enough to flush this one mapping.
 	 * (PGE mappings get flushed as well)
 	 */
-	__flush_tlb_one_kernel(vaddr);
+	flush_tlb_one_kernel(vaddr);
 }
 
 void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte)
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 41536f5..986d575 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -885,5 +885,5 @@ void __init __early_set_fixmap(enum fixed_addresses idx,
 		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
 	else
 		pte_clear(&init_mm, addr, pte);
-	__flush_tlb_one_kernel(addr);
+	flush_tlb_one_kernel(addr);
 }
diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
index 9994353..dd62589 100644
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -173,7 +173,7 @@ static int clear_page_presence(struct kmmio_fault_page *f, bool clear)
 		return -1;
 	}
 
-	__flush_tlb_one_kernel(f->addr);
+	flush_tlb_one_kernel(f->addr);
 	return 0;
 }
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index a28f0c3..b7fb1f0 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -345,7 +345,7 @@ static void __cpa_flush_tlb(void *data)
 	unsigned int i;
 
 	for (i = 0; i < cpa->numpages; i++)
-		__flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
+		flush_tlb_one_kernel(fix_addr(__cpa_addr(cpa, i)));
 }
 
 static void cpa_flush(struct cpa_data *data, int cache)
diff --git a/arch/x86/mm/pgtable_32.c b/arch/x86/mm/pgtable_32.c
index 0e6700e..e1ce59d 100644
--- a/arch/x86/mm/pgtable_32.c
+++ b/arch/x86/mm/pgtable_32.c
@@ -64,7 +64,7 @@ void set_pte_vaddr(unsigned long vaddr, pte_t pteval)
 	 * It's enough to flush this one mapping.
 	 * (PGE mappings get flushed as well)
 	 */
-	__flush_tlb_one_kernel(vaddr);
+	flush_tlb_one_kernel(vaddr);
 }
 
 unsigned long __FIXADDR_TOP = 0xfffff000;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 2822602..ad217ed 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -876,7 +876,7 @@ static void do_kernel_range_flush(void *info)
 
 	/* flush range by one by one 'invlpg' */
 	for (addr = f->start; addr < f->end; addr += PAGE_SIZE)
-		__flush_tlb_one_kernel(addr);
+		flush_tlb_one_kernel(addr);
 }
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
@@ -919,6 +919,38 @@ unsigned long __get_current_cr3_fast(void)
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
