Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F38C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743FA208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qoDAPd+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391188AbgEZVnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:43:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53972 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390952AbgEZVmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:42:49 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QLcXYp015428
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:42:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Vo+5vaoywkqIsR5OytGHWAmnuwqKneK2kkxBMsxQgYk=;
 b=qoDAPd+eYQ0JWutCCpznw7xQug8d9pRRPlmQoBXCYH4Rwgk+b9XBpuIWo+WoxQ4PTMpb
 vvnwPtfMBw+/Iba03X/9SZJtPqczBfPV5dsJwkDjVbQqeAlr78FbgLZDHnhqXaSmlZJM
 isJ2YnCGGXURPDkvu82X3zhN3QUukdqc7Lo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3171nhmx1g-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:42:48 -0700
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 14:42:46 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 76E7215EA7DC; Tue, 26 May 2020 14:42:33 -0700 (PDT)
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
Subject: [PATCH v4 11/19] mm: memcg/slab: move memcg_kmem_bypass() to memcontrol.h
Date:   Tue, 26 May 2020 14:42:19 -0700
Message-ID: <20200526214227.989341-12-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200526214227.989341-1-guro@fb.com>
References: <20200526214227.989341-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=978 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 cotscore=-2147483648 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260166
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
index eca03e13c7ec..107cd7cc3e98 100644
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

