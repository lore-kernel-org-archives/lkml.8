Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA11C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA4620675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgEEORc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730258AbgEEORL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:17:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B5AC061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:17:10 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyNN-0002ZQ-Gu; Tue, 05 May 2020 16:16:49 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 069B31001F5;
        Tue,  5 May 2020 16:16:49 +0200 (CEST)
Message-Id: <20200505135830.390662187@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:54:04 +0200
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
Subject: [patch V4 part 5 23/31] x86/entry: Convert XEN hypercall vector to
 IDTENTRY_SYSVEC
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

From: Thomas Gleixner <tglx@linutronix.de>

Convert the last oldstyle defined vector to IDTENTRY_SYSVEC
  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64bit
  - Remove the BUILD_INTERRUPT entries in 32bit
  - Remove the old prototyoes

Fixup the related XEN code by providing the primary C entry point in x86 to
avoid cluttering the generic code with X86'isms.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
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
@@ -1073,11 +1073,6 @@ SYM_CODE_START(xen_failsafe_callback)
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
 
@@ -1654,7 +1652,7 @@ void xen_callback_vector(void)
 		}
 		pr_info_once("Xen HVM callback vector for event delivery is enabled\n");
 		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
-				xen_hvm_callback_vector);
+				asm_sysvec_xen_hvm_callback);
 	}
 }
 #else
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

