Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F17AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8EB7206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GECI5HpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387951AbgFWRlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:41:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7406 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387912AbgFWRk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:40:58 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NHePoH026264
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:40:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ydqxigM5yYic4GW9s4HzcT/umAZiOYZgw69ZMmKmh3U=;
 b=GECI5HpJkuAn1XSZIbYCqfse5+gie+KUvC75DckQEqAzOU44V+PQMEWNPi9PD/T+xivt
 67a4wqdck2Z3bA+vFEReAi2lJ88gABRzYZdn8BEfXQob+IwgIsfF61vwQIumS+ZzgWGp
 /7DxqUc6adQd1gpz/yaeSN8mwIqD93Uf4hs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31uk2uh5qn-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:40:56 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 10:40:46 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id B281D273E5DE; Tue, 23 Jun 2020 10:40:41 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1291.vll0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: vll0c01
Subject: [PATCH v7 06/19] mm: memcg/slab: obj_cgroup API
Date:   Tue, 23 Jun 2020 10:40:24 -0700
Message-ID: <20200623174037.3951353-7-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623174037.3951353-1-guro@fb.com>
References: <20200623174037.3951353-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=2
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230124
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obj_cgroup API provides an ability to account sub-page sized kernel
objects, which potentially outlive the original memory cgroup.

The top-level API consists of the following functions:
  bool obj_cgroup_tryget(struct obj_cgroup *objcg);
  void obj_cgroup_get(struct obj_cgroup *objcg);
  void obj_cgroup_put(struct obj_cgroup *objcg);

  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)=
;
  void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);

  struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg);
  struct obj_cgroup *get_obj_cgroup_from_current(void);

Object cgroup is basically a pointer to a memory cgroup with a per-cpu
reference counter.  It substitutes a memory cgroup in places where it's
necessary to charge a custom amount of bytes instead of pages.

All charged memory rounded down to pages is charged to the corresponding
memory cgroup using __memcg_kmem_charge().

It implements reparenting: on memcg offlining it's getting reattached to
the parent memory cgroup.  Each online memory cgroup has an associated
active object cgroup to handle new allocations and the list of all
attached object cgroups.  On offlining of a cgroup this list is reparente=
d
and for each object cgroup in the list the memcg pointer is swapped to th=
e
parent memory cgroup.  It prevents long-living objects from pinning the
original memory cgroup in the memory.

The implementation is based on byte-sized per-cpu stocks.  A sub-page
sized leftover is stored in an atomic field, which is a part of obj_cgrou=
p
object.  So on cgroup offlining the leftover is automatically reparented.

memcg->objcg is rcu protected.  objcg->memcg is a raw pointer, which is
always pointing at a memory cgroup, but can be atomically swapped to the
parent memory cgroup.  So a user must ensure the lifetime of the
cgroup, e.g.  grab rcu_read_lock or css_set_lock.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |  51 +++++++
 mm/memcontrol.c            | 288 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 338 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b250f8197710..f2f9d5d6b7d1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -23,6 +23,7 @@
 #include <linux/page-flags.h>
=20
 struct mem_cgroup;
+struct obj_cgroup;
 struct page;
 struct mm_struct;
 struct kmem_cache;
@@ -192,6 +193,22 @@ struct memcg_cgwb_frn {
 	struct wb_completion done;	/* tracks in-flight foreign writebacks */
 };
=20
+/*
+ * Bucket for arbitrarily byte-sized objects charged to a memory
+ * cgroup. The bucket can be reparented in one piece when the cgroup
+ * is destroyed, without having to round up the individual references
+ * of all live memory objects in the wild.
+ */
+struct obj_cgroup {
+	struct percpu_ref refcnt;
+	struct mem_cgroup *memcg;
+	atomic_t nr_charged_bytes;
+	union {
+		struct list_head list;
+		struct rcu_head rcu;
+	};
+};
+
 /*
  * The memory controller data structure. The memory controller controls =
both
  * page cache and RSS per cgroup. We would eventually like to provide
@@ -301,6 +318,8 @@ struct mem_cgroup {
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
 	struct list_head kmem_caches;
+	struct obj_cgroup __rcu *objcg;
+	struct list_head objcg_list; /* list of inherited objcgs */
 #endif
=20
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -416,6 +435,33 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup=
_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
 }
=20
+static inline bool obj_cgroup_tryget(struct obj_cgroup *objcg)
+{
+	return percpu_ref_tryget(&objcg->refcnt);
+}
+
+static inline void obj_cgroup_get(struct obj_cgroup *objcg)
+{
+	percpu_ref_get(&objcg->refcnt);
+}
+
+static inline void obj_cgroup_put(struct obj_cgroup *objcg)
+{
+	percpu_ref_put(&objcg->refcnt);
+}
+
+/*
+ * After the initialization objcg->memcg is always pointing at
+ * a valid memcg, but can be atomically swapped to the parent memcg.
+ *
+ * The caller must ensure that the returned memcg won't be released:
+ * e.g. acquire the rcu_read_lock or css_set_lock.
+ */
+static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *obj=
cg)
+{
+	return READ_ONCE(objcg->memcg);
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 	if (memcg)
@@ -1368,6 +1414,11 @@ void __memcg_kmem_uncharge(struct mem_cgroup *memc=
g, unsigned int nr_pages);
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
=20
+struct obj_cgroup *get_obj_cgroup_from_current(void);
+
+int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
+void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
+
 extern struct static_key_false memcg_kmem_enabled_key;
 extern struct workqueue_struct *memcg_kmem_cache_wq;
=20
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3e5597f8dec5..407f90f7a2f7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -257,6 +257,98 @@ struct cgroup_subsys_state *vmpressure_to_css(struct=
 vmpressure *vmpr)
 }
=20
 #ifdef CONFIG_MEMCG_KMEM
+extern spinlock_t css_set_lock;
+
+static void obj_cgroup_release(struct percpu_ref *ref)
+{
+	struct obj_cgroup *objcg =3D container_of(ref, struct obj_cgroup, refcn=
t);
+	struct mem_cgroup *memcg;
+	unsigned int nr_bytes;
+	unsigned int nr_pages;
+	unsigned long flags;
+
+	/*
+	 * At this point all allocated objects are freed, and
+	 * objcg->nr_charged_bytes can't have an arbitrary byte value.
+	 * However, it can be PAGE_SIZE or (x * PAGE_SIZE).
+	 *
+	 * The following sequence can lead to it:
+	 * 1) CPU0: objcg =3D=3D stock->cached_objcg
+	 * 2) CPU1: we do a small allocation (e.g. 92 bytes),
+	 *          PAGE_SIZE bytes are charged
+	 * 3) CPU1: a process from another memcg is allocating something,
+	 *          the stock if flushed,
+	 *          objcg->nr_charged_bytes =3D PAGE_SIZE - 92
+	 * 5) CPU0: we do release this object,
+	 *          92 bytes are added to stock->nr_bytes
+	 * 6) CPU0: stock is flushed,
+	 *          92 bytes are added to objcg->nr_charged_bytes
+	 *
+	 * In the result, nr_charged_bytes =3D=3D PAGE_SIZE.
+	 * This page will be uncharged in obj_cgroup_release().
+	 */
+	nr_bytes =3D atomic_read(&objcg->nr_charged_bytes);
+	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
+	nr_pages =3D nr_bytes >> PAGE_SHIFT;
+
+	spin_lock_irqsave(&css_set_lock, flags);
+	memcg =3D obj_cgroup_memcg(objcg);
+	if (nr_pages)
+		__memcg_kmem_uncharge(memcg, nr_pages);
+	list_del(&objcg->list);
+	mem_cgroup_put(memcg);
+	spin_unlock_irqrestore(&css_set_lock, flags);
+
+	percpu_ref_exit(ref);
+	kfree_rcu(objcg, rcu);
+}
+
+static struct obj_cgroup *obj_cgroup_alloc(void)
+{
+	struct obj_cgroup *objcg;
+	int ret;
+
+	objcg =3D kzalloc(sizeof(struct obj_cgroup), GFP_KERNEL);
+	if (!objcg)
+		return NULL;
+
+	ret =3D percpu_ref_init(&objcg->refcnt, obj_cgroup_release, 0,
+			      GFP_KERNEL);
+	if (ret) {
+		kfree(objcg);
+		return NULL;
+	}
+	INIT_LIST_HEAD(&objcg->list);
+	return objcg;
+}
+
+static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
+				  struct mem_cgroup *parent)
+{
+	struct obj_cgroup *objcg, *iter;
+
+	objcg =3D rcu_replace_pointer(memcg->objcg, NULL, true);
+
+	spin_lock_irq(&css_set_lock);
+
+	/* Move active objcg to the parent's list */
+	xchg(&objcg->memcg, parent);
+	css_get(&parent->css);
+	list_add(&objcg->list, &parent->objcg_list);
+
+	/* Move already reparented objcgs to the parent's list */
+	list_for_each_entry(iter, &memcg->objcg_list, list) {
+		css_get(&parent->css);
+		xchg(&iter->memcg, parent);
+		css_put(&memcg->css);
+	}
+	list_splice(&memcg->objcg_list, &parent->objcg_list);
+
+	spin_unlock_irq(&css_set_lock);
+
+	percpu_ref_kill(&objcg->refcnt);
+}
+
 /*
  * This will be the memcg's index in each cache's ->memcg_params.memcg_c=
aches.
  * The main reason for not using cgroup id for this:
@@ -2047,6 +2139,12 @@ EXPORT_SYMBOL(unlock_page_memcg);
 struct memcg_stock_pcp {
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
+
+#ifdef CONFIG_MEMCG_KMEM
+	struct obj_cgroup *cached_objcg;
+	unsigned int nr_bytes;
+#endif
+
 	struct work_struct work;
 	unsigned long flags;
 #define FLUSHING_CACHED_CHARGE	0
@@ -2054,6 +2152,22 @@ struct memcg_stock_pcp {
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
 static DEFINE_MUTEX(percpu_charge_mutex);
=20
+#ifdef CONFIG_MEMCG_KMEM
+static void drain_obj_stock(struct memcg_stock_pcp *stock);
+static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
+				     struct mem_cgroup *root_memcg);
+
+#else
+static inline void drain_obj_stock(struct memcg_stock_pcp *stock)
+{
+}
+static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
+				     struct mem_cgroup *root_memcg)
+{
+	return false;
+}
+#endif
+
 /**
  * consume_stock: Try to consume stocked charge on this cpu.
  * @memcg: memcg to consume from.
@@ -2120,6 +2234,7 @@ static void drain_local_stock(struct work_struct *d=
ummy)
 	local_irq_save(flags);
=20
 	stock =3D this_cpu_ptr(&memcg_stock);
+	drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
=20
@@ -2179,6 +2294,8 @@ static void drain_all_stock(struct mem_cgroup *root=
_memcg)
 		if (memcg && stock->nr_pages &&
 		    mem_cgroup_is_descendant(memcg, root_memcg))
 			flush =3D true;
+		if (obj_stock_flush_required(stock, root_memcg))
+			flush =3D true;
 		rcu_read_unlock();
=20
 		if (flush &&
@@ -2705,6 +2822,30 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	return page->mem_cgroup;
 }
=20
+__always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
+{
+	struct obj_cgroup *objcg =3D NULL;
+	struct mem_cgroup *memcg;
+
+	if (unlikely(!current->mm && !current->active_memcg))
+		return NULL;
+
+	rcu_read_lock();
+	if (unlikely(current->active_memcg))
+		memcg =3D rcu_dereference(current->active_memcg);
+	else
+		memcg =3D mem_cgroup_from_task(current);
+
+	for (; memcg !=3D root_mem_cgroup; memcg =3D parent_mem_cgroup(memcg)) =
{
+		objcg =3D rcu_dereference(memcg->objcg);
+		if (objcg && obj_cgroup_tryget(objcg))
+			break;
+	}
+	rcu_read_unlock();
+
+	return objcg;
+}
+
 static int memcg_alloc_cache_id(void)
 {
 	int id, size;
@@ -2996,6 +3137,140 @@ void __memcg_kmem_uncharge_page(struct page *page=
, int order)
 	if (PageKmemcg(page))
 		__ClearPageKmemcg(page);
 }
+
+static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_=
bytes)
+{
+	struct memcg_stock_pcp *stock;
+	unsigned long flags;
+	bool ret =3D false;
+
+	local_irq_save(flags);
+
+	stock =3D this_cpu_ptr(&memcg_stock);
+	if (objcg =3D=3D stock->cached_objcg && stock->nr_bytes >=3D nr_bytes) =
{
+		stock->nr_bytes -=3D nr_bytes;
+		ret =3D true;
+	}
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static void drain_obj_stock(struct memcg_stock_pcp *stock)
+{
+	struct obj_cgroup *old =3D stock->cached_objcg;
+
+	if (!old)
+		return;
+
+	if (stock->nr_bytes) {
+		unsigned int nr_pages =3D stock->nr_bytes >> PAGE_SHIFT;
+		unsigned int nr_bytes =3D stock->nr_bytes & (PAGE_SIZE - 1);
+
+		if (nr_pages) {
+			rcu_read_lock();
+			__memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
+			rcu_read_unlock();
+		}
+
+		/*
+		 * The leftover is flushed to the centralized per-memcg value.
+		 * On the next attempt to refill obj stock it will be moved
+		 * to a per-cpu stock (probably, on an other CPU), see
+		 * refill_obj_stock().
+		 *
+		 * How often it's flushed is a trade-off between the memory
+		 * limit enforcement accuracy and potential CPU contention,
+		 * so it might be changed in the future.
+		 */
+		atomic_add(nr_bytes, &old->nr_charged_bytes);
+		stock->nr_bytes =3D 0;
+	}
+
+	obj_cgroup_put(old);
+	stock->cached_objcg =3D NULL;
+}
+
+static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
+				     struct mem_cgroup *root_memcg)
+{
+	struct mem_cgroup *memcg;
+
+	if (stock->cached_objcg) {
+		memcg =3D obj_cgroup_memcg(stock->cached_objcg);
+		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
+			return true;
+	}
+
+	return false;
+}
+
+static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_b=
ytes)
+{
+	struct memcg_stock_pcp *stock;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	stock =3D this_cpu_ptr(&memcg_stock);
+	if (stock->cached_objcg !=3D objcg) { /* reset if necessary */
+		drain_obj_stock(stock);
+		obj_cgroup_get(objcg);
+		stock->cached_objcg =3D objcg;
+		stock->nr_bytes =3D atomic_xchg(&objcg->nr_charged_bytes, 0);
+	}
+	stock->nr_bytes +=3D nr_bytes;
+
+	if (stock->nr_bytes > PAGE_SIZE)
+		drain_obj_stock(stock);
+
+	local_irq_restore(flags);
+}
+
+int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
+{
+	struct mem_cgroup *memcg;
+	unsigned int nr_pages, nr_bytes;
+	int ret;
+
+	if (consume_obj_stock(objcg, size))
+		return 0;
+
+	/*
+	 * In theory, memcg->nr_charged_bytes can have enough
+	 * pre-charged bytes to satisfy the allocation. However,
+	 * flushing memcg->nr_charged_bytes requires two atomic
+	 * operations, and memcg->nr_charged_bytes can't be big,
+	 * so it's better to ignore it and try grab some new pages.
+	 * memcg->nr_charged_bytes will be flushed in
+	 * refill_obj_stock(), called from this function or
+	 * independently later.
+	 */
+	rcu_read_lock();
+	memcg =3D obj_cgroup_memcg(objcg);
+	css_get(&memcg->css);
+	rcu_read_unlock();
+
+	nr_pages =3D size >> PAGE_SHIFT;
+	nr_bytes =3D size & (PAGE_SIZE - 1);
+
+	if (nr_bytes)
+		nr_pages +=3D 1;
+
+	ret =3D __memcg_kmem_charge(memcg, gfp, nr_pages);
+	if (!ret && nr_bytes)
+		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
+
+	css_put(&memcg->css);
+	return ret;
+}
+
+void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
+{
+	refill_obj_stock(objcg, size);
+}
+
 #endif /* CONFIG_MEMCG_KMEM */
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -3416,6 +3691,7 @@ static void memcg_flush_percpu_vmevents(struct mem_=
cgroup *memcg)
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
+	struct obj_cgroup *objcg;
 	int memcg_id;
=20
 	if (cgroup_memory_nokmem)
@@ -3428,6 +3704,14 @@ static int memcg_online_kmem(struct mem_cgroup *me=
mcg)
 	if (memcg_id < 0)
 		return memcg_id;
=20
+	objcg =3D obj_cgroup_alloc();
+	if (!objcg) {
+		memcg_free_cache_id(memcg_id);
+		return -ENOMEM;
+	}
+	objcg->memcg =3D memcg;
+	rcu_assign_pointer(memcg->objcg, objcg);
+
 	static_branch_inc(&memcg_kmem_enabled_key);
 	/*
 	 * A memory cgroup is considered kmem-online as soon as it gets
@@ -3463,9 +3747,10 @@ static void memcg_offline_kmem(struct mem_cgroup *=
memcg)
 		parent =3D root_mem_cgroup;
=20
 	/*
-	 * Deactivate and reparent kmem_caches.
+	 * Deactivate and reparent kmem_caches and objcgs.
 	 */
 	memcg_deactivate_kmem_caches(memcg, parent);
+	memcg_reparent_objcgs(memcg, parent);
=20
 	kmemcg_id =3D memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
@@ -5034,6 +5319,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->socket_pressure =3D jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id =3D -1;
+	INIT_LIST_HEAD(&memcg->objcg_list);
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
--=20
2.26.2

