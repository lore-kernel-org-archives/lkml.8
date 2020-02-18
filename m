Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F04FC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE602173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgBRWoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:44:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:23569 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgBRWoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:44:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 14:44:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,458,1574150400"; 
   d="scan'208";a="436017418"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 18 Feb 2020 14:44:04 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, mhocko@kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v4] mm/vmscan.c: remove cpu online notification for now
Date:   Wed, 19 Feb 2020 06:44:22 +0800
Message-Id: <20200218224422.3407-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kswapd kernel thread starts either with a CPU affinity set to the full
cpu mask of its target node or without any affinity at all if the node
is CPUless. There is a cpu hotplug callback (kswapd_cpu_online) that
implements an elaborate way to update this mask when a cpu is onlined.

It is not really clear whether there is any actual benefit from this
scheme. Completely CPU-less NUMA nodes rarely gain a new CPU during
runtime. Drop the code for that reason. If there is a real usecase then
we can resurrect and simplify the code.

[mhocko@suse.com rewrite changelog]

Suggested-by: Michal Hocko <mhocko@suse.org>
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>

---
v4:
  * adjust changelog suggested by Michal
v3:
  * remove the cpu online notification suggested by Michal
v2:
  * rephrase the changelog
---
 mm/vmscan.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 665f33258cd7..a4fdf3dc8887 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4023,27 +4023,6 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 }
 #endif /* CONFIG_HIBERNATION */
 
-/* It's optimal to keep kswapds on the same CPUs as their memory, but
-   not required for correctness.  So if the last cpu in a node goes
-   away, we get changed to run anywhere: as the first one comes back,
-   restore their cpu bindings. */
-static int kswapd_cpu_online(unsigned int cpu)
-{
-	int nid;
-
-	for_each_node_state(nid, N_MEMORY) {
-		pg_data_t *pgdat = NODE_DATA(nid);
-		const struct cpumask *mask;
-
-		mask = cpumask_of_node(pgdat->node_id);
-
-		if (cpumask_any_and(cpu_online_mask, mask) < nr_cpu_ids)
-			/* One of our CPUs online: restore mask */
-			set_cpus_allowed_ptr(pgdat->kswapd, mask);
-	}
-	return 0;
-}
-
 /*
  * This kswapd start function will be called by init and node-hot-add.
  * On node-hot-add, kswapd will moved to proper cpus if cpus are hot-added.
@@ -4083,15 +4062,11 @@ void kswapd_stop(int nid)
 
 static int __init kswapd_init(void)
 {
-	int nid, ret;
+	int nid;
 
 	swap_setup();
 	for_each_node_state(nid, N_MEMORY)
  		kswapd_run(nid);
-	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
-					"mm/vmscan:online", kswapd_cpu_online,
-					NULL);
-	WARN_ON(ret < 0);
 	return 0;
 }
 
-- 
2.17.1

