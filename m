Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D91C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9711B2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgCFOmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53881 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgCFOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEBC-0006PX-QI; Fri, 06 Mar 2020 15:42:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 86CF01C21D9;
        Fri,  6 Mar 2020 15:42:11 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:11 -0000
From:   "tip-bot2 for Thara Gopinath" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/pelt: Add support to track thermal pressure
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200222005213.3873-2-thara.gopinath@linaro.org>
References: <20200222005213.3873-2-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <158350573124.28353.7802371753363408650.tip-bot2@tip-bot2>
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

Commit-ID:     765047932f153265db6ef15be208d6cbfc03dc62
Gitweb:        https://git.kernel.org/tip/765047932f153265db6ef15be208d6cbfc03dc62
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Fri, 21 Feb 2020 19:52:05 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:17 +01:00

sched/pelt: Add support to track thermal pressure

Extrapolating on the existing framework to track rt/dl utilization using
pelt signals, add a similar mechanism to track thermal pressure. The
difference here from rt/dl utilization tracking is that, instead of
tracking time spent by a CPU running a RT/DL task through util_avg, the
average thermal pressure is tracked through load_avg. This is because
thermal pressure signal is weighted time "delta" capacity unlike util_avg
which is binary. "delta capacity" here means delta between the actual
capacity of a CPU and the decreased capacity a CPU due to a thermal event.

In order to track average thermal pressure, a new sched_avg variable
avg_thermal is introduced. Function update_thermal_load_avg can be called
to do the periodic bookkeeping (accumulate, decay and average) of the
thermal pressure.

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200222005213.3873-2-thara.gopinath@linaro.org
---
 include/trace/events/sched.h |  4 ++++
 init/Kconfig                 |  4 ++++
 kernel/sched/pelt.c          | 31 +++++++++++++++++++++++++++++++
 kernel/sched/pelt.h          | 31 +++++++++++++++++++++++++++++++
 kernel/sched/sched.h         |  3 +++
 5 files changed, 73 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9c3ebb7..ed168b0 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -618,6 +618,10 @@ DECLARE_TRACE(pelt_dl_tp,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
+DECLARE_TRACE(pelt_thermal_tp,
+	TP_PROTO(struct rq *rq),
+	TP_ARGS(rq));
+
 DECLARE_TRACE(pelt_irq_tp,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
diff --git a/init/Kconfig b/init/Kconfig
index 20a6ac3..275c848 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -451,6 +451,10 @@ config HAVE_SCHED_AVG_IRQ
 	depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
 	depends on SMP
 
+config SCHED_THERMAL_PRESSURE
+	bool "Enable periodic averaging of thermal pressure"
+	depends on SMP
+
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
 	depends on MULTIUSER
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index c40d57a..b647d04 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -368,6 +368,37 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
+#ifdef CONFIG_SCHED_THERMAL_PRESSURE
+/*
+ * thermal:
+ *
+ *   load_sum = \Sum se->avg.load_sum but se->avg.load_sum is not tracked
+ *
+ *   util_avg and runnable_load_avg are not supported and meaningless.
+ *
+ * Unlike rt/dl utilization tracking that track time spent by a cpu
+ * running a rt/dl task through util_avg, the average thermal pressure is
+ * tracked through load_avg. This is because thermal pressure signal is
+ * time weighted "delta" capacity unlike util_avg which is binary.
+ * "delta capacity" =  actual capacity  -
+ *			capped capacity a cpu due to a thermal event.
+ */
+
+int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	if (___update_load_sum(now, &rq->avg_thermal,
+			       capacity,
+			       capacity,
+			       capacity)) {
+		___update_load_avg(&rq->avg_thermal, 1);
+		trace_pelt_thermal_tp(rq);
+		return 1;
+	}
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 /*
  * irq:
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index afff644..eb034d9 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -7,6 +7,26 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
+#ifdef CONFIG_SCHED_THERMAL_PRESSURE
+int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
+
+static inline u64 thermal_load_avg(struct rq *rq)
+{
+	return READ_ONCE(rq->avg_thermal.load_avg);
+}
+#else
+static inline int
+update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	return 0;
+}
+
+static inline u64 thermal_load_avg(struct rq *rq)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 int update_irq_load_avg(struct rq *rq, u64 running);
 #else
@@ -159,6 +179,17 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 }
 
 static inline int
+update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	return 0;
+}
+
+static inline u64 thermal_load_avg(struct rq *rq)
+{
+	return 0;
+}
+
+static inline int
 update_irq_load_avg(struct rq *rq, u64 running)
 {
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2a0caf3..6c839f8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -961,6 +961,9 @@ struct rq {
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
+#ifdef CONFIG_SCHED_THERMAL_PRESSURE
+	struct sched_avg	avg_thermal;
+#endif
 	u64			idle_stamp;
 	u64			avg_idle;
 
