Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FDBC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B3220826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgEUUda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbgEUUcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C769C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:05 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqg-0000Pn-GJ; Thu, 21 May 2020 22:31:26 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id CBC5D100606;
        Thu, 21 May 2020 22:31:25 +0200 (CEST)
Message-Id: <20200521202117.763775313@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:23 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V9 10/39] x86/entry: Provide helpers for execute on irqstack
References: <20200521200513.656533920@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

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

The initial attempt of having the stack switching in inline ASM caused too
much headache vs. objtool and the unwinder. After analysing the use cases
it was agreed on that having the stack switch in ASM for the price of an
indirect call is acceptable as the main users are indirect call heavy
anyway and the few system vectors which are empty shells (scheduler IPI and
KVM posted interrupt vectors) can run from the regular stack.

Provide helper functions to check whether the interrupt stack is already
active and whether stack switching is required.

64 bit only for now. 32 bit has a variant of that already. Once this is
cleaned up the two implementations might be consolidated as a cleanup on
top.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V9: Moved the conditions into an inline to avoid code duplication
---
 arch/x86/entry/entry_64.S        |   39 ++++++++++++++++++++++++++++
 arch/x86/include/asm/irq_stack.h |   53 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1106,6 +1106,45 @@ SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
 SYM_CODE_END(.Lbad_gs)
 	.previous
 
+/*
+ * rdi: New stack pointer points to the top word of the stack
+ * rsi: Function pointer
+ * rdx: Function argument (can be NULL if none)
+ */
+SYM_FUNC_START(asm_call_on_stack)
+	/*
+	 * Save the frame pointer unconditionally. This allows the ORC
+	 * unwinder to handle the stack switch.
+	 */
+	pushq		%rbp
+	mov		%rsp, %rbp
+
+	/*
+	 * The unwinder relies on the word at the top of the new stack
+	 * page linking back to the previous RSP.
+	 */
+	mov		%rsp, (%rdi)
+	mov		%rdi, %rsp
+	/* Move the argument to the right place */
+	mov		%rdx, %rdi
+
+1:
+	.pushsection .discard.instr_begin
+	.long 1b - .
+	.popsection
+
+	CALL_NOSPEC	rsi
+
+2:
+	.pushsection .discard.instr_end
+	.long 2b - .
+	.popsection
+
+	/* Restore the previous stack pointer from RBP. */
+	leaveq
+	ret
+SYM_FUNC_END(asm_call_on_stack)
+
 /* Call softirq on interrupt stack. Interrupts are off. */
 .pushsection .text, "ax"
 SYM_FUNC_START(do_softirq_own_stack)
--- /dev/null
+++ b/arch/x86/include/asm/irq_stack.h
@@ -0,0 +1,53 @@
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
+void asm_call_on_stack(void *sp, void *func, void *arg);
+
+static __always_inline void __run_on_irqstack(void *func, void *arg)
+{
+	void *tos = __this_cpu_read(hardirq_stack_ptr);
+
+	__this_cpu_add(irq_count, 1);
+	asm_call_on_stack(tos - 8, func, arg);
+	__this_cpu_sub(irq_count, 1);
+}
+
+#else /* CONFIG_X86_64 */
+static inline bool irqstack_active(void) { return false; }
+static inline void __run_on_irqstack(void *func, void *arg) { }
+#endif /* !CONFIG_X86_64 */
+
+static __always_inline bool irq_needs_irq_stack(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_X86_32))
+		return false;
+	if (!regs)
+		return !irqstack_active();
+	return !user_mode(regs) && !irqstack_active();
+}
+
+static __always_inline void run_on_irqstack_cond(void *func, void *arg,
+						 struct pt_regs *regs)
+{
+	void (*__func)(void *arg) = func;
+
+	lockdep_assert_irqs_disabled();
+
+	if (irq_needs_irq_stack(regs))
+		__run_on_irqstack(__func, arg);
+	else
+		__func(arg);
+}
+
+#endif

