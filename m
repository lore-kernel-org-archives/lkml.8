Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03465C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB7CD221F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLBXfe3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGNGhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgGNGhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:37:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FE3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:37:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ch3so1098361pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vW6KQNy5+oCCRnnC1Q8VPuviXyfCEPdbUReZkc1RE18=;
        b=sLBXfe3ttAMfTz75e+ERY2AsS9FIU/c552V9ylpEOSE595ixwhhjeZhxlfNesV9IpO
         zd1NGnpeih9vKO0Ey8fZYmRTyORhlacRU/MgWpoRfzpGqYElumOD7eSFPh59pYLuGEK3
         gZfMOMDdFRSyiieGMIN3sCqenjPsCuZZlpENJSzJxTEJ705jrtNUjYGrjdL1dUxsoJCA
         0tprF+BFztmbNPUljlXaGezagsiaXi+fFroI3A2f29TfxwEBXXZ5C7DnyOj2avvbU1qY
         ALmw1/oaZbDi0TwM+vg/OfRM5A9Lfck0pVdeneS1Z7q4cdRwt5K+A2Uxz2fnaJ8OWLKX
         lVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vW6KQNy5+oCCRnnC1Q8VPuviXyfCEPdbUReZkc1RE18=;
        b=O/v/0is64Hjw6EESjGF4wBdFB4oEZh1wQjTiQkWzVqrR6aCKuc3N0Rw84nnflkJdM9
         N6+PxAkUqVxmstW5gpmZWwB5+iy94Vllpqq8X092b2CtJAP6goo+U+sbexwu8OZaCo/5
         nR0kcIfg2LqXHNiq7wsU6kJ59mNmrNuLAtLRFkitCnf+HyXH3zRKbcXRKW2vUPXNEwqo
         BpKuTZohCpyrZxAm5491Md+x31NJnj1X/ehpkpiZn9O3EdLS5tOr0i1v9bZ9ZV3HXnWI
         0lVCaxBcOCN5FKdMTOUr11R44DpHnBO+JzYTnYOz7qzmO6Zti4sLyaHHTdGY6lnzL9fp
         u0Lw==
X-Gm-Message-State: AOAM530T7NW8+4mZMAR3sXuNg9j+cT9QWxP+HcaOKUMixJeo8nC3Q6Bb
        +zT6G02p2FrdUP/aPpssv8pnug==
X-Google-Smtp-Source: ABdhPJzHeXdnI5gFF/5mblIM3hDic3jPtUw/UvPtLtB98l/KOSBrvn3KNrfDcm7rgkIe8jSo2pMjXQ==
X-Received: by 2002:a17:902:e901:: with SMTP id k1mr2847764pld.130.1594708626463;
        Mon, 13 Jul 2020 23:37:06 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id hg13sm1331299pjb.21.2020.07.13.23.37.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 23:37:05 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Date:   Tue, 14 Jul 2020 12:06:53 +0530
Message-Id: <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1594707424.git.viresh.kumar@linaro.org>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several parts of the kernel are already using the effective CPU
utilization to get the current load on the CPU, do the same here instead
of depending on the idle time of the CPU, which isn't that accurate
comparatively.

Note that, this (and CPU frequency scaling in general) doesn't work that
well with idle injection as that is done from rt threads and is counted
as load while it tries to do quite the opposite. That should be solved
separately though.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 65 +++++++------------------------
 1 file changed, 15 insertions(+), 50 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 6c0e1b053126..74340b2b0da7 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -23,6 +23,7 @@
 #include <linux/thermal.h>
 
 #include <trace/events/thermal.h>
+#include "../../kernel/sched/sched.h"
 
 /*
  * Cooling state <-> CPUFreq frequency
@@ -38,16 +39,6 @@
  *	...
  */
 
-/**
- * struct time_in_idle - Idle time stats
- * @time: previous reading of the absolute time that this cpu was idle
- * @timestamp: wall time of the last invocation of get_cpu_idle_time_us()
- */
-struct time_in_idle {
-	u64 time;
-	u64 timestamp;
-};
-
 /**
  * struct cpufreq_cooling_device - data for cooling device with cpufreq
  * @id: unique integer value corresponding to each cpufreq_cooling_device
@@ -62,7 +53,6 @@ struct time_in_idle {
  *	registered cooling device.
  * @policy: cpufreq policy.
  * @node: list_head to link all cpufreq_cooling_device together.
- * @idle_time: idle time stats
  * @qos_req: PM QoS contraint to apply
  *
  * This structure is required for keeping information of each registered
@@ -76,7 +66,6 @@ struct cpufreq_cooling_device {
 	struct em_perf_domain *em;
 	struct cpufreq_policy *policy;
 	struct list_head node;
-	struct time_in_idle *idle_time;
 	struct freq_qos_request qos_req;
 };
 
@@ -132,34 +121,21 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 }
 
 /**
- * get_load() - get load for a cpu since last updated
+ * get_load() - get current load for a cpu
  * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
  * @cpu:	cpu number
- * @cpu_idx:	index of the cpu in time_in_idle*
+ * @cpu_idx:	index of the cpu
  *
- * Return: The average load of cpu @cpu in percentage since this
- * function was last called.
+ * Return: The current load of cpu @cpu in percentage.
  */
 static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
 		    int cpu_idx)
 {
-	u32 load;
-	u64 now, now_idle, delta_time, delta_idle;
-	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
-
-	now_idle = get_cpu_idle_time(cpu, &now, 0);
-	delta_idle = now_idle - idle_time->time;
-	delta_time = now - idle_time->timestamp;
+	unsigned long util = cpu_util_cfs(cpu_rq(cpu));
+	unsigned long max = arch_scale_cpu_capacity(cpu);
 
-	if (delta_time <= delta_idle)
-		load = 0;
-	else
-		load = div64_u64(100 * (delta_time - delta_idle), delta_time);
-
-	idle_time->time = now_idle;
-	idle_time->timestamp = now;
-
-	return load;
+	util = effective_cpu_util(cpu, util, max, ENERGY_UTIL, NULL);
+	return (util * 100) / max;
 }
 
 /**
@@ -192,13 +168,12 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
  * Instead, we calculate the current power on the assumption that the
  * immediate future will look like the immediate past.
  *
- * We use the current frequency and the average load since this
- * function was last called.  In reality, there could have been
- * multiple opps since this function was last called and that affects
- * the load calculation.  While it's not perfectly accurate, this
- * simplification is good enough and works.  REVISIT this, as more
- * complex code may be needed if experiments show that it's not
- * accurate enough.
+ * We use the current frequency and the current load.  In reality,
+ * there could have been multiple opps since this function was last
+ * called and that affects the load calculation.  While it's not
+ * perfectly accurate, this simplification is good enough and works.
+ * REVISIT this, as more complex code may be needed if experiments show
+ * that it's not accurate enough.
  *
  * Return: 0 on success, -E* if getting the static power failed.
  */
@@ -523,13 +498,6 @@ __cpufreq_cooling_register(struct device_node *np,
 
 	cpufreq_cdev->policy = policy;
 	num_cpus = cpumask_weight(policy->related_cpus);
-	cpufreq_cdev->idle_time = kcalloc(num_cpus,
-					 sizeof(*cpufreq_cdev->idle_time),
-					 GFP_KERNEL);
-	if (!cpufreq_cdev->idle_time) {
-		cdev = ERR_PTR(-ENOMEM);
-		goto free_cdev;
-	}
 
 	/* max_level is an index, not a counter */
 	cpufreq_cdev->max_level = i - 1;
@@ -537,7 +505,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	ret = ida_simple_get(&cpufreq_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		cdev = ERR_PTR(ret);
-		goto free_idle_time;
+		goto free_cdev;
 	}
 	cpufreq_cdev->id = ret;
 
@@ -586,8 +554,6 @@ __cpufreq_cooling_register(struct device_node *np,
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 remove_ida:
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
-free_idle_time:
-	kfree(cpufreq_cdev->idle_time);
 free_cdev:
 	kfree(cpufreq_cdev);
 	return cdev;
@@ -680,7 +646,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	thermal_cooling_device_unregister(cdev);
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
-	kfree(cpufreq_cdev->idle_time);
 	kfree(cpufreq_cdev);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
-- 
2.25.0.rc1.19.g042ed3e048af

