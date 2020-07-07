Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DD8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D2020672
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XdJChonl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgGGRge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:36:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28766 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728579AbgGGRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:36:25 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067HK1sd022471
        for <linux-kernel@vger.kernel.org>; Tue, 7 Jul 2020 10:36:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=XFTvKzVN4yKF1jCi+0agAdaSmwFbXYmEbeT5A5QL0a4=;
 b=XdJChonlVQC8wITptAaEByLhYCQXaphboQEghXg5bLhOKgr1liRFi+oAU1NSgTNA3Dzt
 XbNW0Mh2zi6bvmQnAd01ea0Hq7uH6h/o2A+teJ1HpgOsngx3kt6yx0m0GTzSvv+czPQ/
 LTyrBH2kgikiCtMRnyAxACt0ZYKtIdhljm8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3239r9jyaf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:36:24 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 7 Jul 2020 10:36:22 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 508C4CDE8D5; Tue,  7 Jul 2020 10:36:17 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH 2/3] mm: slab: rename (un)charge_slab_page() to (un)account_slab_page()
Date:   Tue, 7 Jul 2020 10:36:11 -0700
Message-ID: <20200707173612.124425-2-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707173612.124425-1-guro@fb.com>
References: <20200707173612.124425-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_09:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=2
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=876 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxscore=0 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070120
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

charge_slab_page() and uncharge_slab_page() are not related anymore
to memcg charging and uncharging. In order to make their names
less confusing, let's rename them to account_slab_page() and
unaccount_slab_page() respectively.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slab.c | 4 ++--
 mm/slab.h | 8 ++++----
 mm/slub.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index fafd46877504..300adfb67245 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1379,7 +1379,7 @@ static struct page *kmem_getpages(struct kmem_cache=
 *cachep, gfp_t flags,
 		return NULL;
 	}
=20
-	charge_slab_page(page, cachep->gfporder, cachep);
+	account_slab_page(page, cachep->gfporder, cachep);
 	__SetPageSlab(page);
 	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
 	if (sk_memalloc_socks() && page_is_pfmemalloc(page))
@@ -1403,7 +1403,7 @@ static void kmem_freepages(struct kmem_cache *cache=
p, struct page *page)
=20
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab +=3D 1 << order;
-	uncharge_slab_page(page, order, cachep);
+	unaccount_slab_page(page, order, cachep);
 	__free_pages(page, order);
 }
=20
diff --git a/mm/slab.h b/mm/slab.h
index 704a65713f81..72ff7cd933db 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -440,15 +440,15 @@ static inline struct kmem_cache *virt_to_cache(cons=
t void *obj)
 	return page->slab_cache;
 }
=20
-static __always_inline void charge_slab_page(struct page *page, int orde=
r,
-					     struct kmem_cache *s)
+static __always_inline void account_slab_page(struct page *page, int ord=
er,
+					      struct kmem_cache *s)
 {
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 			    PAGE_SIZE << order);
 }
=20
-static __always_inline void uncharge_slab_page(struct page *page, int or=
der,
-					       struct kmem_cache *s)
+static __always_inline void unaccount_slab_page(struct page *page, int o=
rder,
+						struct kmem_cache *s)
 {
 	if (memcg_kmem_enabled())
 		memcg_free_page_obj_cgroups(page);
diff --git a/mm/slub.c b/mm/slub.c
index d9b33a935e58..5cffd3fd440b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1621,7 +1621,7 @@ static inline struct page *alloc_slab_page(struct k=
mem_cache *s,
 		page =3D __alloc_pages_node(node, flags, order);
=20
 	if (page)
-		charge_slab_page(page, order, s);
+		account_slab_page(page, order, s);
=20
 	return page;
 }
@@ -1844,7 +1844,7 @@ static void __free_slab(struct kmem_cache *s, struc=
t page *page)
 	page->mapping =3D NULL;
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab +=3D pages;
-	uncharge_slab_page(page, order, s);
+	unaccount_slab_page(page, order, s);
 	__free_pages(page, order);
 }
=20
--=20
2.26.2

