Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE063C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68C920899
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HBboVZIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391174AbgEZVnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:43:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59006 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389384AbgEZVnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:43:18 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04QLe1N5019570
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:43:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=BEM35sFvNzxyPEne7Ec8MioiFlELDkizNoMP4C5szko=;
 b=HBboVZIgdkuplDJ/X3/Pvgdcm6RYsXH2p0AIHIQzDVKIXSlLLeOlOO5Qd1AoZN5TPv3D
 7jJlgWkgOEyCgRlrReVXd3SRLBQ5BFz+EYDfaH8YRSxG2T1sISDhPRx8M4yZU/QJvQP3
 5wkn9P4iDHRNMKEyKi77dRdDGQE8peH02bE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 316yb14wr0-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:43:16 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 14:42:46 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 62B9E15EA7D6; Tue, 26 May 2020 14:42:33 -0700 (PDT)
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
Subject: [PATCH v4 08/19] mm: memcg/slab: save obj_cgroup for non-root slab objects
Date:   Tue, 26 May 2020 14:42:16 -0700
Message-ID: <20200526214227.989341-9-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200526214227.989341-1-guro@fb.com>
References: <20200526214227.989341-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 cotscore=-2147483648 spamscore=0 priorityscore=1501 suspectscore=2
 bulkscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260166
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the obj_cgroup pointer in the corresponding place of
page->obj_cgroups for each allocated non-root slab object.
Make sure that each allocated object holds a reference to obj_cgroup.

Objcg pointer is obtained from the memcg->objcg dereferencing
in memcg_kmem_get_cache() and passed from pre_alloc_hook to
post_alloc_hook. Then in case of successful allocation(s) it's
getting stored in the page->obj_cgroups vector.

The objcg obtaining part look a bit bulky now, but it will be simplified
by next commits in the series.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h |  3 +-
 mm/memcontrol.c            | 14 +++++++--
 mm/slab.c                  | 18 +++++++-----
 mm/slab.h                  | 60 ++++++++++++++++++++++++++++++++++----
 mm/slub.c                  | 14 +++++----
 5 files changed, 88 insertions(+), 21 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ca2e71975581..98239fdf9fee 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1406,7 +1406,8 @@ static inline void memcg_set_shrinker_bit(struct me=
m_cgroup *memcg,
 }
 #endif
=20
-struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
+struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep,
+					struct obj_cgroup **objcgp);
 void memcg_kmem_put_cache(struct kmem_cache *cachep);
=20
 #ifdef CONFIG_MEMCG_KMEM
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c0f1abfea30e..ed12bff81ea5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2916,7 +2916,8 @@ static inline bool memcg_kmem_bypass(void)
  * done with it, memcg_kmem_put_cache() must be called to release the
  * reference.
  */
-struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
+struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep,
+					struct obj_cgroup **objcgp)
 {
 	struct mem_cgroup *memcg;
 	struct kmem_cache *memcg_cachep;
@@ -2972,8 +2973,17 @@ struct kmem_cache *memcg_kmem_get_cache(struct kme=
m_cache *cachep)
 	 */
 	if (unlikely(!memcg_cachep))
 		memcg_schedule_kmem_cache_create(memcg, cachep);
-	else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt))
+	else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt)) {
+		struct obj_cgroup *objcg =3D rcu_dereference(memcg->objcg);
+
+		if (!objcg || !obj_cgroup_tryget(objcg)) {
+			percpu_ref_put(&memcg_cachep->memcg_params.refcnt);
+			goto out_unlock;
+		}
+
+		*objcgp =3D objcg;
 		cachep =3D memcg_cachep;
+	}
 out_unlock:
 	rcu_read_unlock();
 	return cachep;
diff --git a/mm/slab.c b/mm/slab.c
index 9350062ffc1a..02b4363930c1 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3222,9 +3222,10 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t f=
lags, int nodeid,
 	unsigned long save_flags;
 	void *ptr;
 	int slab_node =3D numa_mem_id();
+	struct obj_cgroup *objcg =3D NULL;
=20
 	flags &=3D gfp_allowed_mask;
-	cachep =3D slab_pre_alloc_hook(cachep, flags);
+	cachep =3D slab_pre_alloc_hook(cachep, &objcg, 1, flags);
 	if (unlikely(!cachep))
 		return NULL;
=20
@@ -3260,7 +3261,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t fl=
ags, int nodeid,
 	if (unlikely(slab_want_init_on_alloc(flags, cachep)) && ptr)
 		memset(ptr, 0, cachep->object_size);
=20
-	slab_post_alloc_hook(cachep, flags, 1, &ptr);
+	slab_post_alloc_hook(cachep, objcg, flags, 1, &ptr);
 	return ptr;
 }
=20
@@ -3301,9 +3302,10 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags,=
 unsigned long caller)
 {
 	unsigned long save_flags;
 	void *objp;
+	struct obj_cgroup *objcg =3D NULL;
=20
 	flags &=3D gfp_allowed_mask;
-	cachep =3D slab_pre_alloc_hook(cachep, flags);
+	cachep =3D slab_pre_alloc_hook(cachep, &objcg, 1, flags);
 	if (unlikely(!cachep))
 		return NULL;
=20
@@ -3317,7 +3319,7 @@ slab_alloc(struct kmem_cache *cachep, gfp_t flags, =
unsigned long caller)
 	if (unlikely(slab_want_init_on_alloc(flags, cachep)) && objp)
 		memset(objp, 0, cachep->object_size);
=20
-	slab_post_alloc_hook(cachep, flags, 1, &objp);
+	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp);
 	return objp;
 }
=20
@@ -3439,6 +3441,7 @@ void ___cache_free(struct kmem_cache *cachep, void =
*objp,
 		memset(objp, 0, cachep->object_size);
 	kmemleak_free_recursive(objp, cachep->flags);
 	objp =3D cache_free_debugcheck(cachep, objp, caller);
+	memcg_slab_free_hook(cachep, virt_to_head_page(objp), objp);
=20
 	/*
 	 * Skip calling cache_free_alien() when the platform is not numa.
@@ -3504,8 +3507,9 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp=
_t flags, size_t size,
 			  void **p)
 {
 	size_t i;
+	struct obj_cgroup *objcg =3D NULL;
=20
-	s =3D slab_pre_alloc_hook(s, flags);
+	s =3D slab_pre_alloc_hook(s, &objcg, size, flags);
 	if (!s)
 		return 0;
=20
@@ -3528,13 +3532,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, g=
fp_t flags, size_t size,
 		for (i =3D 0; i < size; i++)
 			memset(p[i], 0, s->object_size);
=20
-	slab_post_alloc_hook(s, flags, size, p);
+	slab_post_alloc_hook(s, objcg, flags, size, p);
 	/* FIXME: Trace call missing. Christoph would like a bulk variant */
 	return size;
 error:
 	local_irq_enable();
 	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
-	slab_post_alloc_hook(s, flags, i, p);
+	slab_post_alloc_hook(s, objcg, flags, i, p);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
diff --git a/mm/slab.h b/mm/slab.h
index a1633ea15fbf..8bca0cb4b928 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -438,6 +438,41 @@ static inline void memcg_free_page_obj_cgroups(struc=
t page *page)
 	page->obj_cgroups =3D NULL;
 }
=20
+static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
+					      struct obj_cgroup *objcg,
+					      size_t size, void **p)
+{
+	struct page *page;
+	unsigned long off;
+	size_t i;
+
+	for (i =3D 0; i < size; i++) {
+		if (likely(p[i])) {
+			page =3D virt_to_head_page(p[i]);
+			off =3D obj_to_index(s, page, p[i]);
+			obj_cgroup_get(objcg);
+			page_obj_cgroups(page)[off] =3D objcg;
+		}
+	}
+	obj_cgroup_put(objcg);
+	memcg_kmem_put_cache(s);
+}
+
+static inline void memcg_slab_free_hook(struct kmem_cache *s, struct pag=
e *page,
+					void *p)
+{
+	struct obj_cgroup *objcg;
+	unsigned int off;
+
+	if (!memcg_kmem_enabled() || is_root_cache(s))
+		return;
+
+	off =3D obj_to_index(s, page, p);
+	objcg =3D page_obj_cgroups(page)[off];
+	page_obj_cgroups(page)[off] =3D NULL;
+	obj_cgroup_put(objcg);
+}
+
 extern void slab_init_memcg_params(struct kmem_cache *);
 extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *me=
mcg);
=20
@@ -497,6 +532,17 @@ static inline void memcg_free_page_obj_cgroups(struc=
t page *page)
 {
 }
=20
+static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
+					      struct obj_cgroup *objcg,
+					      size_t size, void **p)
+{
+}
+
+static inline void memcg_slab_free_hook(struct kmem_cache *s, struct pag=
e *page,
+					void *p)
+{
+}
+
 static inline void slab_init_memcg_params(struct kmem_cache *s)
 {
 }
@@ -605,7 +651,8 @@ static inline size_t slab_ksize(const struct kmem_cac=
he *s)
 }
=20
 static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *=
s,
-						     gfp_t flags)
+						     struct obj_cgroup **objcgp,
+						     size_t size, gfp_t flags)
 {
 	flags &=3D gfp_allowed_mask;
=20
@@ -619,13 +666,14 @@ static inline struct kmem_cache *slab_pre_alloc_hoo=
k(struct kmem_cache *s,
=20
 	if (memcg_kmem_enabled() &&
 	    ((flags & __GFP_ACCOUNT) || (s->flags & SLAB_ACCOUNT)))
-		return memcg_kmem_get_cache(s);
+		return memcg_kmem_get_cache(s, objcgp);
=20
 	return s;
 }
=20
-static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flag=
s,
-					size_t size, void **p)
+static inline void slab_post_alloc_hook(struct kmem_cache *s,
+					struct obj_cgroup *objcg,
+					gfp_t flags, size_t size, void **p)
 {
 	size_t i;
=20
@@ -637,8 +685,8 @@ static inline void slab_post_alloc_hook(struct kmem_c=
ache *s, gfp_t flags,
 					 s->flags, flags);
 	}
=20
-	if (memcg_kmem_enabled())
-		memcg_kmem_put_cache(s);
+	if (memcg_kmem_enabled() && !is_root_cache(s))
+		memcg_slab_post_alloc_hook(s, objcg, size, p);
 }
=20
 #ifndef CONFIG_SLOB
diff --git a/mm/slub.c b/mm/slub.c
index 601c0fc3c83a..82c87444409f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2738,8 +2738,9 @@ static __always_inline void *slab_alloc_node(struct=
 kmem_cache *s,
 	struct kmem_cache_cpu *c;
 	struct page *page;
 	unsigned long tid;
+	struct obj_cgroup *objcg =3D NULL;
=20
-	s =3D slab_pre_alloc_hook(s, gfpflags);
+	s =3D slab_pre_alloc_hook(s, &objcg, 1, gfpflags);
 	if (!s)
 		return NULL;
 redo:
@@ -2815,7 +2816,7 @@ static __always_inline void *slab_alloc_node(struct=
 kmem_cache *s,
 	if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
 		memset(object, 0, s->object_size);
=20
-	slab_post_alloc_hook(s, gfpflags, 1, &object);
+	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object);
=20
 	return object;
 }
@@ -3020,6 +3021,8 @@ static __always_inline void do_slab_free(struct kme=
m_cache *s,
 	void *tail_obj =3D tail ? : head;
 	struct kmem_cache_cpu *c;
 	unsigned long tid;
+
+	memcg_slab_free_hook(s, page, head);
 redo:
 	/*
 	 * Determine the currently cpus per cpu slab.
@@ -3199,9 +3202,10 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gf=
p_t flags, size_t size,
 {
 	struct kmem_cache_cpu *c;
 	int i;
+	struct obj_cgroup *objcg =3D NULL;
=20
 	/* memcg and kmem_cache debug support */
-	s =3D slab_pre_alloc_hook(s, flags);
+	s =3D slab_pre_alloc_hook(s, &objcg, size, flags);
 	if (unlikely(!s))
 		return false;
 	/*
@@ -3255,11 +3259,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, g=
fp_t flags, size_t size,
 	}
=20
 	/* memcg and kmem_cache debug support */
-	slab_post_alloc_hook(s, flags, size, p);
+	slab_post_alloc_hook(s, objcg, flags, size, p);
 	return i;
 error:
 	local_irq_enable();
-	slab_post_alloc_hook(s, flags, i, p);
+	slab_post_alloc_hook(s, objcg, flags, i, p);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
--=20
2.25.4

