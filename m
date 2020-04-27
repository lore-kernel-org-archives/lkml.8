Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34500C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED8C2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgD0Ihg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:37:36 -0400
Received: from foss.arm.com ([217.140.110.172]:59878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgD0Ihf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:37:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 097CE1063;
        Mon, 27 Apr 2020 01:37:35 -0700 (PDT)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D6E13F68F;
        Mon, 27 Apr 2020 01:37:31 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] sched/topology: Store root domain CPU capacity sum
Date:   Mon, 27 Apr 2020 10:37:04 +0200
Message-Id: <20200427083709.30262-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427083709.30262-1-dietmar.eggemann@arm.com>
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sum of (original) CPU capacity of all member CPUs to root domain.

This is needed for capacity-aware SCHED_DEADLINE admission control.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..58e1d3903ab9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -803,6 +803,7 @@ struct root_domain {
 	cpumask_var_t		rto_mask;
 	struct cpupri		cpupri;
 
+	unsigned long           sum_cpu_capacity;
 	unsigned long		max_cpu_capacity;
 
 	/*
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8344757bba6e..fbb20b7a80c0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2052,12 +2052,18 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	/* Attach the domains */
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map) {
+		unsigned long cap;
+
 		rq = cpu_rq(i);
 		sd = *per_cpu_ptr(d.sd, i);
+		cap = rq->cpu_capacity_orig;
 
 		/* Use READ_ONCE()/WRITE_ONCE() to avoid load/store tearing: */
-		if (rq->cpu_capacity_orig > READ_ONCE(d.rd->max_cpu_capacity))
-			WRITE_ONCE(d.rd->max_cpu_capacity, rq->cpu_capacity_orig);
+		if (cap > READ_ONCE(d.rd->max_cpu_capacity))
+			WRITE_ONCE(d.rd->max_cpu_capacity, cap);
+
+		WRITE_ONCE(d.rd->sum_cpu_capacity,
+			   READ_ONCE(d.rd->sum_cpu_capacity) + cap);
 
 		cpu_attach_domain(sd, d.rd, i);
 	}
@@ -2067,8 +2073,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
 
 	if (rq && sched_debug_enabled) {
-		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
-			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
+		pr_info("root domain span: %*pbl (capacity = %lu max cpu_capacity = %lu)\n",
+			cpumask_pr_args(cpu_map), rq->rd->sum_cpu_capacity,
+			rq->rd->max_cpu_capacity);
 	}
 
 	ret = 0;
-- 
2.17.1

