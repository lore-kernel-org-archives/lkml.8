Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B58C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9FD020675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgEEOS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730150AbgEEOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4EDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:42 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMy-0002HF-Pv; Tue, 05 May 2020 16:16:24 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 43D46FFC8D;
        Tue,  5 May 2020 16:16:24 +0200 (CEST)
Message-Id: <20200505135828.408202221@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:53:44 +0200
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
Subject: [patch V4 part 5 03/31] x86/entry/64: Move softirq stack switch to C
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

Use the new C code helpers to move do_softirq_own_stack() out of ASM
code. Mark the switching function noinstr as this is really not a good
place for being instrumented.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |   13 -------------
 arch/x86/kernel/irq_64.c  |   12 ++++++++++++
 2 files changed, 12 insertions(+), 13 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1107,19 +1107,6 @@ SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
 SYM_CODE_END(.Lbad_gs)
 	.previous
 
-/* Call softirq on interrupt stack. Interrupts are off. */
-.pushsection .text, "ax"
-SYM_FUNC_START(do_softirq_own_stack)
-	pushq	%rbp
-	mov	%rsp, %rbp
-	ENTER_IRQ_STACK regs=0 old_rsp=%r11
-	call	__do_softirq
-	LEAVE_IRQ_STACK regs=0
-	leaveq
-	ret
-SYM_FUNC_END(do_softirq_own_stack)
-.popsection
-
 #ifdef CONFIG_XEN_PV
 /*
  * A note on the "critical region" in our callback handler.
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task_stack.h>
 
 #include <asm/cpu_entry_area.h>
+#include <asm/irq_stack.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 
@@ -70,3 +71,14 @@ int irq_init_percpu_irqstack(unsigned in
 		return 0;
 	return map_irq_stack(cpu);
 }
+
+noinstr void do_softirq_own_stack(void)
+{
+	if (irqstack_active()) {
+		instr_begin();
+		__do_softirq();
+		instr_end();
+	} else {
+		RUN_ON_IRQSTACK(__do_softirq);
+	}
+}

