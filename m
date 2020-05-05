Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16553C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0AD6207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgEEOPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729678AbgEEOOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AADC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:51 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLA-00018H-37; Tue, 05 May 2020 16:14:32 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 884331001F5;
        Tue,  5 May 2020 16:14:31 +0200 (CEST)
Message-Id: <20200505134341.579034898@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:41:27 +0200
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
Subject: [patch V4 part 2 15/18] x86/kvm/svm: Handle hardirqs proper on guest
 enter/exit
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

Add hardirq tracing to guest enter/exit functions in the same way as it is
done in the user mode enter/exit code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/svm/svm.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3331,12 +3331,23 @@ static void svm_vcpu_run(struct kvm_vcpu
 	x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
 
 	/*
-	 * Tell context tracking that this CPU is about to enter guest
-	 * mode. This has to be after x86_spec_ctrl_set_guest() because
-	 * that can take locks (lockdep needs RCU) and calls into world and
-	 * some more.
+	 * VMENTER enables interrupts (host state), but the kernel state is
+	 * interrupts disabled when this is invoked. Also tell RCU about
+	 * it. This is the same logic as for exit_to_user_mode().
+	 *
+	 * 1) Trace interrupts on state
+	 * 2) Prepare lockdep with RCU on
+	 * 3) Invoke context tracking if enabled to adjust RCU state
+	 * 4) Tell lockdep that interrupts are enabled
+	 *
+	 * This has to be after x86_spec_ctrl_set_guest() because that can
+	 * take locks (lockdep needs RCU) and calls into world and some
+	 * more.
 	 */
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	guest_enter_irqoff();
+	lockdep_hardirqs_on(CALLER_ADDR0);
 
 	__svm_vcpu_run(svm->vmcb_pa, (unsigned long *)&svm->vcpu.arch.regs);
 
@@ -3348,14 +3359,23 @@ static void svm_vcpu_run(struct kvm_vcpu
 	loadsegment(gs, svm->host.gs);
 #endif
 #endif
+
 	/*
-	 * Tell context tracking that this CPU is back.
+	 * VMEXIT disables interrupts (host state, see the CLI in the ASM
+	 * above), but tracing and lockdep have them in state 'on'. Same as
+	 * enter_from_user_mode().
+	 *
+	 * 1) Tell lockdep that interrupts are disabled
+	 * 2) Invoke context tracking if enabled to reactivate RCU
+	 * 3) Trace interrupts off state
 	 *
 	 * This needs to be done before the below as native_read_msr()
 	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
 	 * into world and some more.
 	 */
+	lockdep_hardirqs_off(CALLER_ADDR0);
 	guest_exit_irqoff();
+	trace_hardirqs_off_prepare();
 
 	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the

