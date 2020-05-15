Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28E6C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03D82078B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 00:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgEPAKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 20:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727817AbgEPAKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:10:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A00DC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:10:40 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkP5-00022O-1o; Sat, 16 May 2020 02:10:11 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 89899100605;
        Sat, 16 May 2020 02:10:10 +0200 (CEST)
Message-Id: <20200515235124.673436293@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:45:50 +0200
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
Subject: [patch V6 03/37] nmi, tracing: Provide nmi_enter/exit_notrace()
References: <20200515234547.710474468@linutronix.de>
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
 include/linux/hardirq.h |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -76,8 +76,16 @@ extern void irq_exit(void);
 
 /*
  * nmi_enter() can nest up to 15 times; see NMI_BITS.
+ *
+ * ftrace_count_nmi() only increments a counter and is noinstr safe so it
+ * can be invoked in nmi_enter_notrace(). ftrace_nmi_handler_enter/exit()
+ * does time stamping and will be invoked in the actual NMI handling after
+ * an instrumentable section has been reached.
+ *
+ * nmi_enter/exit() still calls into the tracer so existing callers
+ * wont break.
  */
-#define nmi_enter()						\
+#define nmi_enter_notrace()					\
 	do {							\
 		arch_nmi_enter();				\
 		printk_nmi_enter();				\
@@ -87,10 +95,15 @@ extern void irq_exit(void);
 		rcu_nmi_enter();				\
 		lockdep_hardirq_enter();			\
 		ftrace_count_nmi();				\
+	} while (0)
+
+#define nmi_enter()						\
+	do {							\
+		nmi_enter_notrace();				\
 		ftrace_nmi_handler_enter();			\
 	} while (0)
 
-#define nmi_exit()						\
+#define nmi_exit_notrace()					\
 	do {							\
 		ftrace_nmi_handler_exit();			\
 		lockdep_hardirq_exit();				\
@@ -102,4 +115,10 @@ extern void irq_exit(void);
 		arch_nmi_exit();				\
 	} while (0)
 
+#define nmi_exit()						\
+	do {							\
+		ftrace_nmi_handler_exit();			\
+		nmi_exit_notrace();				\
+	} while (0)
+
 #endif /* LINUX_HARDIRQ_H */

