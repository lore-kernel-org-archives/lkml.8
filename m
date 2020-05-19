Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D7FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062B920758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgESTw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgESTw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECFDC08C5C0;
        Tue, 19 May 2020 12:52:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8Hz-0007qz-2J; Tue, 19 May 2020 21:52:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A41BF1C0178;
        Tue, 19 May 2020 21:52:34 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:34 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] sched,rcu,tracing: Avoid tracing before in_nmi() is correct
Cc:     "Steven Rostedt (VMware)" <rosted@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134101.434193525@linutronix.de>
References: <20200505134101.434193525@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795458.17951.16867777710377461415.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f93524eb9c54f49be150167918f6546b0a2e09b1
Gitweb:        https://git.kernel.org/tip/f93524eb9c54f49be150167918f6546b0a2e09b1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 12 Feb 2020 21:01:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:18 +02:00

sched,rcu,tracing: Avoid tracing before in_nmi() is correct

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
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/20200505134101.434193525@linutronix.de


---
 include/linux/hardirq.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index a043ad8..621556e 100644
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
