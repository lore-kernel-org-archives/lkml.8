Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D99C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8B020829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cW7DAo+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgIJUrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:47:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39454 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgIJU1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:27:15 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AKJrkX023692
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:27:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pxL6C6slAXM/4e5kZiFDoO4ZMGsuovxE7jduAqGktPQ=;
 b=cW7DAo+GV1VWjyhhS8Ic/K2XODglRypR+VJB5RuWglymEBuFYCCpbgxM9K9WOFrsCPfp
 yyRz1RNNtxEVxINvoi/gZMxGoJ0TABy8LXgrrT3bpvhEFmb7i41yIDqzcC1G1v9UoHXL
 Nma0fX529A1mOpcuKbVct2zFrZ4ftFIuIuk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33f8bfddw5-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:27:13 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 13:27:09 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id B162A3D449B4; Thu, 10 Sep 2020 13:27:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH rfc 2/5] mm: memcontrol: use helpers to access page's memcg data
Date:   Thu, 10 Sep 2020 13:26:56 -0700
Message-ID: <20200910202659.1378404-3-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200910202659.1378404-1-guro@fb.com>
References: <20200910202659.1378404-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_09:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=2 clxscore=1015
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100183
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are many open-coded reads and writes of the page->mem_cgr=
oup
pointer, as well as a couple of read helpers, which are barely used.

It creates an obstacle on a way to reuse some bits of the pointer
for storing additional bits of information. In fact, we already do
this for slab pages, where the last bit indicates that a pointer has
an attached vector of objcg pointers instead of a regular memcg
pointer.

This commits introduces 4 new helper functions and converts all
raw accesses to page->mem_cgroup to calls of these helpers:
  struct mem_cgroup *page_mem_cgroup(struct page *page);
  struct mem_cgroup *page_mem_cgroup_check(struct page *page);
  void set_page_mem_cgroup(struct page *page, struct mem_cgroup *memcg);
  void clear_page_mem_cgroup(struct page *page);

page_mem_cgroup_check() is intended to be used in cases when the page
can be a slab page and have a memcg pointer pointing at objcg vector.
It does check the lowest bit, and if set, returns NULL.
page_mem_cgroup() contains a VM_BUG_ON_PAGE() check for the page not
being a slab page. So do set_page_mem_cgroup() and clear_page_mem_cgroup(=
).

To make sure nobody uses a direct access, struct page's
mem_cgroup/obj_cgroups is converted to unsigned long memcg_data.
Only new helpers and a couple of slab-accounting related functions
access this field directly.

page_memcg() and page_memcg_rcu() helpers defined in mm.h are removed.
New page_mem_cgroup() is a direct analog of page_memcg(), while
page_memcg_rcu() has a single call site in a small rcu-read-lock
section, so it's just not worth it to have a separate helper. So
it's replaced with page_mem_cgroup() too.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h       |  72 +++++++++++++++++---
 include/linux/mm.h               |  22 ------
 include/linux/mm_types.h         |   5 +-
 include/trace/events/writeback.h |   2 +-
 mm/debug.c                       |   4 +-
 mm/huge_memory.c                 |   4 +-
 mm/memcontrol.c                  | 111 +++++++++++++------------------
 mm/migrate.c                     |   2 +-
 mm/page_alloc.c                  |   4 +-
 mm/page_io.c                     |   4 +-
 mm/slab.h                        |   7 +-
 mm/workingset.c                  |   4 +-
 12 files changed, 124 insertions(+), 117 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 924177502479..0997220c84ce 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -340,6 +340,41 @@ struct mem_cgroup {
=20
 extern struct mem_cgroup *root_mem_cgroup;
=20
+static inline struct mem_cgroup *page_mem_cgroup(struct page *page)
+{
+	VM_BUG_ON_PAGE(PageSlab(page), page);
+	return (struct mem_cgroup *)page->memcg_data;
+}
+
+static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page=
)
+{
+	unsigned long memcg_data =3D page->memcg_data;
+
+	/*
+	 * The lowest bit set means that memcg isn't a valid
+	 * memcg pointer, but a obj_cgroups pointer.
+	 * In this case the page is shared and doesn't belong
+	 * to any specific memory cgroup.
+	 */
+	if (memcg_data & 0x1UL)
+		return NULL;
+
+	return (struct mem_cgroup *)memcg_data;
+}
+
+static inline void set_page_mem_cgroup(struct page *page,
+				       struct mem_cgroup *memcg)
+{
+	VM_BUG_ON_PAGE(PageSlab(page), page);
+	page->memcg_data =3D (unsigned long)memcg;
+}
+
+static inline void clear_page_mem_cgroup(struct page *page)
+{
+	VM_BUG_ON_PAGE(PageSlab(page), page);
+	page->memcg_data =3D 0;
+}
+
 static __always_inline bool memcg_stat_item_in_bytes(int idx)
 {
 	if (idx =3D=3D MEMCG_PERCPU_B)
@@ -740,15 +775,15 @@ static inline void mod_memcg_state(struct mem_cgrou=
p *memcg,
 static inline void __mod_memcg_page_state(struct page *page,
 					  int idx, int val)
 {
-	if (page->mem_cgroup)
-		__mod_memcg_state(page->mem_cgroup, idx, val);
+	if (page_mem_cgroup(page))
+		__mod_memcg_state(page_mem_cgroup(page), idx, val);
 }
=20
 static inline void mod_memcg_page_state(struct page *page,
 					int idx, int val)
 {
-	if (page->mem_cgroup)
-		mod_memcg_state(page->mem_cgroup, idx, val);
+	if (page_mem_cgroup(page))
+		mod_memcg_state(page_mem_cgroup(page), idx, val);
 }
=20
 static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
@@ -835,12 +870,12 @@ static inline void __mod_lruvec_page_state(struct p=
age *page,
 	struct lruvec *lruvec;
=20
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!head->mem_cgroup) {
+	if (!page_mem_cgroup(head)) {
 		__mod_node_page_state(pgdat, idx, val);
 		return;
 	}
=20
-	lruvec =3D mem_cgroup_lruvec(head->mem_cgroup, pgdat);
+	lruvec =3D mem_cgroup_lruvec(page_mem_cgroup(head), pgdat);
 	__mod_lruvec_state(lruvec, idx, val);
 }
=20
@@ -875,8 +910,8 @@ static inline void count_memcg_events(struct mem_cgro=
up *memcg,
 static inline void count_memcg_page_event(struct page *page,
 					  enum vm_event_item idx)
 {
-	if (page->mem_cgroup)
-		count_memcg_events(page->mem_cgroup, idx, 1);
+	if (page_mem_cgroup(page))
+		count_memcg_events(page_mem_cgroup(page), idx, 1);
 }
=20
 static inline void count_memcg_event_mm(struct mm_struct *mm,
@@ -938,6 +973,25 @@ void mem_cgroup_split_huge_fixup(struct page *head);
=20
 struct mem_cgroup;
=20
+static inline struct mem_cgroup *page_mem_cgroup(struct page *page)
+{
+	return NULL;
+}
+
+static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page=
)
+{
+	return NULL;
+}
+
+static inline void set_page_mem_cgroup(struct page *page,
+				       struct mem_cgroup *memcg)
+{
+}
+
+static inline void clear_page_mem_cgroup(struct page *page)
+{
+}
+
 static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 {
 	return true;
@@ -1427,7 +1481,7 @@ static inline void mem_cgroup_track_foreign_dirty(s=
truct page *page,
 	if (mem_cgroup_disabled())
 		return;
=20
-	if (unlikely(&page->mem_cgroup->css !=3D wb->memcg_css))
+	if (unlikely(&page_mem_cgroup(page)->css !=3D wb->memcg_css))
 		mem_cgroup_track_foreign_dirty_slowpath(page, wb);
 }
=20
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 517751310dd2..dc4eb3b150fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1474,28 +1474,6 @@ static inline void set_page_links(struct page *pag=
e, enum zone_type zone,
 #endif
 }
=20
-#ifdef CONFIG_MEMCG
-static inline struct mem_cgroup *page_memcg(struct page *page)
-{
-	return page->mem_cgroup;
-}
-static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
-{
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return READ_ONCE(page->mem_cgroup);
-}
-#else
-static inline struct mem_cgroup *page_memcg(struct page *page)
-{
-	return NULL;
-}
-static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
-{
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return NULL;
-}
-#endif
-
 /*
  * Some inline functions in vmstat.h depend on page_zone()
  */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 496c3ff97cce..4856d23b1161 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -199,10 +199,7 @@ struct page {
 	atomic_t _refcount;
=20
 #ifdef CONFIG_MEMCG
-	union {
-		struct mem_cgroup *mem_cgroup;
-		struct obj_cgroup **obj_cgroups;
-	};
+	unsigned long memcg_data;
 #endif
=20
 	/*
diff --git a/include/trace/events/writeback.h b/include/trace/events/writ=
eback.h
index e7cbccc7c14c..b1fa3ac64fa5 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -257,7 +257,7 @@ TRACE_EVENT(track_foreign_dirty,
 		__entry->ino		=3D inode ? inode->i_ino : 0;
 		__entry->memcg_id	=3D wb->memcg_css->id;
 		__entry->cgroup_ino	=3D __trace_wb_assign_cgroup(wb);
-		__entry->page_cgroup_ino =3D cgroup_ino(page->mem_cgroup->css.cgroup);
+		__entry->page_cgroup_ino =3D cgroup_ino(page_mem_cgroup(page)->css.cgr=
oup);
 	),
=20
 	TP_printk("bdi %s[%llu]: ino=3D%lu memcg_id=3D%u cgroup_ino=3D%lu page_=
cgroup_ino=3D%lu",
diff --git a/mm/debug.c b/mm/debug.c
index ccca576b2899..55d1c42c7da8 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -182,8 +182,8 @@ void __dump_page(struct page *page, const char *reaso=
n)
 		pr_warn("page dumped because: %s\n", reason);
=20
 #ifdef CONFIG_MEMCG
-	if (!page_poisoned && page->mem_cgroup)
-		pr_warn("page->mem_cgroup:%px\n", page->mem_cgroup);
+	if (!page_poisoned && page_mem_cgroup(page))
+		pr_warn("page->mem_cgroup:%px\n", page_mem_cgroup(page));
 #endif
 }
=20
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a468a4acb0a..7ca3baea9810 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -470,7 +470,7 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_str=
uct *vma)
 #ifdef CONFIG_MEMCG
 static inline struct deferred_split *get_deferred_split_queue(struct pag=
e *page)
 {
-	struct mem_cgroup *memcg =3D compound_head(page)->mem_cgroup;
+	struct mem_cgroup *memcg =3D page_mem_cgroup(compound_head(page));
 	struct pglist_data *pgdat =3D NODE_DATA(page_to_nid(page));
=20
 	if (memcg)
@@ -2728,7 +2728,7 @@ void deferred_split_huge_page(struct page *page)
 {
 	struct deferred_split *ds_queue =3D get_deferred_split_queue(page);
 #ifdef CONFIG_MEMCG
-	struct mem_cgroup *memcg =3D compound_head(page)->mem_cgroup;
+	struct mem_cgroup *memcg =3D page_mem_cgroup(compound_head(page));
 #endif
 	unsigned long flags;
=20
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 093526fec4bf..19180674e38a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -541,7 +541,7 @@ struct cgroup_subsys_state *mem_cgroup_css_from_page(=
struct page *page)
 {
 	struct mem_cgroup *memcg;
=20
-	memcg =3D page->mem_cgroup;
+	memcg =3D page_mem_cgroup(page);
=20
 	if (!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		memcg =3D root_mem_cgroup;
@@ -568,16 +568,7 @@ ino_t page_cgroup_ino(struct page *page)
 	unsigned long ino =3D 0;
=20
 	rcu_read_lock();
-	memcg =3D page->mem_cgroup;
-
-	/*
-	 * The lowest bit set means that memcg isn't a valid
-	 * memcg pointer, but a obj_cgroups pointer.
-	 * In this case the page is shared and doesn't belong
-	 * to any specific memory cgroup.
-	 */
-	if ((unsigned long) memcg & 0x1UL)
-		memcg =3D NULL;
+	memcg =3D page_mem_cgroup_check(page);
=20
 	while (memcg && !(memcg->css.flags & CSS_ONLINE))
 		memcg =3D parent_mem_cgroup(memcg);
@@ -1058,7 +1049,7 @@ EXPORT_SYMBOL(get_mem_cgroup_from_mm);
  */
 struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
 {
-	struct mem_cgroup *memcg =3D page->mem_cgroup;
+	struct mem_cgroup *memcg =3D page_mem_cgroup(page);
=20
 	if (mem_cgroup_disabled())
 		return NULL;
@@ -1343,7 +1334,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
  * @page: the page
  * @pgdat: pgdat of the page
  *
- * This function relies on page->mem_cgroup being stable - see the
+ * This function relies on page and memcg binding being stable - see the
  * access rules in commit_charge().
  */
 struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_d=
ata *pgdat)
@@ -1357,7 +1348,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *=
page, struct pglist_data *pgd
 		goto out;
 	}
=20
-	memcg =3D page->mem_cgroup;
+	memcg =3D page_mem_cgroup(page);
 	/*
 	 * Swapcache readahead pages are added to the LRU - and
 	 * possibly migrated - before they are charged.
@@ -2100,7 +2091,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *=
memcg)
 }
=20
 /**
- * lock_page_memcg - lock a page->mem_cgroup binding
+ * lock_page_memcg - lock a page and memcg binding
  * @page: the page
  *
  * This function protects unlocked LRU pages from being moved to
@@ -2132,7 +2123,7 @@ struct mem_cgroup *lock_page_memcg(struct page *pag=
e)
 	if (mem_cgroup_disabled())
 		return NULL;
 again:
-	memcg =3D head->mem_cgroup;
+	memcg =3D page_mem_cgroup(head);
 	if (unlikely(!memcg))
 		return NULL;
=20
@@ -2140,7 +2131,7 @@ struct mem_cgroup *lock_page_memcg(struct page *pag=
e)
 		return memcg;
=20
 	spin_lock_irqsave(&memcg->move_lock, flags);
-	if (memcg !=3D head->mem_cgroup) {
+	if (memcg !=3D page_mem_cgroup(head)) {
 		spin_unlock_irqrestore(&memcg->move_lock, flags);
 		goto again;
 	}
@@ -2178,14 +2169,14 @@ void __unlock_page_memcg(struct mem_cgroup *memcg=
)
 }
=20
 /**
- * unlock_page_memcg - unlock a page->mem_cgroup binding
+ * unlock_page_memcg - unlock a page and memcg binding
  * @page: the page
  */
 void unlock_page_memcg(struct page *page)
 {
 	struct page *head =3D compound_head(page);
=20
-	__unlock_page_memcg(head->mem_cgroup);
+	__unlock_page_memcg(page_mem_cgroup(head));
 }
 EXPORT_SYMBOL(unlock_page_memcg);
=20
@@ -2875,16 +2866,16 @@ static void cancel_charge(struct mem_cgroup *memc=
g, unsigned int nr_pages)
=20
 static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 {
-	VM_BUG_ON_PAGE(page->mem_cgroup, page);
+	VM_BUG_ON_PAGE(page_mem_cgroup(page), page);
 	/*
-	 * Any of the following ensures page->mem_cgroup stability:
+	 * Any of the following ensures page and memcg binding stability:
 	 *
 	 * - the page lock
 	 * - LRU isolation
 	 * - lock_page_memcg()
 	 * - exclusive reference
 	 */
-	page->mem_cgroup =3D memcg;
+	set_page_mem_cgroup(page, memcg);
 }
=20
 #ifdef CONFIG_MEMCG_KMEM
@@ -2899,8 +2890,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page,=
 struct kmem_cache *s,
 	if (!vec)
 		return -ENOMEM;
=20
-	if (cmpxchg(&page->obj_cgroups, NULL,
-		    (struct obj_cgroup **) ((unsigned long)vec | 0x1UL)))
+	if (cmpxchg(&page->memcg_data, 0, (unsigned long)vec | 0x1UL))
 		kfree(vec);
 	else
 		kmemleak_not_leak(vec);
@@ -2923,17 +2913,6 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
=20
 	page =3D virt_to_head_page(p);
=20
-	/*
-	 * If page->mem_cgroup is set, it's either a simple mem_cgroup pointer
-	 * or a pointer to obj_cgroup vector. In the latter case the lowest
-	 * bit of the pointer is set.
-	 * The page->mem_cgroup pointer can be asynchronously changed
-	 * from NULL to (obj_cgroup_vec | 0x1UL), but can't be changed
-	 * from a valid memcg pointer to objcg vector or back.
-	 */
-	if (!page->mem_cgroup)
-		return NULL;
-
 	/*
 	 * Slab objects are accounted individually, not per-page.
 	 * Memcg membership data for each individual object is saved in
@@ -2952,7 +2931,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	}
=20
 	/* All other pages use page->mem_cgroup */
-	return page->mem_cgroup;
+	return page_mem_cgroup_check(page);
 }
=20
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
@@ -3090,7 +3069,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp=
_t gfp, int order)
 	if (memcg && !mem_cgroup_is_root(memcg)) {
 		ret =3D __memcg_kmem_charge(memcg, gfp, 1 << order);
 		if (!ret) {
-			page->mem_cgroup =3D memcg;
+			set_page_mem_cgroup(page, memcg);
 			__SetPageKmemcg(page);
 			return 0;
 		}
@@ -3106,7 +3085,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp=
_t gfp, int order)
  */
 void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
-	struct mem_cgroup *memcg =3D page->mem_cgroup;
+	struct mem_cgroup *memcg =3D page_mem_cgroup(page);
 	unsigned int nr_pages =3D 1 << order;
=20
 	if (!memcg)
@@ -3114,7 +3093,7 @@ void __memcg_kmem_uncharge_page(struct page *page, =
int order)
=20
 	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
 	__memcg_kmem_uncharge(memcg, nr_pages);
-	page->mem_cgroup =3D NULL;
+	clear_page_mem_cgroup(page);
 	css_put(&memcg->css);
=20
 	/* slab pages do not have PageKmemcg flag set */
@@ -3265,7 +3244,7 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, =
size_t size)
  */
 void mem_cgroup_split_huge_fixup(struct page *head)
 {
-	struct mem_cgroup *memcg =3D head->mem_cgroup;
+	struct mem_cgroup *memcg =3D page_mem_cgroup(head);
 	int i;
=20
 	if (mem_cgroup_disabled())
@@ -3273,7 +3252,7 @@ void mem_cgroup_split_huge_fixup(struct page *head)
=20
 	for (i =3D 1; i < HPAGE_PMD_NR; i++) {
 		css_get(&memcg->css);
-		head[i].mem_cgroup =3D memcg;
+		set_page_mem_cgroup(&head[i], memcg);
 	}
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -4649,7 +4628,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, =
unsigned long *pfilepages,
 void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 					     struct bdi_writeback *wb)
 {
-	struct mem_cgroup *memcg =3D page->mem_cgroup;
+	struct mem_cgroup *memcg =3D page_mem_cgroup(page);
 	struct memcg_cgwb_frn *frn;
 	u64 now =3D get_jiffies_64();
 	u64 oldest_at =3D now;
@@ -5641,14 +5620,14 @@ static int mem_cgroup_move_account(struct page *p=
age,
=20
 	/*
 	 * Prevent mem_cgroup_migrate() from looking at
-	 * page->mem_cgroup of its source page while we change it.
+	 * page_mem_cgroup(page) of its source page while we change it.
 	 */
 	ret =3D -EBUSY;
 	if (!trylock_page(page))
 		goto out;
=20
 	ret =3D -EINVAL;
-	if (page->mem_cgroup !=3D from)
+	if (page_mem_cgroup(page) !=3D from)
 		goto out_unlock;
=20
 	pgdat =3D page_pgdat(page);
@@ -5703,13 +5682,13 @@ static int mem_cgroup_move_account(struct page *p=
age,
 	/*
 	 * All state has been migrated, let's switch to the new memcg.
 	 *
-	 * It is safe to change page->mem_cgroup here because the page
+	 * It is safe to change page's memcg here because the page
 	 * is referenced, charged, isolated, and locked: we can't race
 	 * with (un)charging, migration, LRU putback, or anything else
-	 * that would rely on a stable page->mem_cgroup.
+	 * that would rely on a stable page_mem_cgroup(page).
 	 *
 	 * Note that lock_page_memcg is a memcg lock, not a page lock,
-	 * to save space. As soon as we switch page->mem_cgroup to a
+	 * to save space. As soon as we switch page_mem_cgroup(page) to a
 	 * new memcg that isn't locked, the above state can change
 	 * concurrently again. Make sure we're truly done with it.
 	 */
@@ -5718,7 +5697,7 @@ static int mem_cgroup_move_account(struct page *pag=
e,
 	css_get(&to->css);
 	css_put(&from->css);
=20
-	page->mem_cgroup =3D to;
+	set_page_mem_cgroup(page, to);
=20
 	__unlock_page_memcg(from);
=20
@@ -5784,7 +5763,7 @@ static enum mc_target_type get_mctgt_type(struct vm=
_area_struct *vma,
 		 * mem_cgroup_move_account() checks the page is valid or
 		 * not under LRU exclusion.
 		 */
-		if (page->mem_cgroup =3D=3D mc.from) {
+		if (page_mem_cgroup(page) =3D=3D mc.from) {
 			ret =3D MC_TARGET_PAGE;
 			if (is_device_private_page(page))
 				ret =3D MC_TARGET_DEVICE;
@@ -5828,7 +5807,7 @@ static enum mc_target_type get_mctgt_type_thp(struc=
t vm_area_struct *vma,
 	VM_BUG_ON_PAGE(!page || !PageHead(page), page);
 	if (!(mc.flags & MOVE_ANON))
 		return ret;
-	if (page->mem_cgroup =3D=3D mc.from) {
+	if (page_mem_cgroup(page) =3D=3D mc.from) {
 		ret =3D MC_TARGET_PAGE;
 		if (target) {
 			get_page(page);
@@ -6739,12 +6718,12 @@ int mem_cgroup_charge(struct page *page, struct m=
m_struct *mm, gfp_t gfp_mask)
 		/*
 		 * Every swap fault against a single page tries to charge the
 		 * page, bail as early as possible.  shmem_unuse() encounters
-		 * already charged pages, too.  page->mem_cgroup is protected
-		 * by the page lock, which serializes swap cache removal, which
-		 * in turn serializes uncharging.
+		 * already charged pages, too.  page and memcg binding is
+		 * protected by the page lock, which serializes swap cache
+		 * removal, which in turn serializes uncharging.
 		 */
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		if (compound_head(page)->mem_cgroup)
+		if (page_mem_cgroup(compound_head(page)))
 			goto out;
=20
 		id =3D lookup_swap_cgroup_id(ent);
@@ -6828,21 +6807,21 @@ static void uncharge_page(struct page *page, stru=
ct uncharge_gather *ug)
=20
 	VM_BUG_ON_PAGE(PageLRU(page), page);
=20
-	if (!page->mem_cgroup)
+	if (!page_mem_cgroup(page))
 		return;
=20
 	/*
 	 * Nobody should be changing or seriously looking at
-	 * page->mem_cgroup at this point, we have fully
+	 * page_mem_cgroup(page) at this point, we have fully
 	 * exclusive access to the page.
 	 */
=20
-	if (ug->memcg !=3D page->mem_cgroup) {
+	if (ug->memcg !=3D page_mem_cgroup(page)) {
 		if (ug->memcg) {
 			uncharge_batch(ug);
 			uncharge_gather_clear(ug);
 		}
-		ug->memcg =3D page->mem_cgroup;
+		ug->memcg =3D page_mem_cgroup(page);
=20
 		/* pairs with css_put in uncharge_batch */
 		css_get(&ug->memcg->css);
@@ -6859,7 +6838,7 @@ static void uncharge_page(struct page *page, struct=
 uncharge_gather *ug)
 	}
=20
 	ug->dummy_page =3D page;
-	page->mem_cgroup =3D NULL;
+	clear_page_mem_cgroup(page);
 	css_put(&ug->memcg->css);
 }
=20
@@ -6902,7 +6881,7 @@ void mem_cgroup_uncharge(struct page *page)
 		return;
=20
 	/* Don't touch page->lru of any random page, pre-check: */
-	if (!page->mem_cgroup)
+	if (!page_mem_cgroup(page))
 		return;
=20
 	uncharge_gather_clear(&ug);
@@ -6952,11 +6931,11 @@ void mem_cgroup_migrate(struct page *oldpage, str=
uct page *newpage)
 		return;
=20
 	/* Page cache replacement: new page already charged? */
-	if (newpage->mem_cgroup)
+	if (page_mem_cgroup(newpage))
 		return;
=20
 	/* Swapcache readahead pages can get replaced before being charged */
-	memcg =3D oldpage->mem_cgroup;
+	memcg =3D page_mem_cgroup(oldpage);
 	if (!memcg)
 		return;
=20
@@ -7151,7 +7130,7 @@ void mem_cgroup_swapout(struct page *page, swp_entr=
y_t entry)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
=20
-	memcg =3D page->mem_cgroup;
+	memcg =3D page_mem_cgroup(page);
=20
 	/* Readahead page, never charged */
 	if (!memcg)
@@ -7172,7 +7151,7 @@ void mem_cgroup_swapout(struct page *page, swp_entr=
y_t entry)
 	VM_BUG_ON_PAGE(oldid, page);
 	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
=20
-	page->mem_cgroup =3D NULL;
+	clear_page_mem_cgroup(page);
=20
 	if (!mem_cgroup_is_root(memcg))
 		page_counter_uncharge(&memcg->memory, nr_entries);
@@ -7215,7 +7194,7 @@ int mem_cgroup_try_charge_swap(struct page *page, s=
wp_entry_t entry)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return 0;
=20
-	memcg =3D page->mem_cgroup;
+	memcg =3D page_mem_cgroup(page);
=20
 	/* Readahead page, never charged */
 	if (!memcg)
@@ -7296,7 +7275,7 @@ bool mem_cgroup_swap_full(struct page *page)
 	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return false;
=20
-	memcg =3D page->mem_cgroup;
+	memcg =3D page_mem_cgroup(page);
 	if (!memcg)
 		return false;
=20
diff --git a/mm/migrate.c b/mm/migrate.c
index 659d3d8a3e1f..6c3b542395e7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -493,7 +493,7 @@ int migrate_page_move_mapping(struct address_space *m=
apping,
 		struct lruvec *old_lruvec, *new_lruvec;
 		struct mem_cgroup *memcg;
=20
-		memcg =3D page_memcg(page);
+		memcg =3D page_mem_cgroup(page);
 		old_lruvec =3D mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
 		new_lruvec =3D mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
=20
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0d9f9bd0e06c..a707671f3b6c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1056,7 +1056,7 @@ static inline bool page_expected_state(struct page =
*page,
 	if (unlikely((unsigned long)page->mapping |
 			page_ref_count(page) |
 #ifdef CONFIG_MEMCG
-			(unsigned long)page->mem_cgroup |
+			(unsigned long)page_mem_cgroup(page) |
 #endif
 			(page->flags & check_flags)))
 		return false;
@@ -1081,7 +1081,7 @@ static const char *page_bad_reason(struct page *pag=
e, unsigned long flags)
 			bad_reason =3D "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
 	}
 #ifdef CONFIG_MEMCG
-	if (unlikely(page->mem_cgroup))
+	if (unlikely(page_mem_cgroup(page)))
 		bad_reason =3D "page still charged to cgroup";
 #endif
 	return bad_reason;
diff --git a/mm/page_io.c b/mm/page_io.c
index dc6de6962612..ffa3a7d20c58 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -282,11 +282,11 @@ static void bio_associate_blkg_from_page(struct bio=
 *bio, struct page *page)
 {
 	struct cgroup_subsys_state *css;
=20
-	if (!page->mem_cgroup)
+	if (!page_mem_cgroup(page))
 		return;
=20
 	rcu_read_lock();
-	css =3D cgroup_e_css(page->mem_cgroup->css.cgroup, &io_cgrp_subsys);
+	css =3D cgroup_e_css(page_mem_cgroup(page)->css.cgroup, &io_cgrp_subsys=
);
 	bio_associate_blkg_from_css(bio, css);
 	rcu_read_unlock();
 }
diff --git a/mm/slab.h b/mm/slab.h
index 4a24e1702923..b9787c4d6e78 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -247,13 +247,12 @@ static inline struct obj_cgroup **page_obj_cgroups(=
struct page *page)
 	 * that the page is a slab page (e.g. page_cgroup_ino()), let's
 	 * always set the lowest bit of obj_cgroups.
 	 */
-	return (struct obj_cgroup **)
-		((unsigned long)page->obj_cgroups & ~0x1UL);
+	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
 }
=20
 static inline bool page_has_obj_cgroups(struct page *page)
 {
-	return ((unsigned long)page->obj_cgroups & 0x1UL);
+	return page->memcg_data & 0x1UL;
 }
=20
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s=
,
@@ -262,7 +261,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page, s=
truct kmem_cache *s,
 static inline void memcg_free_page_obj_cgroups(struct page *page)
 {
 	kfree(page_obj_cgroups(page));
-	page->obj_cgroups =3D NULL;
+	page->memcg_data =3D 0;
 }
=20
 static inline size_t obj_full_size(struct kmem_cache *s)
diff --git a/mm/workingset.c b/mm/workingset.c
index 92e66113a577..c0b7a4faa0d8 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -345,7 +345,7 @@ void workingset_refault(struct page *page, void *shad=
ow)
 	 * However, the cgroup that will own the page is the one that
 	 * is actually experiencing the refault event.
 	 */
-	memcg =3D page_memcg(page);
+	memcg =3D page_mem_cgroup(page);
 	lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
=20
 	inc_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file);
@@ -407,7 +407,7 @@ void workingset_activation(struct page *page)
 	 * XXX: See workingset_refault() - this should return
 	 * root_mem_cgroup even for !CONFIG_MEMCG.
 	 */
-	memcg =3D page_memcg_rcu(page);
+	memcg =3D page_mem_cgroup(page);
 	if (!mem_cgroup_disabled() && !memcg)
 		goto out;
 	lruvec =3D mem_cgroup_page_lruvec(page, page_pgdat(page));
--=20
2.26.2

