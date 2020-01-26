Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE3AC35246
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 13:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D852071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 13:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAZNUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 08:20:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:1045 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgAZNUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 08:20:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 05:20:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,365,1574150400"; 
   d="scan'208";a="401110421"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2020 05:20:44 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm/vmscan.c: only adjust related kswapd cpu affinity when online cpu
Date:   Sun, 26 Jan 2020 21:20:52 +0800
Message-Id: <20200126132052.11921-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When onlining a cpu, kswapd_cpu_online() is called to adjust kswapd cpu
affinity.

Current routine does like this:

  * Iterate all the numa node
  * Adjust cpu affinity when node has an online cpu

Actually we could improve this by:

  * Just adjust the numa node to which current online cpu belongs

Because we know which numa node the cpu belongs to and this cpu would
not affect other node.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/vmscan.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 572fb17c6273..19c92d35045c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4049,18 +4049,19 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
    restore their cpu bindings. */
 static int kswapd_cpu_online(unsigned int cpu)
 {
-	int nid;
+	int nid = cpu_to_node(cpu);
+	pg_data_t *pgdat;
+	const struct cpumask *mask;
 
-	for_each_node_state(nid, N_MEMORY) {
-		pg_data_t *pgdat = NODE_DATA(nid);
-		const struct cpumask *mask;
+	if (!node_state(nid, N_MEMORY))
+		return 0;
 
-		mask = cpumask_of_node(pgdat->node_id);
+	pgdat = NODE_DATA(nid);
+	mask = cpumask_of_node(nid);
+
+	/* One of our CPUs online: restore mask */
+	set_cpus_allowed_ptr(pgdat->kswapd, mask);
 
-		if (cpumask_any_and(cpu_online_mask, mask) < nr_cpu_ids)
-			/* One of our CPUs online: restore mask */
-			set_cpus_allowed_ptr(pgdat->kswapd, mask);
-	}
 	return 0;
 }
 
-- 
2.17.1

