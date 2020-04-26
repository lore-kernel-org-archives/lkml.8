Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C178C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 181D4208FE
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgDZSnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726342AbgDZSm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:42:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1DAC061A10;
        Sun, 26 Apr 2020 11:42:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEt-0007C2-Ex; Sun, 26 Apr 2020 20:42:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 122AA1C0178;
        Sun, 26 Apr 2020 20:42:51 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:50 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tlb: Move flush_tlb_others() out of line
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092559.641957686@linutronix.de>
References: <20200421092559.641957686@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792657057.28353.13010874775801822359.tip-bot2@tip-bot2>
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

Commit-ID:     29def599b38bb8a10f48f83821dd990615300b04
Gitweb:        https://git.kernel.org/tip/29def599b38bb8a10f48f83821dd990615300b04
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:36 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 26 Apr 2020 11:10:25 +02:00

x86/tlb: Move flush_tlb_others() out of line

cpu_tlbstate is exported because various TLB-related functions need
access to it, but cpu_tlbstate is sensitive information which should
only be accessed by well-contained kernel functions and not be directly
exposed to modules.

As a last step, move __flush_tlb_others() out of line and hide the
native function. The latter can be static when CONFIG_PARAVIRT is
disabled.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092559.641957686@linutronix.de
---
 arch/x86/include/asm/paravirt.h |  6 ++++--
 arch/x86/include/asm/tlbflush.h | 10 ++++------
 arch/x86/mm/tlb.c               | 11 +++++++++--
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index dcd6517..5ca5d29 100644
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
@@ -66,8 +68,8 @@ static inline void __flush_tlb_one_user(unsigned long addr)
 	PVOP_VCALL1(mmu.flush_tlb_one_user, addr);
 }
 
-static inline void flush_tlb_others(const struct cpumask *cpumask,
-				    const struct flush_tlb_info *info)
+static inline void __flush_tlb_others(const struct cpumask *cpumask,
+				      const struct flush_tlb_info *info)
 {
 	PVOP_VCALL2(mmu.flush_tlb_others, cpumask, info);
 }
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index bbb94f0..d064ae8 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -140,10 +140,14 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
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
@@ -418,9 +422,6 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
 }
 
-void native_flush_tlb_others(const struct cpumask *cpumask,
-			     const struct flush_tlb_info *info);
-
 static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
 {
 	/*
@@ -442,9 +443,6 @@ static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
 #ifndef CONFIG_PARAVIRT
-#define flush_tlb_others(mask, info)	\
-	native_flush_tlb_others(mask, info)
-
 #define paravirt_tlb_remove_table(tlb, page) \
 	tlb_remove_page(tlb, (void *)(page))
 #endif
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ad217ed..209799d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -25,6 +25,7 @@
 # define __flush_tlb_local		native_flush_tlb_local
 # define __flush_tlb_global		native_flush_tlb_global
 # define __flush_tlb_one_user(addr)	native_flush_tlb_one_user(addr)
+# define __flush_tlb_others(msk, info)	native_flush_tlb_others(msk, info)
 #endif
 
 /*
@@ -715,8 +716,8 @@ static bool tlb_is_not_lazy(int cpu, void *data)
 	return !per_cpu(cpu_tlbstate.is_lazy, cpu);
 }
 
-void native_flush_tlb_others(const struct cpumask *cpumask,
-			     const struct flush_tlb_info *info)
+STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
+					 const struct flush_tlb_info *info)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
 	if (info->end == TLB_FLUSH_ALL)
@@ -766,6 +767,12 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
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
