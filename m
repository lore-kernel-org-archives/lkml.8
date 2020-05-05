Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B89C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BA6206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgEEOWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729659AbgEEOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:46 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F45C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:46 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyL7-00016K-Gc; Tue, 05 May 2020 16:14:29 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 0E3DAFFC8D;
        Tue,  5 May 2020 16:14:29 +0200 (CEST)
Message-Id: <20200505134341.379326289@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:41:25 +0200
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
Subject: [patch V4 part 2 13/18] x86/kvm: Move context tracking where it belongs
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

Context tracking for KVM happens way too early in the vcpu_run()
code. Anything after guest_enter_irqoff() and before guest_exit_irqoff()
cannot use RCU and should also be not instrumented.

The current way of doing this covers way too much code. Move it closer to
the actual vmenter/exit code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/svm/svm.c |   16 ++++++++++++++++
 arch/x86/kvm/vmx/vmx.c |   10 ++++++++++
 arch/x86/kvm/x86.c     |    2 --
 3 files changed, 26 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3330,6 +3330,14 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 */
 	x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
 
+	/*
+	 * Tell context tracking that this CPU is about to enter guest
+	 * mode. This has to be after x86_spec_ctrl_set_guest() because
+	 * that can take locks (lockdep needs RCU) and calls into world and
+	 * some more.
+	 */
+	guest_enter_irqoff();
+
 	__svm_vcpu_run(svm->vmcb_pa, (unsigned long *)&svm->vcpu.arch.regs);
 
 #ifdef CONFIG_X86_64
@@ -3340,6 +3348,14 @@ static void svm_vcpu_run(struct kvm_vcpu
 	loadsegment(gs, svm->host.gs);
 #endif
 #endif
+	/*
+	 * Tell context tracking that this CPU is back.
+	 *
+	 * This needs to be done before the below as native_read_msr()
+	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
+	 * into world and some more.
+	 */
+	guest_exit_irqoff();
 
 	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6603,6 +6603,11 @@ static void vmx_vcpu_run(struct kvm_vcpu
 	 */
 	x86_spec_ctrl_set_guest(vmx->spec_ctrl, 0);
 
+	/*
+	 * Tell context tracking that this CPU is about to enter guest mode.
+	 */
+	guest_enter_irqoff();
+
 	/* L1D Flush includes CPU buffer clear to mitigate MDS */
 	if (static_branch_unlikely(&vmx_l1d_should_flush))
 		vmx_l1d_flush(vcpu);
@@ -6618,6 +6623,11 @@ static void vmx_vcpu_run(struct kvm_vcpu
 	vcpu->arch.cr2 = read_cr2();
 
 	/*
+	 * Tell context tracking that this CPU is back.
+	 */
+	guest_exit_irqoff();
+
+	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the
 	 * SPEC_CTRL MSR it may have left it on; save the value and
 	 * turn it off. This is much more efficient than blindly adding
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8404,7 +8404,6 @@ static int vcpu_enter_guest(struct kvm_v
 	}
 
 	trace_kvm_entry(vcpu->vcpu_id);
-	guest_enter_irqoff();
 
 	fpregs_assert_state_consistent();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
@@ -8467,7 +8466,6 @@ static int vcpu_enter_guest(struct kvm_v
 	local_irq_disable();
 	kvm_after_interrupt(vcpu);
 
-	guest_exit_irqoff();
 	if (lapic_in_kernel(vcpu)) {
 		s64 delta = vcpu->arch.apic->lapic_timer.advance_expire_delta;
 		if (delta != S64_MIN) {

