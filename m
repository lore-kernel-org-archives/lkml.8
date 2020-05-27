Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D938C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C0121531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbgE0INJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgE0IME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE94C03E97A;
        Wed, 27 May 2020 01:12:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAP-0002dU-UY; Wed, 27 May 2020 10:12:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D52E41C04D6;
        Wed, 27 May 2020 10:11:57 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:57 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Provide helpers for executing on the irqstack
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202117.763775313@linutronix.de>
References: <20200521202117.763775313@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711769.17951.7240676234405001898.tip-bot2@tip-bot2>
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

Commit-ID:     0aa4dbb2808991f53396df8d2deb390d4f880abb
Gitweb:        https://git.kernel.org/tip/0aa4dbb2808991f53396df8d2deb390d4f880abb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:27 +02:00

x86/entry: Provide helpers for executing on the irqstack

Device interrupt handlers and system vector handlers are executed on the
interrupt stack. The stack switch happens in the low level assembly entry
code. This conflicts with the efforts to consolidate the exit code in C to
ensure correctness vs. RCU and tracing.

As there is no way to move #DB away from IST due to the MOV SS issue, the
requirements vs. #DB and NMI for switching to the interrupt stack do not
exist anymore. The only requirement is that interrupts are disabled.

That allows the moving of the stack switching to C code, which simplifies the
entry/exit handling further, because it allows the switching of stacks after
handling the entry and on exit before handling RCU, returning to usermode and
kernel preemption in the same way as for regular exceptions.

The initial attempt of having the stack switching in inline ASM caused too
much headache vs. objtool and the unwinder. After analysing the use cases
it was agreed on that having the stack switch in ASM for the price of an
indirect call is acceptable, as the main users are indirect call heavy
anyway and the few system vectors which are empty shells (scheduler IPI and
KVM posted interrupt vectors) can run from the regular stack.

Provide helper functions to check whether the interrupt stack is already
active and whether stack switching is required.

64-bit only for now, as 32-bit has a variant of that already. Once this is
cleaned up, the two implementations might be consolidated as an additional
cleanup on top.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202117.763775313@linutronix.de
---
 arch/x86/entry/entry_64.S        | 39 +++++++++++++++++++++++-
 arch/x86/include/asm/irq_stack.h | 53 +++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+)
 create mode 100644 arch/x86/include/asm/irq_stack.h

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d983a0d..1597370 100644
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
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
new file mode 100644
index 0000000..4ae66f0
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
