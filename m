Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A81C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B558720753
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgDHJu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:50:29 -0400
Received: from foss.arm.com ([217.140.110.172]:36290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDHJu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:50:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CAF41045;
        Wed,  8 Apr 2020 02:50:28 -0700 (PDT)
Received: from macbook.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDDEA3F73D;
        Wed,  8 Apr 2020 02:50:25 -0700 (PDT)
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
Subject: [PATCH 1/4] sched/topology: Store root domain CPU capacity sum
Date:   Wed,  8 Apr 2020 11:50:09 +0200
Message-Id: <20200408095012.3819-2-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408095012.3819-1-dietmar.eggemann@arm.com>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the sum of (original) CPU capacity of all member CPUs to the root
domain.

This is needed for capacity-aware SCHED_DEADLINE admission control.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/sched.h    | 11 +++++++++++
 kernel/sched/topology.c | 14 ++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1e72d1b3d3ce..91bd0cb0c529 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -797,6 +797,7 @@ struct root_domain {
 	cpumask_var_t		rto_mask;
 	struct cpupri		cpupri;
 
+	unsigned long           sum_cpu_capacity;
 	unsigned long		max_cpu_capacity;
 
 	/*
@@ -2393,6 +2394,16 @@ static inline unsigned long capacity_orig_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity_orig;
 }
+
+static inline unsigned long rd_capacity(int cpu)
+{
+	return cpu_rq(cpu)->rd->sum_cpu_capacity;
+}
+#else
+static inline unsigned long rd_capacity(int cpu)
+{
+	return SCHED_CAPACITY_SCALE;
+}
 #endif
 
 /**
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8344757bba6e..74b0c0fa4b1b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2052,12 +2052,17 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	/* Attach the domains */
 	rcu_read_lock();
 	for_each_cpu(i, cpu_map) {
+		unsigned long cap = arch_scale_cpu_capacity(i);
+
 		rq = cpu_rq(i);
 		sd = *per_cpu_ptr(d.sd, i);
 
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
@@ -2067,8 +2072,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
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

