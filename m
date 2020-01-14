Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BEEC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C067924672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snqsJvuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgANT6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:58:00 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38463 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbgANT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:57:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id c24so2818534qtp.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yfen/AoSu53olPP9ksuFCbFgbf4x6IRveD5uzGZKIms=;
        b=snqsJvuQIjL3Bm/ZNs5UWDLzKR0/9FVv+VRL0od926L1vJX6evu/XVJD+9CnRbQigj
         CUXfCeBz3sxUcVbxaPk3oFYOCyC2Mjk/U/Ip6u5rKhOlCLITUk3cwdg/P5DABXDbJ69k
         TLiuPmrgwjtV0IEfGGzS/UvYttBrJpTgQjdbph1HAUuLBWls8VK+VG5p9bLW/aFGGrkF
         AZMAQzWFRjDYWHg3S0bZO299wKqQZ9lH2diCazsHRlXn7P7wG2mFJTQzz2Yn8lg13jX9
         xc2lsnMmNweWxapU2n++mTW4aShDZF4W/f3IOR+Kj1v/PDrakK2+liCoKatdoJ8yvPXS
         bcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yfen/AoSu53olPP9ksuFCbFgbf4x6IRveD5uzGZKIms=;
        b=K6XPyTK2CoKjS6Ih0SiS+HXxYwbDC8n/MtrNuyRWP1nSLIfKVc1DLyBXb1tUsiikn2
         jp/mn9vy/nY9wuQoeIS97jhw5Kpr4eWfxIENMi5IdvsvEOlF+TkuQOEYmg3rKGkrxV5p
         qVf42qqRoad94dzDzPKlDHWjS3zwN0f65gPrlJmZB5Vn6i/8EA6BGuWxnOW7tSOwF5Aw
         /S8CNoBajzm6okT4vrPADl0DOuyoj5f0QdDdYLR+E9CJZcLYwsrm39914zzsFLmU9j1/
         bZvIJ3At17xiy8joU+4lOrNr/VpPa4k9ml2/K0kA+ZkHt1mkqxHsZnGsor3WuGhWy6Gq
         BtLw==
X-Gm-Message-State: APjAAAWxN8IRCAauq79YWqWxuk4WdtYiOHH+wywVtesrKzAYrqw/CtIZ
        NZC6Zxf1YfBotAe65xPzGr9viQ==
X-Google-Smtp-Source: APXvYqz0t6OIqPrDyq+aZGCcSp10zYfP07jDaLy7U1+HH76GlDTN7Kcvmc/wYCCYKL3IaiPIrKCZog==
X-Received: by 2002:ac8:1194:: with SMTP id d20mr230530qtj.243.1579031875611;
        Tue, 14 Jan 2020 11:57:55 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id b81sm7183497qkc.135.2020.01.14.11.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jan 2020 11:57:55 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v8 7/7] sched/fair: Enable tuning of decay period
Date:   Tue, 14 Jan 2020 14:57:39 -0500
Message-Id: <1579031859-18692-8-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
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
 Documentation/admin-guide/kernel-parameters.txt |  5 ++++
 kernel/sched/fair.c                             | 34 +++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dd3df3d..34848e4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4370,6 +4370,11 @@
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
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2b1fec3..8b2ee5a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -86,6 +86,36 @@ static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
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
+static int sched_thermal_decay_shift;
+
+static inline u64 rq_clock_thermal(struct rq *rq)
+{
+	return rq_clock_task(rq) >> sched_thermal_decay_shift;
+}
+
+static int __init setup_sched_thermal_decay_shift(char *str)
+{
+	int _shift;
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
@@ -7509,7 +7539,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_thermal_load_avg(rq_clock_task(rq), rq,
+		  update_thermal_load_avg(rq_clock_thermal(rq), rq,
 					  thermal_pressure) 			|
 		  update_irq_load_avg(rq, 0);
 
@@ -10300,7 +10330,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
-	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
+	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
 }
 
 /*
-- 
2.1.4

