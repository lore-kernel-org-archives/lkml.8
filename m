Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D48FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB166207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="eeMlfq0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgH0RwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:52:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16716 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbgH0RwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:52:20 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RHpUHO017899
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:52:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lBLp+M/M4q7MNxLrusnBwT4NnNHP3uVf51kHz/U8dPs=;
 b=eeMlfq0OG0057zNcGHGiR8Zj4dLqfdomvxEm5FiYzvkdMWMDF0dEimWZZDNU0KqhPeRC
 fEIZwsu3ngL0JDA/Iwf/jICb216OuzDZCDt/bXtjW1bjcOTClC1RuTpgOcdopMGXN3W6
 5jR5M/LZ6l+LKbPBfvXiEhHm8kXXtqPU4AY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 335up8pqc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:52:19 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 27 Aug 2020 10:52:19 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 2DB6D3922483; Thu, 27 Aug 2020 10:52:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH RFC 1/4] mm: kmem: move memcg_kmem_bypass() calls to get_mem/obj_cgroup_from_current()
Date:   Thu, 27 Aug 2020 10:52:12 -0700
Message-ID: <20200827175215.319780-2-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200827175215.319780-1-guro@fb.com>
References: <20200827175215.319780-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_10:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270134
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently memcg_kmem_bypass() is called before obtaining the current
memory/obj cgroup using get_mem/obj_cgroup_from_current(). Moving
memcg_kmem_bypass() into get_mem/obj_cgroup_from_current() reduces
the number of call sites and allows further code simplifications.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 13 ++++++++-----
 mm/percpu.c     |  3 +--
 mm/slab.h       |  3 ---
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dc892a3c4b17..9c08d8d14bc0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1074,6 +1074,9 @@ EXPORT_SYMBOL(get_mem_cgroup_from_page);
  */
 static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(vo=
id)
 {
+	if (memcg_kmem_bypass())
+		return NULL;
+
 	if (unlikely(current->active_memcg)) {
 		struct mem_cgroup *memcg;
=20
@@ -2913,6 +2916,9 @@ __always_inline struct obj_cgroup *get_obj_cgroup_f=
rom_current(void)
 	struct obj_cgroup *objcg =3D NULL;
 	struct mem_cgroup *memcg;
=20
+	if (memcg_kmem_bypass())
+		return NULL;
+
 	if (unlikely(!current->mm && !current->active_memcg))
 		return NULL;
=20
@@ -3039,19 +3045,16 @@ int __memcg_kmem_charge_page(struct page *page, g=
fp_t gfp, int order)
 	struct mem_cgroup *memcg;
 	int ret =3D 0;
=20
-	if (memcg_kmem_bypass())
-		return 0;
-
 	memcg =3D get_mem_cgroup_from_current();
-	if (!mem_cgroup_is_root(memcg)) {
+	if (memcg && !mem_cgroup_is_root(memcg)) {
 		ret =3D __memcg_kmem_charge(memcg, gfp, 1 << order);
 		if (!ret) {
 			page->mem_cgroup =3D memcg;
 			__SetPageKmemcg(page);
 			return 0;
 		}
+		css_put(&memcg->css);
 	}
-	css_put(&memcg->css);
 	return ret;
 }
=20
diff --git a/mm/percpu.c b/mm/percpu.c
index f4709629e6de..9b07bd5bc45f 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1584,8 +1584,7 @@ static enum pcpu_chunk_type pcpu_memcg_pre_alloc_ho=
ok(size_t size, gfp_t gfp,
 {
 	struct obj_cgroup *objcg;
=20
-	if (!memcg_kmem_enabled() || !(gfp & __GFP_ACCOUNT) ||
-	    memcg_kmem_bypass())
+	if (!memcg_kmem_enabled() || !(gfp & __GFP_ACCOUNT))
 		return PCPU_CHUNK_ROOT;
=20
 	objcg =3D get_obj_cgroup_from_current();
diff --git a/mm/slab.h b/mm/slab.h
index 95e5cc1bb2a3..4a24e1702923 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -280,9 +280,6 @@ static inline struct obj_cgroup *memcg_slab_pre_alloc=
_hook(struct kmem_cache *s,
 {
 	struct obj_cgroup *objcg;
=20
-	if (memcg_kmem_bypass())
-		return NULL;
-
 	objcg =3D get_obj_cgroup_from_current();
 	if (!objcg)
 		return NULL;
--=20
2.26.2

