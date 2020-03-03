Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2930BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CD320848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgCCLDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:03:43 -0500
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:58515 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728068AbgCCLDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:03:43 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id C0417FA80D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Mar 2020 11:03:41 +0000 (GMT)
Received: (qmail 16414 invoked from network); 3 Mar 2020 11:03:41 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 3 Mar 2020 11:03:41 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Paul McKenney <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/3] sched/numa: Acquire RCU lock when checking idle cores during NUMA balancing
Date:   Tue,  3 Mar 2020 11:02:58 +0000
Message-Id: <20200303110258.1092-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303110258.1092-1-mgorman@techsingularity.net>
References: <20200303110258.1092-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai reported the following

  The linux-next commit ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a
migration target instead of comparing tasks") introduced a boot warning,

  [   86.520534][    T1] WARNING: suspicious RCU usage
  [   86.520540][    T1] 5.6.0-rc3-next-20200227 #7 Not tainted
  [   86.520545][    T1] -----------------------------
  [   86.520551][    T1] kernel/sched/fair.c:5914 suspicious rcu_dereference_check() usage!
  [   86.520555][    T1]
  [   86.520555][    T1] other info that might help us debug this:
  [   86.520555][    T1]
  [   86.520561][    T1]
  [   86.520561][    T1] rcu_scheduler_active = 2, debug_locks = 1
  [   86.520567][    T1] 1 lock held by systemd/1:
  [   86.520571][    T1]  #0: ffff8887f4b14848 (&mm->mmap_sem#2){++++}, at: do_page_fault+0x1d2/0x998
  [   86.520594][    T1]
  [   86.520594][    T1] stack backtrace:
  [   86.520602][    T1] CPU: 1 PID: 1 Comm: systemd Not tainted 5.6.0-rc3-next-20200227 #7

task_numa_migrate() checks for idle cores when updating NUMA-related statistics.
This relies on reading a RCU-protected structure in test_idle_cores() via this
call chain

task_numa_migrate
  -> update_numa_stats
    -> numa_idle_core
      -> test_idle_cores

While the locking could be fine-grained, it is more appropriate to acquire
the RCU lock for the entire scan of the domain. This patch removes the
warning triggered at boot time.

Fixes: ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a migration target instead of comparing tasks")
Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33622bbfcea7..23a6fe298720 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1595,6 +1595,7 @@ static void update_numa_stats(struct task_numa_env *env,
 	memset(ns, 0, sizeof(*ns));
 	ns->idle_cpu = -1;
 
+	rcu_read_lock();
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		struct rq *rq = cpu_rq(cpu);
 
@@ -1614,6 +1615,7 @@ static void update_numa_stats(struct task_numa_env *env,
 			idle_core = numa_idle_core(idle_core, cpu);
 		}
 	}
+	rcu_read_unlock();
 
 	ns->weight = cpumask_weight(cpumask_of_node(nid));
 
-- 
2.16.4

