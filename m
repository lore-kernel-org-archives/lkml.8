Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0DAC55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325D920857
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgDUJ1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728595AbgDUJ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:27:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9972C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:27:13 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQpBF-00082B-J4; Tue, 21 Apr 2020 11:27:01 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C5E77104099;
        Tue, 21 Apr 2020 11:27:00 +0200 (CEST)
Message-Id: <20200421092559.641957686@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 21 Apr 2020 11:20:36 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch V2 09/16] x86/tlb: Move flush_tlb_others() out of line
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

The various TLB flush functions need access to cpu_tlbstate. As last step
move __flush_tlb_others() out of line and hide the native function. The
latter can be static when CONFIG_PARAVIRT is disabled.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h |    6 ++++--
 arch/x86/include/asm/tlbflush.h |   10 ++++------
 arch/x86/mm/tlb.c               |   11 +++++++++--
 3 files changed, 17 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -50,6 +50,8 @@ static inline void slow_down_io(void)
 void native_flush_tlb_local(void);
 void native_flush_tlb_global(void);
 void native_flush_tlb_one_user(unsigned long addr);
+void native_flush_tlb_others(const struct cpumask *cpumask,
+			     const struct flush_tlb_info *info);
 
 static inline void __flush_tlb_local(void)
 {
@@ -66,8 +68,8 @@ static inline void __flush_tlb_one_user(
 	PVOP_VCALL1(mmu.flush_tlb_one_user, addr);
 }
 
-static inline void flush_tlb_others(const struct cpumask *cpumask,
-				    const struct flush_tlb_info *info)
+static inline void __flush_tlb_others(const struct cpumask *cpumask,
+				      const struct flush_tlb_info *info)
 {
 	PVOP_VCALL2(mmu.flush_tlb_others, cpumask, info);
 }
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -140,10 +140,14 @@ static inline unsigned long build_cr3_no
 	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
 }
 
+struct flush_tlb_info;
+
 void flush_tlb_local(void);
 void flush_tlb_global(void);
 void flush_tlb_one_user(unsigned long addr);
 void flush_tlb_one_kernel(unsigned long addr);
+void flush_tlb_others(const struct cpumask *cpumask,
+		      const struct flush_tlb_info *info);
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
@@ -418,9 +422,6 @@ static inline void flush_tlb_page(struct
 	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
 }
 
-void native_flush_tlb_others(const struct cpumask *cpumask,
-			     const struct flush_tlb_info *info);
-
 static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
 {
 	/*
@@ -442,9 +443,6 @@ static inline void arch_tlbbatch_add_mm(
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
 #ifndef CONFIG_PARAVIRT
-#define flush_tlb_others(mask, info)	\
-	native_flush_tlb_others(mask, info)
-
 #define paravirt_tlb_remove_table(tlb, page) \
 	tlb_remove_page(tlb, (void *)(page))
 #endif
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -25,6 +25,7 @@
 # define __flush_tlb_local		native_flush_tlb_local
 # define __flush_tlb_global		native_flush_tlb_global
 # define __flush_tlb_one_user(addr)	native_flush_tlb_one_user(addr)
+# define __flush_tlb_others(msk, info)	native_flush_tlb_others(msk, info)
 #endif
 
 /*
@@ -715,8 +716,8 @@ static bool tlb_is_not_lazy(int cpu, voi
 	return !per_cpu(cpu_tlbstate.is_lazy, cpu);
 }
 
-void native_flush_tlb_others(const struct cpumask *cpumask,
-			     const struct flush_tlb_info *info)
+STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
+					 const struct flush_tlb_info *info)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
 	if (info->end == TLB_FLUSH_ALL)
@@ -766,6 +767,12 @@ void native_flush_tlb_others(const struc
 				(void *)info, 1, cpumask);
 }
 
+void flush_tlb_others(const struct cpumask *cpumask,
+		      const struct flush_tlb_info *info)
+{
+	__flush_tlb_others(cpumask, info);
+}
+
 /*
  * See Documentation/x86/tlb.rst for details.  We choose 33
  * because it is large enough to cover the vast majority (at

