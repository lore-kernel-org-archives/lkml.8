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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C467C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB260221E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GSooHj9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIJU3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:29:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46078 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726961AbgIJU1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:27:13 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AKOIr5014874
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:27:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=YpAuu73LqS8VETlPU30ylvsD7APUey0fsX1DDemWPf8=;
 b=GSooHj9El7P0teER6JYGoUtDeShoupvpKFT8fvdlYReQJaYurws3JH/sfMhQSkETBTRd
 PheQjT4o+oRUvLoJa4Un833Lp0Z1twCeQwZ/k/7qZt49zFmh9tPCMnPrioCUWP4QRGSQ
 1t3gE86q//hqySZytD4A/rqtVSrWoWVgyDw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33fr1916qs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:27:09 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 13:27:08 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id B64093D449B6; Thu, 10 Sep 2020 13:27:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH rfc 3/5] mm: memcontrol/slab: use helpers to access slab page's memcg_data
Date:   Thu, 10 Sep 2020 13:26:57 -0700
Message-ID: <20200910202659.1378404-4-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200910202659.1378404-1-guro@fb.com>
References: <20200910202659.1378404-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_09:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=696 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=2 priorityscore=1501 adultscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100183
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To gather all direct accesses to struct page's memcg_data field
in one place, let's introduce 4 new helper functions to use in
the slab accounting code:
  struct obj_cgroup **page_obj_cgroups(struct page *page);
  struct obj_cgroup **page_obj_cgroups_check(struct page *page);
  bool set_page_obj_cgroups(struct page *page, struct obj_cgroup **objcgs=
);
  void clear_page_obj_cgroups(struct page *page);

They are similar to the corresponding API for generic pages, except
that the setter can return false, indicating that the value has been
already set from a different thread.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 48 ++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c            |  4 ++--
 mm/slab.h                  | 27 +++------------------
 3 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0997220c84ce..48d4c2c1ce81 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -375,6 +375,54 @@ static inline void clear_page_mem_cgroup(struct page=
 *page)
 	page->memcg_data =3D 0;
 }
=20
+#ifdef CONFIG_MEMCG_KMEM
+static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
+{
+	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
+}
+
+static inline struct obj_cgroup **page_obj_cgroups_check(struct page *pa=
ge)
+{
+	unsigned long memcg_data =3D page->memcg_data;
+
+	if (memcg_data && (memcg_data & 0x1UL))
+		return (struct obj_cgroup **)memcg_data;
+
+	return NULL;
+}
+
+static inline bool set_page_obj_cgroups(struct page *page,
+					struct obj_cgroup **objcgs)
+{
+	return !cmpxchg(&page->memcg_data, 0, (unsigned long)objcgs | 0x1UL);
+}
+
+static inline void clear_page_obj_cgroups(struct page *page)
+{
+	page->memcg_data =3D 0;
+}
+#else
+static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
+{
+	return NULL;
+}
+
+static inline struct obj_cgroup **page_obj_cgroups_check(struct page *pa=
ge)
+{
+	return NULL;
+}
+
+static inline bool set_page_obj_cgroups(struct page *page,
+					struct obj_cgroup **objcgs)
+{
+	return true;
+}
+
+static inline void clear_page_obj_cgroups(struct page *page)
+{
+}
+#endif
+
 static __always_inline bool memcg_stat_item_in_bytes(int idx)
 {
 	if (idx =3D=3D MEMCG_PERCPU_B)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 19180674e38a..ba9b053b1b88 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2890,7 +2890,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page,=
 struct kmem_cache *s,
 	if (!vec)
 		return -ENOMEM;
=20
-	if (cmpxchg(&page->memcg_data, 0, (unsigned long)vec | 0x1UL))
+	if (!set_page_obj_cgroups(page, vec))
 		kfree(vec);
 	else
 		kmemleak_not_leak(vec);
@@ -2918,7 +2918,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
 	 * Memcg membership data for each individual object is saved in
 	 * the page->obj_cgroups.
 	 */
-	if (page_has_obj_cgroups(page)) {
+	if (page_obj_cgroups_check(page)) {
 		struct obj_cgroup *objcg;
 		unsigned int off;
=20
diff --git a/mm/slab.h b/mm/slab.h
index b9787c4d6e78..9a46ab76cb61 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -239,29 +239,13 @@ static inline bool kmem_cache_debug_flags(struct km=
em_cache *s, slab_flags_t fla
 }
=20
 #ifdef CONFIG_MEMCG_KMEM
-static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
-{
-	/*
-	 * page->mem_cgroup and page->obj_cgroups are sharing the same
-	 * space. To distinguish between them in case we don't know for sure
-	 * that the page is a slab page (e.g. page_cgroup_ino()), let's
-	 * always set the lowest bit of obj_cgroups.
-	 */
-	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
-}
-
-static inline bool page_has_obj_cgroups(struct page *page)
-{
-	return page->memcg_data & 0x1UL;
-}
-
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s=
,
 				 gfp_t gfp);
=20
 static inline void memcg_free_page_obj_cgroups(struct page *page)
 {
 	kfree(page_obj_cgroups(page));
-	page->memcg_data =3D 0;
+	clear_page_obj_cgroups(page);
 }
=20
 static inline size_t obj_full_size(struct kmem_cache *s)
@@ -322,7 +306,7 @@ static inline void memcg_slab_post_alloc_hook(struct =
kmem_cache *s,
 		if (likely(p[i])) {
 			page =3D virt_to_head_page(p[i]);
=20
-			if (!page_has_obj_cgroups(page) &&
+			if (!page_obj_cgroups(page) &&
 			    memcg_alloc_page_obj_cgroups(page, s, flags)) {
 				obj_cgroup_uncharge(objcg, obj_full_size(s));
 				continue;
@@ -349,7 +333,7 @@ static inline void memcg_slab_free_hook(struct kmem_c=
ache *s, struct page *page,
 	if (!memcg_kmem_enabled())
 		return;
=20
-	if (!page_has_obj_cgroups(page))
+	if (!page_obj_cgroups(page))
 		return;
=20
 	off =3D obj_to_index(s, page, p);
@@ -367,11 +351,6 @@ static inline void memcg_slab_free_hook(struct kmem_=
cache *s, struct page *page,
 }
=20
 #else /* CONFIG_MEMCG_KMEM */
-static inline bool page_has_obj_cgroups(struct page *page)
-{
-	return false;
-}
-
 static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
 {
 	return NULL;
--=20
2.26.2

