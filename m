Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939A3C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF29214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgDZSnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726346AbgDZSm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:42:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B019FC061A0F;
        Sun, 26 Apr 2020 11:42:57 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEp-00078z-QX; Sun, 26 Apr 2020 20:42:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5C3DF1C0330;
        Sun, 26 Apr 2020 20:42:47 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:46 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tlb: Restrict access to tlbstate
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092600.328438734@linutronix.de>
References: <20200421092600.328438734@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792656698.28353.4053878306741824988.tip-bot2@tip-bot2>
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

Commit-ID:     bfe3d8f6313d1e10806062ba22c5f660dddecbcc
Gitweb:        https://git.kernel.org/tip/bfe3d8f6313d1e10806062ba22c5f660dddecbcc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:43 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 26 Apr 2020 18:52:33 +02:00

x86/tlb: Restrict access to tlbstate

Hide tlbstate, flush_tlb_info and related helpers when tlbflush.h is
included from a module. Modules have absolutely no business with these
internals.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092600.328438734@linutronix.de
---
 arch/x86/include/asm/tlbflush.h | 96 ++++++++++++++++----------------
 arch/x86/mm/init.c              |  1 +-
 2 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index f973121..8c87a2e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -13,19 +13,46 @@
 #include <asm/pti.h>
 #include <asm/processor-flags.h>
 
-struct flush_tlb_info;
-
 void __flush_tlb_all(void);
-void flush_tlb_local(void);
-void flush_tlb_one_user(unsigned long addr);
-void flush_tlb_one_kernel(unsigned long addr);
-void flush_tlb_others(const struct cpumask *cpumask,
-		      const struct flush_tlb_info *info);
 
-#ifdef CONFIG_PARAVIRT
-#include <asm/paravirt.h>
-#endif
+#define TLB_FLUSH_ALL	-1UL
+
+void cr4_update_irqsoff(unsigned long set, unsigned long clear);
+unsigned long cr4_read_shadow(void);
+
+/* Set in this cpu's CR4. */
+static inline void cr4_set_bits_irqsoff(unsigned long mask)
+{
+	cr4_update_irqsoff(mask, 0);
+}
 
+/* Clear in this cpu's CR4. */
+static inline void cr4_clear_bits_irqsoff(unsigned long mask)
+{
+	cr4_update_irqsoff(0, mask);
+}
+
+/* Set in this cpu's CR4. */
+static inline void cr4_set_bits(unsigned long mask)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cr4_set_bits_irqsoff(mask);
+	local_irq_restore(flags);
+}
+
+/* Clear in this cpu's CR4. */
+static inline void cr4_clear_bits(unsigned long mask)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cr4_clear_bits_irqsoff(mask);
+	local_irq_restore(flags);
+}
+
+#ifndef MODULE
 /*
  * 6 because 6 should be plenty and struct tlb_state will fit in two cache
  * lines.
@@ -129,54 +156,17 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate);
 bool nmi_uaccess_okay(void);
 #define nmi_uaccess_okay nmi_uaccess_okay
 
-void cr4_update_irqsoff(unsigned long set, unsigned long clear);
-unsigned long cr4_read_shadow(void);
-
 /* Initialize cr4 shadow for this CPU. */
 static inline void cr4_init_shadow(void)
 {
 	this_cpu_write(cpu_tlbstate.cr4, __read_cr4());
 }
 
-/* Set in this cpu's CR4. */
-static inline void cr4_set_bits_irqsoff(unsigned long mask)
-{
-	cr4_update_irqsoff(mask, 0);
-}
-
-/* Clear in this cpu's CR4. */
-static inline void cr4_clear_bits_irqsoff(unsigned long mask)
-{
-	cr4_update_irqsoff(0, mask);
-}
-
-/* Set in this cpu's CR4. */
-static inline void cr4_set_bits(unsigned long mask)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	cr4_set_bits_irqsoff(mask);
-	local_irq_restore(flags);
-}
-
-/* Clear in this cpu's CR4. */
-static inline void cr4_clear_bits(unsigned long mask)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	cr4_clear_bits_irqsoff(mask);
-	local_irq_restore(flags);
-}
-
 extern unsigned long mmu_cr4_features;
 extern u32 *trampoline_cr4_features;
 
 extern void initialize_tlbstate_and_flush(void);
 
-#define TLB_FLUSH_ALL	-1UL
-
 /*
  * TLB flushing:
  *
@@ -215,6 +205,16 @@ struct flush_tlb_info {
 	bool			freed_tables;
 };
 
+void flush_tlb_local(void);
+void flush_tlb_one_user(unsigned long addr);
+void flush_tlb_one_kernel(unsigned long addr);
+void flush_tlb_others(const struct cpumask *cpumask,
+		      const struct flush_tlb_info *info);
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#endif
+
 #define flush_tlb_mm(mm)						\
 		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
 
@@ -255,4 +255,6 @@ static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
+#endif /* !MODULE */
+
 #endif /* _ASM_X86_TLBFLUSH_H */
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d37e816..248dc8f 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -992,7 +992,6 @@ __visible DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate) = {
 	.next_asid = 1,
 	.cr4 = ~0UL,	/* fail hard if we screw up cr4 shadow initialization */
 };
-EXPORT_PER_CPU_SYMBOL(cpu_tlbstate);
 
 void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache)
 {
