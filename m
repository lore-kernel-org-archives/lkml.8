Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FC1C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB5420899
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JRD17R7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390769AbgEZVnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:43:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41322 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390951AbgEZVmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:42:50 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QLen8A001032
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:42:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=K21jMkhJT7jBdcOiLMo94Thc9cIyegRXhF8qAuXF7+c=;
 b=JRD17R7vXk0XvVxFDpGPoRXuMG1uUpb7lUwyabm0xJKHeZf5b/ehPTNzf3lab2CCx/t8
 Lw6Dr/QzCM4zot0U1wMDHWJ2WFObY3GqeAYTfQKvg8VhG0OFWefd2pe5DkjtJ9vminrC
 TslhVv6gUA++Y1Uw/jk3Sa+irCssimnub00= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3171bpcyf6-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:42:48 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 14:42:42 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 87CBC15EA7E2; Tue, 26 May 2020 14:42:33 -0700 (PDT)
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
Subject: [PATCH v4 14/19] mm: memcg/slab: remove memcg_kmem_get_cache()
Date:   Tue, 26 May 2020 14:42:22 -0700
Message-ID: <20200526214227.989341-15-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200526214227.989341-1-guro@fb.com>
References: <20200526214227.989341-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 cotscore=-2147483648
 mlxlogscore=646 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=2 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005260166
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg_kmem_get_cache() function became really trivial,
so let's just inline it into the single call point:
memcg_slab_pre_alloc_hook().

It will make the code less bulky and can also help the compiler
to generate a better code.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h |  2 --
 mm/memcontrol.c            | 25 +------------------------
 mm/slab.h                  | 11 +++++++++--
 mm/slab_common.c           |  2 +-
 4 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 18ef6c85de5b..7a84d9164449 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1405,8 +1405,6 @@ static inline void memcg_set_shrinker_bit(struct me=
m_cgroup *memcg,
 }
 #endif
=20
-struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
-
 #ifdef CONFIG_MEMCG_KMEM
 int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
 			unsigned int nr_pages);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 883969cdfb5f..ed65fffa1cfc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -393,7 +393,7 @@ void memcg_put_cache_ids(void)
=20
 /*
  * A lot of the calls to the cache allocation functions are expected to =
be
- * inlined by the compiler. Since the calls to memcg_kmem_get_cache are
+ * inlined by the compiler. Since the calls to memcg_slab_pre_alloc_hook=
() are
  * conditional to this static branch, we'll have to allow modules that d=
oes
  * kmem_cache_alloc and the such to see this symbol as well
  */
@@ -2850,29 +2850,6 @@ static void memcg_free_cache_id(int id)
 	ida_simple_remove(&memcg_cache_ida, id);
 }
=20
-/**
- * memcg_kmem_get_cache: select memcg or root cache for allocation
- * @cachep: the original global kmem cache
- *
- * Return the kmem_cache we're supposed to use for a slab allocation.
- *
- * If the cache does not exist yet, if we are the first user of it, we
- * create it asynchronously in a workqueue and let the current allocatio=
n
- * go through with the original cache.
- */
-struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
-{
-	struct kmem_cache *memcg_cachep;
-
-	memcg_cachep =3D READ_ONCE(cachep->memcg_params.memcg_cache);
-	if (unlikely(!memcg_cachep)) {
-		queue_work(system_wq, &cachep->memcg_params.work);
-		return cachep;
-	}
-
-	return memcg_cachep;
-}
-
 /**
  * __memcg_kmem_charge: charge a number of kernel pages to a memcg
  * @memcg: memory cgroup to charge
diff --git a/mm/slab.h b/mm/slab.h
index a730cbe1db66..279c6df92250 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -333,9 +333,16 @@ static inline struct kmem_cache *memcg_slab_pre_allo=
c_hook(struct kmem_cache *s,
 	if (memcg_kmem_bypass())
 		return s;
=20
-	cachep =3D memcg_kmem_get_cache(s);
-	if (is_root_cache(cachep))
+	cachep =3D READ_ONCE(s->memcg_params.memcg_cache);
+	if (unlikely(!cachep)) {
+		/*
+		 * If memcg cache does not exist yet, we schedule it's
+		 * asynchronous creation and let the current allocation
+		 * go through with the root cache.
+		 */
+		queue_work(system_wq, &s->memcg_params.work);
 		return s;
+	}
=20
 	objcg =3D get_obj_cgroup_from_current();
 	if (!objcg)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 10aa2acb84ca..f8874a159637 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -568,7 +568,7 @@ void memcg_create_kmem_cache(struct kmem_cache *root_=
cache)
 	}
=20
 	/*
-	 * Since readers won't lock (see memcg_kmem_get_cache()), we need a
+	 * Since readers won't lock (see memcg_slab_pre_alloc_hook()), we need =
a
 	 * barrier here to ensure nobody will see the kmem_cache partially
 	 * initialized.
 	 */
--=20
2.25.4

