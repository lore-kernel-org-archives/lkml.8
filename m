Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7FAC35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B829F206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ob7s8eKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgBVAwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:52:36 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42916 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgBVAw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:52:28 -0500
Received: by mail-qv1-f65.google.com with SMTP id dc14so1794937qvb.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAQF5ZDVNMZbeHaYGSomVWZS84RJ+K8mXzXhYs96H3A=;
        b=ob7s8eKdRzuIfCLK11osjD3uvs+SrJEUCHWadWxu3dijYZwsnmgWZztyFAolW37eLr
         N7rFclyVFx0P30Aoz7sC46OqH3HTLuOWQds8Mq482pj1vGpc1mScAXMeLcdPPl8K2Jwy
         5ELsDqr/mg6vLZdhHxuLCttP+YvuGIg6Ht4/6XgWb1wqgPO81M13weYplKJ96jrD/Cai
         y3fZ4JYHf8Y0/hRWrAT4k1hYE5dr/Zc31rq5P8mtnnmlapG8A9oOsdw9MMoNLw8CLQG+
         8NN8IQ1DVPc8JQqA6Ai4R05b+j0ZlnZuk44UZoHxfGaCUUEe5dtZWmC5y6wVvlNt3O/3
         oJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAQF5ZDVNMZbeHaYGSomVWZS84RJ+K8mXzXhYs96H3A=;
        b=HHtqJL6D8zRrCvpxVOOagASugcBxi0/IhTZXH21kn+nbYs3rANir8HLvTaycOCNWB3
         X39bpt3iT68mteANVOOMYIQkCBbRq3nkztc8v3TdJD7I6CkqKSSuezIyleuYqQGwsWUB
         HvZORffZXPBkToBB/OpAxsIm5F1YsEUdRX55x9QXXODSKwUDEiGrrG5Ko767+FD7zg5+
         Fu0ese44k9g3VdYmCDr/M3mxd6l21pV5toTQ3y8uKpRp+P4zExgEBBOt8QcxhN6sHUPR
         G+wGsjgm+nruEA6sOijw8QSNmYlT539zrd4BRgls/h+Y4rDwqqFphO4L+rU2HY2ayR7H
         Qzqw==
X-Gm-Message-State: APjAAAXoi/JY/pJsu+XDSqRKOWjdtYRqdjN6CKCM+4dPYzQiUZiaCdBT
        hdsqlg6oF5Kxsw/7R/daLmEiaA==
X-Google-Smtp-Source: APXvYqxGYXCgRBB9YnM6QD+ED/aPRbAafg8fZ++cq8l+Ypx7MdzpGgFciEZmBP+m30kbkcpCZoc/Sw==
X-Received: by 2002:a0c:f8c6:: with SMTP id h6mr33610352qvo.239.1582332748073;
        Fri, 21 Feb 2020 16:52:28 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 12sm359559qkj.136.2020.02.21.16.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:52:27 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v10 9/9] sched/fair: Enable tuning of decay period
Date:   Fri, 21 Feb 2020 19:52:13 -0500
Message-Id: <20200222005213.3873-10-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222005213.3873-1-thara.gopinath@linaro.org>
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
v9->v10:
	- Added description for sched_thermal_decay_shift in
	  kernel-parameters.txt following Randy's review comments.

 .../admin-guide/kernel-parameters.txt          | 16 ++++++++++++++++
 kernel/sched/core.c                            |  2 +-
 kernel/sched/fair.c                            | 15 ++++++++++++++-
 kernel/sched/sched.h                           | 18 ++++++++++++++++++
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c7f407eb22d3..7cf12c611fe0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4393,6 +4393,22 @@
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
index 160b5e9e8945..166a3edfad5f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3597,7 +3597,7 @@ void scheduler_tick(void)
 
 	update_rq_clock(rq);
 	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
-	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
+	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	calc_global_load_tick(rq);
 	psi_task_tick(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 10e867e540ab..454d7735764e 100644
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
@@ -7577,7 +7590,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
+		  update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 211411ac0efa..e6312662679d 100644
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
2.20.1

