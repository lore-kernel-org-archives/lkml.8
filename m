Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE92EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12B5208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgE3J5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgE3J5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E63C08C5C9;
        Sat, 30 May 2020 02:57:18 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyEu-0002oH-BE; Sat, 30 May 2020 11:57:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A018F1C0093;
        Sat, 30 May 2020 11:57:15 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:15 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/idt: Consolidate idt functionality
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200528145523.084915381@linutronix.de>
References: <20200528145523.084915381@linutronix.de>
MIME-Version: 1.0
Message-ID: <159083263547.17951.5591732227841139209.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     5980d208e5ef28455e9e8b08f6250b443a2f0893
Gitweb:        https://git.kernel.org/tip/5980d208e5ef28455e9e8b08f6250b443a2f0893
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 28 May 2020 16:53:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 11:50:13 +02:00

x86/idt: Consolidate idt functionality

 - Move load_current_idt() out of line and replace the hideous comment with
   a lockdep assert. This allows to make idt_table and idt_descr static.

 - Mark idt_table read only after the IDT initialization is complete.

 - Shuffle code around to consolidate the #ifdef sections into one.

 - Adapt the F00F bug code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200528145523.084915381@linutronix.de

---
 arch/x86/include/asm/desc.h | 17 +---------
 arch/x86/kernel/idt.c       | 63 +++++++++++++++++++++---------------
 arch/x86/mm/fault.c         | 16 ++-------
 3 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 07632f3..1ced11d 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -40,9 +40,6 @@ static inline void fill_ldt(struct desc_struct *desc, const struct user_desc *in
 	desc->l			= 0;
 }
 
-extern struct desc_ptr idt_descr;
-extern gate_desc idt_table[];
-
 struct gdt_page {
 	struct desc_struct gdt[GDT_ENTRIES];
 } __attribute__((aligned(PAGE_SIZE)));
@@ -388,22 +385,12 @@ void alloc_intr_gate(unsigned int n, const void *addr);
 
 extern unsigned long system_vectors[];
 
-/*
- * The load_current_idt() must be called with interrupts disabled
- * to avoid races. That way the IDT will always be set back to the expected
- * descriptor. It's also called when a CPU is being initialized, and
- * that doesn't need to disable interrupts, as nothing should be
- * bothering the CPU then.
- */
-static __always_inline void load_current_idt(void)
-{
-	load_idt((const struct desc_ptr *)&idt_descr);
-}
-
+extern void load_current_idt(void);
 extern void idt_setup_early_handler(void);
 extern void idt_setup_early_traps(void);
 extern void idt_setup_traps(void);
 extern void idt_setup_apic_and_irq_gates(void);
+extern bool idt_is_f00f_address(unsigned long address);
 
 #ifdef CONFIG_X86_64
 extern void idt_setup_early_pf(void);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 902cdd0..85e3e22 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -5,6 +5,7 @@
 #include <linux/interrupt.h>
 
 #include <asm/cpu_entry_area.h>
+#include <asm/set_memory.h>
 #include <asm/traps.h>
 #include <asm/proto.h>
 #include <asm/desc.h>
@@ -156,37 +157,25 @@ static const __initconst struct idt_data apic_idts[] = {
 #endif
 };
 
-#ifdef CONFIG_X86_64
-/*
- * Early traps running on the DEFAULT_STACK because the other interrupt
- * stacks work only after cpu_init().
- */
-static const __initconst struct idt_data early_pf_idts[] = {
-	INTG(X86_TRAP_PF,		asm_exc_page_fault),
-};
-#endif
-
-/* Must be page-aligned because the real IDT is used in a fixmap. */
-gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
+/* Must be page-aligned because the real IDT is used in the cpu entry area */
+static gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
 
 struct desc_ptr idt_descr __ro_after_init = {
 	.size		= IDT_TABLE_SIZE - 1,
 	.address	= (unsigned long) idt_table,
 };
 
-#ifdef CONFIG_X86_64
-/*
- * The exceptions which use Interrupt stacks. They are setup after
- * cpu_init() when the TSS has been initialized.
- */
-static const __initconst struct idt_data ist_idts[] = {
-	ISTG(X86_TRAP_DB,	asm_exc_debug,		IST_INDEX_DB),
-	ISTG(X86_TRAP_NMI,	asm_exc_nmi,		IST_INDEX_NMI),
-	ISTG(X86_TRAP_DF,	asm_exc_double_fault,	IST_INDEX_DF),
-#ifdef CONFIG_X86_MCE
-	ISTG(X86_TRAP_MC,	asm_exc_machine_check,	IST_INDEX_MCE),
-#endif
-};
+void load_current_idt(void)
+{
+	lockdep_assert_irqs_disabled();
+	load_idt(&idt_descr);
+}
+
+#ifdef CONFIG_X86_F00F_BUG
+bool idt_is_f00f_address(unsigned long address)
+{
+	return (address - idt_descr.address) >> 3) == 6;
+}
 #endif
 
 static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
@@ -255,6 +244,27 @@ void __init idt_setup_traps(void)
 }
 
 #ifdef CONFIG_X86_64
+/*
+ * Early traps running on the DEFAULT_STACK because the other interrupt
+ * stacks work only after cpu_init().
+ */
+static const __initconst struct idt_data early_pf_idts[] = {
+	INTG(X86_TRAP_PF,		asm_exc_page_fault),
+};
+
+/*
+ * The exceptions which use Interrupt stacks. They are setup after
+ * cpu_init() when the TSS has been initialized.
+ */
+static const __initconst struct idt_data ist_idts[] = {
+	ISTG(X86_TRAP_DB,	asm_exc_debug,		IST_INDEX_DB),
+	ISTG(X86_TRAP_NMI,	asm_exc_nmi,		IST_INDEX_NMI),
+	ISTG(X86_TRAP_DF,	asm_exc_double_fault,	IST_INDEX_DF),
+#ifdef CONFIG_X86_MCE
+	ISTG(X86_TRAP_MC,	asm_exc_machine_check,	IST_INDEX_MCE),
+#endif
+};
+
 /**
  * idt_setup_early_pf - Initialize the idt table with early pagefault handler
  *
@@ -325,6 +335,9 @@ void __init idt_setup_apic_and_irq_gates(void)
 	idt_map_in_cea();
 	load_idt(&idt_descr);
 
+	/* Make the IDT table read only */
+	set_memory_ro((unsigned long)&idt_table, 1);
+
 	idt_setup_done = true;
 }
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9c57fb8..e4625f4 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -555,21 +555,13 @@ static int is_errata100(struct pt_regs *regs, unsigned long address)
 	return 0;
 }
 
+/* Pentium F0 0F C7 C8 bug workaround: */
 static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
 {
 #ifdef CONFIG_X86_F00F_BUG
-	unsigned long nr;
-
-	/*
-	 * Pentium F0 0F C7 C8 bug workaround:
-	 */
-	if (boot_cpu_has_bug(X86_BUG_F00F)) {
-		nr = (address - idt_descr.address) >> 3;
-
-		if (nr == 6) {
-			handle_invalid_op(regs);
-			return 1;
-		}
+	if (boot_cpu_has_bug(X86_BUG_F00F) && idt_is_f00f_address(address)) {
+		handle_invalid_op(regs);
+		return 1;
 	}
 #endif
 	return 0;
