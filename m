Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D685FC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B670724680
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgB0TSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:18:10 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:41420 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729418AbgB0TSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:18:09 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 15F3CCAB1D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 19:18:07 +0000 (GMT)
Received: (qmail 21014 invoked from network); 27 Feb 2020 19:18:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Feb 2020 19:18:06 -0000
Date:   Thu, 27 Feb 2020 19:18:04 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        paulmck@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/numa: Acquire RCU lock for checking idle cores during
 NUMA balancing
Message-ID: <20200227191804.GJ3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
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
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 10f9e6729fcf..1592b6d26239 100644
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
 
