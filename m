Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC07C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4D821531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbgE0INU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgE0IMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56444C061A0F;
        Wed, 27 May 2020 01:12:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAN-0002ca-ND; Wed, 27 May 2020 10:11:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 267B01C0481;
        Wed, 27 May 2020 10:11:56 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:56 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juergen Gross <jgross@suse.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202118.055270078@linutronix.de>
References: <20200521202118.055270078@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711600.17951.3483567529603709857.tip-bot2@tip-bot2>
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

Commit-ID:     66a07b44e7658da3145bb3a8f45256d103e3addc
Gitweb:        https://git.kernel.org/tip/66a07b44e7658da3145bb3a8f45256d103e3addc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:26 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:28 +02:00

x86/entry: Switch XEN/PV hypercall entry to IDTENTRY

Convert the XEN/PV hypercall to IDTENTRY:

  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64-bit
  - Remove the open coded ASM entry code in 32-bit
  - Remove the old prototypes

The handler stubs need to stay in ASM code as they need corner case handling
and adjustment of the stack pointer.

Provide a new C function which invokes the entry/exit handling and calls
into the XEN handler on the interrupt stack if required.

The exit code is slightly different from the regular idtentry_exit() on
non-preemptible kernels. If the hypercall is preemptible and need_resched()
is set then XEN provides a preempt hypercall scheduling function.

Move this functionality into the entry code so it can use the existing
idtentry functionality.

[ mingo: Build fixes. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Juergen Gross <jgross@suse.com>
Tested-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20200521202118.055270078@linutronix.de
---
 arch/x86/entry/common.c         | 74 ++++++++++++++++++++++++++++++++-
 arch/x86/entry/entry_32.S       | 17 +++----
 arch/x86/entry/entry_64.S       | 20 ++-------
 arch/x86/include/asm/idtentry.h | 13 ++++++-
 arch/x86/xen/setup.c            |  4 +-
 arch/x86/xen/smp_pv.c           |  3 +-
 arch/x86/xen/xen-asm_32.S       | 12 ++---
 arch/x86/xen/xen-asm_64.S       |  2 +-
 arch/x86/xen/xen-ops.h          |  1 +-
 drivers/xen/Makefile            |  2 +-
 drivers/xen/preempt.c           | 42 +------------------
 include/xen/xen-ops.h           | 19 ++------
 12 files changed, 123 insertions(+), 86 deletions(-)
 delete mode 100644 drivers/xen/preempt.c

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 066215a..bb66f4d 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -27,6 +27,11 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 
+#ifdef CONFIG_XEN_PV
+#include <xen/xen-ops.h>
+#include <xen/events.h>
+#endif
+
 #include <asm/desc.h>
 #include <asm/traps.h>
 #include <asm/vdso.h>
@@ -35,6 +40,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
 #include <asm/syscall.h>
+#include <asm/irq_stack.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -680,3 +686,71 @@ void noinstr idtentry_exit_user(struct pt_regs *regs)
 
 	prepare_exit_to_usermode(regs);
 }
+
+#ifdef CONFIG_XEN_PV
+#ifndef CONFIG_PREEMPTION
+/*
+ * Some hypercalls issued by the toolstack can take many 10s of
+ * seconds. Allow tasks running hypercalls via the privcmd driver to
+ * be voluntarily preempted even if full kernel preemption is
+ * disabled.
+ *
+ * Such preemptible hypercalls are bracketed by
+ * xen_preemptible_hcall_begin() and xen_preemptible_hcall_end()
+ * calls.
+ */
+DEFINE_PER_CPU(bool, xen_in_preemptible_hcall);
+EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
+
+/*
+ * In case of scheduling the flag must be cleared and restored after
+ * returning from schedule as the task might move to a different CPU.
+ */
+static __always_inline bool get_and_clear_inhcall(void)
+{
+	bool inhcall = __this_cpu_read(xen_in_preemptible_hcall);
+
+	__this_cpu_write(xen_in_preemptible_hcall, false);
+	return inhcall;
+}
+
+static __always_inline void restore_inhcall(bool inhcall)
+{
+	__this_cpu_write(xen_in_preemptible_hcall, inhcall);
+}
+#else
+static __always_inline bool get_and_clear_inhcall(void) { return false; }
+static __always_inline void restore_inhcall(bool inhcall) { }
+#endif
+
+static void __xen_pv_evtchn_do_upcall(void)
+{
+	irq_enter_rcu();
+	inc_irq_stat(irq_hv_callback_count);
+
+	xen_hvm_evtchn_do_upcall();
+
+	irq_exit_rcu();
+}
+
+__visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs;
+	bool inhcall, rcu_exit;
+
+	rcu_exit = idtentry_enter_cond_rcu(regs);
+	old_regs = set_irq_regs(regs);
+
+	run_on_irqstack_cond(__xen_pv_evtchn_do_upcall, NULL, regs);
+
+	set_irq_regs(old_regs);
+
+	inhcall = get_and_clear_inhcall();
+	if (inhcall && !WARN_ON_ONCE(rcu_exit)) {
+		idtentry_exit_cond_resched(regs, true);
+		restore_inhcall(inhcall);
+	} else {
+		idtentry_exit_cond_rcu(regs, rcu_exit);
+	}
+}
+#endif /* CONFIG_XEN_PV */
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 28d13f0..84ee014 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1298,7 +1298,10 @@ SYM_CODE_END(native_iret)
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
@@ -1315,14 +1318,11 @@ SYM_FUNC_START(xen_hypervisor_callback)
 	pushl	$-1				/* orig_ax = -1 => not a system call */
 	SAVE_ALL
 	ENCODE_FRAME_POINTER
-	TRACE_IRQS_OFF
+
 	mov	%esp, %eax
-	call	xen_evtchn_do_upcall
-#ifndef CONFIG_PREEMPTION
-	call	xen_maybe_preempt_hcall
-#endif
-	jmp	ret_from_intr
-SYM_FUNC_END(xen_hypervisor_callback)
+	call	xen_pv_evtchn_do_upcall
+	jmp	handle_exception_return
+SYM_FUNC_END(exc_xen_hypervisor_callback)
 
 /*
  * Hypervisor uses this for application faults while it executes.
@@ -1464,6 +1464,7 @@ SYM_CODE_START_LOCAL_NOALIGN(handle_exception)
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC edi
 
+handle_exception_return:
 #ifdef CONFIG_VM86
 	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb	PT_CS(%esp), %al
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 6b518be..dadb37d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1067,10 +1067,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 
 idtentry	X86_TRAP_PF		page_fault		do_page_fault			has_error_code=1
 
-#ifdef CONFIG_XEN_PV
-idtentry	512 /* dummy */		hypervisor_callback	xen_do_hypervisor_callback	has_error_code=0
-#endif
-
 /*
  * Reload gs selector with exception handling
  * edi:  new selector
@@ -1158,9 +1154,10 @@ SYM_FUNC_END(asm_call_on_stack)
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
@@ -1170,15 +1167,10 @@ SYM_CODE_START_LOCAL(xen_do_hypervisor_callback)
 	movq	%rdi, %rsp			/* we don't return, adjust the stack frame */
 	UNWIND_HINT_REGS
 
-	ENTER_IRQ_STACK old_rsp=%r10
-	call	xen_evtchn_do_upcall
-	LEAVE_IRQ_STACK
+	call	xen_pv_evtchn_do_upcall
 
-#ifndef CONFIG_PREEMPTION
-	call	xen_maybe_preempt_hcall
-#endif
-	jmp	error_exit
-SYM_CODE_END(xen_do_hypervisor_callback)
+	jmp	error_return
+SYM_CODE_END(exc_xen_hypervisor_callback)
 
 /*
  * Hypervisor uses this for application faults while it executes.
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b056889..49a797d 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -337,6 +337,13 @@ __visible noinstr void func(struct pt_regs *regs,			\
  * This avoids duplicate defines and ensures that everything is consistent.
  */
 
+/*
+ * Dummy trap number so the low level ASM macro vector number checks do not
+ * match which results in emitting plain IDTENTRY stubs without bells and
+ * whistels.
+ */
+#define X86_TRAP_OTHER		0xFFFF
+
 /* Simple exception entry points. No hardware error code */
 DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
 DECLARE_IDTENTRY(X86_TRAP_OF,		exc_overflow);
@@ -376,4 +383,10 @@ DECLARE_IDTENTRY_XEN(X86_TRAP_DB,	debug);
 /* #DF */
 DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);
 
+#ifdef CONFIG_XEN_PV
+DECLARE_IDTENTRY(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
+#endif
+
+#undef X86_TRAP_OTHER
+
 #endif
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 1a2d8a5..3566e37 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -20,6 +20,7 @@
 #include <asm/setup.h>
 #include <asm/acpi.h>
 #include <asm/numa.h>
+#include <asm/idtentry.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
@@ -993,7 +994,8 @@ static void __init xen_pvmmu_arch_setup(void)
 	HYPERVISOR_vm_assist(VMASST_CMD_enable,
 			     VMASST_TYPE_pae_extended_cr3);
 
-	if (register_callback(CALLBACKTYPE_event, xen_hypervisor_callback) ||
+	if (register_callback(CALLBACKTYPE_event,
+			      xen_asm_exc_xen_hypervisor_callback) ||
 	    register_callback(CALLBACKTYPE_failsafe, xen_failsafe_callback))
 		BUG();
 
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 8fb8a50..a92259d 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -27,6 +27,7 @@
 #include <asm/paravirt.h>
 #include <asm/desc.h>
 #include <asm/pgtable.h>
+#include <asm/idtentry.h>
 #include <asm/cpu.h>
 
 #include <xen/interface/xen.h>
@@ -347,7 +348,7 @@ cpu_initialize_context(unsigned int cpu, struct task_struct *idle)
 	ctxt->gs_base_kernel = per_cpu_offset(cpu);
 #endif
 	ctxt->event_callback_eip    =
-		(unsigned long)xen_hypervisor_callback;
+		(unsigned long)xen_asm_exc_xen_hypervisor_callback;
 	ctxt->failsafe_callback_eip =
 		(unsigned long)xen_failsafe_callback;
 	per_cpu(xen_cr3, cpu) = __pa(swapper_pg_dir);
diff --git a/arch/x86/xen/xen-asm_32.S b/arch/x86/xen/xen-asm_32.S
index 812ff01..d0ff2dc 100644
--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -93,7 +93,7 @@ xen_iret_start_crit:
 
 	/*
 	 * If there's something pending, mask events again so we can
-	 * jump back into xen_hypervisor_callback. Otherwise do not
+	 * jump back into exc_xen_hypervisor_callback. Otherwise do not
 	 * touch XEN_vcpu_info_mask.
 	 */
 	jne 1f
@@ -113,7 +113,7 @@ iret_restore_end:
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
@@ -152,7 +152,8 @@ SYM_CODE_END(xen_iret)
  *
  * The only caveat is that if the outer eax hasn't been restored yet (i.e.
  * it's still on stack), we need to restore its value here.
- */
+*/
+.pushsection .noinstr.text, "ax"
 SYM_CODE_START(xen_iret_crit_fixup)
 	/*
 	 * Paranoia: Make sure we're really coming from kernel space.
@@ -181,3 +182,4 @@ SYM_CODE_START(xen_iret_crit_fixup)
 2:
 	ret
 SYM_CODE_END(xen_iret_crit_fixup)
+.popsection
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index e46d863..19fbbdb 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -54,7 +54,7 @@ xen_pv_trap asm_exc_simd_coprocessor_error
 #ifdef CONFIG_IA32_EMULATION
 xen_pv_trap entry_INT80_compat
 #endif
-xen_pv_trap hypervisor_callback
+xen_pv_trap asm_exc_xen_hypervisor_callback
 
 	__INIT
 SYM_CODE_START(xen_early_idt_handler_array)
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 1cc1568..ad05d05 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -8,7 +8,6 @@
 #include <xen/xen-ops.h>
 
 /* These are code, but not functions.  Defined in entry.S */
-extern const char xen_hypervisor_callback[];
 extern const char xen_failsafe_callback[];
 
 void xen_sysenter_target(void);
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 0c4efa6..0d322f3 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
-obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
+obj-y	+= grant-table.o features.o balloon.o manage.o time.o
 obj-y	+= mem-reservation.o
 obj-y	+= events/
 obj-y	+= xenbus/
diff --git a/drivers/xen/preempt.c b/drivers/xen/preempt.c
deleted file mode 100644
index 17240c5..0000000
--- a/drivers/xen/preempt.c
+++ /dev/null
@@ -1,42 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Preemptible hypercalls
- *
- * Copyright (C) 2014 Citrix Systems R&D ltd.
- */
-
-#include <linux/sched.h>
-#include <xen/xen-ops.h>
-
-#ifndef CONFIG_PREEMPTION
-
-/*
- * Some hypercalls issued by the toolstack can take many 10s of
- * seconds. Allow tasks running hypercalls via the privcmd driver to
- * be voluntarily preempted even if full kernel preemption is
- * disabled.
- *
- * Such preemptible hypercalls are bracketed by
- * xen_preemptible_hcall_begin() and xen_preemptible_hcall_end()
- * calls.
- */
-
-DEFINE_PER_CPU(bool, xen_in_preemptible_hcall);
-EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
-
-asmlinkage __visible void xen_maybe_preempt_hcall(void)
-{
-	if (unlikely(__this_cpu_read(xen_in_preemptible_hcall)
-		     && need_resched())) {
-		/*
-		 * Clear flag as we may be rescheduled on a different
-		 * cpu.
-		 */
-		__this_cpu_write(xen_in_preemptible_hcall, false);
-		local_irq_enable();
-		cond_resched();
-		local_irq_disable();
-		__this_cpu_write(xen_in_preemptible_hcall, true);
-	}
-}
-#endif /* CONFIG_PREEMPTION */
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 095be1d..39a5580 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -215,17 +215,7 @@ bool xen_running_on_version_or_later(unsigned int major, unsigned int minor);
 void xen_efi_runtime_setup(void);
 
 
-#ifdef CONFIG_PREEMPTION
-
-static inline void xen_preemptible_hcall_begin(void)
-{
-}
-
-static inline void xen_preemptible_hcall_end(void)
-{
-}
-
-#else
+#if defined(CONFIG_XEN_PV) && !defined(CONFIG_PREEMPTION)
 
 DECLARE_PER_CPU(bool, xen_in_preemptible_hcall);
 
@@ -239,6 +229,11 @@ static inline void xen_preemptible_hcall_end(void)
 	__this_cpu_write(xen_in_preemptible_hcall, false);
 }
 
-#endif /* CONFIG_PREEMPTION */
+#else
+
+static inline void xen_preemptible_hcall_begin(void) { }
+static inline void xen_preemptible_hcall_end(void) { }
+
+#endif /* CONFIG_XEN_PV && !CONFIG_PREEMPTION */
 
 #endif /* INCLUDE_XEN_OPS_H */
