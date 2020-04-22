Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865CEC5518C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563F52077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TkE7w2QN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDVUr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:47:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10440 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbgDVUrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:47:23 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03MKimvm002555
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=G27qWnhB4sIuTG7rtqcAAfwhb0Gq7cbH2bwnCW8tUrM=;
 b=TkE7w2QNBpS/raumlYvw0w1pz94Sg+eNbOknzE3Xz8E+UYMaaOzQ0vREpsV3wndALbSo
 W/VCwiQvtSmsXFucipoNLcUaZKcUrPOXtWt9T1x9qDfaA8KtUz40b9nkYHNeMhmMvoit
 HjGPJKdNsUHenrUbjQu4d2s/H6CoytUh4vQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 30g36d8bh1-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:20 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 22 Apr 2020 13:47:18 -0700
Received: by devvm4439.prn2.facebook.com (Postfix, from userid 111017)
        id D2FFE22935803; Wed, 22 Apr 2020 13:47:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm4439.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 06/19] mm: memcg/slab: obj_cgroup API
Date:   Wed, 22 Apr 2020 13:46:55 -0700
Message-ID: <20200422204708.2176080-7-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200422204708.2176080-1-guro@fb.com>
References: <20200422204708.2176080-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_07:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=2
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=824 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004220158
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
reference counter. It substitutes a memory cgroup in places where
it's necessary to charge a custom amount of bytes instead of pages.

All charged memory rounded down to pages is charged to the
corresponding memory cgroup using __memcg_kmem_charge().

It implements reparenting: on memcg offlining it's getting reattached
to the parent memory cgroup. Each online memory cgroup has an
associated active object cgroup to handle new allocations and the list
of all attached object cgroups. On offlining of a cgroup this list is
reparented and for each object cgroup in the list the memcg pointer is
swapped to the parent memory cgroup. It prevents long-living objects
from pinning the original memory cgroup in the memory.

The implementation is based on byte-sized per-cpu stocks. A sub-page
sized leftover is stored in an atomic field, which is a part of
obj_cgroup object. So on cgroup offlining the leftover is automatically
reparented.

memcg->objcg is rcu protected.
objcg->memcg is a raw pointer, which is always pointing at a memory
cgroup, but can be atomically swapped to the parent memory cgroup. So
the caller must ensure the lifetime of the cgroup, e.g. grab
rcu_read_lock or css_set_lock.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h |  51 ++++++++
 mm/memcontrol.c            | 248 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 298 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c2eb73d89f5d..bf1be842fd27 100644
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
@@ -194,6 +195,22 @@ struct memcg_cgwb_frn {
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
@@ -306,6 +323,8 @@ struct mem_cgroup {
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
 	struct list_head kmem_caches;
+	struct obj_cgroup __rcu *objcg;
+	struct list_head objcg_list;
 #endif
=20
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -429,6 +448,33 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup=
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
@@ -1390,6 +1436,11 @@ void __memcg_kmem_uncharge(struct mem_cgroup *memc=
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
index 83805b48817d..7f87a0eeafec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -257,6 +257,78 @@ struct cgroup_subsys_state *vmpressure_to_css(struct=
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
@@ -2064,6 +2136,12 @@ EXPORT_SYMBOL(unlock_page_memcg);
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
@@ -2071,6 +2149,22 @@ struct memcg_stock_pcp {
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
@@ -2137,6 +2231,7 @@ static void drain_local_stock(struct work_struct *d=
ummy)
 	local_irq_save(flags);
=20
 	stock =3D this_cpu_ptr(&memcg_stock);
+	drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
=20
@@ -2196,6 +2291,8 @@ static void drain_all_stock(struct mem_cgroup *root=
_memcg)
 		if (memcg && stock->nr_pages &&
 		    mem_cgroup_is_descendant(memcg, root_memcg))
 			flush =3D true;
+		if (obj_stock_flush_required(stock, root_memcg))
+			flush =3D true;
 		rcu_read_unlock();
=20
 		if (flush &&
@@ -2723,6 +2820,30 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	return page->mem_cgroup;
 }
=20
+__always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
+{
+	struct obj_cgroup *objcg =3D NULL;
+	struct mem_cgroup *memcg;
+
+	if (unlikely(!current->mm))
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
@@ -3007,6 +3128,120 @@ void __memcg_kmem_uncharge_page(struct page *page=
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
@@ -3429,6 +3664,7 @@ static void memcg_flush_percpu_vmevents(struct mem_=
cgroup *memcg)
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
+	struct obj_cgroup *objcg;
 	int memcg_id;
=20
 	if (cgroup_memory_nokmem)
@@ -3441,6 +3677,14 @@ static int memcg_online_kmem(struct mem_cgroup *me=
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
@@ -3476,9 +3720,10 @@ static void memcg_offline_kmem(struct mem_cgroup *=
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
@@ -5045,6 +5290,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	memcg->socket_pressure =3D jiffies;
 #ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id =3D -1;
+	INIT_LIST_HEAD(&memcg->objcg_list);
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
--=20
2.25.3

