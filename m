Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7254C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6D120874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbgEUUde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbgEUUcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C373C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:05 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqv-0000d0-L0; Thu, 21 May 2020 22:31:41 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B8D6F100606;
        Thu, 21 May 2020 22:31:40 +0200 (CEST)
Message-Id: <20200521202118.889972748@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:35 +0200
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
Subject: [patch V9 22/39] x86/irq: Rework handle_irq() for 64bit
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

To consolidate the interrupt entry/exit code vs. the other exceptions
make handle_irq() and inline and handle both 64bit and 32bit

Preparatory change to move irq stack switching for 64bit to C which allows
to consolidate the entry exit handling by reusing the idtentry machinery
both in ASM and C.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V9: Adopt to inlined run_cond_on_irqstack()
---
 arch/x86/include/asm/irq.h |    2 +-
 arch/x86/kernel/irq.c      |   11 ++++++++++-
 arch/x86/kernel/irq_32.c   |    2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -34,7 +34,7 @@ extern __visible void smp_kvm_posted_int
 extern void (*x86_platform_ipi_callback)(void);
 extern void native_init_IRQ(void);
 
-extern void handle_irq(struct irq_desc *desc, struct pt_regs *regs);
+extern void __handle_irq(struct irq_desc *desc, struct pt_regs *regs);
 
 extern __visible void do_IRQ(struct pt_regs *regs, unsigned long vector);
 
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/irq.h>
 
+#include <asm/irq_stack.h>
 #include <asm/apic.h>
 #include <asm/io_apic.h>
 #include <asm/irq.h>
@@ -221,6 +222,14 @@ u64 arch_irq_stat(void)
 	return sum;
 }
 
+static __always_inline void handle_irq(struct irq_desc *desc,
+				       struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_X86_64))
+		run_on_irqstack_cond(desc->handle_irq, desc, regs);
+	else
+		__handle_irq(desc, regs);
+}
 
 /*
  * do_IRQ handles all normal device IRQ's (the special
@@ -246,7 +255,7 @@ u64 arch_irq_stat(void)
 	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		if (IS_ENABLED(CONFIG_X86_32))
-			handle_irq(desc, regs);
+			__handle_irq(desc, regs);
 		else
 			generic_handle_irq_desc(desc);
 	} else {
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -148,7 +148,7 @@ void do_softirq_own_stack(void)
 	call_on_stack(__do_softirq, isp);
 }
 
-void handle_irq(struct irq_desc *desc, struct pt_regs *regs)
+void __handle_irq(struct irq_desc *desc, struct pt_regs *regs)
 {
 	int overflow = check_stack_overflow();
 

