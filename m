Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B0EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F2A2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgE1I7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgE1I7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:59:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46430C05BD1E;
        Thu, 28 May 2020 01:59:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeENw-0002Pa-E8; Thu, 28 May 2020 10:59:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B38601C0051;
        Thu, 28 May 2020 10:59:31 +0200 (CEST)
Date:   Thu, 28 May 2020 08:59:31 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Allow for smp_call_function() running callbacks
 from idle
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527171236.GC706495@hirez.programming.kicks-ass.net>
References: <20200527171236.GC706495@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159065637151.17951.5845770654849565519.tip-bot2@tip-bot2>
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

Commit-ID:     806f04e9fd2c6ad1e39bc2dba77155be0e4becde
Gitweb:        https://git.kernel.org/tip/806f04e9fd2c6ad1e39bc2dba77155be0e4becde
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 27 May 2020 19:12:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 10:50:12 +02:00

rcu: Allow for smp_call_function() running callbacks from idle

Current RCU hard relies on smp_call_function() callbacks running from
interrupt context. A pending optimization is going to break that, it
will allow idle CPUs to run the callbacks from the idle loop. This
avoids raising the IPI on the requesting CPU and avoids handling an
exception on the receiving CPU.

Change rcu_is_cpu_rrupt_from_idle() to also accept task context,
provided it is the idle task.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/20200527171236.GC706495@hirez.programming.kicks-ass.net
---
 kernel/rcu/tree.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 90c8be2..f51385b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -418,16 +418,23 @@ void rcu_momentary_dyntick_idle(void)
 EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
 
 /**
- * rcu_is_cpu_rrupt_from_idle - see if interrupted from idle
+ * rcu_is_cpu_rrupt_from_idle - see if 'interrupted' from idle
  *
  * If the current CPU is idle and running at a first-level (not nested)
- * interrupt from idle, return true.  The caller must have at least
- * disabled preemption.
+ * interrupt, or directly, from idle, return true.
+ *
+ * The caller must have at least disabled IRQs.
  */
 static int rcu_is_cpu_rrupt_from_idle(void)
 {
-	/* Called only from within the scheduling-clock interrupt */
-	lockdep_assert_in_irq();
+	long nesting;
+
+	/*
+	 * Usually called from the tick; but also used from smp_function_call()
+	 * for expedited grace periods. This latter can result in running from
+	 * the idle task, instead of an actual IPI.
+	 */
+	lockdep_assert_irqs_disabled();
 
 	/* Check for counter underflows */
 	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
@@ -436,9 +443,15 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 			 "RCU dynticks_nmi_nesting counter underflow/zero!");
 
 	/* Are we at first interrupt nesting level? */
-	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
+	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
+	if (nesting > 1)
 		return false;
 
+	/*
+	 * If we're not in an interrupt, we must be in the idle task!
+	 */
+	WARN_ON_ONCE(!nesting && !is_idle_task(current));
+
 	/* Does CPU appear to be idle from an RCU standpoint? */
 	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
 }
