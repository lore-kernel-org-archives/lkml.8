Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC2C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BE6220836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgEEOPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729677AbgEEOOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760CDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:51 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyLB-00019B-Cx; Tue, 05 May 2020 16:14:33 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C5C89FFC8D;
        Tue,  5 May 2020 16:14:32 +0200 (CEST)
Message-Id: <20200505134341.672545766@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:41:28 +0200
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
Subject: [patch V4 part 2 16/18] context_tracking: Make guest_enter/exit()
 .noinstr ready
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

Force inlining of the helpers and mark the instrumentable parts
accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
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
 

