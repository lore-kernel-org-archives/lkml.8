Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD90CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63F020675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGFTfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:35:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:27867 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFTfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:35:50 -0400
IronPort-SDR: DcnhaeebATSmZVDtUu7Nsr03Qwv3Gi65R4RUN+HEq5ituXm0NzJCk+lKw1TffmxJUipg9hYcSs
 e0PzQhb/I41Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="127084369"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="127084369"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 12:35:49 -0700
IronPort-SDR: Xqmh/qgz5sDSVIIb8to44uGSW+4tYUjPTWETrSTabV2vPCn1tkDNzDQW+KBEh6DjGVyUYJAhza
 M+kQx+6nSUAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="482805275"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jul 2020 12:35:46 -0700
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
Subject: [PATCH 2/2][RFC] sched/debug: Make sd->flags sysctl writable again
Date:   Tue,  7 Jul 2020 03:37:05 +0800
Message-Id: <a18a80656e67bb527fdd25e8cd4d355b2bfaa310.1594062828.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1594062828.git.yu.c.chen@intel.com>
References: <cover.1594062828.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flags of sched domain in sysctl was limited to read-only in a
recent change. However this might bring inconvenience to some performance
tuning/function test which are sensitive to load balance. Since
the user might want to evaluate the impact of different combination
of sched domain flags on the workloads.

Per Commit 9818427c6270 ("sched/debug: Make sd->flags sysctl read-only"),
we can make the flags writable if we update the cached pointers after
the flag of sched domain has been modified.

Leverage update_domain_cpu() to update corresponding cached pointer of that
CPU once the flags has been changed.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/debug.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 36c54265bb2b..bfeaf547d4af 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -227,6 +227,8 @@ static void sd_free_ctl_entry(struct ctl_table **tablep)
 			sd_free_ctl_entry(&entry->child);
 		if (entry->proc_handler == NULL)
 			kfree(entry->procname);
+		if (entry->extra1)
+			kfree(entry->extra1);
 	}
 
 	kfree(*tablep);
@@ -245,20 +247,42 @@ set_table_entry(struct ctl_table *entry,
 	entry->proc_handler = proc_handler;
 }
 
+static int sysctl_sd_flags_handler(struct ctl_table *table, int write, void *buffer,
+				   size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (!ret && write)
+		update_domain_cpu(*(int *)(table->extra1));
+
+	return ret;
+}
+
 static struct ctl_table *
-sd_alloc_ctl_domain_table(struct sched_domain *sd)
+sd_alloc_ctl_domain_table(struct sched_domain *sd, int cpu)
 {
 	struct ctl_table *table = sd_alloc_ctl_entry(9);
+	int *cpu_param;
 
 	if (table == NULL)
 		return NULL;
 
+	/* Pass the CPU index to the handler. */
+	cpu_param = kmalloc(sizeof(int), GFP_KERNEL);
+	if (!cpu_param) {
+		kfree(table);
+		return NULL;
+	}
+	*cpu_param = cpu;
+
 	set_table_entry(&table[0], "min_interval",	  &sd->min_interval,	    sizeof(long), 0644, proc_doulongvec_minmax);
 	set_table_entry(&table[1], "max_interval",	  &sd->max_interval,	    sizeof(long), 0644, proc_doulongvec_minmax);
 	set_table_entry(&table[2], "busy_factor",	  &sd->busy_factor,	    sizeof(int),  0644, proc_dointvec_minmax);
 	set_table_entry(&table[3], "imbalance_pct",	  &sd->imbalance_pct,	    sizeof(int),  0644, proc_dointvec_minmax);
 	set_table_entry(&table[4], "cache_nice_tries",	  &sd->cache_nice_tries,    sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0444, proc_dointvec_minmax);
+	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0644, sysctl_sd_flags_handler);
+	table[5].extra1 = (void *)cpu_param;
 	set_table_entry(&table[6], "max_newidle_lb_cost", &sd->max_newidle_lb_cost, sizeof(long), 0644, proc_doulongvec_minmax);
 	set_table_entry(&table[7], "name",		  sd->name,	       CORENAME_MAX_SIZE, 0444, proc_dostring);
 	/* &table[8] is terminator */
@@ -284,7 +308,7 @@ static struct ctl_table *sd_alloc_ctl_cpu_table(int cpu)
 		snprintf(buf, 32, "domain%d", i);
 		entry->procname = kstrdup(buf, GFP_KERNEL);
 		entry->mode = 0555;
-		entry->child = sd_alloc_ctl_domain_table(sd);
+		entry->child = sd_alloc_ctl_domain_table(sd, cpu);
 		entry++;
 		i++;
 	}
-- 
2.17.1

