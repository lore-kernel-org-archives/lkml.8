Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A23BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE97920780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgF2Xs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:48:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:17894 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbgF2Xso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:48:44 -0400
IronPort-SDR: /IUzi5FFn77QQM8QS0EQEmJXav3sDFEKqcBghYcUaz1odXF6Y1vxMUdo7lt1k74T8o6EJ3jj0q
 wc2+62LIY9Gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="230951621"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="230951621"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 16:48:36 -0700
IronPort-SDR: 9l3t0L3FlRaHvDVcoJ77HngWdERhkzcih1h5VWLn7eVK4RJzOSkeBYVW6kA/mTCYqKE3Kpzh8F
 hn55odvfiS5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="312203671"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga008.jf.intel.com with ESMTP; 29 Jun 2020 16:48:36 -0700
Subject: [RFC][PATCH 5/8] mm/numa: automatically generate node migration order
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon, 29 Jun 2020 16:45:12 -0700
References: <20200629234503.749E5340@viggo.jf.intel.com>
In-Reply-To: <20200629234503.749E5340@viggo.jf.intel.com>
Message-Id: <20200629234512.F34EDC44@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

When memory fills up on a node, memory contents can be
automatically migrated to another node.  The biggest problems are
knowing when to migrate and to where the migration should be
targeted.

The most straightforward way to generate the "to where" list
would be to follow the page allocator fallback lists.  Those
lists already tell us if memory is full where to look next.  It
would also be logical to move memory in that order.

But, the allocator fallback lists have a fatal flaw: most nodes
appear in all the lists.  This would potentially lead to
migration cycles (A->B, B->A, A->B, ...).

Instead of using the allocator fallback lists directly, keep a
separate node migration ordering.  But, reuse the same data used
to generate page allocator fallback in the first place:
find_next_best_node().

This means that the firmware data used to populate node distances
essentially dictates the ordering for now.  It should also be
architecture-neutral since all NUMA architectures have a working
find_next_best_node().

The protocol for node_demotion[] access and writing is not
standard.  It has no specific locking and is intended to be read
locklessly.  Readers must take care to avoid observing changes
that appear incoherent.  This was done so that node_demotion[]
locking has no chance of becoming a bottleneck on large systems
with lots of CPUs in direct reclaim.

This code is unused for now.  It will be called later in the
series.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---

 b/mm/internal.h   |    1 
 b/mm/migrate.c    |  130 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 b/mm/page_alloc.c |    2 
 3 files changed, 131 insertions(+), 2 deletions(-)

diff -puN mm/internal.h~auto-setup-default-migration-path-from-firmware mm/internal.h
--- a/mm/internal.h~auto-setup-default-migration-path-from-firmware	2020-06-29 16:34:41.629312597 -0700
+++ b/mm/internal.h	2020-06-29 16:34:41.638312597 -0700
@@ -192,6 +192,7 @@ extern int user_min_free_kbytes;
 
 extern void zone_pcp_update(struct zone *zone);
 extern void zone_pcp_reset(struct zone *zone);
+extern int find_next_best_node(int node, nodemask_t *used_node_mask);
 
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
diff -puN mm/migrate.c~auto-setup-default-migration-path-from-firmware mm/migrate.c
--- a/mm/migrate.c~auto-setup-default-migration-path-from-firmware	2020-06-29 16:34:41.631312597 -0700
+++ b/mm/migrate.c	2020-06-29 16:34:41.639312597 -0700
@@ -1128,6 +1128,10 @@ out:
 	return rc;
 }
 
+/*
+ * Writes to this array occur without locking.  READ_ONCE()
+ * is recommended for readers.
+ */
 static int node_demotion[MAX_NUMNODES] = {[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
 
 /**
@@ -1141,7 +1145,13 @@ int next_demotion_node(int node)
 {
 	get_online_mems();
 	while (true) {
-		node = node_demotion[node];
+		/*
+		 * node_demotion[] is updated without excluding
+		 * this function from running.  READ_ONCE() avoids
+		 * 'node' checks reading different values from
+		 * node_demotion[].
+		 */
+		node = READ_ONCE(node_demotion[node]);
 		if (node == NUMA_NO_NODE)
 			break;
 		if (node_online(node))
@@ -3086,3 +3096,121 @@ void migrate_vma_finalize(struct migrate
 }
 EXPORT_SYMBOL(migrate_vma_finalize);
 #endif /* CONFIG_DEVICE_PRIVATE */
+
+/* Disable reclaim-based migration. */
+static void disable_all_migrate_targets(void)
+{
+	int node;
+
+	for_each_online_node(node)
+		node_demotion[node] = NUMA_NO_NODE;
+}
+
+/*
+ * Find an automatic demotion target for 'node'.
+ * Failing here is OK.  It might just indicate
+ * being at the end of a chain.
+ */
+static int establish_migrate_target(int node, nodemask_t *used)
+{
+	int migration_target;
+
+	/*
+	 * Can not set a migration target on a
+	 * node with it already set.
+	 *
+	 * No need for READ_ONCE() here since this
+	 * in the write path for node_demotion[].
+	 * This should be the only thread writing.
+	 */
+	if (node_demotion[node] != NUMA_NO_NODE)
+		return NUMA_NO_NODE;
+
+	migration_target = find_next_best_node(node, used);
+	if (migration_target == NUMA_NO_NODE)
+		return NUMA_NO_NODE;
+
+	node_demotion[node] = migration_target;
+
+	return migration_target;
+}
+
+/*
+ * When memory fills up on a node, memory contents can be
+ * automatically migrated to another node instead of
+ * discarded at reclaim.
+ *
+ * Establish a "migration path" which will start at nodes
+ * with CPUs and will follow the priorities used to build the
+ * page allocator zonelists.
+ *
+ * The difference here is that cycles must be avoided.  If
+ * node0 migrates to node1, then neither node1, nor anything
+ * node1 migrates to can migrate to node0.
+ *
+ * This function can run simultaneously with readers of
+ * node_demotion[].  However, it can not run simultaneously
+ * with itself.  Exclusion is provided by memory hotplug events
+ * being single-threaded.
+ */
+void set_migration_target_nodes(void)
+{
+	nodemask_t next_pass = NODE_MASK_NONE;
+	nodemask_t this_pass = NODE_MASK_NONE;
+	nodemask_t used_targets = NODE_MASK_NONE;
+	int node;
+
+	get_online_mems();
+	/*
+	 * Avoid any oddities like cycles that could occur
+	 * from changes in the topology.  This will leave
+	 * a momentary gap when migration is disabled.
+	 */
+	disable_all_migrate_targets();
+
+	/*
+	 * Ensure that the "disable" is visible across the system.
+	 * Readers will see either a combination of before+disable
+	 * state or disable+after.  They will never see before and
+	 * after state together.
+	 *
+	 * The before+after state together might have cycles and
+	 * could cause readers to do things like loop until this
+	 * function finishes.  This ensures they can only see a
+	 * single "bad" read and would, for instance, only loop
+	 * once.
+	 */
+	smp_wmb();
+
+	/*
+	 * Allocations go close to CPUs, first.  Assume that
+	 * the migration path starts at the nodes with CPUs.
+	 */
+	next_pass = node_states[N_CPU];
+again:
+	this_pass = next_pass;
+	next_pass = NODE_MASK_NONE;
+	/*
+	 * To avoid cycles in the migration "graph", ensure
+	 * that migration sources are not future targets by
+	 * setting them in 'used_targets'.
+	 *
+	 * But, do this only once per pass so that multiple
+	 * source nodes can share a target node.
+	 */
+	nodes_or(used_targets, used_targets, this_pass);
+	for_each_node_mask(node, this_pass) {
+		int target_node = establish_migrate_target(node, &used_targets);
+
+		if (target_node == NUMA_NO_NODE)
+			continue;
+
+		/* Visit targets from this pass in the next pass: */
+		node_set(target_node, next_pass);
+	}
+	/* Is another pass necessary? */
+	if (!nodes_empty(next_pass))
+		goto again;
+
+	put_online_mems();
+}
diff -puN mm/page_alloc.c~auto-setup-default-migration-path-from-firmware mm/page_alloc.c
--- a/mm/page_alloc.c~auto-setup-default-migration-path-from-firmware	2020-06-29 16:34:41.634312597 -0700
+++ b/mm/page_alloc.c	2020-06-29 16:34:41.641312597 -0700
@@ -5591,7 +5591,7 @@ static int node_load[MAX_NUMNODES];
  *
  * Return: node id of the found node or %NUMA_NO_NODE if no node is found.
  */
-static int find_next_best_node(int node, nodemask_t *used_node_mask)
+int find_next_best_node(int node, nodemask_t *used_node_mask)
 {
 	int n, val;
 	int min_val = INT_MAX;
_
