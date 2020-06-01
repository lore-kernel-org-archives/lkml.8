Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A25C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0C42077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgFAJwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgFAJw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E11EC08C5D1;
        Mon,  1 Jun 2020 02:52:27 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfh7G-0003fr-7x; Mon, 01 Jun 2020 11:52:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DB9C61C0244;
        Mon,  1 Jun 2020 11:52:21 +0200 (CEST)
Date:   Mon, 01 Jun 2020 09:52:21 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix smp_call_function_single_async() usage for ILB
Cc:     Qian Cai <cai@lca.pw>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        mgorman@techsingularity.net, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200526161907.778543557@infradead.org>
References: <20200526161907.778543557@infradead.org>
MIME-Version: 1.0
Message-ID: <159100514169.17951.11938781317668210343.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     19a1f5ec699954d21be10f74ff71c2a7079e99ad
Gitweb:        https://git.kernel.org/tip/19a1f5ec699954d21be10f74ff71c2a7079e99ad
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 May 2020 18:10:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 10:54:15 +02:00

sched: Fix smp_call_function_single_async() usage for ILB

The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
got smp_call_function_single_async() subtly wrong. Even though it will
return -EBUSY when trying to re-use a csd, that condition is not
atomic and still requires external serialization.

The change in kick_ilb() got this wrong.

While on first reading kick_ilb() has an atomic test-and-set that
appears to serialize the use, the matching 'release' is not in the
right place to actually guarantee this serialization.

Rework the nohz_idle_balance() trigger so that the release is in the
IPI callback and thus guarantees the required serialization for the
CSD.

Fixes: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: mgorman@techsingularity.net
Link: https://lore.kernel.org/r/20200526161907.778543557@infradead.org
---
 kernel/sched/core.c  | 36 ++++++++++--------------------------
 kernel/sched/fair.c  | 18 ++++++++----------
 kernel/sched/sched.h |  1 +
 3 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e457d..2cacc1e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -637,41 +637,25 @@ void wake_up_nohz_cpu(int cpu)
 		wake_up_idle_cpu(cpu);
 }
 
-static inline bool got_nohz_idle_kick(void)
+static void nohz_csd_func(void *info)
 {
-	int cpu = smp_processor_id();
-
-	if (!(atomic_read(nohz_flags(cpu)) & NOHZ_KICK_MASK))
-		return false;
-
-	if (idle_cpu(cpu) && !need_resched())
-		return true;
+	struct rq *rq = info;
+	int cpu = cpu_of(rq);
+	unsigned int flags;
 
 	/*
-	 * We can't run Idle Load Balance on this CPU for this time so we
-	 * cancel it and clear NOHZ_BALANCE_KICK
+	 * Release the rq::nohz_csd.
 	 */
-	atomic_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
-	return false;
-}
+	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
+	WARN_ON(!(flags & NOHZ_KICK_MASK));
 
-static void nohz_csd_func(void *info)
-{
-	struct rq *rq = info;
-
-	if (got_nohz_idle_kick()) {
-		rq->idle_balance = 1;
+	rq->idle_balance = idle_cpu(cpu);
+	if (rq->idle_balance && !need_resched()) {
+		rq->nohz_idle_balance = flags;
 		raise_softirq_irqoff(SCHED_SOFTIRQ);
 	}
 }
 
-#else /* CONFIG_NO_HZ_COMMON */
-
-static inline bool got_nohz_idle_kick(void)
-{
-	return false;
-}
-
 #endif /* CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dda9b19..2890bd5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10024,6 +10024,10 @@ static void kick_ilb(unsigned int flags)
 	if (ilb_cpu >= nr_cpu_ids)
 		return;
 
+	/*
+	 * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who sets
+	 * the first flag owns it; cleared by nohz_csd_func().
+	 */
 	flags = atomic_fetch_or(flags, nohz_flags(ilb_cpu));
 	if (flags & NOHZ_KICK_MASK)
 		return;
@@ -10371,20 +10375,14 @@ abort:
  */
 static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 {
-	int this_cpu = this_rq->cpu;
-	unsigned int flags;
+	unsigned int flags = this_rq->nohz_idle_balance;
 
-	if (!(atomic_read(nohz_flags(this_cpu)) & NOHZ_KICK_MASK))
+	if (!flags)
 		return false;
 
-	if (idle != CPU_IDLE) {
-		atomic_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
-		return false;
-	}
+	this_rq->nohz_idle_balance = 0;
 
-	/* could be _relaxed() */
-	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
-	if (!(flags & NOHZ_KICK_MASK))
+	if (idle != CPU_IDLE)
 		return false;
 
 	_nohz_idle_balance(this_rq, flags, idle);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4b32cff..3c163cb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -951,6 +951,7 @@ struct rq {
 
 	struct callback_head	*balance_callback;
 
+	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
 
 	unsigned long		misfit_task_load;
