Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F770C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3702077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VMubAITM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgDVUsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:48:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35594 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgDVUrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:47:23 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03MKlDYQ016498
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=d0Y2kCsRrjffDSJZIXIKh5cOtSVvbtaF9Hcldpd6a8s=;
 b=VMubAITM32YHOnv3kEP0PWpVVgpZli7M1mbM9R5efRVTFoJlF2+74Kw/DJV4mc1txrn9
 O4vrrvI8Q7CrmVlz8QERa/zEHHrCEIbXbXqG395oplfJhyW+enc4XLqYPOybypy4c7tM
 qIOp29w3LRljsHndEdNxbcrWh/0MLZMS7Pc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 30jatknts5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:22 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 22 Apr 2020 13:47:21 -0700
Received: by devvm4439.prn2.facebook.com (Postfix, from userid 111017)
        id D683322935805; Wed, 22 Apr 2020 13:47:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm4439.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 07/19] mm: memcg/slab: allocate obj_cgroups for non-root slab pages
Date:   Wed, 22 Apr 2020 13:46:56 -0700
Message-ID: <20200422204708.2176080-8-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200422204708.2176080-1-guro@fb.com>
References: <20200422204708.2176080-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_07:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=2
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=867
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220159
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
---
 include/linux/mm_types.h |  5 ++++-
 include/linux/slab_def.h |  5 +++++
 include/linux/slub_def.h |  2 ++
 mm/memcontrol.c          | 17 +++++++++++---
 mm/slab.c                |  3 ++-
 mm/slab.h                | 48 ++++++++++++++++++++++++++++++++++++++++
 mm/slub.c                |  5 +++++
 7 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4aba6c0c2ba8..0ad7e700f26d 100644
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
index abc7de77b988..967a9a525eab 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -114,4 +114,9 @@ static inline unsigned int obj_to_index(const struct =
kmem_cache *cache,
 	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
 }
=20
+static inline int objs_per_slab(const struct kmem_cache *cache)
+{
+	return cache->num;
+}
+
 #endif	/* _LINUX_SLAB_DEF_H */
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 200ea292f250..cbda7d55796a 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -191,4 +191,6 @@ static inline unsigned int obj_to_index(const struct =
kmem_cache *cache,
 				 cache->reciprocal_size);
 }
=20
+extern int objs_per_slab(struct kmem_cache *cache);
+
 #endif /* _LINUX_SLUB_DEF_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7f87a0eeafec..63826e460b3f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -549,10 +549,21 @@ ino_t page_cgroup_ino(struct page *page)
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
diff --git a/mm/slab.c b/mm/slab.c
index 9350062ffc1a..f2d67984595b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1370,7 +1370,8 @@ static struct page *kmem_getpages(struct kmem_cache=
 *cachep, gfp_t flags,
 		return NULL;
 	}
=20
-	if (charge_slab_page(page, flags, cachep->gfporder, cachep)) {
+	if (charge_slab_page(page, flags, cachep->gfporder, cachep,
+			     cachep->num)) {
 		__free_pages(page, cachep->gfporder);
 		return NULL;
 	}
diff --git a/mm/slab.h b/mm/slab.h
index 8a574d9361c1..44def57f050e 100644
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
@@ -406,6 +418,25 @@ static __always_inline void memcg_uncharge_slab(stru=
ct page *page, int order,
 	percpu_ref_put_many(&s->memcg_params.refcnt, nr_pages);
 }
=20
+static inline int memcg_alloc_page_obj_cgroups(struct page *page, gfp_t =
gfp,
+					       unsigned int objects)
+{
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
@@ -455,6 +486,16 @@ static inline void memcg_uncharge_slab(struct page *=
page, int order,
 {
 }
=20
+static inline int memcg_alloc_page_obj_cgroups(struct page *page, gfp_t =
gfp,
+					       unsigned int objects)
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
@@ -481,12 +522,18 @@ static __always_inline int charge_slab_page(struct =
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
+	ret =3D memcg_alloc_page_obj_cgroups(page, gfp, objs_per_slab(s));
+	if (ret)
+		return ret;
+
 	return memcg_charge_slab(page, gfp, order, s);
 }
=20
@@ -499,6 +546,7 @@ static __always_inline void uncharge_slab_page(struct=
 page *page, int order,
 		return;
 	}
=20
+	memcg_free_page_obj_cgroups(page);
 	memcg_uncharge_slab(page, order, s);
 }
=20
diff --git a/mm/slub.c b/mm/slub.c
index 8d16babe1829..68c2c45dfac1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5992,4 +5992,9 @@ ssize_t slabinfo_write(struct file *file, const cha=
r __user *buffer,
 {
 	return -EIO;
 }
+
+int objs_per_slab(struct kmem_cache *cache)
+{
+	return oo_objects(cache->oo);
+}
 #endif /* CONFIG_SLUB_DEBUG */
--=20
2.25.3

