Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E723DC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0774206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgEEORo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730281AbgEEORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:17:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCE1C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:17:15 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyNR-0002cF-7r; Tue, 05 May 2020 16:16:53 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B8D03FFC8D;
        Tue,  5 May 2020 16:16:52 +0200 (CEST)
Message-Id: <20200505135830.686385997@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:54:07 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 5 26/31] x86/entry/64: Remove IRQ stack switching ASM
References: <20200505135341.730586321@linutronix.de>
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

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |   96 ----------------------------------------------
 1 file changed, 96 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -371,102 +371,6 @@ SYM_CODE_END(ret_from_fork)
 #endif
 .endm
 
-/*
- * Enters the IRQ stack if we're not already using it.  NMI-safe.  Clobbers
- * flags and puts old RSP into old_rsp, and leaves all other GPRs alone.
- * Requires kernel GSBASE.
- *
- * The invariant is that, if irq_count != -1, then the IRQ stack is in use.
- */
-.macro ENTER_IRQ_STACK regs=1 old_rsp save_ret=0
-	DEBUG_ENTRY_ASSERT_IRQS_OFF
-
-	.if \save_ret
-	/*
-	 * If save_ret is set, the original stack contains one additional
-	 * entry -- the return address. Therefore, move the address one
-	 * entry below %rsp to \old_rsp.
-	 */
-	leaq	8(%rsp), \old_rsp
-	.else
-	movq	%rsp, \old_rsp
-	.endif
-
-	.if \regs
-	UNWIND_HINT_REGS base=\old_rsp
-	.endif
-
-	incl	PER_CPU_VAR(irq_count)
-	jnz	.Lirq_stack_push_old_rsp_\@
-
-	/*
-	 * Right now, if we just incremented irq_count to zero, we've
-	 * claimed the IRQ stack but we haven't switched to it yet.
-	 *
-	 * If anything is added that can interrupt us here without using IST,
-	 * it must be *extremely* careful to limit its stack usage.  This
-	 * could include kprobes and a hypothetical future IST-less #DB
-	 * handler.
-	 *
-	 * The OOPS unwinder relies on the word at the top of the IRQ
-	 * stack linking back to the previous RSP for the entire time we're
-	 * on the IRQ stack.  For this to work reliably, we need to write
-	 * it before we actually move ourselves to the IRQ stack.
-	 */
-
-	movq	\old_rsp, PER_CPU_VAR(irq_stack_backing_store + IRQ_STACK_SIZE - 8)
-	movq	PER_CPU_VAR(hardirq_stack_ptr), %rsp
-
-#ifdef CONFIG_DEBUG_ENTRY
-	/*
-	 * If the first movq above becomes wrong due to IRQ stack layout
-	 * changes, the only way we'll notice is if we try to unwind right
-	 * here.  Assert that we set up the stack right to catch this type
-	 * of bug quickly.
-	 */
-	cmpq	-8(%rsp), \old_rsp
-	je	.Lirq_stack_okay\@
-	ud2
-	.Lirq_stack_okay\@:
-#endif
-
-.Lirq_stack_push_old_rsp_\@:
-	pushq	\old_rsp
-
-	.if \regs
-	UNWIND_HINT_REGS indirect=1
-	.endif
-
-	.if \save_ret
-	/*
-	 * Push the return address to the stack. This return address can
-	 * be found at the "real" original RSP, which was offset by 8 at
-	 * the beginning of this macro.
-	 */
-	pushq	-8(\old_rsp)
-	.endif
-.endm
-
-/*
- * Undoes ENTER_IRQ_STACK.
- */
-.macro LEAVE_IRQ_STACK regs=1
-	DEBUG_ENTRY_ASSERT_IRQS_OFF
-	/* We need to be off the IRQ stack before decrementing irq_count. */
-	popq	%rsp
-
-	.if \regs
-	UNWIND_HINT_REGS
-	.endif
-
-	/*
-	 * As in ENTER_IRQ_STACK, irq_count == 0, we are still claiming
-	 * the irq stack but we're not on it.
-	 */
-
-	decl	PER_CPU_VAR(irq_count)
-.endm
-
 /**
  * idtentry_body - Macro to emit code calling the C function
  * @cfunc:		C function to be called

