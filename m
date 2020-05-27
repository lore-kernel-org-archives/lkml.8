Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05524C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E357221531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgE0IL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbgE0ILt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:11:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCF9C061A0F;
        Wed, 27 May 2020 01:11:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAB-0002VQ-Sv; Wed, 27 May 2020 10:11:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 898601C00ED;
        Wed, 27 May 2020 10:11:47 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:47 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert XEN hypercall vector to IDTENTRY_SYSVEC
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202119.741950104@linutronix.de>
References: <20200521202119.741950104@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056710744.17951.7035392369829780543.tip-bot2@tip-bot2>
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

Commit-ID:     eea840b3e3afa140777b31aef52dc8166b05aae2
Gitweb:        https://git.kernel.org/tip/eea840b3e3afa140777b31aef52dc8166b05aae2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:29 +02:00

x86/entry: Convert XEN hypercall vector to IDTENTRY_SYSVEC

Convert the last oldstyle defined vector to IDTENTRY_SYSVEC:

  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64-bit
  - Remove the BUILD_INTERRUPT entries in 32-bit
  - Remove the old prototypes

Fixup the related XEN code by providing the primary C entry point in x86 to
avoid cluttering the generic code with X86'isms.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202119.741950104@linutronix.de
---
 arch/x86/entry/entry_32.S        |  5 -----
 arch/x86/entry/entry_64.S        |  5 -----
 arch/x86/include/asm/idtentry.h  |  4 ++++
 arch/x86/xen/enlighten_hvm.c     | 12 ++++++++++++
 drivers/xen/events/events_base.c |  6 ++----
 include/xen/events.h             |  7 -------
 6 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 212671a..e034b56 100644
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
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b97fcda..fd7efb8 100644
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
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 3f84388..f24701f 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -622,6 +622,10 @@ DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_acrn_hv_callback);
 #endif
 
+#ifdef CONFIG_XEN_PVHVM
+DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_xen_hvm_callback);
+#endif
+
 #undef X86_TRAP_OTHER
 
 #endif
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index e138f7d..3e89b00 100644
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
@@ -118,6 +119,17 @@ static void __init init_hvm_pv_info(void)
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
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index eb35c3c..140c7bf 100644
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
@@ -1236,9 +1237,6 @@ void xen_evtchn_do_upcall(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	irq_enter();
-#ifdef CONFIG_X86
-	inc_irq_stat(irq_hv_callback_count);
-#endif
 
 	__xen_evtchn_do_upcall();
 
@@ -1658,7 +1656,7 @@ static __init void xen_alloc_callback_vector(void)
 		return;
 
 	pr_info("Xen HVM callback vector for event delivery is enabled\n");
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, xen_hvm_callback_vector);
+	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_xen_hvm_callback);
 }
 #else
 void xen_setup_callback_vector(void) {}
diff --git a/include/xen/events.h b/include/xen/events.h
index 12b0dcb..df1e639 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -90,13 +90,6 @@ unsigned int irq_from_evtchn(evtchn_port_t evtchn);
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
