Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6924BC2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE2D24927
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbgELWZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731674AbgELWXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:23:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32223C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:23:13 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYdIC-0004gW-Rb; Wed, 13 May 2020 00:22:29 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 4E8FD1001FC;
        Wed, 13 May 2020 00:22:28 +0200 (CEST)
Message-Id: <20200512213810.212055069@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 12 May 2020 23:01:07 +0200
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
Subject: [patch V5 08/38] x86/entry: Split idtentry_enter/exit()
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

Split the implementation of idtentry_enter/exit() out into inline functions
so that variants of idtentry_enter/exit() can be implemented without
duplicating code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |   37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -539,22 +539,7 @@ void noinstr idtentry_enter(struct pt_re
 	}
 }
 
-/**
- * idtentry_exit - Common code to handle return from exceptions
- * @regs:	Pointer to pt_regs (exception entry regs)
- *
- * Depending on the return target (kernel/user) this runs the necessary
- * preemption and work checks if possible and required and returns to
- * the caller with interrupts disabled and no further work pending.
- *
- * This is the last action before returning to the low level ASM code which
- * just needs to return to the appropriate context.
- *
- * Invoked by all exception/interrupt IDTENTRY handlers which are not
- * returning through the paranoid exit path (all except NMI, #DF and the IST
- * variants of #MC and #DB) and are therefore on the thread stack.
- */
-void noinstr idtentry_exit(struct pt_regs *regs)
+static __always_inline void __idtentry_exit(struct pt_regs *regs)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -610,3 +595,23 @@ void noinstr idtentry_exit(struct pt_reg
 		rcu_irq_exit();
 	}
 }
+
+/**
+ * idtentry_exit - Common code to handle return from exceptions
+ * @regs:	Pointer to pt_regs (exception entry regs)
+ *
+ * Depending on the return target (kernel/user) this runs the necessary
+ * preemption and work checks if possible and required and returns to
+ * the caller with interrupts disabled and no further work pending.
+ *
+ * This is the last action before returning to the low level ASM code which
+ * just needs to return to the appropriate context.
+ *
+ * Invoked by all exception/interrupt IDTENTRY handlers which are not
+ * returning through the paranoid exit path (all except NMI, #DF and the IST
+ * variants of #MC and #DB) and are therefore on the thread stack.
+ */
+void noinstr idtentry_exit(struct pt_regs *regs)
+{
+	__idtentry_exit(regs);
+}

