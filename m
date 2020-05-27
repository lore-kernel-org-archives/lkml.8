Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF051C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F1F208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RxEbYrUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgE0Wea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:34:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17526 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726666AbgE0WeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:34:22 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04RMGA1F001569
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:34:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=7fa9oE7CMP6QvxVNBhE5QvvSm0eIkKjUyjyE/EIni1w=;
 b=RxEbYrUv8Bs0J1JplhkjiSrtKhywA4bmnr4VygDLa/9rYUWbgJYKHZNZJDeVJJyyx6g7
 7tQOeoUCEAdskv0xgS2BJmB5AznAL3D8x7lLYpyOmsICikciS43a/nd2sUgQdRfLw+jo
 J+Ov2aoUy2QTe36/xz264ONho8Dfjj+3qGQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 316yb1gv3t-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:34:20 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 May 2020 15:34:15 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id AC46E1669023; Wed, 27 May 2020 15:34:07 -0700 (PDT)
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
Subject: [PATCH v5 07/19] mm: memcg/slab: allocate obj_cgroups for non-root slab pages
Date:   Wed, 27 May 2020 15:33:52 -0700
Message-ID: <20200527223404.1008856-8-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200527223404.1008856-1-guro@fb.com>
References: <20200527223404.1008856-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=895
 cotscore=-2147483648 spamscore=0 priorityscore=1501 suspectscore=2
 bulkscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270170
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate and release memory to store obj_cgroup pointers for each
non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
to the allocated space.

To distinguish between obj_cgroups and memcg pointers in case
when it's not obvious which one is used (as in page_cgroup_ino()),
let's always set the lowest bit in the obj_cgroup case.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm_types.h |  5 +++-
 include/linux/slab_def.h |  6 +++++
 include/linux/slub_def.h |  5 ++++
 mm/memcontrol.c          | 17 +++++++++++---
 mm/slab.h                | 49 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 64ede5f150dc..0277fbab7c93 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -198,7 +198,10 @@ struct page {
 	atomic_t _refcount;
=20
 #ifdef CONFIG_MEMCG
-	struct mem_cgroup *mem_cgroup;
+	union {
+		struct mem_cgroup *mem_cgroup;
+		struct obj_cgroup **obj_cgroups;
+	};
 #endif
=20
 	/*
diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index abc7de77b988..ccda7b9669a5 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -114,4 +114,10 @@ static inline unsigned int obj_to_index(const struct=
 kmem_cache *cache,
 	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
 }
=20
+static inline int objs_per_slab_page(const struct kmem_cache *cache,
+				     const struct page *page)
+{
+	return cache->num;
+}
+
 #endif	/* _LINUX_SLAB_DEF_H */
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 30e91c83d401..f87302dcfe8c 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -198,4 +198,9 @@ static inline unsigned int obj_to_index(const struct =
kmem_cache *cache,
 	return __obj_to_index(cache, page_address(page), obj);
 }
=20
+static inline int objs_per_slab_page(const struct kmem_cache *cache,
+				     const struct page *page)
+{
+	return page->objects;
+}
 #endif /* _LINUX_SLUB_DEF_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 02716e553675..1c4d2462e867 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -569,10 +569,21 @@ ino_t page_cgroup_ino(struct page *page)
 	unsigned long ino =3D 0;
=20
 	rcu_read_lock();
-	if (PageSlab(page) && !PageTail(page))
+	if (PageSlab(page) && !PageTail(page)) {
 		memcg =3D memcg_from_slab_page(page);
-	else
-		memcg =3D READ_ONCE(page->mem_cgroup);
+	} else {
+		memcg =3D page->mem_cgroup;
+
+		/*
+		 * The lowest bit set means that memcg isn't a valid
+		 * memcg pointer, but a obj_cgroups pointer.
+		 * In this case the page is shared and doesn't belong
+		 * to any specific memory cgroup.
+		 */
+		if ((unsigned long) memcg & 0x1UL)
+			memcg =3D NULL;
+	}
+
 	while (memcg && !(memcg->css.flags & CSS_ONLINE))
 		memcg =3D parent_mem_cgroup(memcg);
 	if (memcg)
diff --git a/mm/slab.h b/mm/slab.h
index 8a574d9361c1..a1633ea15fbf 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -319,6 +319,18 @@ static inline struct kmem_cache *memcg_root_cache(st=
ruct kmem_cache *s)
 	return s->memcg_params.root_cache;
 }
=20
+static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
+{
+	/*
+	 * page->mem_cgroup and page->obj_cgroups are sharing the same
+	 * space. To distinguish between them in case we don't know for sure
+	 * that the page is a slab page (e.g. page_cgroup_ino()), let's
+	 * always set the lowest bit of obj_cgroups.
+	 */
+	return (struct obj_cgroup **)
+		((unsigned long)page->obj_cgroups & ~0x1UL);
+}
+
 /*
  * Expects a pointer to a slab page. Please note, that PageSlab() check
  * isn't sufficient, as it returns true also for tail compound slab page=
s,
@@ -406,6 +418,26 @@ static __always_inline void memcg_uncharge_slab(stru=
ct page *page, int order,
 	percpu_ref_put_many(&s->memcg_params.refcnt, nr_pages);
 }
=20
+static inline int memcg_alloc_page_obj_cgroups(struct page *page,
+					       struct kmem_cache *s, gfp_t gfp)
+{
+	unsigned int objects =3D objs_per_slab_page(s, page);
+	void *vec;
+
+	vec =3D kcalloc(objects, sizeof(struct obj_cgroup *), gfp);
+	if (!vec)
+		return -ENOMEM;
+
+	page->obj_cgroups =3D (struct obj_cgroup **) ((unsigned long)vec | 0x1U=
L);
+	return 0;
+}
+
+static inline void memcg_free_page_obj_cgroups(struct page *page)
+{
+	kfree(page_obj_cgroups(page));
+	page->obj_cgroups =3D NULL;
+}
+
 extern void slab_init_memcg_params(struct kmem_cache *);
 extern void memcg_link_cache(struct kmem_cache *s, struct mem_cgroup *me=
mcg);
=20
@@ -455,6 +487,16 @@ static inline void memcg_uncharge_slab(struct page *=
page, int order,
 {
 }
=20
+static inline int memcg_alloc_page_obj_cgroups(struct page *page,
+					       struct kmem_cache *s, gfp_t gfp)
+{
+	return 0;
+}
+
+static inline void memcg_free_page_obj_cgroups(struct page *page)
+{
+}
+
 static inline void slab_init_memcg_params(struct kmem_cache *s)
 {
 }
@@ -481,12 +523,18 @@ static __always_inline int charge_slab_page(struct =
page *page,
 					    gfp_t gfp, int order,
 					    struct kmem_cache *s)
 {
+	int ret;
+
 	if (is_root_cache(s)) {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 				    PAGE_SIZE << order);
 		return 0;
 	}
=20
+	ret =3D memcg_alloc_page_obj_cgroups(page, s, gfp);
+	if (ret)
+		return ret;
+
 	return memcg_charge_slab(page, gfp, order, s);
 }
=20
@@ -499,6 +547,7 @@ static __always_inline void uncharge_slab_page(struct=
 page *page, int order,
 		return;
 	}
=20
+	memcg_free_page_obj_cgroups(page);
 	memcg_uncharge_slab(page, order, s);
 }
=20
--=20
2.25.4

