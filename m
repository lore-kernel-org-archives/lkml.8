Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7EBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DCDE20B80
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AkXwR2nJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgFHXIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:08:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34716 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727829AbgFHXHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:15 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058N0Zgf022325
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jun 2020 16:07:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cugBKwoeKftvWxkJwY+OzQ/BYGIKUP/EFF3JonuT84o=;
 b=AkXwR2nJXtmLEmx5D3VATBpPrt+9m2CD0hoFHn43mNTmDwYrQ7sBLKb3fgAjlyWg3y6S
 aIrldcIKD5mvGvuO63CtfS/vUtWNFg5nB0QjE4jgomca8dJZPbj+2YJxQDmVSq6SGBsv
 kS1gadhlDLIRSIMH4ueU0Uw/nStydeTR7WY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31g8nkt6v6-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 16:07:13 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Jun 2020 16:07:04 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 5186C1D8FE4C; Mon,  8 Jun 2020 16:07:00 -0700 (PDT)
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
Subject: [PATCH v6 09/19] mm: memcg/slab: charge individual slab objects instead of pages
Date:   Mon, 8 Jun 2020 16:06:44 -0700
Message-ID: <20200608230654.828134-10-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200608230654.828134-1-guro@fb.com>
References: <20200608230654.828134-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 phishscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 mlxlogscore=999 suspectscore=2 cotscore=-2147483648
 lowpriorityscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080160
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
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h | 173 ++++++++++++++++++++++++------------------------------
 1 file changed, 77 insertions(+), 96 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 8bca0cb4b928..f219a29052d9 100644
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
 static inline int memcg_alloc_page_obj_cgroups(struct page *page,
 					       struct kmem_cache *s, gfp_t gfp)
 {
@@ -438,6 +372,47 @@ static inline void memcg_free_page_obj_cgroups(struc=
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
@@ -452,6 +427,10 @@ static inline void memcg_slab_post_alloc_hook(struct=
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
@@ -470,6 +449,11 @@ static inline void memcg_slab_free_hook(struct kmem_=
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
@@ -511,17 +495,6 @@ static inline struct mem_cgroup *memcg_from_slab_pag=
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
 static inline int memcg_alloc_page_obj_cgroups(struct page *page,
 					       struct kmem_cache *s, gfp_t gfp)
 {
@@ -532,6 +505,13 @@ static inline void memcg_free_page_obj_cgroups(struc=
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
@@ -569,32 +549,33 @@ static __always_inline int charge_slab_page(struct =
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
+	if (memcg_kmem_enabled() && !is_root_cache(s)) {
+		int ret;
=20
-	ret =3D memcg_alloc_page_obj_cgroups(page, s, gfp);
-	if (ret)
-		return ret;
+		ret =3D memcg_alloc_page_obj_cgroups(page, s, gfp);
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
+	if (memcg_kmem_enabled() && !is_root_cache(s)) {
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
@@ -666,7 +647,7 @@ static inline struct kmem_cache *slab_pre_alloc_hook(=
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
2.25.4

