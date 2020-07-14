Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828FEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E69221F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T71LGTaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGNGhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgGNGhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:37:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBBDC061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:37:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k5so6597744plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJvOVI5+haMioIoipWHZfVf+fDy3gUcruBvuYCoy5JY=;
        b=T71LGTaCk3UJziEYnsQBwYebQnyCzNN5fObtjzPl83mugAuqiaxXoeFJfX85Wr5T5H
         6YWqFDdqAdSHncwymUpcufJ47+9h1E8loSlg93gR4XNx+JYu/mjiZIB0uWZCNQgxXZ9y
         kRbQx8FcOEkKgOjeNtmTUPQompYfjbHAAzX0noRA913lRAVmAmlNknmP0qTY9xSAaHJD
         5bg7iJGOZuwvnB9mKjaPoz8qTEZdJzd2VzOzYCK8hOl+n0k2UitR9A8GAht8uJ8vFSGw
         wkGxNEZQ3w+uoocSB5B0IWuyehWG7BFzZ/azeAqdq4sfaWtSsoc7k4kdAARu1JnkEwst
         I7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJvOVI5+haMioIoipWHZfVf+fDy3gUcruBvuYCoy5JY=;
        b=sF8wyIAeTJk7p71F5WY/+z1P4qSsfi7yPnfEzcZElu7jNoGGgKmzb2ei7vq6v6F1kl
         GhXIWVSDNPOYbAXVl8hzKtphxYnFjGBdhqvBfYSdE3TMTB3XeNx8+BKw91DjSapxmr73
         4BEZT1BSny9BkQbpQ1niKDtlBz0oCvlQkYzBMx1SVMMuFlJ6Cl9H7sjEXHmguUwDO63l
         d4ext7atcKeb00X3YgflJhyXFgwmPPwWx3QIaimUjvWOn8kEr/t4HAa4zY+ZElWUgvl1
         uzUj/KPWOD0oViIzqDibtplItl/LlsQPLJ7fLaWhSI40cZHRaYvz1UankrgsJIv7dY5Y
         s3ng==
X-Gm-Message-State: AOAM532sDUPsx4/4j9/MR5dKYWzKs3V0LIiZqRid0Zd3MqHJ1UEDueck
        ZCVGctQUituER3LNkuIpVsD1ig==
X-Google-Smtp-Source: ABdhPJxcu60A9EKk7XnWF4ml1+nyVb4sJ4qFgPUHSPHMLI+9DIyQu6v3aZ3kxh25fKqHMQLkyXzxLw==
X-Received: by 2002:a17:90a:2e85:: with SMTP id r5mr3097464pjd.232.1594708622819;
        Mon, 13 Jul 2020 23:37:02 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id g10sm8252664pfr.164.2020.07.13.23.37.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 23:37:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] sched/core: Rename and move schedutil_cpu_util to core.c
Date:   Tue, 14 Jul 2020 12:06:52 +0530
Message-Id: <83d42cb2e589235750d68c9beada882ec93aeedd.1594707424.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1594707424.git.viresh.kumar@linaro.org>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing schedutil specific in schedutil_cpu_util() and is used
by fair.c as well. Allow it to be used by other parts of the kernel as
well.

Move it to core.c and rename it to effective_cpu_util(). While at it,
rename "enum schedutil_type" as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/core.c              | 106 ++++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c | 108 +------------------------------
 kernel/sched/fair.c              |   6 +-
 kernel/sched/sched.h             |  20 ++----
 4 files changed, 115 insertions(+), 125 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a2a244af9a53..c5b345fdf81d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4879,6 +4879,112 @@ struct task_struct *idle_task(int cpu)
 	return cpu_rq(cpu)->idle;
 }
 
+/*
+ * This function computes an effective utilization for the given CPU, to be
+ * used for frequency selection given the linear relation: f = u * f_max.
+ *
+ * The scheduler tracks the following metrics:
+ *
+ *   cpu_util_{cfs,rt,dl,irq}()
+ *   cpu_bw_dl()
+ *
+ * Where the cfs,rt and dl util numbers are tracked with the same metric and
+ * synchronized windows and are thus directly comparable.
+ *
+ * The cfs,rt,dl utilization are the running times measured with rq->clock_task
+ * which excludes things like IRQ and steal-time. These latter are then accrued
+ * in the irq utilization.
+ *
+ * The DL bandwidth number otoh is not a measured metric but a value computed
+ * based on the task model parameters and gives the minimal utilization
+ * required to meet deadlines.
+ */
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum cpu_util_type type,
+				 struct task_struct *p)
+{
+	unsigned long dl_util, util, irq;
+	struct rq *rq = cpu_rq(cpu);
+
+	if (!uclamp_is_used() &&
+	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
+		return max;
+	}
+
+	/*
+	 * Early check to see if IRQ/steal time saturates the CPU, can be
+	 * because of inaccuracies in how we track these -- see
+	 * update_irq_load_avg().
+	 */
+	irq = cpu_util_irq(rq);
+	if (unlikely(irq >= max))
+		return max;
+
+	/*
+	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
+	 * CFS tasks and we use the same metric to track the effective
+	 * utilization (PELT windows are synchronized) we can directly add them
+	 * to obtain the CPU's actual utilization.
+	 *
+	 * CFS and RT utilization can be boosted or capped, depending on
+	 * utilization clamp constraints requested by currently RUNNABLE
+	 * tasks.
+	 * When there are no CFS RUNNABLE tasks, clamps are released and
+	 * frequency will be gracefully reduced with the utilization decay.
+	 */
+	util = util_cfs + cpu_util_rt(rq);
+	if (type == FREQUENCY_UTIL)
+		util = uclamp_rq_util_with(rq, util, p);
+
+	dl_util = cpu_util_dl(rq);
+
+	/*
+	 * For frequency selection we do not make cpu_util_dl() a permanent part
+	 * of this sum because we want to use cpu_bw_dl() later on, but we need
+	 * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
+	 * that we select f_max when there is no idle time.
+	 *
+	 * NOTE: numerical errors or stop class might cause us to not quite hit
+	 * saturation when we should -- something for later.
+	 */
+	if (util + dl_util >= max)
+		return max;
+
+	/*
+	 * OTOH, for energy computation we need the estimated running time, so
+	 * include util_dl and ignore dl_bw.
+	 */
+	if (type == ENERGY_UTIL)
+		util += dl_util;
+
+	/*
+	 * There is still idle time; further improve the number by using the
+	 * irq metric. Because IRQ/steal time is hidden from the task clock we
+	 * need to scale the task numbers:
+	 *
+	 *              max - irq
+	 *   U' = irq + --------- * U
+	 *                 max
+	 */
+	util = scale_irq_capacity(util, irq, max);
+	util += irq;
+
+	/*
+	 * Bandwidth required by DEADLINE must always be granted while, for
+	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
+	 * to gracefully reduce the frequency when no tasks show up for longer
+	 * periods of time.
+	 *
+	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
+	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
+	 * an interface. So, we only do the latter for now.
+	 */
+	if (type == FREQUENCY_UTIL)
+		util += cpu_bw_dl(rq);
+
+	return min(max, util);
+}
+
 /**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index dc6835bc6490..e9623527741b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -183,112 +183,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-/*
- * This function computes an effective utilization for the given CPU, to be
- * used for frequency selection given the linear relation: f = u * f_max.
- *
- * The scheduler tracks the following metrics:
- *
- *   cpu_util_{cfs,rt,dl,irq}()
- *   cpu_bw_dl()
- *
- * Where the cfs,rt and dl util numbers are tracked with the same metric and
- * synchronized windows and are thus directly comparable.
- *
- * The cfs,rt,dl utilization are the running times measured with rq->clock_task
- * which excludes things like IRQ and steal-time. These latter are then accrued
- * in the irq utilization.
- *
- * The DL bandwidth number otoh is not a measured metric but a value computed
- * based on the task model parameters and gives the minimal utilization
- * required to meet deadlines.
- */
-unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
-				 struct task_struct *p)
-{
-	unsigned long dl_util, util, irq;
-	struct rq *rq = cpu_rq(cpu);
-
-	if (!uclamp_is_used() &&
-	    type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt)) {
-		return max;
-	}
-
-	/*
-	 * Early check to see if IRQ/steal time saturates the CPU, can be
-	 * because of inaccuracies in how we track these -- see
-	 * update_irq_load_avg().
-	 */
-	irq = cpu_util_irq(rq);
-	if (unlikely(irq >= max))
-		return max;
-
-	/*
-	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
-	 * CFS tasks and we use the same metric to track the effective
-	 * utilization (PELT windows are synchronized) we can directly add them
-	 * to obtain the CPU's actual utilization.
-	 *
-	 * CFS and RT utilization can be boosted or capped, depending on
-	 * utilization clamp constraints requested by currently RUNNABLE
-	 * tasks.
-	 * When there are no CFS RUNNABLE tasks, clamps are released and
-	 * frequency will be gracefully reduced with the utilization decay.
-	 */
-	util = util_cfs + cpu_util_rt(rq);
-	if (type == FREQUENCY_UTIL)
-		util = uclamp_rq_util_with(rq, util, p);
-
-	dl_util = cpu_util_dl(rq);
-
-	/*
-	 * For frequency selection we do not make cpu_util_dl() a permanent part
-	 * of this sum because we want to use cpu_bw_dl() later on, but we need
-	 * to check if the CFS+RT+DL sum is saturated (ie. no idle time) such
-	 * that we select f_max when there is no idle time.
-	 *
-	 * NOTE: numerical errors or stop class might cause us to not quite hit
-	 * saturation when we should -- something for later.
-	 */
-	if (util + dl_util >= max)
-		return max;
-
-	/*
-	 * OTOH, for energy computation we need the estimated running time, so
-	 * include util_dl and ignore dl_bw.
-	 */
-	if (type == ENERGY_UTIL)
-		util += dl_util;
-
-	/*
-	 * There is still idle time; further improve the number by using the
-	 * irq metric. Because IRQ/steal time is hidden from the task clock we
-	 * need to scale the task numbers:
-	 *
-	 *              max - irq
-	 *   U' = irq + --------- * U
-	 *                 max
-	 */
-	util = scale_irq_capacity(util, irq, max);
-	util += irq;
-
-	/*
-	 * Bandwidth required by DEADLINE must always be granted while, for
-	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
-	 * to gracefully reduce the frequency when no tasks show up for longer
-	 * periods of time.
-	 *
-	 * Ideally we would like to set bw_dl as min/guaranteed freq and util +
-	 * bw_dl as requested freq. However, cpufreq is not yet ready for such
-	 * an interface. So, we only do the latter for now.
-	 */
-	if (type == FREQUENCY_UTIL)
-		util += cpu_bw_dl(rq);
-
-	return min(max, util);
-}
-
 static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
@@ -298,7 +192,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
-	return schedutil_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
+	return effective_cpu_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL, NULL);
 }
 
 /**
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3213cb247aff..94d564745499 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6490,7 +6490,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * is already enough to scale the EM reported power
 		 * consumption at the (eventually clamped) cpu_capacity.
 		 */
-		sum_util += schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+		sum_util += effective_cpu_util(cpu, util_cfs, cpu_cap,
 					       ENERGY_UTIL, NULL);
 
 		/*
@@ -6500,7 +6500,7 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
 		 * NOTE: in case RT tasks are running, by default the
 		 * FREQUENCY_UTIL's utilization can be max OPP.
 		 */
-		cpu_util = schedutil_cpu_util(cpu, util_cfs, cpu_cap,
+		cpu_util = effective_cpu_util(cpu, util_cfs, cpu_cap,
 					      FREQUENCY_UTIL, tsk);
 		max_util = max(max_util, cpu_util);
 	}
@@ -6597,7 +6597,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * IOW, placing the task there would make the CPU
 			 * overutilized. Take uclamp into account to see how
 			 * much capacity we can get out of the CPU; this is
-			 * aligned with schedutil_cpu_util().
+			 * aligned with effective_cpu_util().
 			 */
 			util = uclamp_rq_util_with(cpu_rq(cpu), util, p);
 			if (!fits_capacity(util, cpu_cap))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 65b72e0487bf..dabfc7fa1270 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2465,24 +2465,22 @@ static inline unsigned long capacity_orig_of(int cpu)
 #endif
 
 /**
- * enum schedutil_type - CPU utilization type
+ * enum cpu_util_type - CPU utilization type
  * @FREQUENCY_UTIL:	Utilization used to select frequency
  * @ENERGY_UTIL:	Utilization used during energy calculation
  *
  * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
  * need to be aggregated differently depending on the usage made of them. This
- * enum is used within schedutil_freq_util() to differentiate the types of
+ * enum is used within effective_cpu_util() to differentiate the types of
  * utilization expected by the callers, and adjust the aggregation accordingly.
  */
-enum schedutil_type {
+enum cpu_util_type {
 	FREQUENCY_UTIL,
 	ENERGY_UTIL,
 };
 
-#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
-
-unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long max, enum cpu_util_type type,
 				 struct task_struct *p);
 
 static inline unsigned long cpu_bw_dl(struct rq *rq)
@@ -2511,14 +2509,6 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
-#else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
-static inline unsigned long schedutil_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long max, enum schedutil_type type,
-				 struct task_struct *p)
-{
-	return 0;
-}
-#endif /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
-- 
2.25.0.rc1.19.g042ed3e048af

