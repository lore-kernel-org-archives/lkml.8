Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660FEC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2752467E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCFOmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53815 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbgCFOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:19 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEB3-0006Js-Dk; Fri, 06 Mar 2020 15:42:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A71AD1C21D5;
        Fri,  6 Mar 2020 15:42:07 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:07 -0000
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Acquire RCU lock for checking idle
 cores during NUMA balancing
Cc:     Qian Cai <cai@lca.pw>, "Paul E. McKenney" <paulmck@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200227191804.GJ3818@techsingularity.net>
References: <20200227191804.GJ3818@techsingularity.net>
MIME-Version: 1.0
Message-ID: <158350572742.28353.9668880281521573284.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0621df315402dd7bc56f7272fae9778701289825
Gitweb:        https://git.kernel.org/tip/0621df315402dd7bc56f7272fae9778701289825
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Thu, 27 Feb 2020 19:18:04 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:22 +01:00

sched/numa: Acquire RCU lock for checking idle cores during NUMA balancing

Qian Cai reported the following bug:

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

Reported-by: Qian Cai <cai@lca.pw>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Fixes: ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a migration target instead of comparing tasks")
Link: https://lkml.kernel.org/r/20200227191804.GJ3818@techsingularity.net
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bba9452..3887b73 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1608,6 +1608,7 @@ static void update_numa_stats(struct task_numa_env *env,
 	memset(ns, 0, sizeof(*ns));
 	ns->idle_cpu = -1;
 
+	rcu_read_lock();
 	for_each_cpu(cpu, cpumask_of_node(nid)) {
 		struct rq *rq = cpu_rq(cpu);
 
@@ -1627,6 +1628,7 @@ static void update_numa_stats(struct task_numa_env *env,
 			idle_core = numa_idle_core(idle_core, cpu);
 		}
 	}
+	rcu_read_unlock();
 
 	ns->weight = cpumask_weight(cpumask_of_node(nid));
 
