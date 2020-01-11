Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD639C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3416206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rM+Ri7D0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgAKP7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 10:59:19 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37597 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbgAKP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 10:59:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so4810010qky.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 07:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D0skf/6By7/rqfJ4BHcoMon/wG4Iy6pSq8JDg2nxI/M=;
        b=rM+Ri7D05rcqzEAJiP6RRb/+gp17e21RBanp8BmDlGQ7ILWK9lApyI+aL8hVN/+reJ
         8qylAxre5bWQqQRCfP30Zz7/psf5fA5KhKkiphgldNxHWjx42+bDQPpXBH43DMDaAciK
         17GDTtAUN6DxdV6VboR8cw/c7HqZgjRZYlGU/PTt2Ps5rTS1b57D9SYVuTYWr6Kd57a6
         av04RlTL2FFrnTpfkpsAToG1Ui36kH+UA1h10j95J3U0r1WAfXehvcXJkPuAbsfWjEhS
         k/vtT1B17SfsIyrMmKhwHB+k2Pj8zhr87SlvFPeNoddhBzfz/GlWdMaxSfFUqoYtpQzg
         ng+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D0skf/6By7/rqfJ4BHcoMon/wG4Iy6pSq8JDg2nxI/M=;
        b=GvPd+Bz2Z2EEbVBskCCdKqfrW/KGBJhBKsF09GCITgxvEAgy6snrGCVek3/XmLbS04
         902YaLFQeDKn1NEGLSkJpikjf2VA3jye/aYSJe6uw3iE9krvau2Uzmb+HSeK1N3xInbv
         3Zo8IYRtkAZx54L/Yed9Y8h5s0+d0Us5FSeJkBJ279g0CWiclcU+576XMKqjWsbK6iTl
         1D9GxdPfZaSIZFC2Ul+HxYwnBM5v7cbzwRejNkagj+3RkhqUq6S6TCPTiWdsbEGoG8rG
         k2RUq5I0zXcZ4tLtmb7DpyAGQjIzAdtWmmmhrje809IBv3DLG024PlEnJvdnbZ3xXUMv
         Xj4A==
X-Gm-Message-State: APjAAAXMkmia39j1CXTEbyTicUnB6wkOxxOHMvhNbFFAn5sj3UB6cnpo
        gE9NGt0a9bB2FCGmBvSG0k+TnQ==
X-Google-Smtp-Source: APXvYqyhZeYnPxyXhqBJUK9R+sFv6B2Gjmsl3Zb/WriSouhWTLWc+FDU+EEnl6Pa9t+J/cLZ/otJ/g==
X-Received: by 2002:a05:620a:791:: with SMTP id 17mr8488609qka.31.1578758354943;
        Sat, 11 Jan 2020 07:59:14 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id l49sm2843478qtk.7.2020.01.11.07.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Jan 2020 07:59:14 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v7 4/7] sched/fair: Enable periodic update of average thermal pressure
Date:   Sat, 11 Jan 2020 10:59:03 -0500
Message-Id: <1578758346-507-5-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1578758346-507-1-git-send-email-thara.gopinath@linaro.org>
References: <1578758346-507-1-git-send-email-thara.gopinath@linaro.org>
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

