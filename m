Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F34C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CFFC20826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgEUUd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbgEUUbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:31:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E25EC05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:31:51 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqa-0000Kv-58; Thu, 21 May 2020 22:31:20 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 96EB0100C2D;
        Thu, 21 May 2020 22:31:19 +0200 (CEST)
Message-Id: <20200521202117.289548561@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:18 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: [patch V9 05/39] x86/entry: Provide idtentry_enter/exit_user()
References: <20200521200513.656533920@linutronix.de>
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

As there are exceptions which already handle entry from user mode and from
kernel mode separately having an explicit user handling makes sense and
makes the code easier to understand.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V9: New patch
---
 arch/x86/entry/common.c         |   31 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/idtentry.h |    3 +++
 2 files changed, 34 insertions(+)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -655,3 +655,34 @@ void noinstr idtentry_exit_cond_rcu(stru
 			rcu_irq_exit();
 	}
 }
+
+/**
+ * idtentry_enter_user - Handle state tracking on idtentry from user mode
+ * @regs:	Pointer to pt_regs of interrupted context
+ *
+ * Invokes enter_from_user_mode() to establish the proper context for
+ * NOHZ_FULL. Otherwise scheduling on exit would not be possible.
+ */
+void noinstr idtentry_enter_user(struct pt_regs *regs)
+{
+	enter_from_user_mode();
+}
+
+/**
+ * idtentry_exit_user - Handle return from exception to user mode
+ * @regs:	Pointer to pt_regs (exception entry regs)
+ *
+ * Runs the necessary preemption and work checks and returns to the caller
+ * with interrupts disabled and no further work pending.
+ *
+ * This is the last action before returning to the low level ASM code which
+ * just needs to return to the appropriate context.
+ *
+ * Counterpart to idtentry_enter_user().
+ */
+void noinstr idtentry_exit_user(struct pt_regs *regs)
+{
+	lockdep_assert_irqs_disabled();
+
+	prepare_exit_to_usermode(regs);
+}
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -7,6 +7,9 @@
 
 #ifndef __ASSEMBLY__
 
+void idtentry_enter_user(struct pt_regs *regs);
+void idtentry_exit_user(struct pt_regs *regs);
+
 bool idtentry_enter_cond_rcu(struct pt_regs *regs, bool cond_rcu);
 void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit);
 

