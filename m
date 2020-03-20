Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B28FC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE7A20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgCTSih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:38:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36900 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbgCTSi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:38:27 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFMXI-000248-Kx
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 19:38:24 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id CB7141040CC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 19:38:19 +0100 (CET)
Message-Id: <20200320180034.488016631@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 19:00:17 +0100
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
Subject: [patch V3 21/23] context_tracking: Make guest_enter/exit_irqoff()
 .noinstr ready
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

Mark the functions __always_inline and add the annotations for the "safe"
calls into regular text sections where RCU is watching.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
---
 include/linux/context_tracking.h |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -101,12 +101,14 @@ static inline void context_tracking_init
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 /* must be called with irqs disabled */
-static inline void guest_enter_irqoff(void)
+static __always_inline void guest_enter_irqoff(void)
 {
+	instr_begin();
 	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_enter(current);
 	else
 		current->flags |= PF_VCPU;
+	instr_end();
 
 	if (context_tracking_enabled())
 		__context_tracking_enter(CONTEXT_GUEST);
@@ -118,39 +120,48 @@ static inline void guest_enter_irqoff(vo
 	 * one time slice). Lets treat guest mode as quiescent state, just like
 	 * we do with user-mode execution.
 	 */
-	if (!context_tracking_enabled_this_cpu())
+	if (!context_tracking_enabled_this_cpu()) {
+		instr_begin();
 		rcu_virt_note_context_switch(smp_processor_id());
+		instr_end();
+	}
 }
 
-static inline void guest_exit_irqoff(void)
+static __always_inline void guest_exit_irqoff(void)
 {
 	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_GUEST);
 
+	instr_begin();
 	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_exit(current);
 	else
 		current->flags &= ~PF_VCPU;
+	instr_end();
 }
 
 #else
-static inline void guest_enter_irqoff(void)
+static __always_inline void guest_enter_irqoff(void)
 {
 	/*
 	 * This is running in ioctl context so its safe
 	 * to assume that it's the stime pending cputime
 	 * to flush.
 	 */
+	instr_begin();
 	vtime_account_kernel(current);
 	current->flags |= PF_VCPU;
 	rcu_virt_note_context_switch(smp_processor_id());
+	instr_end();
 }
 
-static inline void guest_exit_irqoff(void)
+static __always_inline void guest_exit_irqoff(void)
 {
+	instr_begin();
 	/* Flush the guest cputime we spent on the guest */
 	vtime_account_kernel(current);
 	current->flags &= ~PF_VCPU;
+	instr_end();
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
 

