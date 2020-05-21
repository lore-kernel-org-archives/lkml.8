Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0FFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F47208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgEUUcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbgEUUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:32:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DB6C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:32:15 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrr6-0000oP-FL; Thu, 21 May 2020 22:31:52 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id EF9E3100C2D;
        Thu, 21 May 2020 22:31:51 +0200 (CEST)
Message-Id: <20200521202119.741950104@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:44 +0200
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
Subject: [patch V9 31/39] x86/entry: Convert XEN hypercall vector to IDTENTRY_SYSVEC
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

Convert the last oldstyle defined vector to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototypes

Fixup the related XEN code by providing the primary C entry point in x86 to
avoid cluttering the generic code with X86'isms.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_32.S        |    5 -----
 arch/x86/entry/entry_64.S        |    5 -----
 arch/x86/include/asm/idtentry.h  |    4 ++++
 arch/x86/xen/enlighten_hvm.c     |   12 ++++++++++++
 drivers/xen/events/events_base.c |    6 ++----
 include/xen/events.h             |    7 -------
 6 files changed, 18 insertions(+), 21 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1337,11 +1337,6 @@ SYM_FUNC_START(xen_failsafe_callback)
 SYM_FUNC_END(xen_failsafe_callback)
 #endif /* CONFIG_XEN_PV */
 
-#ifdef CONFIG_XEN_PVHVM
-BUILD_INTERRUPT3(xen_hvm_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
-		 xen_evtchn_do_upcall)
-#endif
-
 SYM_CODE_START_LOCAL_NOALIGN(handle_exception)
 	/* the function address is in %gs's slot on the stack */
 	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1111,11 +1111,6 @@ SYM_CODE_START(xen_failsafe_callback)
 SYM_CODE_END(xen_failsafe_callback)
 #endif /* CONFIG_XEN_PV */
 
-#ifdef CONFIG_XEN_PVHVM
-apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
-	xen_hvm_callback_vector xen_evtchn_do_upcall
-#endif
-
 /*
  * Save all registers in pt_regs, and switch gs if needed.
  * Use slow, but surefire "are we in kernel?" check.
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -618,6 +618,10 @@ DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIME
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_acrn_hv_callback);
 #endif
 
+#ifdef CONFIG_XEN_PVHVM
+DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_xen_hvm_callback);
+#endif
+
 #undef X86_TRAP_OTHER
 
 #endif
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -13,6 +13,7 @@
 #include <asm/smp.h>
 #include <asm/reboot.h>
 #include <asm/setup.h>
+#include <asm/idtentry.h>
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
 #include <asm/early_ioremap.h>
@@ -118,6 +119,17 @@ static void __init init_hvm_pv_info(void
 		this_cpu_write(xen_vcpu_id, smp_processor_id());
 }
 
+DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_callback)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	inc_irq_stat(irq_hv_callback_count);
+
+	xen_hvm_evtchn_do_upcall();
+
+	set_irq_regs(old_regs);
+}
+
 #ifdef CONFIG_KEXEC_CORE
 static void xen_hvm_shutdown(void)
 {
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -37,6 +37,7 @@
 #ifdef CONFIG_X86
 #include <asm/desc.h>
 #include <asm/ptrace.h>
+#include <asm/idtentry.h>
 #include <asm/irq.h>
 #include <asm/io_apic.h>
 #include <asm/i8259.h>
@@ -1236,9 +1237,6 @@ void xen_evtchn_do_upcall(struct pt_regs
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	irq_enter();
-#ifdef CONFIG_X86
-	inc_irq_stat(irq_hv_callback_count);
-#endif
 
 	__xen_evtchn_do_upcall();
 
@@ -1658,7 +1656,7 @@ static __init void xen_alloc_callback_ve
 		return;
 
 	pr_info("Xen HVM callback vector for event delivery is enabled\n");
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, xen_hvm_callback_vector);
+	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_xen_hvm_callback);
 }
 #else
 void xen_setup_callback_vector(void) {}
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -90,13 +90,6 @@ unsigned int irq_from_evtchn(evtchn_port
 int irq_from_virq(unsigned int cpu, unsigned int virq);
 evtchn_port_t evtchn_from_irq(unsigned irq);
 
-#ifdef CONFIG_XEN_PVHVM
-/* Xen HVM evtchn vector callback */
-void xen_hvm_callback_vector(void);
-#ifdef CONFIG_TRACING
-#define trace_xen_hvm_callback_vector xen_hvm_callback_vector
-#endif
-#endif
 int xen_set_callback_via(uint64_t via);
 void xen_evtchn_do_upcall(struct pt_regs *regs);
 void xen_hvm_evtchn_do_upcall(void);

