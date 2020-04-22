Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76300C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4510A216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="efRHvWMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgDVUr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:47:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35106 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgDVUrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:47:23 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MKjmAV028590
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=E9Y/fKB2RbnzfXqvbSlPGLm+ZpArbv7zrVP+rtYf5ao=;
 b=efRHvWMXxRRc0SX7JNjAwwh/GgUSHFFmaBDOGttNZ9Xmsblle1n6MeC4D4XYZlyFml4h
 d84uxiEDKsD6Ong/MDioyDSl+duARs99rAuFPY43jfx6kiRcj38dA2bQmw9iNPOyvtH1
 EQbCsAHwBVSxJGHOYFFPau8mDl/RMzA+vUo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30g0vs04tc-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:21 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 22 Apr 2020 13:47:20 -0700
Received: by devvm4439.prn2.facebook.com (Postfix, from userid 111017)
        id C27F3229357FB; Wed, 22 Apr 2020 13:47:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm4439.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 02/19] mm: memcg: prepare for byte-sized vmstat items
Date:   Wed, 22 Apr 2020 13:46:51 -0700
Message-ID: <20200422204708.2176080-3-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200422204708.2176080-1-guro@fb.com>
References: <20200422204708.2176080-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_07:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220158
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To implement per-object slab memory accounting, we need to
convert slab vmstat counters to bytes. Actually, out of
4 levels of counters: global, per-node, per-memcg and per-lruvec
only two last levels will require byte-sized counters.
It's because global and per-node counters will be counting the
number of slab pages, and per-memcg and per-lruvec will be
counting the amount of memory taken by charged slab objects.

Converting all vmstat counters to bytes or even all slab
counters to bytes would introduce an additional overhead.
So instead let's store global and per-node counters
in pages, and memcg and lruvec counters in bytes.

To make the API clean all access helpers (both on the read
and write sides) are dealing with bytes.

To avoid back-and-forth conversions a new flavor of helpers
is introduced, which always returns values in pages:
node_page_state_pages() and global_node_page_state_pages().

Actually new helpers are just reading raw values. Old helpers are
simple wrappers, which perform a conversion if the vmstat items are
in bytes. Because at the moment no one actually need bytes,
there are WARN_ON_ONCE() macroses inside to warn about inappropriate
use cases.

Thanks to Johannes Weiner for the idea of having the byte-sized API
on top of the page-sized internal storage.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 drivers/base/node.c    |  2 +-
 include/linux/mmzone.h |  5 +++++
 include/linux/vmstat.h | 16 +++++++++++++++-
 mm/memcontrol.c        | 14 ++++++++++----
 mm/vmstat.c            | 33 +++++++++++++++++++++++++++++----
 5 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 10d7e818e118..9d6afb7d2ccd 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -507,7 +507,7 @@ static ssize_t node_read_vmstat(struct device *dev,
=20
 	for (i =3D 0; i < NR_VM_NODE_STAT_ITEMS; i++)
 		n +=3D sprintf(buf+n, "%s %lu\n", node_stat_name(i),
-			     node_page_state(pgdat, i));
+			     node_page_state_pages(pgdat, i));
=20
 	return n;
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c1fbda9ddd1f..22fe65edf425 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -204,6 +204,11 @@ enum node_stat_item {
 	NR_VM_NODE_STAT_ITEMS
 };
=20
+static __always_inline bool vmstat_item_in_bytes(enum node_stat_item ite=
m)
+{
+	return false;
+}
+
 /*
  * We do arithmetic on the LRU lists in various places in the code,
  * so it is important to keep the active lists LRU_ACTIVE higher in
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 292485f3d24d..117763827cd0 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -190,7 +190,8 @@ static inline unsigned long global_zone_page_state(en=
um zone_stat_item item)
 	return x;
 }
=20
-static inline unsigned long global_node_page_state(enum node_stat_item i=
tem)
+static inline
+unsigned long global_node_page_state_pages(enum node_stat_item item)
 {
 	long x =3D atomic_long_read(&vm_node_stat[item]);
 #ifdef CONFIG_SMP
@@ -200,6 +201,16 @@ static inline unsigned long global_node_page_state(e=
num node_stat_item item)
 	return x;
 }
=20
+static inline unsigned long global_node_page_state(enum node_stat_item i=
tem)
+{
+	unsigned long x =3D global_node_page_state_pages(item);
+
+	if (WARN_ON_ONCE(vmstat_item_in_bytes(item)))
+		return x << PAGE_SHIFT;
+
+	return x;
+}
+
 static inline unsigned long zone_page_state(struct zone *zone,
 					enum zone_stat_item item)
 {
@@ -240,9 +251,12 @@ extern unsigned long sum_zone_node_page_state(int no=
de,
 extern unsigned long sum_zone_numa_state(int node, enum numa_stat_item i=
tem);
 extern unsigned long node_page_state(struct pglist_data *pgdat,
 						enum node_stat_item item);
+extern unsigned long node_page_state_pages(struct pglist_data *pgdat,
+					   enum node_stat_item item);
 #else
 #define sum_zone_node_page_state(node, item) global_zone_page_state(item=
)
 #define node_page_state(node, item) global_node_page_state(item)
+#define node_page_state_pages(node, item) global_node_page_state_pages(i=
tem)
 #endif /* CONFIG_NUMA */
=20
 #ifdef CONFIG_SMP
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f6ff20095105..5f700fa8b78c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -681,13 +681,16 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgrou=
p_tree_per_node *mctz)
  */
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 {
-	long x;
+	long x, threshold =3D MEMCG_CHARGE_BATCH;
=20
 	if (mem_cgroup_disabled())
 		return;
=20
+	if (vmstat_item_in_bytes(idx))
+		threshold <<=3D PAGE_SHIFT;
+
 	x =3D val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
-	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+	if (unlikely(abs(x) > threshold)) {
 		struct mem_cgroup *mi;
=20
 		/*
@@ -719,7 +722,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, =
enum node_stat_item idx,
 	pg_data_t *pgdat =3D lruvec_pgdat(lruvec);
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
-	long x;
+	long x, threshold =3D MEMCG_CHARGE_BATCH;
=20
 	pn =3D container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg =3D pn->memcg;
@@ -730,8 +733,11 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec,=
 enum node_stat_item idx,
 	/* Update lruvec */
 	__this_cpu_add(pn->lruvec_stat_local->count[idx], val);
=20
+	if (vmstat_item_in_bytes(idx))
+		threshold <<=3D PAGE_SHIFT;
+
 	x =3D val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
-	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
+	if (unlikely(abs(x) > threshold)) {
 		struct mem_cgroup_per_node *pi;
=20
 		for (pi =3D pn; pi; pi =3D parent_nodeinfo(pi, pgdat->node_id))
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6fd1407f4632..7ac13f6d189a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -341,6 +341,11 @@ void __mod_node_page_state(struct pglist_data *pgdat=
, enum node_stat_item item,
 	long x;
 	long t;
=20
+	if (vmstat_item_in_bytes(item)) {
+		WARN_ON(delta & (PAGE_SIZE - 1));
+		delta >>=3D PAGE_SHIFT;
+	}
+
 	x =3D delta + __this_cpu_read(*p);
=20
 	t =3D __this_cpu_read(pcp->stat_threshold);
@@ -398,6 +403,8 @@ void __inc_node_state(struct pglist_data *pgdat, enum=
 node_stat_item item)
 	s8 __percpu *p =3D pcp->vm_node_stat_diff + item;
 	s8 v, t;
=20
+	WARN_ON_ONCE(vmstat_item_in_bytes(item));
+
 	v =3D __this_cpu_inc_return(*p);
 	t =3D __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
@@ -442,6 +449,8 @@ void __dec_node_state(struct pglist_data *pgdat, enum=
 node_stat_item item)
 	s8 __percpu *p =3D pcp->vm_node_stat_diff + item;
 	s8 v, t;
=20
+	WARN_ON_ONCE(vmstat_item_in_bytes(item));
+
 	v =3D __this_cpu_dec_return(*p);
 	t =3D __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
@@ -541,6 +550,11 @@ static inline void mod_node_state(struct pglist_data=
 *pgdat,
 	s8 __percpu *p =3D pcp->vm_node_stat_diff + item;
 	long o, n, t, z;
=20
+	if (vmstat_item_in_bytes(item)) {
+		WARN_ON_ONCE(delta & (PAGE_SIZE - 1));
+		delta >>=3D PAGE_SHIFT;
+	}
+
 	do {
 		z =3D 0;  /* overflow to node counters */
=20
@@ -989,8 +1003,8 @@ unsigned long sum_zone_numa_state(int node,
 /*
  * Determine the per node value of a stat item.
  */
-unsigned long node_page_state(struct pglist_data *pgdat,
-				enum node_stat_item item)
+unsigned long node_page_state_pages(struct pglist_data *pgdat,
+				    enum node_stat_item item)
 {
 	long x =3D atomic_long_read(&pgdat->vm_stat[item]);
 #ifdef CONFIG_SMP
@@ -999,6 +1013,17 @@ unsigned long node_page_state(struct pglist_data *p=
gdat,
 #endif
 	return x;
 }
+
+unsigned long node_page_state(struct pglist_data *pgdat,
+				enum node_stat_item item)
+{
+	unsigned long x =3D node_page_state_pages(pgdat, item);
+
+	if (WARN_ON_ONCE(vmstat_item_in_bytes(item)))
+		return x << PAGE_SHIFT;
+
+	return x;
+}
 #endif
=20
 #ifdef CONFIG_COMPACTION
@@ -1571,7 +1596,7 @@ static void zoneinfo_show_print(struct seq_file *m,=
 pg_data_t *pgdat,
 		seq_printf(m, "\n  per-node stats");
 		for (i =3D 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
 			seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
-				   node_page_state(pgdat, i));
+				   node_page_state_pages(pgdat, i));
 		}
 	}
 	seq_printf(m,
@@ -1692,7 +1717,7 @@ static void *vmstat_start(struct seq_file *m, loff_=
t *pos)
 #endif
=20
 	for (i =3D 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-		v[i] =3D global_node_page_state(i);
+		v[i] =3D global_node_page_state_pages(i);
 	v +=3D NR_VM_NODE_STAT_ITEMS;
=20
 	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
--=20
2.25.3

