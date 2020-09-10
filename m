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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F1C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5432214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BoqgspmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgIJUrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:47:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46422 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgIJU1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:27:15 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AKK6q6026452
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:27:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=U00U9BAnLGdXJ2bHMe54VK8p/LCktUxrS/WXFvH6Qno=;
 b=BoqgspmRwSxVsaGA4vmb5sCQHKhaJn/Oh+Z/H8+U6KYmnShK+7iKa5t7brEuCguG7f3r
 6gd65O4MAkK4GY+Ep23rtor69yBcMDO6aSHSomLLiYk4inf/Xg2on2dUs7q6RP9Rh/VA
 luVb+jd2CjQfJfD4bcfXXZbsSYPEjnM47uk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33fqw11a7a-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 13:27:14 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 13:27:11 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id C0CB43D449BA; Thu, 10 Sep 2020 13:27:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH rfc 5/5] mm: convert page kmemcg type to a page memcg flag
Date:   Thu, 10 Sep 2020 13:26:59 -0700
Message-ID: <20200910202659.1378404-6-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200910202659.1378404-1-guro@fb.com>
References: <20200910202659.1378404-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_09:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 suspectscore=2 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100183
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PageKmemcg flag is currently defined as a page type (like buddy,
offline, table and guard). Semantically it means that the page
was accounted as a kernel memory by the page allocator and has
to be uncharged on the release.

As a side effect of defining the flag as a page type, the accounted
page can't be mapped to userspace (look at page_has_type() and
comments above). In particular, this blocks the accounting of
vmalloc-backed memory used by some bpf maps, because these maps
do map the memory to userspace.

One option is to fix it by complicating the access to page->mapcount,
which provides some free bits for page->page_type.

But it's way better to move this flag into page->memcg_data flags.
Indeed, the flag makes no sense without enabled memory cgroups
and memory cgroup pointer set in particular.

This commit replaces PageKmemcg() and __SetPageKmemcg() with
PageMemcgKmem() and SetPageMemcgKmem(). __ClearPageKmemcg()
can be simple deleted because clear_page_mem_cgroup() already
does the job.

As a bonus, on !CONFIG_MEMCG build the PageMemcgKmem() check will
be compiled out.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 35 ++++++++++++++++++++++++++++++++---
 include/linux/page-flags.h | 11 ++---------
 mm/memcontrol.c            | 14 ++++----------
 mm/page_alloc.c            |  2 +-
 4 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7ab5f92bb686..430d1ca925c9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -343,15 +343,22 @@ extern struct mem_cgroup *root_mem_cgroup;
 enum page_memcg_flags {
 	/* page->memcg_data is a pointer to a objcgs vector */
 	PG_MEMCG_OBJ_CGROUPS,
+	/* page has been accounted as a non-slab kernel page */
+	PG_MEMCG_KMEM,
+	/* the next bit after the last actual flag */
+	PG_MEMCG_LAST_FLAG,
 };
=20
+#define MEMCG_FLAGS_MASK ((1UL << PG_MEMCG_LAST_FLAG) - 1)
+
 static inline struct mem_cgroup *page_mem_cgroup(struct page *page)
 {
 	unsigned long memcg_data =3D page->memcg_data;
=20
 	VM_BUG_ON_PAGE(PageSlab(page), page);
+	VM_BUG_ON_PAGE(test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data), page);
=20
-	return (struct mem_cgroup *)memcg_data;
+	return (struct mem_cgroup *)(memcg_data & ~MEMCG_FLAGS_MASK);
 }
=20
 static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page=
)
@@ -361,7 +368,7 @@ static inline struct mem_cgroup *page_mem_cgroup_chec=
k(struct page *page)
 	if (test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
 		return NULL;
=20
-	return (struct mem_cgroup *)memcg_data;
+	return (struct mem_cgroup *)(memcg_data & ~MEMCG_FLAGS_MASK);
 }
=20
 static inline void set_page_mem_cgroup(struct page *page,
@@ -377,6 +384,16 @@ static inline void clear_page_mem_cgroup(struct page=
 *page)
 	page->memcg_data =3D 0;
 }
=20
+static inline bool PageMemcgKmem(struct page *page)
+{
+	return test_bit(PG_MEMCG_KMEM, &page->memcg_data);
+}
+
+static inline void SetPageMemcgKmem(struct page *page)
+{
+	__set_bit(PG_MEMCG_KMEM, &page->memcg_data);
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
 {
@@ -385,6 +402,7 @@ static inline struct obj_cgroup **page_obj_cgroups(st=
ruct page *page)
 	VM_BUG_ON_PAGE(memcg_data && !test_bit(PG_MEMCG_OBJ_CGROUPS,
 					       &memcg_data), page);
 	__clear_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data);
+	VM_BUG_ON_PAGE(test_bit(PG_MEMCG_KMEM, &memcg_data), page);
=20
 	return (struct obj_cgroup **)memcg_data;
 }
@@ -393,8 +411,10 @@ static inline struct obj_cgroup **page_obj_cgroups_c=
heck(struct page *page)
 {
 	unsigned long memcg_data =3D page->memcg_data;
=20
-	if (memcg_data && test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
+	if (memcg_data && test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data)) {
+		VM_BUG_ON_PAGE(test_bit(PG_MEMCG_KMEM, &memcg_data), page);
 		return (struct obj_cgroup **)memcg_data;
+	}
=20
 	return NULL;
 }
@@ -1052,6 +1072,15 @@ static inline void clear_page_mem_cgroup(struct pa=
ge *page)
 {
 }
=20
+static inline bool PageMemcgKmem(struct page *page)
+{
+	return false;
+}
+
+static inline void SetPageMemcgKmem(struct page *page)
+{
+}
+
 static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 {
 	return true;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index fbbb841a9346..a7ca01ae78d9 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -712,9 +712,8 @@ PAGEFLAG_FALSE(DoubleMap)
 #define PAGE_MAPCOUNT_RESERVE	-128
 #define PG_buddy	0x00000080
 #define PG_offline	0x00000100
-#define PG_kmemcg	0x00000200
-#define PG_table	0x00000400
-#define PG_guard	0x00000800
+#define PG_table	0x00000200
+#define PG_guard	0x00000400
=20
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) =3D=3D PAGE_TYPE_BASE)
@@ -765,12 +764,6 @@ PAGE_TYPE_OPS(Buddy, buddy)
  */
 PAGE_TYPE_OPS(Offline, offline)
=20
-/*
- * If kmemcg is enabled, the buddy allocator will set PageKmemcg() on
- * pages allocated with __GFP_ACCOUNT. It gets cleared on page free.
- */
-PAGE_TYPE_OPS(Kmemcg, kmemcg)
-
 /*
  * Marks pages in use as page tables.
  */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ba9b053b1b88..d4c21870dab9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3070,7 +3070,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp=
_t gfp, int order)
 		ret =3D __memcg_kmem_charge(memcg, gfp, 1 << order);
 		if (!ret) {
 			set_page_mem_cgroup(page, memcg);
-			__SetPageKmemcg(page);
+			SetPageMemcgKmem(page);
 			return 0;
 		}
 		css_put(&memcg->css);
@@ -3095,10 +3095,6 @@ void __memcg_kmem_uncharge_page(struct page *page,=
 int order)
 	__memcg_kmem_uncharge(memcg, nr_pages);
 	clear_page_mem_cgroup(page);
 	css_put(&memcg->css);
-
-	/* slab pages do not have PageKmemcg flag set */
-	if (PageKmemcg(page))
-		__ClearPageKmemcg(page);
 }
=20
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_=
bytes)
@@ -6830,12 +6826,10 @@ static void uncharge_page(struct page *page, stru=
ct uncharge_gather *ug)
 	nr_pages =3D compound_nr(page);
 	ug->nr_pages +=3D nr_pages;
=20
-	if (!PageKmemcg(page)) {
-		ug->pgpgout++;
-	} else {
+	if (PageMemcgKmem(page))
 		ug->nr_kmem +=3D nr_pages;
-		__ClearPageKmemcg(page);
-	}
+	else
+		ug->pgpgout++;
=20
 	ug->dummy_page =3D page;
 	clear_page_mem_cgroup(page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a707671f3b6c..3a61868113ec 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1197,7 +1197,7 @@ static __always_inline bool free_pages_prepare(stru=
ct page *page,
 	}
 	if (PageMappingFlags(page))
 		page->mapping =3D NULL;
-	if (memcg_kmem_enabled() && PageKmemcg(page))
+	if (memcg_kmem_enabled() && PageMemcgKmem(page))
 		__memcg_kmem_uncharge_page(page, order);
 	if (check_free)
 		bad +=3D check_free_page(page);
--=20
2.26.2

