Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5759C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1417214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehLXECDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgA1WgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:36:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36487 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgA1WgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:36:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id w25so9452401qki.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sINAUo2AMmS2CvfWX14jb7B4+XN4TP06PCpwgnlE4uQ=;
        b=ehLXECDHvJg5B1S2iemghebvLkwXAkmCBefa415il0PjOJqpYr3w3sn783FBLraZVp
         P8FsFELd4utpxFcCdjkMrxsUnUNHANttxo7oop9ahcU0BmtgJ/hUJbo2pM4kPP2mdG64
         HGMg5O3O3Yxx43hLdzSsOMWErtauwQI3B21aDEgCe6QVOnJPT5a0Av8mPwdtrrQCl/Fm
         0BpyPQg+A/HqWjSoshW9iMJxqVtEhBxmGfjr9KUB8p/CLmmy8qGTiwstMhLVWoEoJzK5
         MCeeH6wFNr21/2LeQFfLSJJ7AwgiV5OLQ0lBULjU/pVdIgAin4C1k19ojKBv1rGYHX3o
         p9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sINAUo2AMmS2CvfWX14jb7B4+XN4TP06PCpwgnlE4uQ=;
        b=WlgEJfWqeDykfGFJgby5HYmkxQGZgrs4zgejkaeZLxm/t4zoSi7AEsW4pAJR2aP2ud
         m5gc/ozeGq9AyqxjKOzPsaJz9TiWo/dU0FeIC0Efm1x+3IYVnxFf3JntznHHpK5RUxVE
         UA4qNfcTAkNcnyzbpY0lAnf9VfrUnLw47U6dAKxrWxVLdUEdsBlqTyDiX1vGkmJoap8N
         8DXXd+eqpbJz9iVRgTdXVHQ2FbaFAgYYvqvkKh/LOSKScwmQsvYKoGSuSxMFaWYfqa1+
         An0nhrXr4+mzCmz8Lr0AHDc9YAM+GyiI2S3ixr+RuBi7CmAtYvjJCV4y1jkjOhI2bg19
         VPzQ==
X-Gm-Message-State: APjAAAXCBYkAC37LEpfNQ9aaaPpFSm2tWX7OB5LM8CAnbalTSiLM2N3U
        s5L8SJIOHEunYNdcd26s2z7ELw==
X-Google-Smtp-Source: APXvYqxiVRwxjeo9k/cV0WxRsnp0wE2/ZalIGx3HH7y4BNRgZ52ZwI2FvT49RW+kLagcGRdIIkvkzQ==
X-Received: by 2002:a37:64d5:: with SMTP id y204mr24334150qkb.459.1580250976571;
        Tue, 28 Jan 2020 14:36:16 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 124sm13014259qko.11.2020.01.28.14.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jan 2020 14:36:15 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v9 4/8] sched/fair: Enable periodic update of average thermal pressure
Date:   Tue, 28 Jan 2020 17:36:03 -0500
Message-Id: <1580250967-4386-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
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
	  tick function to generic scheduler core tick function.

 kernel/sched/core.c | 3 +++
 kernel/sched/fair.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc1dfc0..b921795 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3594,12 +3594,15 @@ void scheduler_tick(void)
 	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *curr = rq->curr;
 	struct rq_flags rf;
+	unsigned long thermal_pressure;
 
 	sched_clock_tick();
 
 	rq_lock(rq, &rf);
 
 	update_rq_clock(rq);
+	thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
+	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	calc_global_load_tick(rq);
 	psi_task_tick(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ebf5095..5f58c03 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7491,6 +7491,9 @@ static inline bool others_have_blocked(struct rq *rq)
 	if (READ_ONCE(rq->avg_dl.util_avg))
 		return true;
 
+	if (thermal_load_avg(rq))
+		return true;
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	if (READ_ONCE(rq->avg_irq.util_avg))
 		return true;
@@ -7516,6 +7519,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 {
 	const struct sched_class *curr_class;
 	u64 now = rq_clock_pelt(rq);
+	unsigned long thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
 	bool decayed;
 
 	/*
@@ -7526,6 +7530,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
+		  update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
-- 
2.1.4

