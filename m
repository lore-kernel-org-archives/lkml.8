Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE2DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E180120810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h0ME/Jjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgE2VhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:37:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54872 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgE2VhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8M0uHrQFcpCH9N7RG6/ZaUWZon6D/JdwZY5bgIEl3Dk=; b=h0ME/JjmG2xVU4Z0CtcjgtQ+nc
        ikXGgnrT2Fyc3zEyiSHJmGEZUw36/fuaUafEJa+bB705OObqcKhEp/XqGqozJVrzjsQV13veaMERH
        3QV0oj6Jtg9vnsC3yFxPDTtOw3WM2QcMlYGWBIl/qyiLYNEVwtCQ87livZBWJEyt/qV3j6tKHX1HT
        +a71D/f+rKXRAQY9seaypiZLwU2Tgj5fZf8pqNz0yLpDgUCPdfkhXPISh8uPReDjLBt170gvMLCtr
        UxIhOYPkINqIIfO2eZmXK5MjvJTEZt+LvRdRUTgKgvbClhxklmf4PfZqUTql2LlnUI0JqVOVJR1/3
        73p3HJPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jemeP-0007J5-VR; Fri, 29 May 2020 21:34:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 023AA307643;
        Fri, 29 May 2020 23:34:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 355432B9B1BBF; Fri, 29 May 2020 23:34:41 +0200 (CEST)
Message-ID: <20200529213321.245019500@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 29 May 2020 23:27:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de
Subject: [PATCH 09/14] x86/entry: Remove debug IDT frobbing
References: <20200529212728.795169701@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is all unused now.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/debugreg.h |   19 -------------------
 arch/x86/include/asm/desc.h     |   34 +---------------------------------
 arch/x86/kernel/cpu/common.c    |   17 -----------------
 arch/x86/kernel/idt.c           |   30 ------------------------------
 arch/x86/kernel/traps.c         |    9 ---------
 5 files changed, 1 insertion(+), 108 deletions(-)

--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -96,25 +96,6 @@ extern void aout_dump_debugregs(struct u
 
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
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -42,8 +42,6 @@ static inline void fill_ldt(struct desc_
 
 extern struct desc_ptr idt_descr;
 extern gate_desc idt_table[];
-extern const struct desc_ptr debug_idt_descr;
-extern gate_desc debug_idt_table[];
 
 struct gdt_page {
 	struct desc_struct gdt[GDT_ENTRIES];
@@ -390,31 +388,6 @@ void alloc_intr_gate(unsigned int n, con
 
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
@@ -438,11 +408,9 @@ extern void idt_setup_apic_and_irq_gates
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
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1672,23 +1672,6 @@ void syscall_init(void)
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
@@ -158,14 +158,6 @@ static const __initconst struct idt_data
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
@@ -177,9 +169,6 @@ struct desc_ptr idt_descr __ro_after_ini
 };
 
 #ifdef CONFIG_X86_64
-/* No need to be aligned, but done to keep all IDTs defined the same way. */
-gate_desc debug_idt_table[IDT_ENTRIES] __page_aligned_bss;
-
 /*
  * The exceptions which use Interrupt stacks. They are setup after
  * cpu_init() when the TSS has been initialized.
@@ -192,15 +181,6 @@ static const __initconst struct idt_data
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
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -798,12 +798,6 @@ static void noinstr handle_debug(struct
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
 
@@ -831,7 +825,6 @@ static void noinstr handle_debug(struct
 
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


