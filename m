Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3B2C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F60F21531
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgE3J53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbgE3J5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:57:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4186DC03E969;
        Sat, 30 May 2020 02:57:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeyEx-0002qZ-Sk; Sat, 30 May 2020 11:57:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 876541C0093;
        Sat, 30 May 2020 11:57:19 +0200 (CEST)
Date:   Sat, 30 May 2020 09:57:19 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Remove debug IDT frobbing
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200529213321.245019500@infradead.org>
References: <20200529213321.245019500@infradead.org>
MIME-Version: 1.0
Message-ID: <159083263941.17951.12730400395308289342.tip-bot2@tip-bot2>
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

Commit-ID:     8449e768dcb85b4d8db51482d8c9260bb05ccabc
Gitweb:        https://git.kernel.org/tip/8449e768dcb85b4d8db51482d8c9260bb05ccabc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 29 May 2020 23:27:37 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 30 May 2020 10:00:09 +02:00

x86/entry: Remove debug IDT frobbing

This is all unused now.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200529213321.245019500@infradead.org

---
 arch/x86/include/asm/debugreg.h | 19 +------------------
 arch/x86/include/asm/desc.h     | 34 +--------------------------------
 arch/x86/kernel/cpu/common.c    | 17 +----------------
 arch/x86/kernel/idt.c           | 30 +----------------------------
 arch/x86/kernel/traps.c         |  9 +--------
 5 files changed, 1 insertion(+), 108 deletions(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 3e1c502..42fc35d 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -94,25 +94,6 @@ extern void aout_dump_debugregs(struct user *dump);
 
 extern void hw_breakpoint_restore(void);
 
-#ifdef CONFIG_X86_64
-DECLARE_PER_CPU(int, debug_stack_usage);
-static inline void debug_stack_usage_inc(void)
-{
-	__this_cpu_inc(debug_stack_usage);
-}
-static inline void debug_stack_usage_dec(void)
-{
-	__this_cpu_dec(debug_stack_usage);
-}
-void debug_stack_set_zero(void);
-void debug_stack_reset(void);
-#else /* !X86_64 */
-static inline void debug_stack_set_zero(void) { }
-static inline void debug_stack_reset(void) { }
-static inline void debug_stack_usage_inc(void) { }
-static inline void debug_stack_usage_dec(void) { }
-#endif /* X86_64 */
-
 static __always_inline unsigned long local_db_save(void)
 {
 	unsigned long dr7;
diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index d6c3d34..07632f3 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -42,8 +42,6 @@ static inline void fill_ldt(struct desc_struct *desc, const struct user_desc *in
 
 extern struct desc_ptr idt_descr;
 extern gate_desc idt_table[];
-extern const struct desc_ptr debug_idt_descr;
-extern gate_desc debug_idt_table[];
 
 struct gdt_page {
 	struct desc_struct gdt[GDT_ENTRIES];
@@ -390,31 +388,6 @@ void alloc_intr_gate(unsigned int n, const void *addr);
 
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
 /*
  * The load_current_idt() must be called with interrupts disabled
  * to avoid races. That way the IDT will always be set back to the expected
@@ -424,10 +397,7 @@ static inline void load_debug_idt(void)
  */
 static __always_inline void load_current_idt(void)
 {
-	if (is_debug_idt_enabled())
-		load_debug_idt();
-	else
-		load_idt((const struct desc_ptr *)&idt_descr);
+	load_idt((const struct desc_ptr *)&idt_descr);
 }
 
 extern void idt_setup_early_handler(void);
@@ -438,11 +408,9 @@ extern void idt_setup_apic_and_irq_gates(void);
 #ifdef CONFIG_X86_64
 extern void idt_setup_early_pf(void);
 extern void idt_setup_ist_traps(void);
-extern void idt_setup_debugidt_traps(void);
 #else
 static inline void idt_setup_early_pf(void) { }
 static inline void idt_setup_ist_traps(void) { }
-static inline void idt_setup_debugidt_traps(void) { }
 #endif
 
 extern void idt_invalidate(void *addr);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 6751b81..c55be3b 100644
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
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index bc9b0d1..226c992 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -158,14 +158,6 @@ static const __initconst struct idt_data apic_idts[] = {
 static const __initconst struct idt_data early_pf_idts[] = {
 	INTG(X86_TRAP_PF,		asm_exc_page_fault),
 };
-
-/*
- * Override for the debug_idt. Same as the default, but with interrupt
- * stack set to DEFAULT_STACK (0). Required for NMI trap handling.
- */
-static const __initconst struct idt_data dbg_idts[] = {
-	INTG(X86_TRAP_DB,		asm_exc_debug),
-};
 #endif
 
 /* Must be page-aligned because the real IDT is used in a fixmap. */
@@ -177,9 +169,6 @@ struct desc_ptr idt_descr __ro_after_init = {
 };
 
 #ifdef CONFIG_X86_64
-/* No need to be aligned, but done to keep all IDTs defined the same way. */
-gate_desc debug_idt_table[IDT_ENTRIES] __page_aligned_bss;
-
 /*
  * The exceptions which use Interrupt stacks. They are setup after
  * cpu_init() when the TSS has been initialized.
@@ -192,15 +181,6 @@ static const __initconst struct idt_data ist_idts[] = {
 	ISTG(X86_TRAP_MC,	asm_exc_machine_check,	IST_INDEX_MCE),
 #endif
 };
-
-/*
- * Override for the debug_idt. Same as the default, but with interrupt
- * stack set to DEFAULT_STACK (0). Required for NMI trap handling.
- */
-const struct desc_ptr debug_idt_descr = {
-	.size		= IDT_ENTRIES * 16 - 1,
-	.address	= (unsigned long) debug_idt_table,
-};
 #endif
 
 static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
@@ -292,16 +272,6 @@ void __init idt_setup_ist_traps(void)
 {
 	idt_setup_from_table(idt_table, ist_idts, ARRAY_SIZE(ist_idts), true);
 }
-
-/**
- * idt_setup_debugidt_traps - Initialize the debug idt table with debug traps
- */
-void __init idt_setup_debugidt_traps(void)
-{
-	memcpy(&debug_idt_table, &idt_table, IDT_ENTRIES * 16);
-
-	idt_setup_from_table(debug_idt_table, dbg_idts, ARRAY_SIZE(dbg_idts), false);
-}
 #endif
 
 /**
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index bcb9dd9..6f887be 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -798,12 +798,6 @@ static void noinstr handle_debug(struct pt_regs *regs, unsigned long dr6,
 		return;
 	}
 
-	/*
-	 * Let others (NMI) know that the debug stack is in use
-	 * as we may switch to the interrupt stack.
-	 */
-	debug_stack_usage_inc();
-
 	/* It's safe to allow irq's after DR6 has been saved */
 	cond_local_irq_enable(regs);
 
@@ -831,7 +825,6 @@ static void noinstr handle_debug(struct pt_regs *regs, unsigned long dr6,
 
 out:
 	cond_local_irq_disable(regs);
-	debug_stack_usage_dec();
 	instrumentation_end();
 }
 
@@ -1077,6 +1070,4 @@ void __init trap_init(void)
 	cpu_init();
 
 	idt_setup_ist_traps();
-
-	idt_setup_debugidt_traps();
 }
