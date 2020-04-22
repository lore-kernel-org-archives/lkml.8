Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D74C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E223B2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ND2Z9HMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgDVUsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:48:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgDVUrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:47:24 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MKhRKM028348
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=A0Tyv2mOBa6+wSdXkw5A1AmFK68jxtJ9zE33tnua4f0=;
 b=ND2Z9HMXP0wf6cMNjEcAQ1Hyj4ER1zk9ijMJ7Lo7oWb5M+C8RMRIqJNX0tmXxPOslMOo
 tYgpkTwXItCy9OHBZ/fS8kha01zBsztjezJOHiwANvo277fh5LAhOD9RldV25ZKmtw5I
 12qxh7EBmeY23rFggUl/K9efLgKsUAaBu4Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30ghfebmvp-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:23 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 22 Apr 2020 13:47:21 -0700
Received: by devvm4439.prn2.facebook.com (Postfix, from userid 111017)
        id DD3B022935809; Wed, 22 Apr 2020 13:47:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm4439.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 09/19] mm: memcg/slab: charge individual slab objects instead of pages
Date:   Wed, 22 Apr 2020 13:46:58 -0700
Message-ID: <20200422204708.2176080-10-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200422204708.2176080-1-guro@fb.com>
References: <20200422204708.2176080-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_07:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=2 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004220158
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to per-object accounting of non-root slab objects.

Charging is performed using obj_cgroup API in the pre_alloc hook.
Obj_cgroup is charged with the size of the object and the size
of metadata: as now it's the size of an obj_cgroup pointer.
If the amount of memory has been charged successfully, the actual
allocation code is executed. Otherwise, -ENOMEM is returned.

In the post_alloc hook if the actual allocation succeeded,
corresponding vmstats are bumped and the obj_cgroup pointer is saved.
Otherwise, the charge is canceled.

On the free path obj_cgroup pointer is obtained and used to uncharge
the size of the releasing object.

Memcg and lruvec counters are now representing only memory used
by active slab objects and do not include the free space. The free
space is shared and doesn't belong to any specific cgroup.

Global per-node slab vmstats are still modified from (un)charge_slab_page=
()
functions. The idea is to keep all slab pages accounted as slab pages
on system level.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slab.h | 173 ++++++++++++++++++++++++------------------------------
 1 file changed, 77 insertions(+), 96 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 525e09e05743..0ecf14bec6a2 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -352,72 +352,6 @@ static inline struct mem_cgroup *memcg_from_slab_pag=
e(struct page *page)
 	return NULL;
 }
=20
-/*
- * Charge the slab page belonging to the non-root kmem_cache.
- * Can be called for non-root kmem_caches only.
- */
-static __always_inline int memcg_charge_slab(struct page *page,
-					     gfp_t gfp, int order,
-					     struct kmem_cache *s)
-{
-	unsigned int nr_pages =3D 1 << order;
-	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
-	int ret;
-
-	rcu_read_lock();
-	memcg =3D READ_ONCE(s->memcg_params.memcg);
-	while (memcg && !css_tryget_online(&memcg->css))
-		memcg =3D parent_mem_cgroup(memcg);
-	rcu_read_unlock();
-
-	if (unlikely(!memcg || mem_cgroup_is_root(memcg))) {
-		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    nr_pages << PAGE_SHIFT);
-		percpu_ref_get_many(&s->memcg_params.refcnt, nr_pages);
-		return 0;
-	}
-
-	ret =3D memcg_kmem_charge(memcg, gfp, nr_pages);
-	if (ret)
-		goto out;
-
-	lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
-	mod_lruvec_state(lruvec, cache_vmstat_idx(s), nr_pages << PAGE_SHIFT);
-
-	percpu_ref_get_many(&s->memcg_params.refcnt, nr_pages);
-out:
-	css_put(&memcg->css);
-	return ret;
-}
-
-/*
- * Uncharge a slab page belonging to a non-root kmem_cache.
- * Can be called for non-root kmem_caches only.
- */
-static __always_inline void memcg_uncharge_slab(struct page *page, int o=
rder,
-						struct kmem_cache *s)
-{
-	unsigned int nr_pages =3D 1 << order;
-	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
-
-	rcu_read_lock();
-	memcg =3D READ_ONCE(s->memcg_params.memcg);
-	if (likely(!mem_cgroup_is_root(memcg))) {
-		lruvec =3D mem_cgroup_lruvec(memcg, page_pgdat(page));
-		mod_lruvec_state(lruvec, cache_vmstat_idx(s),
-				 -(nr_pages << PAGE_SHIFT));
-		memcg_kmem_uncharge(memcg, nr_pages);
-	} else {
-		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    -(nr_pages << PAGE_SHIFT));
-	}
-	rcu_read_unlock();
-
-	percpu_ref_put_many(&s->memcg_params.refcnt, nr_pages);
-}
-
 static inline int memcg_alloc_page_obj_cgroups(struct page *page, gfp_t =
gfp,
 					       unsigned int objects)
 {
@@ -437,6 +371,47 @@ static inline void memcg_free_page_obj_cgroups(struc=
t page *page)
 	page->obj_cgroups =3D NULL;
 }
=20
+static inline size_t obj_full_size(struct kmem_cache *s)
+{
+	/*
+	 * For each accounted object there is an extra space which is used
+	 * to store obj_cgroup membership. Charge it too.
+	 */
+	return s->size + sizeof(struct obj_cgroup *);
+}
+
+static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_c=
ache *s,
+						struct obj_cgroup **objcgp,
+						size_t objects, gfp_t flags)
+{
+	struct kmem_cache *cachep;
+
+	cachep =3D memcg_kmem_get_cache(s, objcgp);
+	if (is_root_cache(cachep))
+		return s;
+
+	if (obj_cgroup_charge(*objcgp, flags, objects * obj_full_size(s))) {
+		memcg_kmem_put_cache(cachep);
+		cachep =3D NULL;
+	}
+
+	return cachep;
+}
+
+static inline void mod_objcg_state(struct obj_cgroup *objcg,
+				   struct pglist_data *pgdat,
+				   int idx, int nr)
+{
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
+
+	rcu_read_lock();
+	memcg =3D obj_cgroup_memcg(objcg);
+	lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
+	mod_memcg_lruvec_state(lruvec, idx, nr);
+	rcu_read_unlock();
+}
+
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct obj_cgroup *objcg,
 					      size_t size, void **p)
@@ -451,6 +426,10 @@ static inline void memcg_slab_post_alloc_hook(struct=
 kmem_cache *s,
 			off =3D obj_to_index(s, page, p[i]);
 			obj_cgroup_get(objcg);
 			page_obj_cgroups(page)[off] =3D objcg;
+			mod_objcg_state(objcg, page_pgdat(page),
+					cache_vmstat_idx(s), obj_full_size(s));
+		} else {
+			obj_cgroup_uncharge(objcg, obj_full_size(s));
 		}
 	}
 	obj_cgroup_put(objcg);
@@ -469,6 +448,11 @@ static inline void memcg_slab_free_hook(struct kmem_=
cache *s, struct page *page,
 	off =3D obj_to_index(s, page, p);
 	objcg =3D page_obj_cgroups(page)[off];
 	page_obj_cgroups(page)[off] =3D NULL;
+
+	obj_cgroup_uncharge(objcg, obj_full_size(s));
+	mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
+			-obj_full_size(s));
+
 	obj_cgroup_put(objcg);
 }
=20
@@ -510,17 +494,6 @@ static inline struct mem_cgroup *memcg_from_slab_pag=
e(struct page *page)
 	return NULL;
 }
=20
-static inline int memcg_charge_slab(struct page *page, gfp_t gfp, int or=
der,
-				    struct kmem_cache *s)
-{
-	return 0;
-}
-
-static inline void memcg_uncharge_slab(struct page *page, int order,
-				       struct kmem_cache *s)
-{
-}
-
 static inline int memcg_alloc_page_obj_cgroups(struct page *page, gfp_t =
gfp,
 					       unsigned int objects)
 {
@@ -531,6 +504,13 @@ static inline void memcg_free_page_obj_cgroups(struc=
t page *page)
 {
 }
=20
+static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_c=
ache *s,
+						struct obj_cgroup **objcgp,
+						size_t objects, gfp_t flags)
+{
+	return NULL;
+}
+
 static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct obj_cgroup *objcg,
 					      size_t size, void **p)
@@ -568,32 +548,33 @@ static __always_inline int charge_slab_page(struct =
page *page,
 					    gfp_t gfp, int order,
 					    struct kmem_cache *s)
 {
-	int ret;
-
-	if (is_root_cache(s)) {
-		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    PAGE_SIZE << order);
-		return 0;
-	}
+#ifdef CONFIG_MEMCG_KMEM
+	if (!is_root_cache(s)) {
+		int ret;
=20
-	ret =3D memcg_alloc_page_obj_cgroups(page, gfp, objs_per_slab(s));
-	if (ret)
-		return ret;
+		ret =3D memcg_alloc_page_obj_cgroups(page, gfp, objs_per_slab(s));
+		if (ret)
+			return ret;
=20
-	return memcg_charge_slab(page, gfp, order, s);
+		percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
+	}
+#endif
+	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
+			    PAGE_SIZE << order);
+	return 0;
 }
=20
 static __always_inline void uncharge_slab_page(struct page *page, int or=
der,
 					       struct kmem_cache *s)
 {
-	if (is_root_cache(s)) {
-		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
-				    -(PAGE_SIZE << order));
-		return;
+#ifdef CONFIG_MEMCG_KMEM
+	if (!is_root_cache(s)) {
+		memcg_free_page_obj_cgroups(page);
+		percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
 	}
-
-	memcg_free_page_obj_cgroups(page);
-	memcg_uncharge_slab(page, order, s);
+#endif
+	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
+			    -(PAGE_SIZE << order));
 }
=20
 static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, vo=
id *x)
@@ -665,7 +646,7 @@ static inline struct kmem_cache *slab_pre_alloc_hook(=
struct kmem_cache *s,
=20
 	if (memcg_kmem_enabled() &&
 	    ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
-		return memcg_kmem_get_cache(s, objcgp);
+		return memcg_slab_pre_alloc_hook(s, objcgp, size, flags);
=20
 	return s;
 }
--=20
2.25.3

