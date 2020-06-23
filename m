Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D00C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18AC207BC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 01:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CT0J/BCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbgFWB7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 21:59:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12966 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732154AbgFWB7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 21:59:08 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05N1wTBa003621
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:59:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JXUspudHQGAsG6wbk4FnMPo8oy0xBT01USd2Q25R2f8=;
 b=CT0J/BCwu4Qq0BXnH+zQwUzGNJA1r5q+A67lIjqZ6xxlPgpyFVsfWqKmai8HJBsnswj+
 7i4U+VMZROlC7DgNa3Ec/954L3aRNbS6exLODJin5CzwdxAKXeYhwXvJMcqbQnenQbix
 2Qhc4nu6+hyt/GxFY9z+lfpBjdH5pP39VDM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 31se4nknfn-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:59:07 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 18:59:03 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id A4B5E26DD036; Mon, 22 Jun 2020 18:58:48 -0700 (PDT)
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
Subject: [PATCH v7 14/19] mm: memcg/slab: remove memcg_kmem_get_cache()
Date:   Mon, 22 Jun 2020 18:58:41 -0700
Message-ID: <20200623015846.1141975-15-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623015846.1141975-1-guro@fb.com>
References: <20200623015846.1141975-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_16:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=651 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 cotscore=-2147483648 adultscore=0 suspectscore=2 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230012
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg_kmem_get_cache() function became really trivial, so let's just
inline it into the single call point: memcg_slab_pre_alloc_hook().

It will make the code less bulky and can also help the compiler to
generate a better code.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |  2 --
 mm/memcontrol.c            | 25 +------------------------
 mm/slab.h                  | 11 +++++++++--
 mm/slab_common.c           |  2 +-
 4 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2ac84dcfc9e5..5a8b62d075e6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1403,8 +1403,6 @@ static inline void memcg_set_shrinker_bit(struct me=
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
index d23c2bdeea66..c910fe326ca6 100644
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
@@ -2900,29 +2900,6 @@ static void memcg_free_cache_id(int id)
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
index 66482f8467e7..d47430e97ff1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -364,9 +364,16 @@ static inline struct kmem_cache *memcg_slab_pre_allo=
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
index fe4f5be0e51f..e0a2a904fdd9 100644
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
2.26.2

