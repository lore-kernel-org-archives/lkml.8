Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7ACC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175C621582
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VPECCMtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDVUrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:47:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60462 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbgDVUrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:47:21 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MKjmAR028590
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MwirGxbq6UN6kpLNBPlDooYbITmQ1Yo9BMLqAWUHKtM=;
 b=VPECCMtgK0z3FBisf57RMLMabSZajXm8k9SbdbzzuvUPFZ0Ol6cEH1lZve3VTTwiQcSj
 ING2bDYkb1OjXSDDbJtFGykcBiNI5FRzYDyxJ7sHHKPSr6N22LU6gE8RqH5mjfCvzyWV
 GyXVwIDbSkTjbBAWB9fIG9QlLbJ77e3Hox0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30g0vs04tc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:20 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 22 Apr 2020 13:47:18 -0700
Received: by devvm4439.prn2.facebook.com (Postfix, from userid 111017)
        id CB29B229357FF; Wed, 22 Apr 2020 13:47:16 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm4439.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 04/19] mm: slub: implement SLUB version of obj_to_index()
Date:   Wed, 22 Apr 2020 13:46:53 -0700
Message-ID: <20200422204708.2176080-5-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200422204708.2176080-1-guro@fb.com>
References: <20200422204708.2176080-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_07:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=2
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220158
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements SLUB version of the obj_to_index() function,
which will be required to calculate the offset of obj_cgroup in the
obj_cgroups vector to store/obtain the objcg ownership data.

To make it faster, let's repeat the SLAB's trick introduced by
commit 6a2d7a955d8d ("[PATCH] SLAB: use a multiply instead of a
divide in obj_to_index()") and avoid an expensive division.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Christoph Lameter <cl@linux.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/slub_def.h | 9 +++++++++
 mm/slub.c                | 1 +
 2 files changed, 10 insertions(+)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index d2153789bd9f..200ea292f250 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -8,6 +8,7 @@
  * (C) 2007 SGI, Christoph Lameter
  */
 #include <linux/kobject.h>
+#include <linux/reciprocal_div.h>
=20
 enum stat_item {
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
@@ -86,6 +87,7 @@ struct kmem_cache {
 	unsigned long min_partial;
 	unsigned int size;	/* The size of an object including metadata */
 	unsigned int object_size;/* The size of an object without metadata */
+	struct reciprocal_value reciprocal_size;
 	unsigned int offset;	/* Free pointer offset */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	/* Number of per cpu partial objects to keep around */
@@ -182,4 +184,11 @@ static inline void *nearest_obj(struct kmem_cache *c=
ache, struct page *page,
 	return result;
 }
=20
+static inline unsigned int obj_to_index(const struct kmem_cache *cache,
+					const struct page *page, void *obj)
+{
+	return reciprocal_divide(kasan_reset_tag(obj) - page_address(page),
+				 cache->reciprocal_size);
+}
+
 #endif /* _LINUX_SLUB_DEF_H */
diff --git a/mm/slub.c b/mm/slub.c
index 03071ae5ff07..8d16babe1829 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3660,6 +3660,7 @@ static int calculate_sizes(struct kmem_cache *s, in=
t forced_order)
 	 */
 	size =3D ALIGN(size, s->align);
 	s->size =3D size;
+	s->reciprocal_size =3D reciprocal_value(size);
 	if (forced_order >=3D 0)
 		order =3D forced_order;
 	else
--=20
2.25.3

