Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED2C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E00214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FnHxIrsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCBVdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:33:46 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2680 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgCBVdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:33:45 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5d7b900003>; Mon, 02 Mar 2020 13:33:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 02 Mar 2020 13:33:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 02 Mar 2020 13:33:44 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Mar
 2020 21:33:43 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 2 Mar 2020 21:33:44 +0000
Received: from ng-linuxvm.nvidia.com (Not Verified[10.110.48.88]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e5d7bb70000>; Mon, 02 Mar 2020 13:33:43 -0800
From:   Nitin Gupta <nigupta@nvidia.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
CC:     Nitin Gupta <nigupta@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: [PATCH v2] mm: Proactive compaction
Date:   Mon, 2 Mar 2020 13:33:43 -0800
Message-ID: <20200302213343.2712-1-nigupta@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583184784; bh=T9gPXoXKOm3Eqn4iPRHv8hfss1ucUMNxfM36zNTt0Z8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=FnHxIrsNLDjO/YjYH9klkNh6DUBI4ICsKQ65bDJvyIPl7TsyoJWjJDSvSdy/9UxOZ
         Zi36w1sBd+qjfnviVAAG/a1sIE+2rTmOZ9dQVJd+wUvoIeDfWpfD7LPk/Oen7VX2u0
         2/MRkGsyHEQ9E6OIXys3jqRtLWxQ1ct2VLjWjvLxi8nMI5ti79dwvI17EHjlHUnh+N
         j3rlyKkSNZMoffGiX+yYBCu0y7sTd+jWcnm56SgbEk83F9ODAOX40WHxmIOFTEUUL+
         srzdBFhDXGrbhXZkK8WBPZaab5BTtLRvgjQPwoc+JmP3p7A9hdq9JSIPAptIcTUXLQ
         1lGNW9+hwvRYw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some applications we need to allocate almost all memory as
hugepages. However, on a running system, higher order allocations can
fail if the memory is fragmented. Linux kernel currently does on-demand
compaction as we request more hugepages but this style of compaction
incurs very high latency. Experiments with one-time full memory
compaction (followed by hugepage allocations) shows that kernel is able
to restore a highly fragmented memory state to a fairly compacted memory
state within <1 sec for a 32G system. Such data suggests that a more
proactive compaction can help us allocate a large fraction of memory as
hugepages keeping allocation latencies low.

For a more proactive compaction, the approach taken here is to define
per page-node tunable called 'proactiveness' which dictates
bounds for external fragmentation for HUGETLB_PAGE_ORDER pages which
kcompactd should try to maintain.

The tunable is exposed through sysfs:
  /sys/kernel/mm/compaction/node-n/proactiveness

The value of this tunable is used to determine low and high thresholds
for external fragmentation wrt HUGETLB_PAGE_ORDER order.

Note that previous version of this patch [1] was found to introduce too
many tunables (per-order extfrag{low, high}) but this one reduces them
to just (per-node proactiveness). Also, the new tunable is an
opaque value instead of asking for specific bounds of "external
fragmentation" which would have been difficult to estimate. The internal
interpretation of this opaque value allows for future fine-tuning.

Currently, we use a simple translation from this tunable to [low, high]
"proactive compaction score" thresholds (low=3D100-proactiveness,
high=3Dlow+10%). The score for a node is defined as weighed mean of per-zon=
e
external fragmentation wrt HUGETLB_PAGE_ORDER. A zone's present_pages
determines its weight. Proactive compaction is triggered when a node's
score exceeds its high threshold value and continues till it reaches its
low value.

To periodically check per-node score, we reuse per-node kcompactd
threads which are woken up every few milliseconds to check the same. If
a node's score exceeds its high threshold (as derived from user provided
proactiveness value), proactive compaction is started till its score
reaches its low threshold value. By default, proactiveness is set to 0
(=3D> low=3D100%, high=3D100%) for all nodes.

This patch is largely based on ideas from Michal Hocko posted here:
https://lore.kernel.org/linux-mm/20161230131412.GI13301@dhcp22.suse.cz/

Performance data
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

System: x64_64, 1T RAM, 80 CPU threads.
Kernel: 5.6.0-rc3 + this patch

echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/defrag

Before starting the driver, the system was fragmented from a userspace
program that allocates all memory and then for each 2M aligned section,
frees 3/4 of base pages using munmap. The workload is mainly anonymous
userspace pages which are easy to move around. I intentionally avoided
unmovable pages in this test to see how much latency we incur when
hugepage allocations hit direct compaction.

1. Kernel hugepage allocation latencies

With system in such a fragmented state, a kernel driver then allocates
as many hugepages as possible and measures allocation latency:

(all latency values are in microseconds)

- With vanilla 5.6.0-rc3

echo 0 | sudo tee /sys/kernel/mm/compaction/node-*/proactiveness

  percentile latency
  =E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=
=E2=80=93=E2=80=93 =E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=
=E2=80=93
	   5    7894
	  10    9496
	  25   12561
	  30   15295
	  40   18244
	  50   21229
	  60   27556
	  75   30147
	  80   31047
	  90   32859
	  95   33799

Total 2M hugepages allocated =3D 383859 (749G worth of hugepages out of 762=
G
total free =3D> 98% of free memory could be allocated as hugepages)

- With 5.6.0-rc3 + this patch, with proactiveness=3D20

echo 20 | sudo tee /sys/kernel/mm/compaction/node-*/proactiveness

  percentile latency
  =E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=
=E2=80=93=E2=80=93 =E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=
=E2=80=93
	   5       2
	  10       2
	  25       3
	  30       3
	  40       3
	  50       4
	  60       4
	  75       4
	  80       4
	  90       5
	  95     429

Total 2M hugepages allocated =3D 11120 (21.7G worth of hugepages out of
25G total free =3D> 98% of free memory could be allocated as hugepages)

2. JAVA heap allocation

First fragment memory using the same method as for (1).

With memory in a fragmented state, run:

/usr/bin/time
 java -Xms700G -Xmx700G -XX:+UseTransparentHugePages -XX:+AlwaysPreTouch

To allocate 700G of java heap using hugepages.

- With vanilla 5.6.0-rc3

17.39user 1666.48system 27:37.89elapsed

- With 5.6.0-rc3 + this patch, with proactiveness=3D20

8.35user 194.58system 3:19.62elapsed

Elapsed time remains around 3:15 as proactiveness is further increased.

Backoff behavior
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Above workloads produces a memory state which is easy to compact.
However, if memory is filled with unmovable pages, proactive compaction
should essentially back off. To test this aspect:

- Created a kernel driver that allocates almost all memory as hugepages
  followed by freeing first 3/4 of each hugepage.
- Set proactiveness=3D40 (for all nodes)
- Note that proactive_compact_node() is deferred maximum number of times
  with HPAGE_FRAG_CHECK_INTERVAL_MSEC of wait between each check
  (=3D> ~30 seconds between retries).

[1] https://patchwork.kernel.org/patch/11098289/

Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
To: Mel Gorman <mgorman@techsingularity.net>
To: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Mike Kravetz <mike.kravetz@oracle.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
CC: linux-mm <linux-mm@kvack.org>

---
Changelog v2 vs v1:
 - Introduce per-node and per-zone "proactive compaction score". This
   score is compared against watermarks which are set according to
   user provided proactiveness value.
 - Separate code-paths for proactive compaction from targeted compaction
   i.e. where pgdat->kcompactd_max_order is non-zero.
 - Renamed hpage_compaction_effort -> proactiveness. In future we may
   use more than extfrag wrt hugepage size to determine proactive
   compaction score.
---
 include/linux/compaction.h |  10 ++
 mm/compaction.c            | 242 ++++++++++++++++++++++++++++++++++++-
 mm/internal.h              |   1 +
 mm/page_alloc.c            |   1 +
 mm/vmstat.c                |  12 ++
 5 files changed, 260 insertions(+), 6 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 4b898cdbdf05..c98f45107164 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -60,6 +60,15 @@ enum compact_result {
=20
 struct alloc_context; /* in mm/internal.h */
=20
+// "node-%d"
+#define COMPACTION_STATE_NAME_LEN 16
+// Per-node compaction state
+struct compaction_state {
+	int node_id;
+	unsigned int proactiveness;
+	char name[COMPACTION_STATE_NAME_LEN];
+};
+
 /*
  * Number of free order-0 pages that should be available above given water=
mark
  * to make sure compaction has reasonable chance of not running out of fre=
e
@@ -90,6 +99,7 @@ extern int sysctl_compaction_handler(struct ctl_table *ta=
ble, int write,
 extern int sysctl_extfrag_threshold;
 extern int sysctl_compact_unevictable_allowed;
=20
+extern int extfrag_for_order(struct zone *zone, unsigned int order);
 extern int fragmentation_index(struct zone *zone, unsigned int order);
 extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		unsigned int order, unsigned int alloc_flags,
diff --git a/mm/compaction.c b/mm/compaction.c
index 672d3c78c6ab..d906ccfedce0 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -25,6 +25,10 @@
 #include <linux/psi.h>
 #include "internal.h"
=20
+#ifdef CONFIG_COMPACTION
+static struct compaction_state compaction_states[MAX_NUMNODES];
+#endif
+
 #ifdef CONFIG_COMPACTION
 static inline void count_compact_event(enum vm_event_item item)
 {
@@ -50,6 +54,8 @@ static inline void count_compact_events(enum vm_event_ite=
m item, long delta)
 #define pageblock_start_pfn(pfn)	block_start_pfn(pfn, pageblock_order)
 #define pageblock_end_pfn(pfn)		block_end_pfn(pfn, pageblock_order)
=20
+static const int HPAGE_FRAG_CHECK_INTERVAL_MSEC =3D 500;
+
 static unsigned long release_freepages(struct list_head *freelist)
 {
 	struct page *page, *next;
@@ -1846,6 +1852,51 @@ static inline bool is_via_compact_memory(int order)
 	return order =3D=3D -1;
 }
=20
+static int proactive_compaction_score_zone(struct zone *zone)
+{
+	unsigned long score;
+
+	score =3D zone->present_pages *
+			extfrag_for_order(zone, HUGETLB_PAGE_ORDER);
+	score =3D div64_ul(score,
+			node_present_pages(zone->zone_pgdat->node_id) + 1);
+	return score;
+}
+
+static int proactive_compaction_score_node(pg_data_t *pgdat)
+{
+	unsigned long score =3D 0;
+	int zoneid;
+
+	for (zoneid =3D 0; zoneid < MAX_NR_ZONES; zoneid++) {
+		struct zone *zone;
+
+		zone =3D &pgdat->node_zones[zoneid];
+		score +=3D proactive_compaction_score_zone(zone);
+	}
+
+	return score;
+}
+
+static int proactive_compaction_score_wmark(pg_data_t *pgdat, bool low)
+{
+	int wmark_low;
+
+	wmark_low =3D 100 - compaction_states[pgdat->node_id].proactiveness;
+	return low ? wmark_low : min(wmark_low + 10, 100);
+}
+
+static bool should_proactive_compact_node(pg_data_t *pgdat)
+{
+	int wmark_high;
+
+	if (!compaction_states[pgdat->node_id].proactiveness)
+		return false;
+
+	wmark_high =3D proactive_compaction_score_wmark(pgdat, false);
+	return proactive_compaction_score_node(pgdat) > wmark_high;
+}
+
 static enum compact_result __compact_finished(struct compact_control *cc)
 {
 	unsigned int order;
@@ -1872,6 +1923,19 @@ static enum compact_result __compact_finished(struct=
 compact_control *cc)
 			return COMPACT_PARTIAL_SKIPPED;
 	}
=20
+	if (cc->proactive_compaction) {
+		int score, wmark_low;
+
+		score =3D proactive_compaction_score_zone(cc->zone);
+		wmark_low =3D proactive_compaction_score_wmark(
+					cc->zone->zone_pgdat, true);
+		if (score > wmark_low)
+			ret =3D COMPACT_CONTINUE;
+		else
+			ret =3D COMPACT_SUCCESS;
+		goto out;
+	}
+
 	if (is_via_compact_memory(cc->order))
 		return COMPACT_CONTINUE;
=20
@@ -1930,6 +1994,7 @@ static enum compact_result __compact_finished(struct =
compact_control *cc)
 		}
 	}
=20
+out:
 	if (cc->contended || fatal_signal_pending(current))
 		ret =3D COMPACT_CONTENDED;
=20
@@ -2301,6 +2366,7 @@ static enum compact_result compact_zone_order(struct =
zone *zone, int order,
 		.alloc_flags =3D alloc_flags,
 		.classzone_idx =3D classzone_idx,
 		.direct_compaction =3D true,
+		.proactive_compaction =3D false,
 		.whole_zone =3D (prio =3D=3D MIN_COMPACT_PRIORITY),
 		.ignore_skip_hint =3D (prio =3D=3D MIN_COMPACT_PRIORITY),
 		.ignore_block_suitable =3D (prio =3D=3D MIN_COMPACT_PRIORITY)
@@ -2404,6 +2470,34 @@ enum compact_result try_to_compact_pages(gfp_t gfp_m=
ask, unsigned int order,
 	return rc;
 }
=20
+/* Compact all zones within a node according to proactiveness */
+static void proactive_compact_node(pg_data_t *pgdat)
+{
+	int zoneid;
+	struct zone *zone;
+	struct compact_control cc =3D {
+		.order =3D -1,
+		.mode =3D MIGRATE_SYNC_LIGHT,
+		.ignore_skip_hint =3D true,
+		.whole_zone =3D true,
+		.gfp_mask =3D GFP_KERNEL,
+		.direct_compaction =3D false,
+		.proactive_compaction =3D true,
+	};
+
+	for (zoneid =3D 0; zoneid < MAX_NR_ZONES; zoneid++) {
+		zone =3D &pgdat->node_zones[zoneid];
+		if (!populated_zone(zone))
+			continue;
+
+		cc.zone =3D zone;
+
+		compact_zone(&cc, NULL);
+
+		VM_BUG_ON(!list_empty(&cc.freepages));
+		VM_BUG_ON(!list_empty(&cc.migratepages));
+	}
+}
=20
 /* Compact all zones within a node */
 static void compact_node(int nid)
@@ -2417,9 +2511,10 @@ static void compact_node(int nid)
 		.ignore_skip_hint =3D true,
 		.whole_zone =3D true,
 		.gfp_mask =3D GFP_KERNEL,
+		.direct_compaction =3D false,
+		.proactive_compaction =3D false,
 	};
=20
-
 	for (zoneid =3D 0; zoneid < MAX_NR_ZONES; zoneid++) {
=20
 		zone =3D &pgdat->node_zones[zoneid];
@@ -2492,6 +2587,118 @@ void compaction_unregister_node(struct node *node)
 }
 #endif /* CONFIG_SYSFS && CONFIG_NUMA */
=20
+#ifdef CONFIG_SYSFS
+
+#define COMPACTION_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr =3D __ATTR_RO(_name)
+
+#define COMPACTION_ATTR(_name) \
+	static struct kobj_attribute _name##_attr =3D \
+		__ATTR(_name, 0644, _name##_show, _name##_store)
+
+static struct kobject *compaction_kobj;
+static struct kobject *compaction_kobjs[MAX_NUMNODES];
+
+static struct compaction_state *kobj_to_compaction_state(struct kobject *k=
obj)
+{
+	int node;
+
+	for_each_online_node(node) {
+		if (compaction_kobjs[node] =3D=3D kobj)
+			return &compaction_states[node];
+	}
+
+	return NULL;
+}
+
+static ssize_t proactiveness_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	int err;
+	unsigned long input;
+	struct compaction_state *c =3D kobj_to_compaction_state(kobj);
+
+	err =3D kstrtoul(buf, 10, &input);
+	if (err)
+		return err;
+	if (input > 100)
+		return -EINVAL;
+
+	c->proactiveness =3D input;
+	return count;
+}
+
+static ssize_t proactiveness_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	struct compaction_state *c =3D kobj_to_compaction_state(kobj);
+
+	return sprintf(buf, "%u\n", c->proactiveness);
+}
+
+COMPACTION_ATTR(proactiveness);
+
+static struct attribute *compaction_attrs[] =3D {
+	&proactiveness_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group compaction_attr_group =3D {
+	.attrs =3D compaction_attrs,
+};
+
+static int compaction_sysfs_add_node(struct compaction_state *c,
+	struct kobject *parent, struct kobject **compaction_kobjs,
+	const struct attribute_group *compaction_attr_group)
+{
+	int retval;
+
+	compaction_kobjs[c->node_id] =3D
+			kobject_create_and_add(c->name, parent);
+	if (!compaction_kobjs[c->node_id])
+		return -ENOMEM;
+
+	retval =3D sysfs_create_group(compaction_kobjs[c->node_id],
+				compaction_attr_group);
+	if (retval)
+		kobject_put(compaction_kobjs[c->node_id]);
+
+	return retval;
+}
+
+static void __init compaction_sysfs_init(void)
+{
+	struct compaction_state *c;
+	int err, node;
+
+	compaction_kobj =3D kobject_create_and_add("compaction", mm_kobj);
+	if (!compaction_kobj)
+		return;
+
+	for_each_online_node(node) {
+		c =3D &compaction_states[node];
+		err =3D compaction_sysfs_add_node(c, compaction_kobj,
+					compaction_kobjs,
+					&compaction_attr_group);
+		if (err)
+			pr_err("compaction: Unable to add state %s", c->name);
+	}
+}
+
+static void __init compaction_init(void)
+{
+	int node;
+
+	for_each_online_node(node) {
+		struct compaction_state *c =3D &compaction_states[node];
+
+		c->node_id =3D node;
+		c->proactiveness =3D 0;
+		snprintf(c->name, COMPACTION_STATE_NAME_LEN, "node-%d", node);
+	}
+}
+#endif
+
 static inline bool kcompactd_work_requested(pg_data_t *pgdat)
 {
 	return pgdat->kcompactd_max_order > 0 || kthread_should_stop();
@@ -2532,6 +2739,8 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		.mode =3D MIGRATE_SYNC_LIGHT,
 		.ignore_skip_hint =3D false,
 		.gfp_mask =3D GFP_KERNEL,
+		.direct_compaction =3D false,
+		.proactive_compaction =3D false,
 	};
 	trace_mm_compaction_kcompactd_wake(pgdat->node_id, cc.order,
 							cc.classzone_idx);
@@ -2629,6 +2838,7 @@ static int kcompactd(void *p)
 {
 	pg_data_t *pgdat =3D (pg_data_t*)p;
 	struct task_struct *tsk =3D current;
+	unsigned int proactive_defer =3D 0;
=20
 	const struct cpumask *cpumask =3D cpumask_of_node(pgdat->node_id);
=20
@@ -2644,12 +2854,29 @@ static int kcompactd(void *p)
 		unsigned long pflags;
=20
 		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
-		wait_event_freezable(pgdat->kcompactd_wait,
-				kcompactd_work_requested(pgdat));
+		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
+			kcompactd_work_requested(pgdat),
+			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
=20
-		psi_memstall_enter(&pflags);
-		kcompactd_do_work(pgdat);
-		psi_memstall_leave(&pflags);
+			psi_memstall_enter(&pflags);
+			kcompactd_do_work(pgdat);
+			psi_memstall_leave(&pflags);
+			continue;
+		}
+
+		if (should_proactive_compact_node(pgdat)) {
+			unsigned int prev_score, score;
+
+			if (proactive_defer) {
+				proactive_defer--;
+				continue;
+			}
+			prev_score =3D proactive_compaction_score_node(pgdat);
+			proactive_compact_node(pgdat);
+			score =3D proactive_compaction_score_node(pgdat);
+			proactive_defer =3D score < prev_score ?
+					0 : 1 << COMPACT_MAX_DEFER_SHIFT;
+		}
 	}
=20
 	return 0;
@@ -2726,6 +2953,9 @@ static int __init kcompactd_init(void)
 		return ret;
 	}
=20
+	compaction_init();
+	compaction_sysfs_init();
+
 	for_each_node_state(nid, N_MEMORY)
 		kcompactd_run(nid);
 	return 0;
diff --git a/mm/internal.h b/mm/internal.h
index 3cf20ab3ca01..e66bafd6c7a2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -203,6 +203,7 @@ struct compact_control {
 	bool no_set_skip_hint;		/* Don't mark blocks for skipping */
 	bool ignore_block_suitable;	/* Scan blocks considered unsuitable */
 	bool direct_compaction;		/* False from kcompactd or /proc/... */
+	bool proactive_compaction;	/* kcompactd proactive compaction */
 	bool whole_zone;		/* Whole zone should/has been scanned */
 	bool contended;			/* Signal lock or sched contention */
 	bool rescan;			/* Rescanning the same pageblock */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..e92c706e93ee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8402,6 +8402,7 @@ int alloc_contig_range(unsigned long start, unsigned =
long end,
 		.ignore_skip_hint =3D true,
 		.no_set_skip_hint =3D true,
 		.gfp_mask =3D current_gfp_context(gfp_mask),
+		.proactive_compaction =3D false,
 	};
 	INIT_LIST_HEAD(&cc.migratepages);
=20
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 78d53378db99..70d724122643 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1074,6 +1074,18 @@ static int __fragmentation_index(unsigned int order,=
 struct contig_page_info *in
 	return 1000 - div_u64( (1000+(div_u64(info->free_pages * 1000ULL, request=
ed))), info->free_blocks_total);
 }
=20
+int extfrag_for_order(struct zone *zone, unsigned int order)
+{
+	struct contig_page_info info;
+
+	fill_contig_page_info(zone, order, &info);
+	if (info.free_pages =3D=3D 0)
+		return 0;
+
+	return (info.free_pages - (info.free_blocks_suitable << order)) * 100
+							/ info.free_pages;
+}
+
 /* Same as __fragmentation index but allocs contig_page_info on stack */
 int fragmentation_index(struct zone *zone, unsigned int order)
 {
--=20
2.17.1

