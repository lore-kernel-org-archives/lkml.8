Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4187BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4E620672
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GJk+GzF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgGGRgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:36:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62100 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727777AbgGGRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:36:23 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 067HKvFW019860
        for <linux-kernel@vger.kernel.org>; Tue, 7 Jul 2020 10:36:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=YaBH2lQkNIgWyjRpk8numGFGjwrStua5RMBvDTLhu2Y=;
 b=GJk+GzF3vgIgcEvYzxwhi3ce/cWZzvuD6b4mXK76a6MWD/e9jnyl3DerSMOUv09lm1Vt
 n2mMRA9wNmpgKSHydYpvVKanRZPoyia47BnbBcQEzbVMtuiNt7WFjdBS+yuHDyMDobOq
 LKvVn2RrDGtrhntYqA4cfcSGfVRZkNkYmX8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 322n90nst4-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:36:21 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 7 Jul 2020 10:36:18 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 4DA11CDE8D3; Tue,  7 Jul 2020 10:36:17 -0700 (PDT)
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
Subject: [PATCH 1/3] mm: memcg/slab: remove unused argument by charge_slab_page()
Date:   Tue, 7 Jul 2020 10:36:10 -0700
Message-ID: <20200707173612.124425-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_09:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 cotscore=-2147483648 phishscore=0 mlxscore=0 mlxlogscore=843
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070120
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

charge_slab_page() is not using the gfp argument anymore,
remove it.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slab.c | 2 +-
 mm/slab.h | 3 +--
 mm/slub.c | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 2850fe3c5fb8..fafd46877504 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1379,7 +1379,7 @@ static struct page *kmem_getpages(struct kmem_cache=
 *cachep, gfp_t flags,
 		return NULL;
 	}
=20
-	charge_slab_page(page, flags, cachep->gfporder, cachep);
+	charge_slab_page(page, cachep->gfporder, cachep);
 	__SetPageSlab(page);
 	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
 	if (sk_memalloc_socks() && page_is_pfmemalloc(page))
diff --git a/mm/slab.h b/mm/slab.h
index ab172dca8ce2..704a65713f81 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -440,8 +440,7 @@ static inline struct kmem_cache *virt_to_cache(const =
void *obj)
 	return page->slab_cache;
 }
=20
-static __always_inline void charge_slab_page(struct page *page,
-					     gfp_t gfp, int order,
+static __always_inline void charge_slab_page(struct page *page, int orde=
r,
 					     struct kmem_cache *s)
 {
 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
diff --git a/mm/slub.c b/mm/slub.c
index 6769f5f802e9..d9b33a935e58 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1621,7 +1621,7 @@ static inline struct page *alloc_slab_page(struct k=
mem_cache *s,
 		page =3D __alloc_pages_node(node, flags, order);
=20
 	if (page)
-		charge_slab_page(page, flags, order, s);
+		charge_slab_page(page, order, s);
=20
 	return page;
 }
--=20
2.26.2

