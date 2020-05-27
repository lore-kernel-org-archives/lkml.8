Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABA8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3317520707
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="V5t0pDlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgE0WeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:34:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10906 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgE0WeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:34:18 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RMF8rb003190
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:34:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=PcKHh48klJGJru2b4wU2dVoKS4B4is1tLRqw5jMmaYE=;
 b=V5t0pDlK9CmVVUsHNspJgNDrDblrkQfXFWuhw/etxM1I9mhGOWNTzjvaz2liv6z6xkL3
 hbv+rdL/EVzZQnJcCstiAK+ahuk+mRyKIqhT3b63YfLZzltiaAYW0KZk9pCtoyALfGUp
 XDem8Km0+uuuQB/jG7hCyU31pO06pZW5e/w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 317ktstmr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:34:17 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 May 2020 15:34:14 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id C1F8C166902D; Wed, 27 May 2020 15:34:07 -0700 (PDT)
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
Subject: [PATCH v5 11/19] mm: memcg/slab: move memcg_kmem_bypass() to memcontrol.h
Date:   Wed, 27 May 2020 15:33:56 -0700
Message-ID: <20200527223404.1008856-12-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200527223404.1008856-1-guro@fb.com>
References: <20200527223404.1008856-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 cotscore=-2147483648 phishscore=0 impostorscore=0 adultscore=0
 mlxlogscore=978 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270170
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the memcg_kmem_bypass() function available outside of
the memcontrol.c, let's move it to memcontrol.h. The function
is small and nicely fits into static inline sort of functions.

It will be used from the slab code.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h | 7 +++++++
 mm/memcontrol.c            | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 98239fdf9fee..2165470a2534 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1442,6 +1442,13 @@ static inline bool memcg_kmem_enabled(void)
 	return static_branch_unlikely(&memcg_kmem_enabled_key);
 }
=20
+static inline bool memcg_kmem_bypass(void)
+{
+	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
+		return true;
+	return false;
+}
+
 static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
 					 int order)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 56588677608e..314084e2e6e7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2893,13 +2893,6 @@ static void memcg_schedule_kmem_cache_create(struc=
t mem_cgroup *memcg,
 	queue_work(memcg_kmem_cache_wq, &cw->work);
 }
=20
-static inline bool memcg_kmem_bypass(void)
-{
-	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
-		return true;
-	return false;
-}
-
 /**
  * memcg_kmem_get_cache: select the correct per-memcg cache for allocati=
on
  * @cachep: the original global kmem cache
--=20
2.25.4

