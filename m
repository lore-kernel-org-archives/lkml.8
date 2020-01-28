Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE95C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8111B21739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yeD6JCkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgA1WgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:36:15 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44752 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgA1WgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:36:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so15097308qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5mlWzBIx5gOkkO/peVFFSdZxnrfoBE1p31yhua1uZIw=;
        b=yeD6JCkKIutHWXvx5AMKQNb4jpMSMDKweTiSJdq4/NCP+i3WGmt2kJvqt5ZbXc/DPs
         +3tKDFoRB4/phz1ax9lvie3uXTp0y/B9DVhu3AB8xJUExzmPT/K/oEi6Q+xUCGHKHB/q
         /EzTgloQ7GiCFK2RChmBo1Gca5k6hGhK6WWvIdmqZHCNTofH4Tkdt+73M6KdYdEouI4H
         dd0gpqHYPMyGl1hH4Ct6mVg0hzRYw/DAhZtRbBOTqm4vkp+hZ/e9iWGH4hk9pIpZ/l9u
         RMVOrSuPf2tl+1cXURmLWMrFuesQnKk6BDNg3nosGQxDuN2pNarz19UrnsA7yYr5E6zp
         KStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5mlWzBIx5gOkkO/peVFFSdZxnrfoBE1p31yhua1uZIw=;
        b=VMmzxHL/BRBrNDRLGYU2ghJAxQjqUH31yejBzFZ4W9byGUKM5TRwfyn3NlkWocBOyU
         q7cg0RShQagglJZ8cxAD24AM+b2BYxn2O2WOaDc4HP7ll3OYX3Hx+ba3ZocDTzZ/8uB4
         mg3TVhkpl4eQi069iSyQ2F5JKSMmhQvwwfeY7IYw904heqx4pzVAZBTY/TCFIwAhQds1
         /S+e2UBPLpTC0ACqVeov/Lm0j+ARl/LbTwHbg1N5pylvYaCKI1uSobcwOlDUZo+/YgzK
         fWq5TBuSNKKSrKa3WAyDMyo8M+8/So9CZmFH/2hD/oyPgpaG+0jhr5LZ9QOh3C1nX2Z/
         hKnw==
X-Gm-Message-State: APjAAAWRQPtpvzSbDfiQXbhQgK+k1uGftmKVMlg69KPXMsgXIz3ZuDrl
        OCejmJjJzAyXbcsHuO+6cmu0lg==
X-Google-Smtp-Source: APXvYqyWqUep5KSuNLAwNO7IfxGZXkqn+VIgusiBjaArocBsVFbizT42yfGRE1zVQlWPlP26WKYIPA==
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr25101640qkl.305.1580250971624;
        Tue, 28 Jan 2020 14:36:11 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 124sm13014259qko.11.2020.01.28.14.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jan 2020 14:36:11 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v9 1/8] sched/pelt: Add support to track thermal pressure
Date:   Tue, 28 Jan 2020 17:36:00 -0500
Message-Id: <1580250967-4386-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extrapolating on the existing framework to track rt/dl utilization using
pelt signals, add a similar mechanism to track thermal pressure. The
difference here from rt/dl utilization tracking is that, instead of
tracking time spent by a cpu running a rt/dl task through util_avg, the
average thermal pressure is tracked through load_avg. This is because
thermal pressure signal is weighted "delta" capacity and is not
binary(util_avg is binary). "delta capacity" here means delta between the
actual capacity of a cpu and the decreased capacity a cpu due to a thermal
event.

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

 include/trace/events/sched.h |  4 ++++
 init/Kconfig                 |  4 ++++
 kernel/sched/pelt.c          | 31 +++++++++++++++++++++++++++++++
 kernel/sched/pelt.h          | 31 +++++++++++++++++++++++++++++++
 kernel/sched/sched.h         |  3 +++
 5 files changed, 73 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 420e80e..a8fb667 100644
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
index bd9f1fd..055c3bf 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -463,6 +463,10 @@ config HAVE_SCHED_AVG_IRQ
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
index bd006b7..5d1fbf0 100644
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
+ * weighted "delta" capacity and is not binary(util_avg is binary). "delta
+ * capacity" here means delta between the actual capacity of a cpu and the
+ * decreased capacity a cpu due to a thermal event.
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
index afff644..916979a 100644
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
index 1a88dc8..1f256cb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -944,6 +944,9 @@ struct rq {
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
+#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
+	struct sched_avg	avg_thermal;
+#endif
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.1.4

