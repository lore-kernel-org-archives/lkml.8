Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F8BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073DC222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 07:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgBNHdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 02:33:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:29563 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728691AbgBNHdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:33:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 23:33:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,439,1574150400"; 
   d="scan'208";a="257438882"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 13 Feb 2020 23:33:13 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rientjes@google.com, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v2] mm/vmscan.c: only adjust related kswapd cpu affinity when online cpu
Date:   Fri, 14 Feb 2020 15:33:20 +0800
Message-Id: <20200214073320.28735-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When onlining a cpu, kswapd_cpu_online() is called to adjust kswapd cpu
affinity.

Current routine does like this:

  a) Iterate all the numa node
  b) Adjust cpu affinity when node has an online cpu

For a) this is not necessary, since the particular online cpu belongs to
a particular numa node. So it is not necessary to iterate on every nodes
on the system. This new onlined cpu just affect kswapd cpu affinity of
this particular node.

For b) several cpumask operation is used to check whether the node has
an online CPU. Since at this point we are sure one of our CPU onlined,
we can set the cpu affinity directly to current cpumask_of_node().

This patch simplifies the logic by set cpu affinity of the affected
kswapd.

---
v2:
  * rephrase the changelog

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/vmscan.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 665f33258cd7..acc5af82b6ed 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4029,18 +4029,19 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
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

