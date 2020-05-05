Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D257C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27639207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgEEOQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730172AbgEEOQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DD2C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:49 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMx-0002GR-Hc; Tue, 05 May 2020 16:16:23 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 0AD8BFFC8D;
        Tue,  5 May 2020 16:16:23 +0200 (CEST)
Message-Id: <20200505135828.316937774@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:53:43 +0200
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
Subject: [patch V4 part 5 02/31] x86/entry: Provide helpers for execute on irqstack
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

Device interrupt handlers and system vector handlers are executed on the
interrupt stack. The stack switch happens in the low level assembly entry
code. This conflicts with the efforts to consolidate the exit code in C to
ensure correctness vs. RCU and tracing.

As there is no way to move #DB away from IST due to the MOV SS issue, the
requirements vs. #DB and NMI for switching to the interrupt stack do not
exist anymore. The only requirement is that interrupts are disabled.

That allows to move the stack switching to C code which simplifies the
entry/exit handling further because it allows to switch stacks after
handling the entry and on exit before handling RCU, return to usermode and
kernel preemption in the same way as for regular exceptions.

That also allows to move the xen hypercall extra magic code and the softirq
stack switching into C.

The mechanism is straight forward:

  1) Store the current stack pointer on top of the interrupt stack. That's
     required for the unwinder. 

  2) Switch the stack pointer

  3) Call the function

  4) Restore the stackpointer

The full code sequence to make the unwinder happy is:

    	pushq	%rbp
	movq	%rsp, %rbp
	movq    $(top_of_hardirq_stack - 8), %reg
	movq	%rsp, (%reg)
  	movq	%reg , %rsp
	call    function
	popq	%rsp
	leaveq
	
While the following sequence would spare the 'popq %rsp':

    	pushq	%rbp
	movq    $(top_of_hardirq_stack - 8), %rbp
	movq	%rsp, (%rrbp)
  	xchgq	%rbp, %rsp
	call    function
 	movq	%rbp, %rsp
	leaveq

but that requires further changes to objtool so that the unwinder works
correctly. Can be done on top and is not critical for now.

Provide helper functions to check whether the interrupt stack is already
active and whether stack switching is required.

64 bit only for now. 32 bit has a variant of that already. Once this is
cleaned up the two implementations might be consolidated as a cleanup on
top.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/irq_stack.h |   61 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

--- /dev/null
+++ b/arch/x86/include/asm/irq_stack.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IRQ_STACK_H
+#define _ASM_X86_IRQ_STACK_H
+
+#include <linux/ptrace.h>
+
+#include <asm/processor.h>
+
+#ifdef CONFIG_X86_64
+static __always_inline bool irqstack_active(void)
+{
+	return __this_cpu_read(irq_count) != -1;
+}
+
+/*
+ * Macro to emit code for running @func on the irq stack.
+ */
+#define RUN_ON_IRQSTACK(func)	{					\
+	unsigned long tos;						\
+									\
+	lockdep_assert_irqs_disabled();					\
+									\
+	tos = ((unsigned long)__this_cpu_read(hardirq_stack_ptr)) - 8;	\
+									\
+	__this_cpu_add(irq_count, 1);					\
+	asm volatile(							\
+		"pushq  %%rbp					\n"	\
+		"movq   %%rsp, %%rbp				\n"	\
+		"movq	%%rsp, (%[ts])				\n"	\
+		"movq	%[ts], %%rsp				\n"	\
+		"1:						\n"	\
+		"	.pushsection .discard.instr_begin	\n"	\
+		"	.long 1b - .				\n"	\
+		"	.popsection				\n"	\
+		"call	" __ASM_FORM(func) "			\n"	\
+		"2:						\n"	\
+		"	.pushsection .discard.instr_end		\n"	\
+		"	.long 2b - .				\n"	\
+		"	.popsection				\n"	\
+		"popq	%%rsp					\n"	\
+		"leaveq						\n"	\
+		:							\
+		: [ts] "r" (tos)					\
+		: "memory"						\
+		);							\
+	__this_cpu_sub(irq_count, 1);					\
+}
+
+#else /* CONFIG_X86_64 */
+static __always_inline bool irqstack_active(void) { return false; }
+#define RUN_ON_IRQSTACK(func)	do { } while (0)
+#endif /* !CONFIG_X86_64 */
+
+static __always_inline bool irq_needs_irq_stack(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		return false;
+	return !user_mode(regs) && !irqstack_active();
+}
+
+#endif

