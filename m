Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864F0C2D0FC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615DB24930
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgELWXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731652AbgELWXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:23:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8694C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:23:09 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYdIE-0004hY-4O; Wed, 13 May 2020 00:22:31 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 8D558100605;
        Wed, 13 May 2020 00:22:29 +0200 (CEST)
Message-Id: <20200512213810.320365524@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 12 May 2020 23:01:08 +0200
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
Subject: [patch V5 09/38] x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
References: <20200512210059.056244513@linutronix.de>
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

Convert the XEN/PV hypercall to IDTENTRY:

  - Emit the ASM stub with DECLARE_IDTENTRY
  - Remove the ASM idtentry in 64bit
  - Remove the open coded ASM entry code in 32bit
  - Remove the old prototypes

The handler stubs need to stay in ASM code as it needs corner case handling
and adjustment of the stack pointer.

Provide a new C function which invokes the entry/exit handling and calls
into the XEN handler on the interrupt stack.

The exit code is slightly different from the regular idtentry_exit() on
non-preemptible kernels. If the hypercall is preemptible and need_resched()
is set then XEN provides a preempt hypercall scheduling function. Add it as
conditional path to __idtentry_exit() so the function can be reused.

__idtentry_exit() is forced inlined so on the regular idtentry_exit() path
the extra condition is optimized out by the compiler.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
---
V5: Move DECLARE_PER_CPU(bool, xen_in_preemptible_hcall) out of ifdeffery
    to avoid #ifdeffery in idtentry_exit().
    Convert to the reworked stack switching helper
    Fixed up the XEN callback initialization (Boris O.)
---
 arch/x86/entry/common.c         |   57 ++++++++++++++++++++++++++++++++++++++--
 arch/x86/entry/entry_32.S       |   17 ++++++-----
 arch/x86/entry/entry_64.S       |   22 ++++-----------
 arch/x86/include/asm/idtentry.h |   13 +++++++++
 arch/x86/xen/setup.c            |    4 ++
 arch/x86/xen/smp_pv.c           |    3 +-
 arch/x86/xen/xen-asm_32.S       |   12 ++++----
 arch/x86/xen/xen-asm_64.S       |    2 -
 arch/x86/xen/xen-ops.h          |    1 
 drivers/xen/preempt.c           |    2 -
 include/xen/xen-ops.h           |    7 +++-
 11 files changed, 103 insertions(+), 37 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -27,6 +27,9 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 
+#include <xen/xen-ops.h>
+#include <xen/events.h>
+
 #include <asm/desc.h>
 #include <asm/traps.h>
 #include <asm/vdso.h>
@@ -35,6 +38,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
 #include <asm/syscall.h>
+#include <asm/irq_stack.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -539,7 +543,8 @@ void noinstr idtentry_enter(struct pt_re
 	}
 }
 
-static __always_inline void __idtentry_exit(struct pt_regs *regs)
+static __always_inline void __idtentry_exit(struct pt_regs *regs,
+					    bool preempt_hcall)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -573,6 +578,16 @@ static __always_inline void __idtentry_e
 				instrumentation_end();
 				return;
 			}
+		} else if (IS_ENABLED(CONFIG_XEN_PV)) {
+			if (preempt_hcall) {
+				/* See CONFIG_PREEMPTION above */
+				instrumentation_begin();
+				rcu_irq_exit_preempt();
+				xen_maybe_preempt_hcall();
+				trace_hardirqs_on();
+				instrumentation_end();
+				return;
+			}
 		}
 		/*
 		 * If preemption is disabled then this needs to be done
@@ -612,5 +627,43 @@ static __always_inline void __idtentry_e
  */
 void noinstr idtentry_exit(struct pt_regs *regs)
 {
-	__idtentry_exit(regs);
+	__idtentry_exit(regs, false);
+}
+
+#ifdef CONFIG_XEN_PV
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
+
+	idtentry_enter(regs);
+	old_regs = set_irq_regs(regs);
+
+	if (!irq_needs_irq_stack(regs)) {
+		instrumentation_begin();
+		__xen_pv_evtchn_do_upcall();
+		instrumentation_end();
+	} else {
+		run_on_irqstack(__xen_pv_evtchn_do_upcall, NULL);
+	}
+
+	set_irq_regs(old_regs);
+
+	if (IS_ENABLED(CONFIG_PREEMPTION)) {
+		__idtentry_exit(regs, false);
+	} else {
+		bool inhcall = __this_cpu_read(xen_in_preemptible_hcall);
+
+		__idtentry_exit(regs, inhcall && need_resched());
+	}
 }
+#endif /* CONFIG_XEN_PV */
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
@@ -1464,6 +1464,7 @@ SYM_CODE_START_LOCAL_NOALIGN(handle_exce
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC edi
 
+handle_exception_return:
 #ifdef CONFIG_VM86
 	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb	PT_CS(%esp), %al
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1067,10 +1067,6 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 
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
@@ -1170,15 +1167,10 @@ SYM_CODE_START_LOCAL(xen_do_hypervisor_c
 	movq	%rdi, %rsp			/* we don't return, adjust the stack frame */
 	UNWIND_HINT_REGS
 
-	ENTER_IRQ_STACK old_rsp=%r10
-	call	xen_evtchn_do_upcall
-	LEAVE_IRQ_STACK
-
-#ifndef CONFIG_PREEMPTION
-	call	xen_maybe_preempt_hcall
-#endif
-	jmp	error_exit
-SYM_CODE_END(xen_do_hypervisor_callback)
+	call	xen_pv_evtchn_do_upcall
+
+	jmp	error_return
+SYM_CODE_END(exc_xen_hypervisor_callback)
 
 /*
  * Hypervisor uses this for application faults while it executes.
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -332,6 +332,13 @@ static __always_inline void __##func(str
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
@@ -373,4 +380,10 @@ DECLARE_IDTENTRY_XEN(X86_TRAP_DB,	debug)
 DECLARE_IDTENTRY_DF(X86_TRAP_DF,	exc_double_fault);
 #endif
 
+#ifdef CONFIG_XEN_PV
+DECLARE_IDTENTRY(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
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
 
@@ -993,7 +994,8 @@ static void __init xen_pvmmu_arch_setup(
 	HYPERVISOR_vm_assist(VMASST_CMD_enable,
 			     VMASST_TYPE_pae_extended_cr3);
 
-	if (register_callback(CALLBACKTYPE_event, xen_hypervisor_callback) ||
+	if (register_callback(CALLBACKTYPE_event,
+			      xen_asm_exc_xen_hypervisor_callback) ||
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
@@ -347,7 +348,7 @@ cpu_initialize_context(unsigned int cpu,
 	ctxt->gs_base_kernel = per_cpu_offset(cpu);
 #endif
 	ctxt->event_callback_eip    =
-		(unsigned long)xen_hypervisor_callback;
+		(unsigned long)xen_asm_exc_xen_hypervisor_callback;
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
--- a/drivers/xen/preempt.c
+++ b/drivers/xen/preempt.c
@@ -24,7 +24,7 @@
 DEFINE_PER_CPU(bool, xen_in_preemptible_hcall);
 EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
 
-asmlinkage __visible void xen_maybe_preempt_hcall(void)
+void xen_maybe_preempt_hcall(void)
 {
 	if (unlikely(__this_cpu_read(xen_in_preemptible_hcall)
 		     && need_resched())) {
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -214,6 +214,7 @@ bool xen_running_on_version_or_later(uns
 
 void xen_efi_runtime_setup(void);
 
+DECLARE_PER_CPU(bool, xen_in_preemptible_hcall);
 
 #ifdef CONFIG_PREEMPTION
 
@@ -225,9 +226,9 @@ static inline void xen_preemptible_hcall
 {
 }
 
-#else
+static inline void xen_maybe_preempt_hcall(void) { }
 
-DECLARE_PER_CPU(bool, xen_in_preemptible_hcall);
+#else
 
 static inline void xen_preemptible_hcall_begin(void)
 {
@@ -239,6 +240,8 @@ static inline void xen_preemptible_hcall
 	__this_cpu_write(xen_in_preemptible_hcall, false);
 }
 
+void xen_maybe_preempt_hcall(void);
+
 #endif /* CONFIG_PREEMPTION */
 
 #endif /* INCLUDE_XEN_OPS_H */

