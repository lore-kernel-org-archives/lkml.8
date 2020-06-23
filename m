Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F64C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A25206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ehMVoSJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbgFWRlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:41:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54878 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387821AbgFWRlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:41:04 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NHef5O020485
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:41:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3xrqEml6JFG1Qa1+blKuF+yOkDVEww+N7R6Knip8TAw=;
 b=ehMVoSJr34USJnA3PSp61C03MIaRwWEpEpNXXptkC7Q3cMMbMsg1Ysre+ILivEaPddQj
 ORIyYTpvqRc940p99Ofe7agHcpkCaZMkM4rmP2Ze2kRh3vzdp+vEtqpGCVm8AytZxqmg
 bRxPha/AcdvyLG6wXPSGsBtqmmpPIljQxV4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31uk21h634-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:41:02 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 10:40:46 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id C99D4273E5E8; Tue, 23 Jun 2020 10:40:41 -0700 (PDT)
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
Subject: [PATCH v7 11/19] mm: memcg/slab: move memcg_kmem_bypass() to memcontrol.h
Date:   Tue, 23 Jun 2020 10:40:29 -0700
Message-ID: <20200623174037.3951353-12-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623174037.3951353-1-guro@fb.com>
References: <20200623174037.3951353-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230124
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the memcg_kmem_bypass() function available outside of the
memcontrol.c, let's move it to memcontrol.h.  The function is small and
nicely fits into static inline sort of functions.

It will be used from the slab code.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 12 ++++++++++++
 mm/memcontrol.c            | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b845e908e76e..83e2858aecf2 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1440,6 +1440,18 @@ static inline bool memcg_kmem_enabled(void)
 	return static_branch_unlikely(&memcg_kmem_enabled_key);
 }
=20
+static inline bool memcg_kmem_bypass(void)
+{
+	if (in_interrupt())
+		return true;
+
+	/* Allow remote memcg charging in kthread contexts. */
+	if ((!current->mm || (current->flags & PF_KTHREAD)) &&
+	     !current->active_memcg)
+		return true;
+	return false;
+}
+
 static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
 					 int order)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ad43e5bc482b..2ad1ff0f0107 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2945,18 +2945,6 @@ static void memcg_schedule_kmem_cache_create(struc=
t mem_cgroup *memcg,
 	queue_work(memcg_kmem_cache_wq, &cw->work);
 }
=20
-static inline bool memcg_kmem_bypass(void)
-{
-	if (in_interrupt())
-		return true;
-
-	/* Allow remote memcg charging in kthread contexts. */
-	if ((!current->mm || (current->flags & PF_KTHREAD)) &&
-	     !current->active_memcg)
-		return true;
-	return false;
-}
-
 /**
  * memcg_kmem_get_cache: select the correct per-memcg cache for allocati=
on
  * @cachep: the original global kmem cache
--=20
2.26.2

