Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EAAC4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EABA2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgCKSRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:17:13 -0400
Received: from foss.arm.com ([217.140.110.172]:53276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730847AbgCKSRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:17:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E01C61063;
        Wed, 11 Mar 2020 11:17:06 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 074853F6CF;
        Wed, 11 Mar 2020 11:17:05 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [PATCH v2 9/9] sched/topology: Define and use shortcut pointers for wakeup sd_flag scan
Date:   Wed, 11 Mar 2020 18:16:01 +0000
Message-Id: <20200311181601.18314-10-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200311181601.18314-1-valentin.schneider@arm.com>
References: <20200311181601.18314-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reworking select_task_rq_fair()'s domain walk exposed that !want_affine
wakeups only look for highest sched_domain with the required sd_flag
set. This is something we can cache at sched domain build time to slightly
optimize select_task_rq_fair(). Note that this isn't a "free" optimization:
it costs us 3 pointers per CPU.

Add cached per-CPU pointers for the highest domains with SD_BALANCE_WAKE,
SD_BALANCE_EXEC and SD_BALANCE_FORK. Use them in select_task_rq_fair().

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c     | 25 +++++++++++++------------
 kernel/sched/sched.h    |  3 +++
 kernel/sched/topology.c | 12 ++++++++++++
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a6fca6817e92..40fb97062157 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6595,17 +6595,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	int want_affine = 0;
 	int sd_flag;
 
-	switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
-	case WF_TTWU:
-		sd_flag = SD_BALANCE_WAKE;
-		break;
-	case WF_FORK:
-		sd_flag = SD_BALANCE_FORK;
-		break;
-	default:
-		sd_flag = SD_BALANCE_EXEC;
-	}
-
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
@@ -6621,7 +6610,19 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 
 	rcu_read_lock();
 
-	sd = highest_flag_domain(cpu, sd_flag);
+	switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
+	case WF_TTWU:
+		sd_flag = SD_BALANCE_WAKE;
+		sd = rcu_dereference(per_cpu(sd_balance_wake, cpu));
+		break;
+	case WF_FORK:
+		sd_flag = SD_BALANCE_FORK;
+		sd = rcu_dereference(per_cpu(sd_balance_fork, cpu));
+		break;
+	default:
+		sd_flag = SD_BALANCE_EXEC;
+		sd = rcu_dereference(per_cpu(sd_balance_exec, cpu));
+	}
 
 	/*
 	 * If !want_affine, we just look for the highest domain where
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ad2106245e12..3a0e38f2f713 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1393,6 +1393,9 @@ DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_balance_wake);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_balance_fork);
+DECLARE_PER_CPU(struct sched_domain __rcu *, sd_balance_exec);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6077b23f9723..0270252a964b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -610,6 +610,9 @@ DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_balance_wake);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_balance_fork);
+DEFINE_PER_CPU(struct sched_domain __rcu *, sd_balance_exec);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
@@ -636,6 +639,15 @@ static void update_top_cache_domain(int cpu)
 	sd = lowest_flag_domain(cpu, SD_NUMA);
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
 
+	sd = highest_flag_domain(cpu, SD_BALANCE_WAKE);
+	rcu_assign_pointer(per_cpu(sd_balance_wake, cpu), sd);
+
+	sd = highest_flag_domain(cpu, SD_BALANCE_FORK);
+	rcu_assign_pointer(per_cpu(sd_balance_fork, cpu), sd);
+
+	sd = highest_flag_domain(cpu, SD_BALANCE_EXEC);
+	rcu_assign_pointer(per_cpu(sd_balance_exec, cpu), sd);
+
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
 	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
 
-- 
2.24.0

