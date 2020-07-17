Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E3BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 21:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC402076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 21:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gUqLwyZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGQVsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 17:48:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28150 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726720AbgGQVsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:48:46 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06HLUie2023542
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 14:48:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=E1zbxRNa6n18xFElQmvtOWH5Yyo6DOn9fwekaPZ2vh8=;
 b=gUqLwyZTZPmtoeGM4+8xXp9nCmn9bj+osbXA/ahOO0+ep2yt7PK0GZcrJLu08MGhd9iD
 JgQ5H5VdcuisNjY4cVmvmjqoIB+6O3qOmjEqgmkmsR83067gOtHMh4UAJJWQTo6n2Id5
 oU+KOEDqY70fbx7RB4c/4LCJzFovc9YBeDI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32a7dfbkkb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 14:48:45 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 17 Jul 2020 14:48:40 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 8D7E714C528E; Fri, 17 Jul 2020 14:48:28 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH] mm: slab/memcg: fix build on MIPS
Date:   Fri, 17 Jul 2020 14:48:10 -0700
Message-ID: <20200717214810.3733082-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_10:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=2 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007170145
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naresh reported that linux-next build is broken on MIPS. The problem
is reproducible using gcc 8 and 9, but not 10.

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Dmips
CROSS_COMPILE=3Dmips-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
mips-linux-gnu-gcc" O=3Dbuild
../mm/slub.c: In function =E2=80=98slab_alloc.constprop=E2=80=99:
../mm/slub.c:2897:30: error: inlining failed in call to always_inline
=E2=80=98slab_alloc.constprop=E2=80=99: recursive inlining
 2897 | static __always_inline void *slab_alloc(struct kmem_cache *s,
      |                              ^~~~~~~~~~
../mm/slub.c:2905:14: note: called from here
 2905 |  void *ret =3D slab_alloc(s, gfpflags, _RET_IP_);
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../mm/slub.c: In function =E2=80=98sysfs_slab_alias=E2=80=99:
../mm/slub.c:2897:30: error: inlining failed in call to always_inline
=E2=80=98slab_alloc.constprop=E2=80=99: recursive inlining
 2897 | static __always_inline void *slab_alloc(struct kmem_cache *s,
      |                              ^~~~~~~~~~
../mm/slub.c:2905:14: note: called from here
 2905 |  void *ret =3D slab_alloc(s, gfpflags, _RET_IP_);
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../mm/slub.c: In function =E2=80=98sysfs_slab_add=E2=80=99:
../mm/slub.c:2897:30: error: inlining failed in call to always_inline
=E2=80=98slab_alloc.constprop=E2=80=99: recursive inlining
 2897 | static __always_inline void *slab_alloc(struct kmem_cache *s,
      |                              ^~~~~~~~~~
../mm/slub.c:2905:14: note: called from here
 2905 |  void *ret =3D slab_alloc(s, gfpflags, _RET_IP_);
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The problem was introduced by commit "mem: memcg/slab: use a single
set of kmem_caches for all allocations", which added an allocation
of the space for the obj_cgroup vector into the slab post hook
and created a recursive inlining.

The easies way to fix this is to move memcg_alloc_page_obj_cgroups()
to memcontrol.c and make it a generic (not static inline) function.
It breaks the inlining recursion and fixes the build.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
---
 mm/memcontrol.c | 20 ++++++++++++++++++++
 mm/slab.h       | 21 ++-------------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3f49e9bdbf2d..f47e9f0d42f4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2831,6 +2831,26 @@ static void commit_charge(struct page *page, struc=
t mem_cgroup *memcg)
 }
=20
 #ifdef CONFIG_MEMCG_KMEM
+int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s=
,
+				 gfp_t gfp)
+{
+	unsigned int objects =3D objs_per_slab_page(s, page);
+	void *vec;
+
+	vec =3D kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
+			   page_to_nid(page));
+	if (!vec)
+		return -ENOMEM;
+
+	if (cmpxchg(&page->obj_cgroups, NULL,
+		    (struct obj_cgroup **) ((unsigned long)vec | 0x1UL)))
+		kfree(vec);
+	else
+		kmemleak_not_leak(vec);
+
+	return 0;
+}
+
 /*
  * Returns a pointer to the memory cgroup to which the kernel object is =
charged.
  *
diff --git a/mm/slab.h b/mm/slab.h
index 92a4104b22b3..6cc323f1313a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -257,25 +257,8 @@ static inline bool page_has_obj_cgroups(struct page =
*page)
 	return ((unsigned long)page->obj_cgroups & 0x1UL);
 }
=20
-static inline int memcg_alloc_page_obj_cgroups(struct page *page,
-					       struct kmem_cache *s, gfp_t gfp)
-{
-	unsigned int objects =3D objs_per_slab_page(s, page);
-	void *vec;
-
-	vec =3D kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
-			   page_to_nid(page));
-	if (!vec)
-		return -ENOMEM;
-
-	if (cmpxchg(&page->obj_cgroups, NULL,
-		    (struct obj_cgroup **) ((unsigned long)vec | 0x1UL)))
-		kfree(vec);
-	else
-		kmemleak_not_leak(vec);
-
-	return 0;
-}
+int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s=
,
+				 gfp_t gfp);
=20
 static inline void memcg_free_page_obj_cgroups(struct page *page)
 {
--=20
2.26.2

