Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36620C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA22206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgGFTfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:35:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:61214 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFTfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:35:33 -0400
IronPort-SDR: Cw7307QVQ4ewAOVMEyoiGMa1RK/0fJ9PsQrUjJBSBMdFAmfegzih4I8AFdGWi5lc6zEhq0iWk7
 OGhebs40zXuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212469587"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="212469587"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 12:35:33 -0700
IronPort-SDR: BV3MTMeSa7ZSVfIrR1qQpNJ01pAY/1saVEuR6QjRfRtE+w9Lc5meCdJlYKaPB/4ZtzFPvI6x76
 1MNGGF3Yf1aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="482805193"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jul 2020 12:35:30 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][RFC] sched/topology: Add update_domain_cpu()
Date:   Tue,  7 Jul 2020 03:36:41 +0800
Message-Id: <d06455426aecadd7c7751ed0a5bd24d1bd54422c.1594062828.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1594062828.git.yu.c.chen@intel.com>
References: <cover.1594062828.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce update_domain_cpu(), which is a wrapper of
update_top_cache_domain(). In update_domain_cpu() the
cpu hotplug lock is to protect against the rebuild of
sched domain, and the rcu read lock is to protect against
the dereference of domain tree(rq->sd) in update_top_cache_domain().
This patch is to prepare for the next patch to update the
flags of sched domain via sysctl.

No intentional functional impact.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched/topology.h |  5 +++++
 kernel/sched/topology.c        | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index fb11091129b3..dc81736090e3 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -161,6 +161,7 @@ cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
 void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
 
 bool cpus_share_cache(int this_cpu, int that_cpu);
+void update_domain_cpu(int cpu);
 
 typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
 typedef int (*sched_domain_flags_f)(void);
@@ -214,6 +215,10 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 	return true;
 }
 
+static inline void update_domain_cpu(int cpu)
+{
+}
+
 #endif	/* !CONFIG_SMP */
 
 #ifndef arch_scale_cpu_capacity
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ba81187bb7af..495b65367a12 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -651,6 +651,17 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
+void update_domain_cpu(int cpu)
+{
+	/* Protect against sched domain rebuild. */
+	get_online_cpus();
+	/* Guard read-side sched domain dereference. */
+	rcu_read_lock();
+	update_top_cache_domain(cpu);
+	rcu_read_unlock();
+	put_online_cpus();
+}
+
 /*
  * Attach the domain 'sd' to 'cpu' as its base domain. Callers must
  * hold the hotplug lock.
-- 
2.17.1

