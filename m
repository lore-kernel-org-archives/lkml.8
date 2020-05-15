Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEDDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB8D82078B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgEPAMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727930AbgEPAKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:10:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:10:54 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkPB-00028g-ML; Sat, 16 May 2020 02:10:17 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B9265100605;
        Sat, 16 May 2020 02:10:16 +0200 (CEST)
Message-Id: <20200515235125.219205621@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:45:55 +0200
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V6 08/37] x86/entry/64: Move do_softirq_own_stack() to C
References: <20200515234547.710474468@linutronix.de>
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


The first step to get rid of the ENTER/LEAVE_IRQ_STACK ASM macro maze.  Use
the new C code helpers to move do_softirq_own_stack() out of ASM code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3b8da9f09297..bdf8391b2f95 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1145,19 +1145,6 @@ SYM_FUNC_START(asm_call_on_stack)
 	ret
 SYM_FUNC_END(asm_call_on_stack)
 
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
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 12df3a4abfdd..62cff52e03c5 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -20,6 +20,7 @@
 #include <linux/sched/task_stack.h>
 
 #include <asm/cpu_entry_area.h>
+#include <asm/irq_stack.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 
@@ -70,3 +71,11 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 		return 0;
 	return map_irq_stack(cpu);
 }
+
+void do_softirq_own_stack(void)
+{
+	if (irqstack_active())
+		__do_softirq();
+	else
+		run_on_irqstack(__do_softirq, NULL);
+}

