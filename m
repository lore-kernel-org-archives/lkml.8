Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F3B206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHRSs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:48:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:63808 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgHRSsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:48:19 -0400
IronPort-SDR: DQKCtZFFwFlkRSHphVQkQm3TQobJQg2YVHziYr4y29IzYeRUaUMMuVbZ2+fT/qvTaCz/4uKvvs
 ArNxgLQk0jNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="154248706"
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="154248706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 11:48:07 -0700
IronPort-SDR: emSl2c0c4Z2kpGQzxXQI1LdUHj3B37UgttUoY8IhQqBclhLlUQuUpkpFiadz5S7ul3PsZjhyjE
 ttq7+9vwAbtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,328,1592895600"; 
   d="scan'208";a="496948337"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2020 11:48:06 -0700
Subject: [RFC][PATCH 3/9] mm/migrate: update migration order during on hotplug events
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 18 Aug 2020 11:41:27 -0700
References: <20200818184122.29C415DF@viggo.jf.intel.com>
In-Reply-To: <20200818184122.29C415DF@viggo.jf.intel.com>
Message-Id: <20200818184127.C3B49AB6@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Reclaim-based migration is attempting to optimize data placement in
memory based on the system topology.  If the system changes, so must
the migration ordering.

The implementation here is pretty simple and entirely unoptimized.  On
any memory or CPU hotplug events, assume that a node was added or
removed and recalculate all migration targets.  This ensures that the
node_demotion[] array is always ready to be used in case the new
reclaim mode is enabled.

This recalculation is far from optimal, most glaringly that it does
not even attempt to figure out if nodes are actually coming or going.
But, given the expected paucity of hotplug events, this should be
fine.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---

 b/mm/migrate.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff -puN mm/migrate.c~enable-numa-demotion mm/migrate.c
--- a/mm/migrate.c~enable-numa-demotion	2020-08-18 11:36:50.193583185 -0700
+++ b/mm/migrate.c	2020-08-18 11:36:50.197583185 -0700
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/ptrace.h>
 #include <linux/oom.h>
+#include <linux/memory.h>
 
 #include <asm/tlbflush.h>
 
@@ -3130,9 +3131,101 @@ again:
 		goto again;
 }
 
+/*
+ * For callers that do not hold get_online_mems() already.
+ */
 void set_migration_target_nodes(void)
 {
 	get_online_mems();
 	__set_migration_target_nodes();
 	put_online_mems();
 }
+
+/*
+ * React to hotplug events that might affect the migration targes
+ * like events that online or offline NUMA nodes.
+ *
+ * The ordering is also currently dependent on which nodes have
+ * CPUs.  That means we need CPU on/offline notification too.
+ */
+static int migration_online_cpu(unsigned int cpu)
+{
+	set_migration_target_nodes();
+	return 0;
+}
+
+static int migration_offline_cpu(unsigned int cpu)
+{
+	set_migration_target_nodes();
+	return 0;
+}
+
+/*
+ * This leaves migrate-on-reclaim transiently disabled
+ * between the MEM_GOING_OFFLINE and MEM_OFFLINE events.
+ * This runs reclaim-based micgration is enabled or not.
+ * This ensures that the user can turn reclaim-based
+ * migration at any time without needing to recalcuate
+ * migration targets.
+ *
+ * These callbacks already hold get_online_mems().  That
+ * is why __set_migration_target_nodes() can be used as
+ * opposed to set_migration_target_nodes().
+ */
+#if defined(CONFIG_MEMORY_HOTPLUG)
+static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
+						 unsigned long action, void *arg)
+{
+	switch (action) {
+	case MEM_GOING_OFFLINE:
+		/*
+		 * Make sure there are not transient states where
+		 * an offline node is a migration target.  This
+		 * will leave migration disabled until the offline
+		 * completes and the MEM_OFFLINE case below runs.
+		 */
+		disable_all_migrate_targets();
+		break;
+	case MEM_OFFLINE:
+	case MEM_ONLINE:
+		/*
+		 * Recalculate the target nodes once the node
+		 * reaches its final state (online or offline).
+		 */
+		__set_migration_target_nodes();
+		break;
+	case MEM_CANCEL_OFFLINE:
+		/*
+		 * MEM_GOING_OFFLINE disabled all the migration
+		 * targets.  Reenable them.
+		 */
+		__set_migration_target_nodes();
+		break;
+	case MEM_GOING_ONLINE:
+	case MEM_CANCEL_ONLINE:
+		break;
+	}
+
+	return notifier_from_errno(0);
+}
+
+static int __init migrate_on_reclaim_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "migrate on reclaim",
+				migration_online_cpu,
+				migration_offline_cpu);
+	/*
+	 * In the unlikely case that this fails, the automatic
+	 * migration targets may become suboptimal for nodes
+	 * where N_CPU changes.  With such a small impact in a
+	 * rare case, do not bother trying to do anything special.
+	 */
+	WARN_ON(ret < 0);
+
+	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
+	return 0;
+}
+late_initcall(migrate_on_reclaim_init);
+#endif /* CONFIG_MEMORY_HOTPLUG */
_
