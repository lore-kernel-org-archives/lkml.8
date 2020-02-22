Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D611C35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F9F206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBUM81/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgBVAwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:52:19 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46978 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBVAwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:52:18 -0500
Received: by mail-qk1-f195.google.com with SMTP id u124so3593090qkh.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yh6Np5NAp09sqBJL1Y7XFYzIWwPoRwAqcckkXofTxjk=;
        b=GBUM81/qNqkpx0uMEh6RM0GrbiS1/mdjWuGaeuudxvb0WBTPZc2js2SDQqLy5QcN61
         0dDcl6xyS/WWq0fx/wrf4Y5uHZj/wfk5hsDLZqf8t4nW058/cZHiAtoCnYFr7TrASAqb
         y+8iD4HancfVacdnpfw9/eE0wSgA9IgCi/g4devlSyW8tQKfQ5GSH9pDnJLEcCf6HATO
         qCuEyULgKFnrGOe24rxL9X+NSfg0MOxIQ3Efgns7qVZIeNBriNBpVr/hNff4mFaBkEr5
         DoNiGfKuIkbe+HphQSCi68QFrirq9vIih6LznO6mGuweP0daTxJyT2xf8MJVnBYYoFdb
         Y75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yh6Np5NAp09sqBJL1Y7XFYzIWwPoRwAqcckkXofTxjk=;
        b=SlBRDJ3rMuOQNdLnDCTJoCJU3mrz9+lq7SqurirEDkZpy0/ZVSVasXkaF2h9QyvJgV
         Wz1aEyfKzIlRdUtxwZPGGqq7qOPhCxTh/ji8VWb/oRZyuIFXZ2QE85KGyvnMqkzLioNR
         Ohj6mkRSGMaqfcmz1O+MuaHF/Kv+//zx+F3O4qVeK5HWmwvTRnhs+gzfcqKvc4+UoWBO
         aFZ3QqH+w24+RYzNIAipAsbAiiNF2g//QfpnGqBozrXBu6EXW1pQ5haTXs0n0h/UiX71
         SkUMqO47QjPXm5CnPSMTl3x6WTjxqmbhuzj/lBherUMlOhSPtwYjZthoxMaOM3/VICCO
         EnxA==
X-Gm-Message-State: APjAAAXXgIQthqoSQmzI5SqojcrnL9EgbH0Rq0M2uSY3ejBIr578HWLQ
        K4sfoq9+9bQOr2r2e1idkM+GzOgjolwfOQ==
X-Google-Smtp-Source: APXvYqybIo6HRD3a7jmSFItcBNm/Y/muJWOTiIYwyPFdELdGVP3tUDXKRBJjybRaGcaWXeAxlx8K2w==
X-Received: by 2002:a37:91c2:: with SMTP id t185mr32944019qkd.284.1582332736752;
        Fri, 21 Feb 2020 16:52:16 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 12sm359559qkj.136.2020.02.21.16.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:52:16 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v10 1/9] sched/pelt: Add support to track thermal pressure
Date:   Fri, 21 Feb 2020 19:52:05 -0500
Message-Id: <20200222005213.3873-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222005213.3873-1-thara.gopinath@linaro.org>
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extrapolating on the existing framework to track rt/dl utilization using
pelt signals, add a similar mechanism to track thermal pressure. The
difference here from rt/dl utilization tracking is that, instead of
tracking time spent by a cpu running a rt/dl task through util_avg, the
average thermal pressure is tracked through load_avg. This is because
thermal pressure signal is weighted time "delta" capacity unlike util_avg
which is binary. "delta capacity" here means delta between the actual
capacity of a cpu and the decreased capacity a cpu due to a thermal event.

In order to track average thermal pressure, a new sched_avg variable
avg_thermal is introduced. Function update_thermal_load_avg can be called
to do the periodic bookkeeping (accumulate, decay and average) of the
thermal pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
v6->v7:
	- Added CONFIG_HAVE_SCHED_THERMAL_PRESSURE to stub out
	  update_thermal_load_avg in unsupported architectures as per
	  review comments from Peter, Dietmar and Quentin.
	- Updated comment for update_thermal_load_avg as per review
	  comments from Peter and Dietmar.
v7->v8:
	- Fixed typo in defining update_thermal_load_avg which was
	  causing build errors (reported by kbuild test report)
v8->v9:
	- Defined thermal_load_avg to read rq->avg_thermal.load_avg and
	  avoid cacheline miss in unsupported cases as per Peter's
          suggestion.
v9->v10:
	- Fixed typos in comments as per Amit Kucheria's review comments.

 include/trace/events/sched.h |  4 ++++
 init/Kconfig                 |  4 ++++
 kernel/sched/pelt.c          | 31 +++++++++++++++++++++++++++++++
 kernel/sched/pelt.h          | 31 +++++++++++++++++++++++++++++++
 kernel/sched/sched.h         |  3 +++
 5 files changed, 73 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 420e80e56e55..a8fb667c669e 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -613,6 +613,10 @@ DECLARE_TRACE(pelt_dl_tp,
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
index 2a25c769eaaa..8d56902efa70 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -464,6 +464,10 @@ config HAVE_SCHED_AVG_IRQ
 	depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
 	depends on SMP
 
+config HAVE_SCHED_THERMAL_PRESSURE
+	bool "Enable periodic averaging of thermal pressure"
+	depends on SMP
+
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
 	depends on MULTIUSER
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index bd006b79b360..1fdacbf6fb44 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -367,6 +367,37 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
+#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
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
+		___update_load_avg(&rq->avg_thermal, 1, 1);
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
index afff644da065..916979a54782 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -7,6 +7,26 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
+#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
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
@@ -158,6 +178,17 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
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
+
 static inline int
 update_irq_load_avg(struct rq *rq, u64 running)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 12bf82d86156..211411ac0efa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -943,6 +943,9 @@ struct rq {
 	struct sched_avg	avg_dl;
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
+#endif
+#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
+	struct sched_avg	avg_thermal;
 #endif
 	u64			idle_stamp;
 	u64			avg_idle;
-- 
2.20.1

