Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEC0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5912072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbgAXNDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:03:54 -0500
Received: from foss.arm.com ([217.140.110.172]:51472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388993AbgAXNDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:03:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98D5F1063;
        Fri, 24 Jan 2020 05:03:47 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6524B3F68E;
        Fri, 24 Jan 2020 05:03:46 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org
Subject: [PATCH v2 3/3] sched/fair: Kill wake_cap()
Date:   Fri, 24 Jan 2020 13:02:13 +0000
Message-Id: <20200124130213.24886-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200124130213.24886-1-valentin.schneider@arm.com>
References: <20200124130213.24886-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morten Rasmussen <morten.rasmussen@arm.com>

Capacity-awareness in the wake-up path previously involved disabling
wake_affine in certain scenarios. We have just made select_idle_sibling()
capacity-aware, so this isn't needed anymore.

Remove wake_cap() entirely.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
[Changelog tweaks]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c44b135f61ad0..8097a279ee7dd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6124,33 +6124,6 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 	return min_t(unsigned long, util, capacity_orig_of(cpu));
 }
 
-/*
- * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
- * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
- *
- * In that case WAKE_AFFINE doesn't make sense and we'll let
- * BALANCE_WAKE sort things out.
- */
-static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
-{
-	long min_cap, max_cap;
-
-	if (!static_branch_unlikely(&sched_asym_cpucapacity))
-		return 0;
-
-	min_cap = min(capacity_orig_of(prev_cpu), capacity_orig_of(cpu));
-	max_cap = cpu_rq(cpu)->rd->max_cpu_capacity;
-
-	/* Minimum capacity is close to max, no need to abort wake_affine */
-	if (max_cap - min_cap < max_cap >> 3)
-		return 0;
-
-	/* Bring task utilization in sync with prev_cpu */
-	sync_entity_load_avg(&p->se);
-
-	return !task_fits_capacity(p, min_cap);
-}
-
 /*
  * Predicts what cpu_util(@cpu) would return if @p was migrated (and enqueued)
  * to @dst_cpu.
@@ -6415,8 +6388,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 			new_cpu = prev_cpu;
 		}
 
-		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu) &&
-			      cpumask_test_cpu(cpu, p->cpus_ptr);
+		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
 	}
 
 	rcu_read_lock();
-- 
2.24.0

