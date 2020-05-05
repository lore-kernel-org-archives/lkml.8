Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4F9C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C56C207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgEEOO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729683AbgEEOOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DF4C0610D5
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:52 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLC-0001A1-Ie; Tue, 05 May 2020 16:14:34 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 0F6671001F5;
        Tue,  5 May 2020 16:14:34 +0200 (CEST)
Message-Id: <20200505134341.781667216@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:41:29 +0200
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
Subject: [patch V4 part 2 17/18] x86/kvm/vmx: Move guest enter/exit into .noinstr.text
References: <20200505134112.272268764@linutronix.de>
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

Move the functions which are inside the RCU off region into the
non-instrumentable text section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/hardirq.h  |    4 -
 arch/x86/include/asm/kvm_host.h |    8 +++
 arch/x86/kvm/vmx/ops.h          |    4 +
 arch/x86/kvm/vmx/vmenter.S      |    5 +
 arch/x86/kvm/vmx/vmx.c          |  105 ++++++++++++++++++++++------------------
 arch/x86/kvm/x86.c              |    2 
 6 files changed, 79 insertions(+), 49 deletions(-)

--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -67,12 +67,12 @@ static inline void kvm_set_cpu_l1tf_flus
 	__this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
 }
 
-static inline void kvm_clear_cpu_l1tf_flush_l1d(void)
+static __always_inline void kvm_clear_cpu_l1tf_flush_l1d(void)
 {
 	__this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 0);
 }
 
-static inline bool kvm_get_cpu_l1tf_flush_l1d(void)
+static __always_inline bool kvm_get_cpu_l1tf_flush_l1d(void)
 {
 	return __this_cpu_read(irq_stat.kvm_cpu_l1tf_flush_l1d);
 }
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1601,7 +1601,15 @@ asmlinkage void kvm_spurious_fault(void)
 	insn "\n\t"							\
 	"jmp	668f \n\t"						\
 	"667: \n\t"							\
+	"1: \n\t"							\
+	".pushsection .discard.instr_begin \n\t"			\
+	".long 1b - . \n\t"						\
+	".popsection \n\t"						\
 	"call	kvm_spurious_fault \n\t"				\
+	"1: \n\t"							\
+	".pushsection .discard.instr_end \n\t"				\
+	".long 1b - . \n\t"						\
+	".popsection \n\t"						\
 	"668: \n\t"							\
 	_ASM_EXTABLE(666b, 667b)
 
--- a/arch/x86/kvm/vmx/ops.h
+++ b/arch/x86/kvm/vmx/ops.h
@@ -146,7 +146,9 @@ do {									\
 			  : : op1 : "cc" : error, fault);		\
 	return;								\
 error:									\
+	instr_begin();							\
 	insn##_error(error_args);					\
+	instr_end();							\
 	return;								\
 fault:									\
 	kvm_spurious_fault();						\
@@ -161,7 +163,9 @@ do {									\
 			  : : op1, op2 : "cc" : error, fault);		\
 	return;								\
 error:									\
+	instr_begin();							\
 	insn##_error(error_args);					\
+	instr_end();							\
 	return;								\
 fault:									\
 	kvm_spurious_fault();						\
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -27,7 +27,7 @@
 #define VCPU_R15	__VCPU_REGS_R15 * WORD_SIZE
 #endif
 
-	.text
+.section .noinstr.text, "ax"
 
 /**
  * vmx_vmenter - VM-Enter the current loaded VMCS
@@ -231,6 +231,9 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	jmp 1b
 SYM_FUNC_END(__vmx_vcpu_run)
 
+
+.section .text, "ax"
+
 /**
  * vmread_error_trampoline - Trampoline from inline asm to vmread_error()
  * @field:	VMCS field encoding that failed
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6000,7 +6000,7 @@ static int vmx_handle_exit(struct kvm_vc
  * information but as all relevant affected CPUs have 32KiB L1D cache size
  * there is no point in doing so.
  */
-static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
+static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 {
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
 
@@ -6033,7 +6033,7 @@ static void vmx_l1d_flush(struct kvm_vcp
 	vcpu->stat.l1d_flush++;
 
 	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
-		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		native_wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
 		return;
 	}
 
@@ -6514,7 +6514,7 @@ static void vmx_update_hv_timer(struct k
 	}
 }
 
-void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)
+void noinstr vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)
 {
 	if (unlikely(host_rsp != vmx->loaded_vmcs->host_state.rsp)) {
 		vmx->loaded_vmcs->host_state.rsp = host_rsp;
@@ -6524,6 +6524,61 @@ void vmx_update_host_rsp(struct vcpu_vmx
 
 bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned long *regs, bool launched);
 
+static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
+					struct vcpu_vmx *vmx)
+{
+	instr_begin();
+	/*
+	 * VMENTER enables interrupts (host state), but the kernel state is
+	 * interrupts disabled when this is invoked. Also tell RCU about
+	 * it. This is the same logic as for exit_to_user_mode().
+	 *
+	 * 1) Trace interrupts on state
+	 * 2) Prepare lockdep with RCU on
+	 * 3) Invoke context tracking if enabled to adjust RCU state
+	 * 4) Tell lockdep that interrupts are enabled
+	 */
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	instr_end();
+
+	guest_enter_irqoff();
+	lockdep_hardirqs_on(CALLER_ADDR0);
+
+	/* L1D Flush includes CPU buffer clear to mitigate MDS */
+	if (static_branch_unlikely(&vmx_l1d_should_flush))
+		vmx_l1d_flush(vcpu);
+	else if (static_branch_unlikely(&mds_user_clear))
+		mds_clear_cpu_buffers();
+
+	if (vcpu->arch.cr2 != read_cr2())
+		write_cr2(vcpu->arch.cr2);
+
+	vmx->fail = __vmx_vcpu_run(vmx, (unsigned long *)&vcpu->arch.regs,
+				   vmx->loaded_vmcs->launched);
+
+	vcpu->arch.cr2 = read_cr2();
+
+	/*
+	 * VMEXIT disables interrupts (host state), but tracing and lockdep
+	 * have them in state 'on'. Same as enter_from_user_mode().
+	 *
+	 * 1) Tell lockdep that interrupts are disabled
+	 * 2) Invoke context tracking if enabled to reactivate RCU
+	 * 3) Trace interrupts off state
+	 *
+	 * This needs to be done before the below as native_read_msr()
+	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
+	 * into world and some more.
+	 */
+	lockdep_hardirqs_off(CALLER_ADDR0);
+	guest_exit_irqoff();
+
+	instr_begin();
+	trace_hardirqs_off_prepare();
+	instr_end();
+}
+
 static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -6604,49 +6659,9 @@ static void vmx_vcpu_run(struct kvm_vcpu
 	x86_spec_ctrl_set_guest(vmx->spec_ctrl, 0);
 
 	/*
-	 * VMENTER enables interrupts (host state), but the kernel state is
-	 * interrupts disabled when this is invoked. Also tell RCU about
-	 * it. This is the same logic as for exit_to_user_mode().
-	 *
-	 * 1) Trace interrupts on state
-	 * 2) Prepare lockdep with RCU on
-	 * 3) Invoke context tracking if enabled to adjust RCU state
-	 * 4) Tell lockdep that interrupts are enabled
+	 * The actual VMENTER/EXIT is in the .noinstr.text section.
 	 */
-	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
-	guest_enter_irqoff();
-	lockdep_hardirqs_on(CALLER_ADDR0);
-
-	/* L1D Flush includes CPU buffer clear to mitigate MDS */
-	if (static_branch_unlikely(&vmx_l1d_should_flush))
-		vmx_l1d_flush(vcpu);
-	else if (static_branch_unlikely(&mds_user_clear))
-		mds_clear_cpu_buffers();
-
-	if (vcpu->arch.cr2 != read_cr2())
-		write_cr2(vcpu->arch.cr2);
-
-	vmx->fail = __vmx_vcpu_run(vmx, (unsigned long *)&vcpu->arch.regs,
-				   vmx->loaded_vmcs->launched);
-
-	vcpu->arch.cr2 = read_cr2();
-
-	/*
-	 * VMEXIT disables interrupts (host state), but tracing and lockdep
-	 * have them in state 'on'. Same as enter_from_user_mode().
-	 *
-	 * 1) Tell lockdep that interrupts are disabled
-	 * 2) Invoke context tracking if enabled to reactivate RCU
-	 * 3) Trace interrupts off state
-	 *
-	 * This needs to be done before the below as native_read_msr()
-	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
-	 * into world and some more.
-	 */
-	lockdep_hardirqs_off(CALLER_ADDR0);
-	guest_exit_irqoff();
-	trace_hardirqs_off_prepare();
+	vmx_vcpu_enter_exit(vcpu, vmx);
 
 	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -381,7 +381,7 @@ int kvm_set_apic_base(struct kvm_vcpu *v
 }
 EXPORT_SYMBOL_GPL(kvm_set_apic_base);
 
-asmlinkage __visible void kvm_spurious_fault(void)
+asmlinkage __visible noinstr void kvm_spurious_fault(void)
 {
 	/* Fault while not rebooting.  We want the trace. */
 	BUG_ON(!kvm_rebooting);

