Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6D4C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A071208CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgCFOnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:43:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53798 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgCFOmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEB2-0006KN-Dl; Fri, 06 Mar 2020 15:42:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7D4221C21DC;
        Fri,  6 Mar 2020 15:42:08 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:08 -0000
From:   "tip-bot2 for Thara Gopinath" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Enable tuning of decay period
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200222005213.3873-10-thara.gopinath@linaro.org>
References: <20200222005213.3873-10-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <158350572817.28353.10208505701731851476.tip-bot2@tip-bot2>
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

Commit-ID:     05289b90c2e40ae80f5c70431cd0be4cc8a6038d
Gitweb:        https://git.kernel.org/tip/05289b90c2e40ae80f5c70431cd0be4cc8a6038d
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Fri, 21 Feb 2020 19:52:13 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:21 +01:00

sched/fair: Enable tuning of decay period

Thermal pressure follows pelt signals which means the decay period for
thermal pressure is the default pelt decay period. Depending on SoC
characteristics and thermal activity, it might be beneficial to decay
thermal pressure slower, but still in-tune with the pelt signals.  One way
to achieve this is to provide a command line parameter to set a decay
shift parameter to an integer between 0 and 10.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200222005213.3873-10-thara.gopinath@linaro.org
---
 Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++++++-
 kernel/sched/core.c                             |  2 +-
 kernel/sched/fair.c                             | 15 ++++++++++++-
 kernel/sched/sched.h                            | 18 ++++++++++++++++-
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d..dac8245 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4392,6 +4392,22 @@
 			incurs a small amount of overhead in the scheduler
 			but is useful for debugging and performance tuning.
 
+	sched_thermal_decay_shift=
+			[KNL, SMP] Set a decay shift for scheduler thermal
+			pressure signal. Thermal pressure signal follows the
+			default decay period of other scheduler pelt
+			signals(usually 32 ms but configurable). Setting
+			sched_thermal_decay_shift will left shift the decay
+			period for the thermal pressure signal by the shift
+			value.
+			i.e. with the default pelt decay period of 32 ms
+			sched_thermal_decay_shift   thermal pressure decay pr
+				1			64 ms
+				2			128 ms
+			and so on.
+			Format: integer between 0 and 10
+			Default is 0.
+
 	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
 			xtime_lock contention on larger systems, and/or RCU lock
 			contention on all systems with CONFIG_MAXSMP set.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e620fe..4d76df3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3595,7 +3595,7 @@ void scheduler_tick(void)
 
 	update_rq_clock(rq);
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
-	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
+	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	calc_global_load_tick(rq);
 	psi_task_tick(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa51286..79bb423 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -86,6 +86,19 @@ static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
+int sched_thermal_decay_shift;
+static int __init setup_sched_thermal_decay_shift(char *str)
+{
+	int _shift = 0;
+
+	if (kstrtoint(str, 0, &_shift))
+		pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");
+
+	sched_thermal_decay_shift = clamp(_shift, 0, 10);
+	return 1;
+}
+__setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
+
 #ifdef CONFIG_SMP
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
@@ -7760,7 +7773,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
+		  update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c839f8..7f1a85b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1127,6 +1127,24 @@ static inline u64 rq_clock_task(struct rq *rq)
 	return rq->clock_task;
 }
 
+/**
+ * By default the decay is the default pelt decay period.
+ * The decay shift can change the decay period in
+ * multiples of 32.
+ *  Decay shift		Decay period(ms)
+ *	0			32
+ *	1			64
+ *	2			128
+ *	3			256
+ *	4			512
+ */
+extern int sched_thermal_decay_shift;
+
+static inline u64 rq_clock_thermal(struct rq *rq)
+{
+	return rq_clock_task(rq) >> sched_thermal_decay_shift;
+}
+
 static inline void rq_clock_skip_update(struct rq *rq)
 {
 	lockdep_assert_held(&rq->lock);
