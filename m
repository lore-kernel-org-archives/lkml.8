Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1166C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7951C204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dP5vBGcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbgEVUuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:50:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60100 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731089AbgEVUuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ECXIFCqzMAsRJ+1Dq9iprTLNShImRuIXIFz/RxLWG5c=; b=dP5vBGcV3cLzZJUAPrKAofsAi/
        4Aq0iDWkaZMHbueUJ11ju8CfdRTFVnVh31+XCuqXSvVc6sTWJyCKB92u8LjN4Fh9FU1YEnYfqJ5ur
        8Uw67jEauMud5s8qP3wR06y6PnalTA71Iw+iSFAAyuQKqjmKYLMoYXVMysn86Vdz9t0Xv41M+1iL/
        oXtRyC5MPRNwLMqN0HwVlLQb58B4aXY/p+WR50i8+knV/fzho/G2sEgbFdErcyd3ajrkA1J1f6xdr
        g24/GEjP+tBLudJ7HWwXdM2SNJS/3Q/Y61usOzqycbN6gwhSsvkDn90BfVV0gFQCJhT2NEV3sHuz9
        cJrtdCKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcEcJ-0002gS-Hb; Fri, 22 May 2020 20:50:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD4C5305E45;
        Fri, 22 May 2020 22:49:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B2EDB2B7F3D20; Fri, 22 May 2020 22:49:56 +0200 (CEST)
Message-ID: <20200522204943.350442553@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 May 2020 22:47:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [RFC][PATCH 3/4] x86/entry: Remove debug IST frobbing
References: <20200522204738.645043059@infradead.org>
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
 arch/x86/include/asm/desc.h     |   32 +-------------------------------
 arch/x86/kernel/cpu/common.c    |   17 -----------------
 arch/x86/kernel/idt.c           |   22 ----------------------
 arch/x86/kernel/traps.c         |    9 ---------
 5 files changed, 1 insertion(+), 98 deletions(-)

--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -94,25 +94,6 @@ extern void aout_dump_debugregs(struct u
 
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
 static __always_inline void local_db_save(unsigned long *dr7)
 {
 	get_debugreg(*dr7, 7);
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -390,31 +390,6 @@ void alloc_intr_gate(unsigned int n, con
 
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
@@ -424,10 +399,7 @@ static inline void load_debug_idt(void)
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
@@ -438,11 +410,9 @@ extern void idt_setup_apic_and_irq_gates
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
@@ -177,9 +177,6 @@ struct desc_ptr idt_descr __ro_after_ini
 };
 
 #ifdef CONFIG_X86_64
-/* No need to be aligned, but done to keep all IDTs defined the same way. */
-gate_desc debug_idt_table[IDT_ENTRIES] __page_aligned_bss;
-
 /*
  * The exceptions which use Interrupt stacks. They are setup after
  * cpu_init() when the TSS has been initialized.
@@ -192,15 +189,6 @@ static const __initconst struct idt_data
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
@@ -292,16 +280,6 @@ void __init idt_setup_ist_traps(void)
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


