Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CBCC2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A65C2492C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbgELWXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731794AbgELWXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:23:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD08EC05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:23:35 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYdI6-0004bG-Hi; Wed, 13 May 2020 00:22:23 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 0A1AC1006FB;
        Wed, 13 May 2020 00:22:22 +0200 (CEST)
Message-Id: <20200512213809.678944067@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 12 May 2020 23:01:02 +0200
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
Subject: [patch V5 03/38] nmi, tracing: Provide nmi_enter/exit_notrace()
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

To fully isolate #DB and #BP from instrumentable code it's necessary to
avoid invoking the hardware latency tracer on nmi_enter/exit().

Provide nmi_enter/exit() variants which are not invoking the hardware
latency tracer. That allows to put calls explicitely into the call sites
outside of the kprobe handling.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 include/linux/hardirq.h |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -77,28 +77,38 @@ extern void irq_exit(void);
 /*
  * nmi_enter() can nest up to 15 times; see NMI_BITS.
  */
-#define nmi_enter()						\
+#define nmi_enter_notrace()					\
 	do {							\
 		arch_nmi_enter();				\
 		printk_nmi_enter();				\
 		lockdep_off();					\
-		ftrace_nmi_enter();				\
 		BUG_ON(in_nmi() == NMI_MASK);			\
 		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		rcu_nmi_enter();				\
 		lockdep_hardirq_enter();			\
 	} while (0)
 
-#define nmi_exit()						\
+#define nmi_enter()						\
+	do {							\
+		nmi_enter_notrace();				\
+		ftrace_nmi_enter();				\
+	} while (0)
+
+#define nmi_exit_notrace()					\
 	do {							\
 		lockdep_hardirq_exit();				\
 		rcu_nmi_exit();					\
 		BUG_ON(!in_nmi());				\
 		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
-		ftrace_nmi_exit();				\
 		lockdep_on();					\
 		printk_nmi_exit();				\
 		arch_nmi_exit();				\
 	} while (0)
 
+#define nmi_exit()						\
+	do {							\
+		ftrace_nmi_exit();				\
+		nmi_exit_notrace();				\
+	} while (0)
+
 #endif /* LINUX_HARDIRQ_H */

