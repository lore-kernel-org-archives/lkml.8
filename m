Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4D5C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0AD24673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lsnfdCcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgANT5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:57:47 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35046 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:57:45 -0500
Received: by mail-qt1-f194.google.com with SMTP id e12so13617531qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kRsTRwNkr4c5Iv/bW7M4A6X+Drqw4d7kQWJ0lfiuJDg=;
        b=lsnfdCcplPTO+r0L9CZRm+VjbF8JjzGOmdRxz1uFOB3UbL3RhVgQwTiUxXlJMjd15l
         7TLyosR63Vwf3vCSHQ/TlSPnpiORXK3Q/50zDMTin4eXXas0dU7Y2/tsfkID/bi2A40G
         Ws1Pw4bYVhjSkhkeSnnXZPlr8yno97/jX+5XYW6xEmqO9cqTK/zfz7O361W+wAWV/nbi
         TEW6Lxvo8vizpSOP3jWARHD0eYW1NVU9mMXIcml+HqNxKwugqczDHAv8mlFyihVKgMPJ
         XgLq5RQ85MCdglEhJedSfIC5B5VteDExHG1ASQefuJo3wFlNrk7xPm6FyyiI4fPy6FB5
         zm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kRsTRwNkr4c5Iv/bW7M4A6X+Drqw4d7kQWJ0lfiuJDg=;
        b=RE4NnRBYLvc99nAvvoWLEH8chPt4d7mKtLdbloRnOTBRXfw7hB/TovdkvFQ6OqF2TC
         vKsZuNkJCqcvvxZTG1b9LIL2aaH8yIEKi8Tn5sD/7ktQyMJk9KDG6kF4Ukz9wD+eXnzT
         A0SYhTZ6l9Kvy7+iWYc4pBvIjC8Qgnr70vPd4NwqQM1lTXAsJs1THXECmGZZUYM8wzCl
         SqKBCzoTz0QD0r7HfV03mWg4JC5H2DeAL99zboerUX8tBWzCM9ZwY5JTd9nq9sYvdiZt
         jnMkxMWY95TQYrLdqqlqR6ONObEwYcY4mMgUMKepCPiD6S2uLPQUvI4s0KE1Dxz3/eyD
         U6WQ==
X-Gm-Message-State: APjAAAWwp7ymKtbN5GPpSlscsLU+X0d+rixPD4kEmEI5xXiY9E/MtM7q
        9fCruWNsshmbGQm7AU+816/41A==
X-Google-Smtp-Source: APXvYqxWLeL/lG2PuqdFJ831IjiwAqRKLeHsoKReBq1CTXPRwmoyIQba9vblEq1PkmG7GXowmzDZbA==
X-Received: by 2002:ac8:30ba:: with SMTP id v55mr260099qta.324.1579031864072;
        Tue, 14 Jan 2020 11:57:44 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id b81sm7183497qkc.135.2020.01.14.11.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jan 2020 11:57:43 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v8 1/7] sched/pelt: Add support to track thermal pressure
Date:   Tue, 14 Jan 2020 14:57:33 -0500
Message-Id: <1579031859-18692-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
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

 include/trace/events/sched.h |  4 ++++
 init/Kconfig                 |  4 ++++
 kernel/sched/pelt.c          | 31 +++++++++++++++++++++++++++++++
 kernel/sched/pelt.h          | 16 ++++++++++++++++
 kernel/sched/sched.h         |  1 +
 5 files changed, 56 insertions(+)

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
index f6a4a91..c16ea88 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -450,6 +450,10 @@ config HAVE_SCHED_AVG_IRQ
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
index afff644..bf1e17b 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -7,6 +7,16 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
+#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
+int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
+#else
+static inline int
+update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 int update_irq_load_avg(struct rq *rq, u64 running);
 #else
@@ -159,6 +169,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 }
 
 static inline int
+update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	return 0;
+}
+
+static inline int
 update_irq_load_avg(struct rq *rq, u64 running)
 {
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c7..37bd7ef 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -944,6 +944,7 @@ struct rq {
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
+	struct sched_avg	avg_thermal;
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.1.4

