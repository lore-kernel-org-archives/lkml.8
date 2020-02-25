Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15D2C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A2724680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgBYX1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56048 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgBYX1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:27:09 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jb6-00059b-O3; Wed, 26 Feb 2020 00:26:42 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 7ED931040C5;
        Wed, 26 Feb 2020 00:25:53 +0100 (CET)
Message-Id: <20200225231610.016800778@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:30 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 11/15] x86/entry: Convert XEN hypercall vector to IDTENTRY_SYSVEC
References: <20200225224719.950376311@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/entry/entry_32.S        |    5 -----
 arch/x86/entry/entry_64.S        |    5 -----
 arch/x86/include/asm/idtentry.h  |    4 ++++
 arch/x86/xen/enlighten_hvm.c     |    6 ++++++
 drivers/xen/events/events_base.c |    3 ++-
 include/xen/events.h             |    7 -------
 6 files changed, 12 insertions(+), 18 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1375,11 +1375,6 @@ SYM_FUNC_START(xen_failsafe_callback)
 SYM_FUNC_END(xen_failsafe_callback)
 #endif /* CONFIG_XEN_PV */
 
-#ifdef CONFIG_XEN_PVHVM
-BUILD_INTERRUPT3(xen_hvm_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
-		 xen_evtchn_do_upcall)
-#endif
-
 SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	/* the function address is in %gs's slot on the stack */
 	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1125,11 +1125,6 @@ SYM_CODE_START(xen_failsafe_callback)
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
@@ -536,6 +536,10 @@ DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIME
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_acrn_hv_callback);
 #endif
 
+#ifdef CONFIG_XEN_PVHVM
+DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_xen_hvm_callback);
+#endif
+
 #ifdef CONFIG_X86_MCE
 /* Machine check */
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
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
@@ -118,6 +119,11 @@ static void __init init_hvm_pv_info(void
 		this_cpu_write(xen_vcpu_id, smp_processor_id());
 }
 
+DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_callback)
+{
+	xen_evtchn_do_upcall(regs);
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
@@ -1651,7 +1652,7 @@ void xen_callback_vector(void)
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
@@ -90,13 +90,6 @@ unsigned irq_from_evtchn(unsigned int ev
 int irq_from_virq(unsigned int cpu, unsigned int virq);
 unsigned int evtchn_from_irq(unsigned irq);
 
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

