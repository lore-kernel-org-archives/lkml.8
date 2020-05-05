Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A3EC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA19720675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgEEOSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730201AbgEEOQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79193C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:56 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyNC-0002Qr-LP; Tue, 05 May 2020 16:16:38 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id D8517FFC8D;
        Tue,  5 May 2020 16:16:37 +0200 (CEST)
Message-Id: <20200505135829.492233336@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:53:55 +0200
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
Subject: [patch V4 part 5 14/31] x86/irq/64: Provide handle_irq()
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

To consolidate the interrupt entry/exit code vs. the other exceptions
provide handle_irq() (similar to 32bit) to move the interrupt stack
switching to C code. That allows to consolidate the entry exit handling by
reusing the idtentry machinery both in ASM and C.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/irq_64.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -72,6 +72,48 @@ int irq_init_percpu_irqstack(unsigned in
 	return map_irq_stack(cpu);
 }
 
+static noinstr void handle_irq_on_irqstack(struct irq_desc *desc)
+{
+	unsigned long tos;
+
+	tos = (unsigned long) __this_cpu_read(hardirq_stack_ptr);
+	tos -= 8;
+	/*
+	 * The unwinder requires that the top of the IRQ stack links back
+	 * to the previous stack and RBP is set up.
+	 */
+	asm volatile(
+		"pushq  %%rbp					\n"
+		"movq   %%rsp, %%rbp				\n"
+		"movq	%%rsp, (%[ts])				\n"
+		"movq	%[ts], %%rsp				\n"
+		"1:						\n"
+		"	.pushsection .discard.instr_begin	\n"
+		"	.long 1b - .				\n"
+		"	.popsection				\n"
+		CALL_NOSPEC
+		"2:						\n"
+		"	.pushsection .discard.instr_end		\n"
+		"	.long 2b - .				\n"
+		"	.popsection				\n"
+		"popq	%%rsp					\n"
+		"leaveq						\n"
+		:
+		: [ts] "r" (tos),
+		  [thunk_target] "r" (desc->handle_irq),
+		  "D" (desc)
+		: "memory"
+		);
+}
+
+void handle_irq(struct irq_desc *desc, struct pt_regs *regs)
+{
+	if (!irq_needs_irq_stack(regs))
+		generic_handle_irq_desc(desc);
+	else
+		handle_irq_on_irqstack(desc);
+}
+
 noinstr void do_softirq_own_stack(void)
 {
 	if (irqstack_active()) {

