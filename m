Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183B6C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19D020775
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgCTSif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:38:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36898 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbgCTSi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:38:26 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFMXH-00023u-Lv
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 19:38:23 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5C29C104084
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 19:38:19 +0100 (CET)
Message-Id: <20200320180034.297670977@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 19:00:15 +0100
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
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch V3 19/23] x86/kvm/vmx: Add hardirq tracing to guest enter/exit
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

The VMX code does not track hard interrupt state correctly. The state in
tracing and lockdep is 'OFF' all the way during guest mode. From the host
point of view this is wrong because the VMENTER reenables interrupts like a
return to user space and VMENTER disables them again like an entry from
user space.

Make it do exactly the same thing as enter/exit user mode does.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
---
 arch/x86/kvm/vmx/vmx.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6538,9 +6538,19 @@ static void vmx_vcpu_run(struct kvm_vcpu
 	x86_spec_ctrl_set_guest(vmx->spec_ctrl, 0);
 
 	/*
-	 * Tell context tracking that this CPU is about to enter guest mode.
+	 * VMENTER enables interrupts (host state), but the kernel state is
+	 * interrupts disabled when this is invoked. Also tell RCU about
+	 * it. This is the same logic as for exit_to_user_mode().
+	 *
+	 * 1) Trace interrupts on state
+	 * 2) Prepare lockdep with RCU on
+	 * 3) Invoke context tracking if enabled to adjust RCU state
+	 * 4) Tell lockdep that interrupts are enabled
 	 */
+	__trace_hardirqs_on();
+	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	guest_enter_irqoff();
+	lockdep_hardirqs_on(CALLER_ADDR0);
 
 	/* L1D Flush includes CPU buffer clear to mitigate MDS */
 	if (static_branch_unlikely(&vmx_l1d_should_flush))
@@ -6557,9 +6567,20 @@ static void vmx_vcpu_run(struct kvm_vcpu
 	vcpu->arch.cr2 = read_cr2();
 
 	/*
-	 * Tell context tracking that this CPU is back.
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
 	 */
+	lockdep_hardirqs_off(CALLER_ADDR0);
 	guest_exit_irqoff();
+	__trace_hardirqs_off();
 
 	/*
 	 * We do not use IBRS in the kernel. If this vCPU has used the

