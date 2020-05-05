Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32301C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C3320836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgEEOOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729550AbgEEOOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA967C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:18 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKa-0000oH-KS; Tue, 05 May 2020 16:13:56 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 1B1E9FFC8D;
        Tue,  5 May 2020 16:13:56 +0200 (CEST)
Message-Id: <20200505134101.434193525@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:36 +0200
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
        "Steven Rostedt (VMware)" <rosted@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V4 part 1 34/36] sched,rcu,tracing: Avoid tracing before
 in_nmi() is correct
References: <20200505131602.633487962@linutronix.de>
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

From: Peter Zijlstra <peterz@infradead.org>

If a tracer is invoked before in_nmi() becomes true, the tracer can no
longer detect it is called from NMI context and behave correctly.

Therefore change nmi_{enter,exit}() to use __preempt_count_{add,sub}()
as the normal preempt_count_{add,sub}() have a (desired) function
trace entry.

This fixes a potential issue with the current code; when the function-tracer
has stack-tracing enabled __trace_stack() will malfunction when it hits the
preempt_count_add() function entry from NMI context.

Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/hardirq.h |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -66,6 +66,15 @@ extern void irq_exit(void);
 #endif
 
 /*
+ * NMI vs Tracing
+ * --------------
+ *
+ * We must not land in a tracer until (or after) we've changed preempt_count
+ * such that in_nmi() becomes true. To that effect all NMI C entry points must
+ * be marked 'notrace' and call nmi_enter() as soon as possible.
+ */
+
+/*
  * nmi_enter() can nest up to 15 times; see NMI_BITS.
  */
 #define nmi_enter()						\
@@ -75,7 +84,7 @@ extern void irq_exit(void);
 		lockdep_off();					\
 		ftrace_nmi_enter();				\
 		BUG_ON(in_nmi() == NMI_MASK);			\
-		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		rcu_nmi_enter();				\
 		lockdep_hardirq_enter();			\
 	} while (0)
@@ -85,7 +94,7 @@ extern void irq_exit(void);
 		lockdep_hardirq_exit();				\
 		rcu_nmi_exit();					\
 		BUG_ON(!in_nmi());				\
-		preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		ftrace_nmi_exit();				\
 		lockdep_on();					\
 		printk_nmi_exit();				\

