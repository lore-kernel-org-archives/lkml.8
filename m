Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCE0C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 23:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B7020639
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 23:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oYvygHxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgICXBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:01:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32698 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728288AbgICXBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 19:01:15 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083MtjQ5008580
        for <linux-kernel@vger.kernel.org>; Thu, 3 Sep 2020 16:01:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=YWYptwdcblR9vA8Ah1Yv2S9FNwktLFxutd6Oqa5gWDo=;
 b=oYvygHxk1usYgCuxr0lqc29kSgBGPkEh4uIFXs8uqdq26t9svmxmeTts+25EZnwNzi1m
 nx1fheoukbQTWz5G0EOxL4DOlyuVvCAVmjqY3ISQapcqc4SGiibdvhGDNRiiYyBVwerV
 2dX0znpWIRaGC5+SC7pGGshjohlBDhsrr7s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33ae5urnv2-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 16:01:13 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Sep 2020 16:01:09 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 2291C3B54F24; Thu,  3 Sep 2020 16:01:09 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH] mm: workingset: ignore slab memory size when calculating shadows pressure
Date:   Thu, 3 Sep 2020 16:00:55 -0700
Message-ID: <20200903230055.1245058-1-guro@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_14:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxlogscore=733 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030204
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the memcg case count_shadow_nodes() sums the number of pages in lru
lists and the amount of slab memory (reclaimable and non-reclaimable)
as a baseline for the allowed number of shadow entries.

It seems to be a good analogy for the !memcg case, where
node_present_pages() is used. However, it's not quite true, as there
two problems:

1) Due to slab reparenting introduced by commit fb2f2b0adb98 ("mm:
memcg/slab: reparent memcg kmem_caches on cgroup removal") local
per-lruvec slab counters might be inaccurate on non-leaf levels.
It's the only place where local slab counters are used.

2) Shadow nodes by themselves are backed by slabs. So there is a loop
dependency: the more shadow entries are there, the less pressure the
kernel applies to reclaim them.

Fortunately, there is a simple way to solve both problems: slab
counters shouldn't be taken into the account by count_shadow_nodes().

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Shakeel Butt <shakeelb@google.com>
---
 mm/workingset.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 92e66113a577..50d53f3699e4 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -495,10 +495,6 @@ static unsigned long count_shadow_nodes(struct shrin=
ker *shrinker,
 		for (pages =3D 0, i =3D 0; i < NR_LRU_LISTS; i++)
 			pages +=3D lruvec_page_state_local(lruvec,
 							 NR_LRU_BASE + i);
-		pages +=3D lruvec_page_state_local(
-			lruvec, NR_SLAB_RECLAIMABLE_B) >> PAGE_SHIFT;
-		pages +=3D lruvec_page_state_local(
-			lruvec, NR_SLAB_UNRECLAIMABLE_B) >> PAGE_SHIFT;
 	} else
 #endif
 		pages =3D node_present_pages(sc->nid);
--=20
2.26.2

