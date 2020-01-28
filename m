Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A79C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1AF24683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8MjLRYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgA1Wga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:36:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41636 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA1WgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:36:22 -0500
Received: by mail-qk1-f193.google.com with SMTP id s187so15128648qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kpqHiVMo6zenVbMWFcfdR4o07ctEHjVmown2mEtCZYM=;
        b=K8MjLRYx+AFl9FBt3jbcgjU1qo6JXuAySdceatSshxnchzgA67zEGyFlsn8w5X4yda
         kfV/ZJw+5Q6sAjAyYpjFkhiWquQm/sbBfXnFRTlbNESf0/qC6661ZOmyk+56lNpgUM3E
         DMfs4recvRxd4MCkldlhtWObuWon6EBhJ7kojbWQtOI7QTlTaeiRKDKuXN44IFPgbnSp
         X+liFJinuO2AUA8Ffto02iz32g0L4no6/gN/fGyX/kLqfGc8W0NiPUP113URSZKRK7+X
         RGOMUFMKl8h/I1qwxMWvk/3zVGbPaVNuHCktkVIB5meXOdojvzqOIPJyRn42/KvbSF1m
         hm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kpqHiVMo6zenVbMWFcfdR4o07ctEHjVmown2mEtCZYM=;
        b=cm3c48Lb6uh3hm89laXYv6MAE52Ms5qK7oTkvIekjrLvMFPCuLk00703+jfgIxj8jD
         G9fubjS7owpltAGW4bNLbdGtzLfP5jw0UK5MSMAB+TUJhB4YLGn03LnNQdN+CzRxG80q
         Jhn8hUfciG32WDExOm4WDZWZ+WTbRoz8Pva6PfRDy2KUzCZP1E7UGLXteWzB681ZvecK
         rCwmE5nTdoHzrli9lgcELlck9XTofiKbzaBXjlyVSoNaBfb6UmQyJOD4l6ARJMbw+YeX
         hnCf3YnnULehdI1ktv2QEcVYXZWj1w0SeCYCwvwxlKiep39oSGryIovDO8ZbZ+4phlDB
         L36w==
X-Gm-Message-State: APjAAAU/e1ei1r3DpiLKI1RTURLC93DU/bMvO+YtFB8xYSrHjdt0B3Vg
        2/18sjzrloorAQf/pOAlDURoSA==
X-Google-Smtp-Source: APXvYqztQmdra3LGFSJagd7gFqkoHEhZIsGwyAcxg21L0Kx8pnn5Aj4fN/kJK2hNau6UBtJH9mKabA==
X-Received: by 2002:a05:620a:15d2:: with SMTP id o18mr23207081qkm.362.1580250981670;
        Tue, 28 Jan 2020 14:36:21 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 124sm13014259qko.11.2020.01.28.14.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jan 2020 14:36:21 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v9 7/8] sched/fair: Enable tuning of decay period
Date:   Tue, 28 Jan 2020 17:36:06 -0500
Message-Id: <1580250967-4386-8-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal pressure follows pelt signals which means the decay period for
thermal pressure is the default pelt decay period. Depending on soc
characteristics and thermal activity, it might be beneficial to decay
thermal pressure slower, but still in-tune with the pelt signals.  One way
to achieve this is to provide a command line parameter to set a decay
shift parameter to an integer between 0 and 10.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v8->v9:
	- Initialized the __shift to 0 in setup_sched_thermal_decay_shift
	  as per Quentin's suggestion.

 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/sched/core.c                             |  2 +-
 kernel/sched/fair.c                             | 15 ++++++++++++++-
 kernel/sched/sched.h                            | 18 ++++++++++++++++++
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e35b28e..be4147b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4376,6 +4376,11 @@
 			incurs a small amount of overhead in the scheduler
 			but is useful for debugging and performance tuning.
 
+	sched_thermal_decay_shift=
+			[KNL, SMP] Set decay shift for thermal pressure signal.
+			Format: integer between 0 and 10
+			Default is 0.
+
 	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
 			xtime_lock contention on larger systems, and/or RCU lock
 			contention on all systems with CONFIG_MAXSMP set.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b921795..508e64b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3602,7 +3602,7 @@ void scheduler_tick(void)
 
 	update_rq_clock(rq);
 	thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
-	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
+	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	calc_global_load_tick(rq);
 	psi_task_tick(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d879077..df23564 100644
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
@@ -7530,7 +7543,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
+		  update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f256cb..acd32bf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1110,6 +1110,24 @@ static inline u64 rq_clock_task(struct rq *rq)
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
-- 
2.1.4

