Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AACC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A7120739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgCTSio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:38:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36907 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbgCTSia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:38:30 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFMXL-00025T-NP
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 19:38:27 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 46A081040D0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 19:38:20 +0100 (CET)
Message-Id: <20200320180034.672927065@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 19:00:19 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Paul McKenney <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [patch V3 23/23] x86/kvm/svm: Move guest enter/exit into .noinstr.text
References: <20200320175956.033706968@linutronix.de>
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

Split out the really last steps of guest enter and the early guest exit
code and mark it .noinstr.text. Add the required instr_begin()/end() pairs
around "safe" code and replace the wrmsr() with native_wrmsr() to prevent a
tracepoint injection.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
---
 arch/x86/kvm/svm.c |  114 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 62 insertions(+), 52 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5714,58 +5714,9 @@ static void svm_cancel_injection(struct
 	svm_complete_interrupts(svm);
 }
 
-static void svm_vcpu_run(struct kvm_vcpu *vcpu)
+static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu,
+					struct vcpu_svm *svm)
 {
-	struct vcpu_svm *svm = to_svm(vcpu);
-
-	svm->vmcb->save.rax = vcpu->arch.regs[VCPU_REGS_RAX];
-	svm->vmcb->save.rsp = vcpu->arch.regs[VCPU_REGS_RSP];
-	svm->vmcb->save.rip = vcpu->arch.regs[VCPU_REGS_RIP];
-
-	/*
-	 * A vmexit emulation is required before the vcpu can be executed
-	 * again.
-	 */
-	if (unlikely(svm->nested.exit_required))
-		return;
-
-	/*
-	 * Disable singlestep if we're injecting an interrupt/exception.
-	 * We don't want our modified rflags to be pushed on the stack where
-	 * we might not be able to easily reset them if we disabled NMI
-	 * singlestep later.
-	 */
-	if (svm->nmi_singlestep && svm->vmcb->control.event_inj) {
-		/*
-		 * Event injection happens before external interrupts cause a
-		 * vmexit and interrupts are disabled here, so smp_send_reschedule
-		 * is enough to force an immediate vmexit.
-		 */
-		disable_nmi_singlestep(svm);
-		smp_send_reschedule(vcpu->cpu);
-	}
-
-	pre_svm_run(svm);
-
-	sync_lapic_to_cr8(vcpu);
-
-	svm->vmcb->save.cr2 = vcpu->arch.cr2;
-
-	clgi();
-	kvm_load_guest_xsave_state(vcpu);
-
-	if (lapic_in_kernel(vcpu) &&
-		vcpu->arch.apic->lapic_timer.timer_advance_ns)
-		kvm_wait_lapic_expire(vcpu);
-
-	/*
-	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
-	 * it's non-zero. Since vmentry is serialising on affected CPUs, there
-	 * is no need to worry about the conditional branch over the wrmsr
-	 * being speculatively taken.
-	 */
-	x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
-
 	/*
 	 * VMENTER enables interrupts (host state), but the kernel state is
 	 * interrupts disabled when this is invoked. Also tell RCU about
@@ -5780,8 +5731,10 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * take locks (lockdep needs RCU) and calls into world and some
 	 * more.
 	 */
+	instr_begin();
 	__trace_hardirqs_on();
 	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	instr_end();
 	guest_enter_irqoff();
 	lockdep_hardirqs_on(CALLER_ADDR0);
 
@@ -5881,7 +5834,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	vmexit_fill_RSB();
 
 #ifdef CONFIG_X86_64
-	wrmsrl(MSR_GS_BASE, svm->host.gs_base);
+	native_wrmsrl(MSR_GS_BASE, svm->host.gs_base);
 #else
 	loadsegment(fs, svm->host.fs);
 #ifndef CONFIG_X86_32_LAZY_GS
@@ -5904,7 +5857,64 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 */
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	guest_exit_irqoff();
+	instr_begin();
 	__trace_hardirqs_off();
+	instr_end();
+}
+
+static void svm_vcpu_run(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	svm->vmcb->save.rax = vcpu->arch.regs[VCPU_REGS_RAX];
+	svm->vmcb->save.rsp = vcpu->arch.regs[VCPU_REGS_RSP];
+	svm->vmcb->save.rip = vcpu->arch.regs[VCPU_REGS_RIP];
+
+	/*
+	 * A vmexit emulation is required before the vcpu can be executed
+	 * again.
+	 */
+	if (unlikely(svm->nested.exit_required))
+		return;
+
+	/*
+	 * Disable singlestep if we're injecting an interrupt/exception.
+	 * We don't want our modified rflags to be pushed on the stack where
+	 * we might not be able to easily reset them if we disabled NMI
+	 * singlestep later.
+	 */
+	if (svm->nmi_singlestep && svm->vmcb->control.event_inj) {
+		/*
+		 * Event injection happens before external interrupts cause a
+		 * vmexit and interrupts are disabled here, so smp_send_reschedule
+		 * is enough to force an immediate vmexit.
+		 */
+		disable_nmi_singlestep(svm);
+		smp_send_reschedule(vcpu->cpu);
+	}
+
+	pre_svm_run(svm);
+
+	sync_lapic_to_cr8(vcpu);
+
+	svm->vmcb->save.cr2 = vcpu->arch.cr2;
+
+	clgi();
+	kvm_load_guest_xsave_state(vcpu);
+
+	if (lapic_in_kernel(vcpu) &&
+		vcpu->arch.apic->lapic_timer.timer_advance_ns)
+		kvm_wait_lapic_expire(vcpu);
+
+	/*
+	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
+	 * it's non-zero. Since vmentry is serialising on affected CPUs, there
+	 * is no need to worry about the conditional branch over the wrmsr
+	 * being speculatively taken.
+	 */
+	x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
+
+	svm_vcpu_enter_exit(vcpu, svm);
 
 	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the

