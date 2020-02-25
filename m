Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63140C4BA09
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C5124685
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgBYXad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:30:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55551 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbgBYXZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:52 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6ja2-0004Y0-LD; Wed, 26 Feb 2020 00:25:35 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id CF0D6104092;
        Wed, 26 Feb 2020 00:25:29 +0100 (CET)
Message-Id: <20200225220217.150607679@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 22:36:46 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [patch 10/10] x86/traps: Stop using ist_enter/exit() in do_int3()
References: <20200225213636.689276920@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#BP is not longer using IST and using ist_enter() and ist_exit() makes it
harder to change ist_enter() and ist_exit()'s behavior.  Instead open-code
the very small amount of required logic.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/traps.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -572,14 +572,20 @@ dotraplinkage void notrace do_int3(struc
 		return;
 
 	/*
-	 * Use ist_enter despite the fact that we don't use an IST stack.
-	 * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
-	 * mode or even during context tracking state changes.
+	 * Unlike any other non-IST entry, we can be called from a kprobe in
+	 * non-CONTEXT_KERNEL kernel mode or even during context tracking
+	 * state changes.  Make sure that we wake up RCU even if we're coming
+	 * from kernel code.
 	 *
-	 * This means that we can't schedule.  That's okay.
+	 * This means that we can't schedule even if we came from a
+	 * preemptible kernel context.  That's okay.
 	 */
-	ist_enter(regs);
+	if (!user_mode(regs)) {
+		rcu_nmi_enter();
+		preempt_disable();
+	}
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
 				SIGTRAP) == NOTIFY_STOP)
@@ -600,7 +606,10 @@ dotraplinkage void notrace do_int3(struc
 	cond_local_irq_disable(regs);
 
 exit:
-	ist_exit(regs);
+	if (!user_mode(regs)) {
+		preempt_enable_no_resched();
+		rcu_nmi_exit();
+	}
 }
 NOKPROBE_SYMBOL(do_int3);
 

