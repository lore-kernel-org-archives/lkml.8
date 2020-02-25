Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0114C4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8459C24681
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgBYX21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:28:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55896 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730312AbgBYX0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:37 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jal-0004x3-3y; Wed, 26 Feb 2020 00:26:19 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id A961C1040B5;
        Wed, 26 Feb 2020 00:25:46 +0100 (CET)
Message-Id: <20200225224145.233039728@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:33:32 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 11/16] x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
References: <20200225223321.231477305@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert # to IDTENTRY:
  - Implement the C entry point with DEFINE_IDTENTRY
  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Fixup the XEN/PV code
  - Remove the old prototyoes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |    7 +++++--
 arch/x86/entry/entry_64.S       |   11 ++++-------
 arch/x86/include/asm/idtentry.h |   13 +++++++++++++
 arch/x86/xen/setup.c            |    4 +++-
 arch/x86/xen/smp_pv.c           |    3 ++-
 arch/x86/xen/xen-asm_32.S       |    8 ++++----
 arch/x86/xen/xen-asm_64.S       |    2 +-
 arch/x86/xen/xen-ops.h          |    1 -
 8 files changed, 32 insertions(+), 17 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1307,7 +1307,10 @@ SYM_CODE_END(native_iret)
 #endif
 
 #ifdef CONFIG_XEN_PV
-SYM_FUNC_START(xen_hypervisor_callback)
+/*
+ * See comment in entry_64.S for further explanation
+ */
+SYM_FUNC_START(exc_xen_hypervisor_callback)
 	/*
 	 * Check to see if we got the event in the critical
 	 * region in xen_iret_direct, after we've reenabled
@@ -1331,7 +1334,7 @@ SYM_FUNC_START(xen_hypervisor_callback)
 	call	xen_maybe_preempt_hcall
 #endif
 	jmp	ret_from_intr
-SYM_FUNC_END(xen_hypervisor_callback)
+SYM_FUNC_END(exc_xen_hypervisor_callback)
 
 /*
  * Hypervisor uses this for application faults while it executes.
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1059,10 +1059,6 @@ idtentry	X86_TRAP_PF		page_fault		do_pag
 idtentry	X86_TRAP_PF		async_page_fault	do_async_page_fault		has_error_code=1
 #endif
 
-#ifdef CONFIG_XEN_PV
-idtentry	512 /* dummy */		hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
-#endif
-
 	/*
 	 * Reload gs selector with exception handling
 	 * edi:  new selector
@@ -1125,9 +1121,10 @@ SYM_FUNC_END(do_softirq_own_stack)
  * So, on entry to the handler we detect whether we interrupted an
  * existing activation in its critical region -- if so, we pop the current
  * activation and restart the handler using the previous one.
+ *
+ * C calling convention: exc_xen_hypervisor_callback(struct *pt_regs)
  */
-/* do_hypervisor_callback(struct *pt_regs) */
-SYM_CODE_START_LOCAL(xen_do_hypervisor_callback)
+SYM_CODE_START_LOCAL(exc_xen_hypervisor_callback)
 
 /*
  * Since we don't modify %rdi, evtchn_do_upall(struct *pt_regs) will
@@ -1145,7 +1142,7 @@ SYM_CODE_START_LOCAL(xen_do_hypervisor_c
 	call	xen_maybe_preempt_hcall
 #endif
 	jmp	error_exit
-SYM_CODE_END(xen_do_hypervisor_callback)
+SYM_CODE_END(exc_xen_hypervisor_callback)
 
 /*
  * Hypervisor uses this for application faults while it executes.
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -308,6 +308,13 @@ static __always_inline void __##func(str
 
 #endif /* __ASSEMBLY__ */
 
+/*
+ * Dummy trap number so the low level ASM macro vector number checks do not
+ * match which results in emitting plain IDTENTRY stubs without bells and
+ * whistels.
+ */
+#define X86_TRAP_OTHER		~0uL
+
 /* Simple exception entries: */
 DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
 DECLARE_IDTENTRY(X86_TRAP_BP,		exc_int3);
@@ -348,4 +355,10 @@ DECLARE_IDTENTRY_XEN(X86_TRAP_DB,	debug)
 DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);
 #endif
 
+#ifdef CONFIG_XEN_PV
+DECLARE_IDTENTRY(X6_TRAP_OTHER,		exc_xen_hypervisor_callback);
+#endif
+
+#undef X86_TRAP_OTHER
+
 #endif
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -20,6 +20,7 @@
 #include <asm/setup.h>
 #include <asm/acpi.h>
 #include <asm/numa.h>
+#include <asm/idtentry.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
@@ -993,7 +994,8 @@ void __init xen_pvmmu_arch_setup(void)
 	HYPERVISOR_vm_assist(VMASST_CMD_enable,
 			     VMASST_TYPE_pae_extended_cr3);
 
-	if (register_callback(CALLBACKTYPE_event, xen_hypervisor_callback) ||
+	if (register_callback(CALLBACKTYPE_event,
+			      asm_exc_xen_hypervisor_callback) ||
 	    register_callback(CALLBACKTYPE_failsafe, xen_failsafe_callback))
 		BUG();
 
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -27,6 +27,7 @@
 #include <asm/paravirt.h>
 #include <asm/desc.h>
 #include <asm/pgtable.h>
+#include <asm/idtentry.h>
 #include <asm/cpu.h>
 
 #include <xen/interface/xen.h>
@@ -346,7 +347,7 @@ cpu_initialize_context(unsigned int cpu,
 	ctxt->gs_base_kernel = per_cpu_offset(cpu);
 #endif
 	ctxt->event_callback_eip    =
-		(unsigned long)xen_hypervisor_callback;
+		(unsigned long)asm_exc_xen_hypervisor_callback;
 	ctxt->failsafe_callback_eip =
 		(unsigned long)xen_failsafe_callback;
 	per_cpu(xen_cr3, cpu) = __pa(swapper_pg_dir);
--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -93,7 +93,7 @@ SYM_CODE_START(xen_iret)
 
 	/*
 	 * If there's something pending, mask events again so we can
-	 * jump back into xen_hypervisor_callback. Otherwise do not
+	 * jump back into exc_xen_hypervisor_callback. Otherwise do not
 	 * touch XEN_vcpu_info_mask.
 	 */
 	jne 1f
@@ -113,7 +113,7 @@ SYM_CODE_START(xen_iret)
 	 * Events are masked, so jumping out of the critical region is
 	 * OK.
 	 */
-	je xen_hypervisor_callback
+	je asm_exc_xen_hypervisor_callback
 
 1:	iret
 xen_iret_end_crit:
@@ -127,7 +127,7 @@ SYM_CODE_END(xen_iret)
 	.globl xen_iret_start_crit, xen_iret_end_crit
 
 /*
- * This is called by xen_hypervisor_callback in entry_32.S when it sees
+ * This is called by exc_xen_hypervisor_callback in entry_32.S when it sees
  * that the EIP at the time of interrupt was between
  * xen_iret_start_crit and xen_iret_end_crit.
  *
@@ -144,7 +144,7 @@ SYM_CODE_END(xen_iret)
  *	 eflags		}
  *	 cs		}  nested exception info
  *	 eip		}
- *	 return address	: (into xen_hypervisor_callback)
+ *	 return address	: (into asm_exc_xen_hypervisor_callback)
  *
  * In order to deliver the nested exception properly, we need to discard the
  * nested exception frame such that when we handle the exception, we do it
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -54,7 +54,7 @@ xen_pv_trap asm_exc_simd_coprocessor_err
 #ifdef CONFIG_IA32_EMULATION
 xen_pv_trap entry_INT80_compat
 #endif
-xen_pv_trap hypervisor_callback
+xen_pv_trap asm_exc_xen_hypervisor_callback
 
 	__INIT
 SYM_CODE_START(xen_early_idt_handler_array)
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -8,7 +8,6 @@
 #include <xen/xen-ops.h>
 
 /* These are code, but not functions.  Defined in entry.S */
-extern const char xen_hypervisor_callback[];
 extern const char xen_failsafe_callback[];
 
 void xen_sysenter_target(void);

