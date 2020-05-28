Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACCBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546CB2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403863AbgE1O4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403835AbgE1O4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:56:17 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB6DC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:56:17 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeJx9-0002Qo-Qk; Thu, 28 May 2020 16:56:16 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5BC88FF834;
        Thu, 28 May 2020 16:56:15 +0200 (CEST)
Message-Id: <20200528145523.084915381@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 28 May 2020 16:53:20 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [patch 5/5] x86/idt: Consolidate idt functionality
References: <20200528145315.727724091@linutronix.de>
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

 - Move load_current_idt() out of line and replace the hideous comment
   with a lockdep assert.

 - Move debug IDT cruft into the IDT code and simplify it.  This makes
   debug_idt_ctr static and removes one function call.

 - Move the idt descriptor table definition to spare the extra #ifdef
   sections and make it static.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/desc.h  |   45 -------------------------
 arch/x86/kernel/cpu/common.c |   17 ---------
 arch/x86/kernel/idt.c        |   75 ++++++++++++++++++++++++++++++-------------
 3 files changed, 55 insertions(+), 82 deletions(-)

--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -40,11 +40,6 @@ static inline void fill_ldt(struct desc_
 	desc->l			= 0;
 }
 
-extern struct desc_ptr idt_descr;
-extern gate_desc idt_table[];
-extern const struct desc_ptr debug_idt_descr;
-extern gate_desc debug_idt_table[];
-
 struct gdt_page {
 	struct desc_struct gdt[GDT_ENTRIES];
 } __attribute__((aligned(PAGE_SIZE)));
@@ -390,45 +385,7 @@ void alloc_intr_gate(unsigned int n, con
 
 extern unsigned long system_vectors[];
 
-#ifdef CONFIG_X86_64
-DECLARE_PER_CPU(u32, debug_idt_ctr);
-static __always_inline bool is_debug_idt_enabled(void)
-{
-	if (this_cpu_read(debug_idt_ctr))
-		return true;
-
-	return false;
-}
-
-static __always_inline void load_debug_idt(void)
-{
-	load_idt((const struct desc_ptr *)&debug_idt_descr);
-}
-#else
-static inline bool is_debug_idt_enabled(void)
-{
-	return false;
-}
-
-static inline void load_debug_idt(void)
-{
-}
-#endif
-
-/*
- * The load_current_idt() must be called with interrupts disabled
- * to avoid races. That way the IDT will always be set back to the expected
- * descriptor. It's also called when a CPU is being initialized, and
- * that doesn't need to disable interrupts, as nothing should be
- * bothering the CPU then.
- */
-static __always_inline void load_current_idt(void)
-{
-	if (is_debug_idt_enabled())
-		load_debug_idt();
-	else
-		load_idt((const struct desc_ptr *)&idt_descr);
-}
+void load_current_idt(void);
 
 extern void idt_setup_early_handler(void);
 extern void idt_setup_early_traps(void);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1689,23 +1689,6 @@ void syscall_init(void)
 	       X86_EFLAGS_IOPL|X86_EFLAGS_AC|X86_EFLAGS_NT);
 }
 
-DEFINE_PER_CPU(int, debug_stack_usage);
-DEFINE_PER_CPU(u32, debug_idt_ctr);
-
-noinstr void debug_stack_set_zero(void)
-{
-	this_cpu_inc(debug_idt_ctr);
-	load_current_idt();
-}
-
-noinstr void debug_stack_reset(void)
-{
-	if (WARN_ON(!this_cpu_read(debug_idt_ctr)))
-		return;
-	if (this_cpu_dec_return(debug_idt_ctr) == 0)
-		load_current_idt();
-}
-
 #else	/* CONFIG_X86_64 */
 
 DEFINE_PER_CPU(struct task_struct *, current_task) = &init_task;
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -157,6 +157,14 @@ static const __initconst struct idt_data
 #endif
 };
 
+/* Must be page-aligned because the real IDT is used in the cpu entry area */
+static gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
+
+static struct desc_ptr idt_descr __ro_after_init = {
+	.size		= IDT_TABLE_SIZE - 1,
+	.address	= (unsigned long) idt_table,
+};
+
 #ifdef CONFIG_X86_64
 /*
  * Early traps running on the DEFAULT_STACK because the other interrupt
@@ -173,20 +181,19 @@ static const __initconst struct idt_data
 static const __initconst struct idt_data dbg_idts[] = {
 	INTG(X86_TRAP_DB,		asm_exc_debug),
 };
-#endif
 
-/* Must be page-aligned because the real IDT is used in a fixmap. */
-gate_desc idt_table[IDT_ENTRIES] __page_aligned_bss;
+/* No need to be aligned, but done to keep all IDTs defined the same way. */
+static gate_desc debug_idt_table[IDT_ENTRIES] __page_aligned_bss;
 
-struct desc_ptr idt_descr __ro_after_init = {
-	.size		= IDT_TABLE_SIZE - 1,
-	.address	= (unsigned long) idt_table,
+/*
+ * Override for the debug_idt. Same as the default, but with interrupt
+ * stack set to DEFAULT_STACK (0). Required for NMI trap handling.
+ */
+static const struct desc_ptr debug_idt_descr = {
+	.size		= IDT_DEBUG_TABLE_SIZE - 1,
+	.address	= (unsigned long) debug_idt_table,
 };
 
-#ifdef CONFIG_X86_64
-/* No need to be aligned, but done to keep all IDTs defined the same way. */
-gate_desc debug_idt_table[IDT_ENTRIES] __page_aligned_bss;
-
 /*
  * The exceptions which use Interrupt stacks. They are setup after
  * cpu_init() when the TSS has been initialized.
@@ -200,15 +207,41 @@ static const __initconst struct idt_data
 #endif
 };
 
-/*
- * Override for the debug_idt. Same as the default, but with interrupt
- * stack set to DEFAULT_STACK (0). Required for NMI trap handling.
- */
-const struct desc_ptr debug_idt_descr = {
-	.size		= IDT_DEBUG_TABLE_SIZE - 1,
-	.address	= (unsigned long) debug_idt_table,
-};
-#endif
+DEFINE_PER_CPU(int, debug_stack_usage);
+static DEFINE_PER_CPU(u32, debug_idt_ctr);
+
+noinstr void load_current_idt(void)
+{
+	lockdep_assert_irqs_disabled();
+
+	if (this_cpu_read(debug_idt_ctr))
+		load_idt(&debug_idt_descr);
+	else
+		load_idt(&idt_descr);
+}
+
+noinstr void debug_stack_set_zero(void)
+{
+	this_cpu_inc(debug_idt_ctr);
+	load_idt(&debug_idt_descr);
+}
+
+noinstr void debug_stack_reset(void)
+{
+	if (WARN_ON(!this_cpu_read(debug_idt_ctr)))
+		return;
+	if (this_cpu_dec_return(debug_idt_ctr) == 0)
+		load_idt(&idt_descr);
+}
+
+#else /* X86_64 */
+
+noinstr void load_current_idt(void)
+{
+	load_idt(&idt_descr);
+}
+
+#endif /* !X86_64 */
 
 static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
 {
@@ -264,7 +297,7 @@ void __init idt_setup_early_traps(void)
 {
 	idt_setup_from_table(idt_table, early_idts, ARRAY_SIZE(early_idts),
 			     true);
-	load_idt(&idt_descr);
+	load_current_idt();
 }
 
 /**
@@ -374,7 +407,7 @@ void __init idt_setup_early_handler(void
 	for ( ; i < NR_VECTORS; i++)
 		set_intr_gate(i, early_ignore_irq);
 #endif
-	load_idt(&idt_descr);
+	load_current_idt();
 }
 
 /**

