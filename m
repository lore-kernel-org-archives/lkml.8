Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AF2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A061520826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgEUUb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgEUUbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:31:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C05AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:31:53 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbrqf-0000Oo-2u; Thu, 21 May 2020 22:31:25 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 9124F100606;
        Thu, 21 May 2020 22:31:24 +0200 (CEST)
Message-Id: <20200521202117.671682341@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 21 May 2020 22:05:22 +0200
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
Subject: [patch V9 09/39] genirq: Provide __irq_enter/exit_raw()
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

From: Thomas Gleixner <tglx@linutronix.de>

Like __irq_enter/exit() but without time accounting. To be used for "empty"
system vectors like the scheduler IPI to avoid the overhead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 include/linux/hardirq.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -50,6 +50,17 @@ static __always_inline void rcu_irq_ente
 	} while (0)
 
 /*
+ * Like __irq_enter() without time accounting for fast
+ * interrupts, e.g. reschedule IPI where time accounting
+ * is more expensive than the actual interrupt.
+ */
+#define __irq_enter_raw()				\
+	do {						\
+		preempt_count_add(HARDIRQ_OFFSET);	\
+		lockdep_hardirq_enter();		\
+	} while (0)
+
+/*
  * Enter irq context (on NO_HZ, update jiffies):
  */
 void irq_enter(void);
@@ -68,6 +79,15 @@ void irq_enter_rcu(void);
 		preempt_count_sub(HARDIRQ_OFFSET);	\
 	} while (0)
 
+/*
+ * Like __irq_exit() without time accounting
+ */
+#define __irq_exit_raw()				\
+	do {						\
+		lockdep_hardirq_exit();			\
+		preempt_count_sub(HARDIRQ_OFFSET);	\
+	} while (0)
+
 /*
  * Exit irq context and process softirqs if needed:
  */

