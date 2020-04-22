Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F68C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D192421655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RJehrFM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgDVUrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:47:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58284 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbgDVUra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:47:30 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MKeMlh018783
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=v9IYj2zWMMg/zACpatteWNwLCaqTniZeKMk/YgX7Knw=;
 b=RJehrFM4g/cnoyRYfvf7o+HhnMEmnNhzo5U6dtXgOolEIYoof7f0PEH0UcTAs2U/u2t0
 T7/cnLv2a2AlF9fP6hZ0HOahUOwNtwYpjYFyGUwfqikzhV6UK9Ra9/nqCYc1SBEAScl1
 IX+LGxwLe/I6ZZZgbbmhe8AWWIY9/2SdcGM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30ghjpuj58-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:28 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 22 Apr 2020 13:47:21 -0700
Received: by devvm4439.prn2.facebook.com (Postfix, from userid 111017)
        id 068FF22935819; Wed, 22 Apr 2020 13:47:17 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm4439.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 17/19] mm: memcg/slab: use a single set of kmem_caches for all allocations
Date:   Wed, 22 Apr 2020 13:47:06 -0700
Message-ID: <20200422204708.2176080-18-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200422204708.2176080-1-guro@fb.com>
References: <20200422204708.2176080-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_07:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=2 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220158
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having two sets of kmem_caches: one for system-wide and
non-accounted allocations and the second one shared by all accounted
allocations, we can use just one.

The idea is simple: space for obj_cgroup metadata can be allocated
on demand and filled only for accounted allocations.

It allows to remove a bunch of code which is required to handle
kmem_cache clones for accounted allocations. There is no more need
to create them, accumulate statistics, propagate attributes, etc.
It's a quite significant simplification.

Also, because the total number of slab_caches is reduced almost twice
(not all kmem_caches have a memcg clone), some additional memory
savings are expected. On my devvm it additionally saves about 3.5%
of slab memory.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/slab.h     |   2 -
 include/linux/slab_def.h |   3 -
 include/linux/slub_def.h |   9 --
 mm/memcontrol.c          |   5 +-
 mm/slab.c                |   7 +-
 mm/slab.h                | 180 +++++++-----------------------
 mm/slab_common.c         | 230 +--------------------------------------
 mm/slub.c                | 126 +--------------------
 8 files changed, 55 insertions(+), 507 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 310768bfa8d2..694a4f69e146 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -155,8 +155,6 @@ struct kmem_cache *kmem_cache_create_usercopy(const c=
har *name,
 void kmem_cache_destroy(struct kmem_cache *);
 int kmem_cache_shrink(struct kmem_cache *);
=20
-void memcg_create_kmem_cache(struct kmem_cache *cachep);
-
 /*
  * Please use this macro to create slab caches. Simply specify the
  * name of the structure and maybe some flags that are listed above.
diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index 967a9a525eab..73f9308e98e3 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -72,9 +72,6 @@ struct kmem_cache {
 	int obj_offset;
 #endif /* CONFIG_DEBUG_SLAB */
=20
-#ifdef CONFIG_MEMCG
-	struct memcg_cache_params memcg_params;
-#endif
 #ifdef CONFIG_KASAN
 	struct kasan_cache kasan_info;
 #endif
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index cbda7d55796a..cdf4f299c982 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -110,15 +110,6 @@ struct kmem_cache {
 	struct kobject kobj;	/* For sysfs */
 	struct work_struct kobj_remove_work;
 #endif
-#ifdef CONFIG_MEMCG
-	struct memcg_cache_params memcg_params;
-	/* For propagation, maximum size of a stored attr */
-	unsigned int max_attr_size;
-#ifdef CONFIG_SYSFS
-	struct kset *memcg_kset;
-#endif
-#endif
-
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	unsigned long random;
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bd58b91631f7..4af95739ccb6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2824,7 +2824,10 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
=20
 		off =3D obj_to_index(page->slab_cache, page, p);
 		objcg =3D page_obj_cgroups(page)[off];
-		return obj_cgroup_memcg(objcg);
+		if (objcg)
+			return obj_cgroup_memcg(objcg);
+
+		return NULL;
 	}
=20
 	/* All other pages use page->mem_cgroup */
diff --git a/mm/slab.c b/mm/slab.c
index 5e933f5e24db..181ce8665d55 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1369,12 +1369,7 @@ static struct page *kmem_getpages(struct kmem_cach=
e *cachep, gfp_t flags,
 		return NULL;
 	}
=20
-	if (charge_slab_page(page, flags, cachep->gfporder, cachep,
-			     cachep->num)) {
-		__free_pages(page, cachep->gfporder);
-		return NULL;
-	}
-
+	charge_slab_page(page, flags, cachep->gfporder, cachep, cachep->num);
 	__SetPageSlab(page);
 	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
 	if (sk_memalloc_socks() && page_is_pfmemalloc(page))
diff --git a/mm/slab.h b/mm/slab.h
index 2958ca8d3159..13fadf33be5c 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -30,28 +30,6 @@ struct kmem_cache {
 	struct list_head list;	/* List of all slab caches on the system */
 };
=20
-#else /* !CONFIG_SLOB */
-
-/*
- * This is the main placeholder for memcg-related information in kmem ca=
ches.
- * Both the root cache and the child cache will have it. Some fields are=
 used
- * in both cases, other are specific to root caches.
- *
- * @root_cache:	Common to root and child caches.  NULL for root, pointer=
 to
- *		the root cache for children.
- *
- * The following fields are specific to root caches.
- *
- * @memcg_cache: pointer to memcg kmem cache, used by all non-root memor=
y
- *		cgroups.
- * @work: work struct used to create the non-root cache.
- */
-struct memcg_cache_params {
-	struct kmem_cache *root_cache;
-
-	struct kmem_cache *memcg_cache;
-	struct work_struct work;
-};
 #endif /* CONFIG_SLOB */
=20
 #ifdef CONFIG_SLAB
@@ -194,7 +172,6 @@ int __kmem_cache_shutdown(struct kmem_cache *);
 void __kmem_cache_release(struct kmem_cache *);
 int __kmem_cache_shrink(struct kmem_cache *);
 void slab_kmem_cache_release(struct kmem_cache *);
-void kmem_cache_shrink_all(struct kmem_cache *s);
=20
 struct seq_file;
 struct file;
@@ -233,43 +210,6 @@ static inline int cache_vmstat_idx(struct kmem_cache=
 *s)
 }
=20
 #ifdef CONFIG_MEMCG_KMEM
-static inline bool is_root_cache(struct kmem_cache *s)
-{
-	return !s->memcg_params.root_cache;
-}
-
-static inline bool slab_equal_or_root(struct kmem_cache *s,
-				      struct kmem_cache *p)
-{
-	return p =3D=3D s || p =3D=3D s->memcg_params.root_cache;
-}
-
-/*
- * We use suffixes to the name in memcg because we can't have caches
- * created in the system with the same name. But when we print them
- * locally, better refer to them with the base name
- */
-static inline const char *cache_name(struct kmem_cache *s)
-{
-	if (!is_root_cache(s))
-		s =3D s->memcg_params.root_cache;
-	return s->name;
-}
-
-static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
-{
-	if (is_root_cache(s))
-		return s;
-	return s->memcg_params.root_cache;
-}
-
-static inline struct kmem_cache *memcg_cache(struct kmem_cache *s)
-{
-	if (is_root_cache(s))
-		return s->memcg_params.memcg_cache;
-	return NULL;
-}
-
 static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
 {
 	/*
@@ -315,38 +255,25 @@ static inline size_t obj_full_size(struct kmem_cach=
e *s)
 	return s->size + sizeof(struct obj_cgroup *);
 }
=20
-static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_c=
ache *s,
-						struct obj_cgroup **objcgp,
-						size_t objects, gfp_t flags)
+static inline struct obj_cgroup *memcg_slab_pre_alloc_hook(struct kmem_c=
ache *s,
+							   size_t objects,
+							   gfp_t flags)
 {
-	struct kmem_cache *cachep;
 	struct obj_cgroup *objcg;
=20
 	if (memcg_kmem_bypass())
-		return s;
-
-	cachep =3D READ_ONCE(s->memcg_params.memcg_cache);
-	if (unlikely(!cachep)) {
-		/*
-		 * If memcg cache does not exist yet, we schedule it's
-		 * asynchronous creation and let the current allocation
-		 * go through with the root cache.
-		 */
-		queue_work(system_wq, &s->memcg_params.work);
-		return s;
-	}
+		return NULL;
=20
 	objcg =3D get_obj_cgroup_from_current();
 	if (!objcg)
-		return s;
+		return NULL;
=20
 	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s))) {
 		obj_cgroup_put(objcg);
-		cachep =3D NULL;
+		return NULL;
 	}
=20
-	*objcgp =3D objcg;
-	return cachep;
+	return objcg;
 }
=20
 static inline void mod_objcg_state(struct obj_cgroup *objcg,
@@ -365,15 +292,28 @@ static inline void mod_objcg_state(struct obj_cgrou=
p *objcg,
=20
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct obj_cgroup *objcg,
-					      size_t size, void **p)
+					      gfp_t flags, size_t size,
+					      void **p)
 {
 	struct page *page;
 	unsigned long off;
 	size_t i;
=20
+	if (!objcg)
+		return;
+
+	flags &=3D ~__GFP_ACCOUNT;
 	for (i =3D 0; i < size; i++) {
 		if (likely(p[i])) {
 			page =3D virt_to_head_page(p[i]);
+
+			if (!page_has_obj_cgroups(page) &&
+			    memcg_alloc_page_obj_cgroups(page, flags,
+							 objs_per_slab(s))) {
+				obj_cgroup_uncharge(objcg, obj_full_size(s));
+				continue;
+			}
+
 			off =3D obj_to_index(s, page, p[i]);
 			obj_cgroup_get(objcg);
 			page_obj_cgroups(page)[off] =3D objcg;
@@ -392,13 +332,19 @@ static inline void memcg_slab_free_hook(struct kmem=
_cache *s, struct page *page,
 	struct obj_cgroup *objcg;
 	unsigned int off;
=20
-	if (!memcg_kmem_enabled() || is_root_cache(s))
+	if (!memcg_kmem_enabled())
+		return;
+
+	if (!page_has_obj_cgroups(page))
 		return;
=20
 	off =3D obj_to_index(s, page, p);
 	objcg =3D page_obj_cgroups(page)[off];
 	page_obj_cgroups(page)[off] =3D NULL;
=20
+	if (!objcg)
+		return;
+
 	obj_cgroup_uncharge(objcg, obj_full_size(s));
 	mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
 			-obj_full_size(s));
@@ -406,35 +352,7 @@ static inline void memcg_slab_free_hook(struct kmem_=
cache *s, struct page *page,
 	obj_cgroup_put(objcg);
 }
=20
-extern void slab_init_memcg_params(struct kmem_cache *);
-
 #else /* CONFIG_MEMCG_KMEM */
-static inline bool is_root_cache(struct kmem_cache *s)
-{
-	return true;
-}
-
-static inline bool slab_equal_or_root(struct kmem_cache *s,
-				      struct kmem_cache *p)
-{
-	return s =3D=3D p;
-}
-
-static inline const char *cache_name(struct kmem_cache *s)
-{
-	return s->name;
-}
-
-static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
-{
-	return s;
-}
-
-static inline struct kmem_cache *memcg_cache(struct kmem_cache *s)
-{
-	return NULL;
-}
-
 static inline bool page_has_obj_cgroups(struct page *page)
 {
 	return false;
@@ -455,16 +373,17 @@ static inline void memcg_free_page_obj_cgroups(stru=
ct page *page)
 {
 }
=20
-static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_c=
ache *s,
-						struct obj_cgroup **objcgp,
-						size_t objects, gfp_t flags)
+static inline struct obj_cgroup *memcg_slab_pre_alloc_hook(struct kmem_c=
ache *s,
+							   size_t objects,
+							   gfp_t flags)
 {
 	return NULL;
 }
=20
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct obj_cgroup *objcg,
-					      size_t size, void **p)
+					      gfp_t flags, size_t size,
+					      void **p)
 {
 }
=20
@@ -472,11 +391,6 @@ static inline void memcg_slab_free_hook(struct kmem_=
cache *s, struct page *page,
 					void *p)
 {
 }
-
-static inline void slab_init_memcg_params(struct kmem_cache *s)
-{
-}
-
 #endif /* CONFIG_MEMCG_KMEM */
=20
 static inline struct kmem_cache *virt_to_cache(const void *obj)
@@ -490,28 +404,18 @@ static inline struct kmem_cache *virt_to_cache(cons=
t void *obj)
 	return page->slab_cache;
 }
=20
-static __always_inline int charge_slab_page(struct page *page,
-					    gfp_t gfp, int order,
-					    struct kmem_cache *s)
+static __always_inline void charge_slab_page(struct page *page,
+					     gfp_t gfp, int order,
+					     struct kmem_cache *s)
 {
-	if (!is_root_cache(s)) {
-		int ret;
-
-		ret =3D memcg_alloc_page_obj_cgroups(page, gfp, objs_per_slab(s));
-		if (ret)
-			return ret;
-	}
-
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
-	return 0;
 }
=20
 static __always_inline void uncharge_slab_page(struct page *page, int or=
der,
 					       struct kmem_cache *s)
 {
-	if (!is_root_cache(s))
-		memcg_free_page_obj_cgroups(page);
+	memcg_free_page_obj_cgroups(page);
=20
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
@@ -525,8 +429,7 @@ static inline struct kmem_cache *cache_from_obj(struc=
t kmem_cache *s, void *x)
 	 * When kmemcg is not being used, both assignments should return the
 	 * same value. but we don't want to pay the assignment price in that
 	 * case. If it is not compiled in, the compiler should be smart enough
-	 * to not do even the assignment. In that case, slab_equal_or_root
-	 * will also be a constant.
+	 * to not do even the assignment.
 	 */
 	if (!memcg_kmem_enabled() &&
 	    !IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
@@ -534,7 +437,7 @@ static inline struct kmem_cache *cache_from_obj(struc=
t kmem_cache *s, void *x)
 		return s;
=20
 	cachep =3D virt_to_cache(x);
-	WARN_ONCE(cachep && !slab_equal_or_root(cachep, s),
+	WARN_ONCE(cachep && cachep !=3D s,
 		  "%s: Wrong slab cache. %s but object is from %s\n",
 		  __func__, s->name, cachep->name);
 	return cachep;
@@ -586,7 +489,7 @@ static inline struct kmem_cache *slab_pre_alloc_hook(=
struct kmem_cache *s,
=20
 	if (memcg_kmem_enabled() &&
 	    ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
-		return memcg_slab_pre_alloc_hook(s, objcgp, size, flags);
+		*objcgp =3D memcg_slab_pre_alloc_hook(s, size, flags);
=20
 	return s;
 }
@@ -605,8 +508,7 @@ static inline void slab_post_alloc_hook(struct kmem_c=
ache *s,
 					 s->flags, flags);
 	}
=20
-	if (!is_root_cache(s))
-		memcg_slab_post_alloc_hook(s, objcg, size, p);
+	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
 }
=20
 #ifndef CONFIG_SLOB
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 52164ad0f197..7be382d45514 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -128,36 +128,6 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gf=
p_t flags, size_t nr,
 	return i;
 }
=20
-#ifdef CONFIG_MEMCG_KMEM
-static void memcg_kmem_cache_create_func(struct work_struct *work)
-{
-	struct kmem_cache *cachep =3D container_of(work, struct kmem_cache,
-						 memcg_params.work);
-	memcg_create_kmem_cache(cachep);
-}
-
-void slab_init_memcg_params(struct kmem_cache *s)
-{
-	s->memcg_params.root_cache =3D NULL;
-	s->memcg_params.memcg_cache =3D NULL;
-	INIT_WORK(&s->memcg_params.work, memcg_kmem_cache_create_func);
-}
-
-static void init_memcg_params(struct kmem_cache *s,
-			      struct kmem_cache *root_cache)
-{
-	if (root_cache)
-		s->memcg_params.root_cache =3D root_cache;
-	else
-		slab_init_memcg_params(s);
-}
-#else
-static inline void init_memcg_params(struct kmem_cache *s,
-				     struct kmem_cache *root_cache)
-{
-}
-#endif /* CONFIG_MEMCG_KMEM */
-
 /*
  * Figure out what the alignment of the objects will be given a set of
  * flags, a user specified alignment and the size of the objects.
@@ -195,9 +165,6 @@ int slab_unmergeable(struct kmem_cache *s)
 	if (slab_nomerge || (s->flags & SLAB_NEVER_MERGE))
 		return 1;
=20
-	if (!is_root_cache(s))
-		return 1;
-
 	if (s->ctor)
 		return 1;
=20
@@ -284,7 +251,6 @@ static struct kmem_cache *create_cache(const char *na=
me,
 	s->useroffset =3D useroffset;
 	s->usersize =3D usersize;
=20
-	init_memcg_params(s, root_cache);
 	err =3D __kmem_cache_create(s, flags);
 	if (err)
 		goto out_free_cache;
@@ -342,7 +308,6 @@ kmem_cache_create_usercopy(const char *name,
=20
 	get_online_cpus();
 	get_online_mems();
-	memcg_get_cache_ids();
=20
 	mutex_lock(&slab_mutex);
=20
@@ -392,7 +357,6 @@ kmem_cache_create_usercopy(const char *name,
 out_unlock:
 	mutex_unlock(&slab_mutex);
=20
-	memcg_put_cache_ids();
 	put_online_mems();
 	put_online_cpus();
=20
@@ -505,87 +469,6 @@ static int shutdown_cache(struct kmem_cache *s)
 	return 0;
 }
=20
-#ifdef CONFIG_MEMCG_KMEM
-/*
- * memcg_create_kmem_cache - Create a cache for non-root memory cgroups.
- * @root_cache: The parent of the new cache.
- *
- * This function attempts to create a kmem cache that will serve allocat=
ion
- * requests going all non-root memory cgroups to @root_cache. The new ca=
che
- * inherits properties from its parent.
- */
-void memcg_create_kmem_cache(struct kmem_cache *root_cache)
-{
-	struct kmem_cache *s =3D NULL;
-	char *cache_name;
-
-	get_online_cpus();
-	get_online_mems();
-
-	mutex_lock(&slab_mutex);
-
-	if (root_cache->memcg_params.memcg_cache)
-		goto out_unlock;
-
-	cache_name =3D kasprintf(GFP_KERNEL, "%s-memcg", root_cache->name);
-	if (!cache_name)
-		goto out_unlock;
-
-	s =3D create_cache(cache_name, root_cache->object_size,
-			 root_cache->align,
-			 root_cache->flags & CACHE_CREATE_MASK,
-			 root_cache->useroffset, root_cache->usersize,
-			 root_cache->ctor, root_cache);
-	/*
-	 * If we could not create a memcg cache, do not complain, because
-	 * that's not critical at all as we can always proceed with the root
-	 * cache.
-	 */
-	if (IS_ERR(s)) {
-		kfree(cache_name);
-		goto out_unlock;
-	}
-
-	/*
-	 * Since readers won't lock (see memcg_slab_pre_alloc_hook()), we need =
a
-	 * barrier here to ensure nobody will see the kmem_cache partially
-	 * initialized.
-	 */
-	smp_wmb();
-	root_cache->memcg_params.memcg_cache =3D s;
-
-out_unlock:
-	mutex_unlock(&slab_mutex);
-
-	put_online_mems();
-	put_online_cpus();
-}
-
-static int shutdown_memcg_caches(struct kmem_cache *s)
-{
-	BUG_ON(!is_root_cache(s));
-
-	if (s->memcg_params.memcg_cache)
-		WARN_ON(shutdown_cache(s->memcg_params.memcg_cache));
-
-	return 0;
-}
-
-static void cancel_memcg_cache_creation(struct kmem_cache *s)
-{
-	cancel_work_sync(&s->memcg_params.work);
-}
-#else
-static inline int shutdown_memcg_caches(struct kmem_cache *s)
-{
-	return 0;
-}
-
-static inline void cancel_memcg_cache_creation(struct kmem_cache *s)
-{
-}
-#endif /* CONFIG_MEMCG_KMEM */
-
 void slab_kmem_cache_release(struct kmem_cache *s)
 {
 	__kmem_cache_release(s);
@@ -600,8 +483,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (unlikely(!s))
 		return;
=20
-	cancel_memcg_cache_creation(s);
-
 	get_online_cpus();
 	get_online_mems();
=20
@@ -611,10 +492,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (s->refcount)
 		goto out_unlock;
=20
-	err =3D shutdown_memcg_caches(s);
-	if (!err)
-		err =3D shutdown_cache(s);
-
+	err =3D shutdown_cache(s);
 	if (err) {
 		pr_err("kmem_cache_destroy %s: Slab cache still has objects\n",
 		       s->name);
@@ -651,33 +529,6 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
 }
 EXPORT_SYMBOL(kmem_cache_shrink);
=20
-/**
- * kmem_cache_shrink_all - shrink root and memcg caches
- * @s: The cache pointer
- */
-void kmem_cache_shrink_all(struct kmem_cache *s)
-{
-	struct kmem_cache *c;
-
-	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || !is_root_cache(s)) {
-		kmem_cache_shrink(s);
-		return;
-	}
-
-	get_online_cpus();
-	get_online_mems();
-	kasan_cache_shrink(s);
-	__kmem_cache_shrink(s);
-
-	c =3D memcg_cache(s);
-	if (c) {
-		kasan_cache_shrink(c);
-		__kmem_cache_shrink(c);
-	}
-	put_online_mems();
-	put_online_cpus();
-}
-
 bool slab_is_available(void)
 {
 	return slab_state >=3D UP;
@@ -706,8 +557,6 @@ void __init create_boot_cache(struct kmem_cache *s, c=
onst char *name,
 	s->useroffset =3D useroffset;
 	s->usersize =3D usersize;
=20
-	slab_init_memcg_params(s);
-
 	err =3D __kmem_cache_create(s, flags);
=20
 	if (err)
@@ -1081,25 +930,6 @@ void slab_stop(struct seq_file *m, void *p)
 	mutex_unlock(&slab_mutex);
 }
=20
-static void
-memcg_accumulate_slabinfo(struct kmem_cache *s, struct slabinfo *info)
-{
-	struct kmem_cache *c;
-	struct slabinfo sinfo;
-
-	c =3D memcg_cache(s);
-	if (c) {
-		memset(&sinfo, 0, sizeof(sinfo));
-		get_slabinfo(c, &sinfo);
-
-		info->active_slabs +=3D sinfo.active_slabs;
-		info->num_slabs +=3D sinfo.num_slabs;
-		info->shared_avail +=3D sinfo.shared_avail;
-		info->active_objs +=3D sinfo.active_objs;
-		info->num_objs +=3D sinfo.num_objs;
-	}
-}
-
 static void cache_show(struct kmem_cache *s, struct seq_file *m)
 {
 	struct slabinfo sinfo;
@@ -1107,10 +937,8 @@ static void cache_show(struct kmem_cache *s, struct=
 seq_file *m)
 	memset(&sinfo, 0, sizeof(sinfo));
 	get_slabinfo(s, &sinfo);
=20
-	memcg_accumulate_slabinfo(s, &sinfo);
-
 	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
-		   cache_name(s), sinfo.active_objs, sinfo.num_objs, s->size,
+		   s->name, sinfo.active_objs, sinfo.num_objs, s->size,
 		   sinfo.objects_per_slab, (1 << sinfo.cache_order));
=20
 	seq_printf(m, " : tunables %4u %4u %4u",
@@ -1127,8 +955,7 @@ static int slab_show(struct seq_file *m, void *p)
=20
 	if (p =3D=3D slab_caches.next)
 		print_slabinfo_header(m);
-	if (is_root_cache(s))
-		cache_show(s, m);
+	cache_show(s, m);
 	return 0;
 }
=20
@@ -1153,13 +980,13 @@ void dump_unreclaimable_slab(void)
 	pr_info("Name                      Used          Total\n");
=20
 	list_for_each_entry_safe(s, s2, &slab_caches, list) {
-		if (!is_root_cache(s) || (s->flags & SLAB_RECLAIM_ACCOUNT))
+		if (s->flags & SLAB_RECLAIM_ACCOUNT)
 			continue;
=20
 		get_slabinfo(s, &sinfo);
=20
 		if (sinfo.num_objs > 0)
-			pr_info("%-17s %10luKB %10luKB\n", cache_name(s),
+			pr_info("%-17s %10luKB %10luKB\n", s->name,
 				(sinfo.active_objs * s->size) / 1024,
 				(sinfo.num_objs * s->size) / 1024);
 	}
@@ -1218,53 +1045,6 @@ static int __init slab_proc_init(void)
 }
 module_init(slab_proc_init);
=20
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_MEMCG_KMEM)
-/*
- * Display information about kmem caches that have memcg cache.
- */
-static int memcg_slabinfo_show(struct seq_file *m, void *unused)
-{
-	struct kmem_cache *s, *c;
-	struct slabinfo sinfo;
-
-	mutex_lock(&slab_mutex);
-	seq_puts(m, "# <name> <css_id[:dead|deact]> <active_objs> <num_objs>");
-	seq_puts(m, " <active_slabs> <num_slabs>\n");
-	list_for_each_entry(s, &slab_caches, list) {
-		/*
-		 * Skip kmem caches that don't have the memcg cache.
-		 */
-		if (!s->memcg_params.memcg_cache)
-			continue;
-
-		memset(&sinfo, 0, sizeof(sinfo));
-		get_slabinfo(s, &sinfo);
-		seq_printf(m, "%-17s root       %6lu %6lu %6lu %6lu\n",
-			   cache_name(s), sinfo.active_objs, sinfo.num_objs,
-			   sinfo.active_slabs, sinfo.num_slabs);
-
-		c =3D s->memcg_params.memcg_cache;
-		memset(&sinfo, 0, sizeof(sinfo));
-		get_slabinfo(c, &sinfo);
-		seq_printf(m, "%-17s %4d %6lu %6lu %6lu %6lu\n",
-			   cache_name(c), root_mem_cgroup->css.id,
-			   sinfo.active_objs, sinfo.num_objs,
-			   sinfo.active_slabs, sinfo.num_slabs);
-	}
-	mutex_unlock(&slab_mutex);
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(memcg_slabinfo);
-
-static int __init memcg_slabinfo_init(void)
-{
-	debugfs_create_file("memcg_slabinfo", S_IFREG | S_IRUGO,
-			    NULL, NULL, &memcg_slabinfo_fops);
-	return 0;
-}
-
-late_initcall(memcg_slabinfo_init);
-#endif /* CONFIG_DEBUG_FS && CONFIG_MEMCG_KMEM */
 #endif /* CONFIG_SLAB || CONFIG_SLUB_DEBUG */
=20
 static __always_inline void *__do_krealloc(const void *p, size_t new_siz=
e,
diff --git a/mm/slub.c b/mm/slub.c
index 799082723e77..d875bab1626a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -214,13 +214,11 @@ enum track_item { TRACK_ALLOC, TRACK_FREE };
 #ifdef CONFIG_SYSFS
 static int sysfs_slab_add(struct kmem_cache *);
 static int sysfs_slab_alias(struct kmem_cache *, const char *);
-static void memcg_propagate_slab_attrs(struct kmem_cache *s);
 static void sysfs_slab_remove(struct kmem_cache *s);
 #else
 static inline int sysfs_slab_add(struct kmem_cache *s) { return 0; }
 static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
 							{ return 0; }
-static inline void memcg_propagate_slab_attrs(struct kmem_cache *s) { }
 static inline void sysfs_slab_remove(struct kmem_cache *s) { }
 #endif
=20
@@ -1536,10 +1534,8 @@ static inline struct page *alloc_slab_page(struct =
kmem_cache *s,
 	else
 		page =3D __alloc_pages_node(node, flags, order);
=20
-	if (page && charge_slab_page(page, flags, order, s)) {
-		__free_pages(page, order);
-		page =3D NULL;
-	}
+	if (page)
+		charge_slab_page(page, flags, order, s);
=20
 	return page;
 }
@@ -4271,7 +4267,6 @@ static struct kmem_cache * __init bootstrap(struct =
kmem_cache *static_cache)
 			p->slab_cache =3D s;
 #endif
 	}
-	slab_init_memcg_params(s);
 	list_add(&s->list, &slab_caches);
 	return s;
 }
@@ -4327,7 +4322,7 @@ struct kmem_cache *
 __kmem_cache_alias(const char *name, unsigned int size, unsigned int ali=
gn,
 		   slab_flags_t flags, void (*ctor)(void *))
 {
-	struct kmem_cache *s, *c;
+	struct kmem_cache *s;
=20
 	s =3D find_mergeable(size, align, flags, name, ctor);
 	if (s) {
@@ -4340,12 +4335,6 @@ __kmem_cache_alias(const char *name, unsigned int =
size, unsigned int align,
 		s->object_size =3D max(s->object_size, size);
 		s->inuse =3D max(s->inuse, ALIGN(size, sizeof(void *)));
=20
-		c =3D memcg_cache(s);
-		if (c) {
-			c->object_size =3D s->object_size;
-			c->inuse =3D max(c->inuse, ALIGN(size, sizeof(void *)));
-		}
-
 		if (sysfs_slab_alias(s, name)) {
 			s->refcount--;
 			s =3D NULL;
@@ -4367,7 +4356,6 @@ int __kmem_cache_create(struct kmem_cache *s, slab_=
flags_t flags)
 	if (slab_state <=3D UP)
 		return 0;
=20
-	memcg_propagate_slab_attrs(s);
 	err =3D sysfs_slab_add(s);
 	if (err)
 		__kmem_cache_release(s);
@@ -5347,7 +5335,7 @@ static ssize_t shrink_store(struct kmem_cache *s,
 			const char *buf, size_t length)
 {
 	if (buf[0] =3D=3D '1')
-		kmem_cache_shrink_all(s);
+		kmem_cache_shrink(s);
 	else
 		return -EINVAL;
 	return length;
@@ -5571,98 +5559,9 @@ static ssize_t slab_attr_store(struct kobject *kob=
j,
 		return -EIO;
=20
 	err =3D attribute->store(s, buf, len);
-#ifdef CONFIG_MEMCG
-	if (slab_state >=3D FULL && err >=3D 0 && is_root_cache(s)) {
-		struct kmem_cache *c;
-
-		mutex_lock(&slab_mutex);
-		if (s->max_attr_size < len)
-			s->max_attr_size =3D len;
-
-		/*
-		 * This is a best effort propagation, so this function's return
-		 * value will be determined by the parent cache only. This is
-		 * basically because not all attributes will have a well
-		 * defined semantics for rollbacks - most of the actions will
-		 * have permanent effects.
-		 *
-		 * Returning the error value of any of the children that fail
-		 * is not 100 % defined, in the sense that users seeing the
-		 * error code won't be able to know anything about the state of
-		 * the cache.
-		 *
-		 * Only returning the error code for the parent cache at least
-		 * has well defined semantics. The cache being written to
-		 * directly either failed or succeeded, in which case we loop
-		 * through the descendants with best-effort propagation.
-		 */
-		c =3D memcg_cache(s);
-		if (c)
-			attribute->store(c, buf, len);
-		mutex_unlock(&slab_mutex);
-	}
-#endif
 	return err;
 }
=20
-static void memcg_propagate_slab_attrs(struct kmem_cache *s)
-{
-#ifdef CONFIG_MEMCG
-	int i;
-	char *buffer =3D NULL;
-	struct kmem_cache *root_cache;
-
-	if (is_root_cache(s))
-		return;
-
-	root_cache =3D s->memcg_params.root_cache;
-
-	/*
-	 * This mean this cache had no attribute written. Therefore, no point
-	 * in copying default values around
-	 */
-	if (!root_cache->max_attr_size)
-		return;
-
-	for (i =3D 0; i < ARRAY_SIZE(slab_attrs); i++) {
-		char mbuf[64];
-		char *buf;
-		struct slab_attribute *attr =3D to_slab_attr(slab_attrs[i]);
-		ssize_t len;
-
-		if (!attr || !attr->store || !attr->show)
-			continue;
-
-		/*
-		 * It is really bad that we have to allocate here, so we will
-		 * do it only as a fallback. If we actually allocate, though,
-		 * we can just use the allocated buffer until the end.
-		 *
-		 * Most of the slub attributes will tend to be very small in
-		 * size, but sysfs allows buffers up to a page, so they can
-		 * theoretically happen.
-		 */
-		if (buffer)
-			buf =3D buffer;
-		else if (root_cache->max_attr_size < ARRAY_SIZE(mbuf))
-			buf =3D mbuf;
-		else {
-			buffer =3D (char *) get_zeroed_page(GFP_KERNEL);
-			if (WARN_ON(!buffer))
-				continue;
-			buf =3D buffer;
-		}
-
-		len =3D attr->show(root_cache, buf);
-		if (len > 0)
-			attr->store(s, buf, len);
-	}
-
-	if (buffer)
-		free_page((unsigned long)buffer);
-#endif	/* CONFIG_MEMCG */
-}
-
 static void kmem_cache_release(struct kobject *k)
 {
 	slab_kmem_cache_release(to_slab(k));
@@ -5695,10 +5594,6 @@ static struct kset *slab_kset;
=20
 static inline struct kset *cache_kset(struct kmem_cache *s)
 {
-#ifdef CONFIG_MEMCG
-	if (!is_root_cache(s))
-		return s->memcg_params.root_cache->memcg_kset;
-#endif
 	return slab_kset;
 }
=20
@@ -5755,9 +5650,6 @@ static void sysfs_slab_remove_workfn(struct work_st=
ruct *work)
 		 */
 		goto out;
=20
-#ifdef CONFIG_MEMCG
-	kset_unregister(s->memcg_kset);
-#endif
 	kobject_uevent(&s->kobj, KOBJ_REMOVE);
 out:
 	kobject_put(&s->kobj);
@@ -5806,16 +5698,6 @@ static int sysfs_slab_add(struct kmem_cache *s)
 	if (err)
 		goto out_del_kobj;
=20
-#ifdef CONFIG_MEMCG
-	if (is_root_cache(s) && memcg_sysfs_enabled) {
-		s->memcg_kset =3D kset_create_and_add("cgroup", NULL, &s->kobj);
-		if (!s->memcg_kset) {
-			err =3D -ENOMEM;
-			goto out_del_kobj;
-		}
-	}
-#endif
-
 	kobject_uevent(&s->kobj, KOBJ_ADD);
 	if (!unmergeable) {
 		/* Setup first alias */
--=20
2.25.3

