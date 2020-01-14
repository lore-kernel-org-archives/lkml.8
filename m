Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611BFC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A54E24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+HAAWqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgANT5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:57:53 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43154 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgANT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:57:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so13581138qtj.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D0skf/6By7/rqfJ4BHcoMon/wG4Iy6pSq8JDg2nxI/M=;
        b=y+HAAWqWNOZ8iYPKBST7TKp8xvS29vpdjc3VJNuLHXm+CQwifHOAcDRI7i34dmcJgF
         jVq+csa77pceFTHmVv1c6+Cyf/Y2krfYWdykp5CXfey+c9NEK5SVOBDf4LGXOB7HLXB9
         QQzVbtQQKOWRtcgL+yvn6mnp0TuQm7bj11S8EhwKp3Mj/GnwfbeecUbK3WVTWexxipeP
         Xp3RkATUWXTvhP0rpkys30ScGDjgfo5tDic+FcJVciLUmD6ij3+SUVVxp+WVHQyQx2e+
         WtI5IVWhlZS/Qxsr7GK0rhVSHc/wrlsaOG3F+W3VhJtuRUbWpuFW+Rg/peb4mOV/NHBb
         A0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D0skf/6By7/rqfJ4BHcoMon/wG4Iy6pSq8JDg2nxI/M=;
        b=O9dcJU9FbI7V0wdQbqEyXnNsvqm5PPwwcaSuTxVIZabUFctI8r2cArUqGxZFELS9zw
         LGdJ83KMGJt/4CVaGl+ko/Suyrq10dNkSs/JTT9XwPFgzUWxoZHjolk9vrpHfDbAIs64
         boQ/rnBUnFbI9gWdKzUwy5hsfVyD4i1kmlCtLIsPzQL8As5dGvxWScVYzu9sjWyv3K7M
         bLxATvfRX+PM1Vtvsjqm/CIF+n+ZXPYcq7r6BPf2Dw2utjsL6MCxooLVmKq3JMv9HtHF
         P3wUyZ4OxMKEYDmq3tBQukeFnePHCDT0kHZ62o9iUBXFEB8G1FpOc9CgOyw8yUzNVbQJ
         cVuA==
X-Gm-Message-State: APjAAAXw9A5xBYr+5tPXeAU5usQAMqJSQZgiVZPZcRRNElC2ua4AwD5A
        SxEgfziy8MtdPlSdazGduGKvuA==
X-Google-Smtp-Source: APXvYqxfS1LrTPVKpQ8yGbqnCXmadDYhDoHKxZ0X3wm6x9sxk08+zVMxUznHHXVpvu4YfXbKIG+fBg==
X-Received: by 2002:ac8:958:: with SMTP id z24mr298822qth.40.1579031870419;
        Tue, 14 Jan 2020 11:57:50 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id b81sm7183497qkc.135.2020.01.14.11.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jan 2020 11:57:49 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v8 4/7] sched/fair: Enable periodic update of average thermal pressure
Date:   Tue, 14 Jan 2020 14:57:36 -0500
Message-Id: <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support in CFS periodic tick and other bookkeeping apis
to trigger the process of computing average thermal pressure for a
cpu. Also consider avg_thermal.load_avg in others_have_blocked
which allows for decay of pelt signals.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8da0222..311bb0b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7470,6 +7470,9 @@ static inline bool others_have_blocked(struct rq *rq)
 	if (READ_ONCE(rq->avg_dl.util_avg))
 		return true;
 
+	if (READ_ONCE(rq->avg_thermal.load_avg))
+		return true;
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	if (READ_ONCE(rq->avg_irq.util_avg))
 		return true;
@@ -7495,6 +7498,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 {
 	const struct sched_class *curr_class;
 	u64 now = rq_clock_pelt(rq);
+	unsigned long thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
 	bool decayed;
 
 	/*
@@ -7505,6 +7509,8 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
+		  update_thermal_load_avg(rq_clock_task(rq), rq,
+					  thermal_pressure) 			|
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
@@ -10275,6 +10281,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &curr->se;
+	unsigned long thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
@@ -10286,6 +10293,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	update_misfit_status(curr, rq);
 	update_overutilized_status(task_rq(curr));
+	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
 }
 
 /*
-- 
2.1.4

