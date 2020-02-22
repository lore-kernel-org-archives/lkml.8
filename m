Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E882FC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2BF206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L7vtnjOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBVAw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:52:27 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37910 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgBVAwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:52:24 -0500
Received: by mail-qt1-f195.google.com with SMTP id i23so2659634qtr.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 16:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6AZebL7Sh8tHCoBLDF/73E6NQ4SpBPEYakN7cz0vLpc=;
        b=L7vtnjOMFOugLgUpCh1nUW98fEphKU9qy/ARk8G6fPbTKl0XPMeQk6soHTWQ59puhn
         YwqZPd2GhnStmcNyHO5V+0rwTFMy+4YHcDLZreMZ2mCXB2orpzRpmsQIayjhAAmGk3Bl
         jUEsazRVB5WSWLXivjy2B1jo9veugZ2pQ8UCcEYhrTj2tjuUCXOMjJM+kmID58F0/hQ6
         +pRj30UROuAbcNzkEW93KNK9uYJYUhz7ba9LzBzuGsvT9KkCsDVxQeMO3U1PN3Sibtdq
         4Oxq7HGX43pNxY7MEw3HVc/5H67MrwqVI50vFyLLxhWQPUPxjBrdzT1lNgyXLacHtAHk
         a9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6AZebL7Sh8tHCoBLDF/73E6NQ4SpBPEYakN7cz0vLpc=;
        b=PJVJDSEhMQq2XkJFMFhreo3jDoXF8H49cN8z/bqVRnZkEh/ULhjjiTb4QaD05Psx3k
         JvRLWac8hOAkH0Xb2Fu7/UYKoMMGs/YhRV6cjb8zhpfyy1DzCj/3m2TRKgsjR6se/KwE
         DNHi+hGNXBOB+C9RZmVgmeDaW5E04/eycZE3/hDEfG7qSh9nzopxzcaXZ2ecOdhhQILO
         ZHc55B+WsM9yueFrkFIpKxAo45B8f/jp586a/Finnc1MR5wLY3E7C3KXIvKrAiccW+3E
         ZoNKaH/GN9ytCDsn3DlvJQ6y2mEU7/0TaOc7fBOU1E1b1rhcA1rMU4ptyCsLpvuuLJwR
         U5oQ==
X-Gm-Message-State: APjAAAXFlC55g0yM2bn6rVgWd8nS+k5N9Ji54dX2L6Tp4ZqPNUP+fvly
        oPyqqxv3bkgJeZNg7zh8v9Aikg==
X-Google-Smtp-Source: APXvYqzss8GyRdJA34Hn1YaCUOpGoLxo0T+NrKDzZJJdH0NOXdOESZiPIQpyg9p1JjZGlyLeL8LeOQ==
X-Received: by 2002:ac8:3fc3:: with SMTP id v3mr25144710qtk.367.1582332743926;
        Fri, 21 Feb 2020 16:52:23 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 12sm359559qkj.136.2020.02.21.16.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 16:52:23 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v10 6/9] sched/fair: Enable periodic update of average thermal pressure
Date:   Fri, 21 Feb 2020 19:52:10 -0500
Message-Id: <20200222005213.3873-7-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222005213.3873-1-thara.gopinath@linaro.org>
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support in scheduler periodic tick and other CFS bookkeeping
apis to trigger the process of computing average thermal pressure for a
cpu. Also consider avg_thermal.load_avg in others_have_blocked which
allows for decay of pelt signals.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v8->v9:
	- Moved periodic triggering of thermal pressure averaging from CFS
	  tick function to generic scheduler core tick function as per
	  Peter's review comments.

 kernel/sched/core.c | 3 +++
 kernel/sched/fair.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e94819d573be..160b5e9e8945 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3588,6 +3588,7 @@ void scheduler_tick(void)
 	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
+	unsigned long thermal_pressure;
 
 	arch_scale_freq_tick();
 	sched_clock_tick();
@@ -3595,6 +3596,8 @@ void scheduler_tick(void)
 	rq_lock(rq, &rf);
 
 	update_rq_clock(rq);
+	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
+	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	calc_global_load_tick(rq);
 	psi_task_tick(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f38ff5a335d3..00b21a5b71f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7536,6 +7536,9 @@ static inline bool others_have_blocked(struct rq *rq)
 	if (READ_ONCE(rq->avg_dl.util_avg))
 		return true;
 
+	if (thermal_load_avg(rq))
+		return true;
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	if (READ_ONCE(rq->avg_irq.util_avg))
 		return true;
@@ -7561,6 +7564,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 {
 	const struct sched_class *curr_class;
 	u64 now = rq_clock_pelt(rq);
+	unsigned long thermal_pressure;
 	bool decayed;
 
 	/*
@@ -7569,8 +7573,11 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	 */
 	curr_class = rq->curr->sched_class;
 
+	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
+
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
+		  update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
-- 
2.20.1

