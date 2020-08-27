Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EC1C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D254120872
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EGb78lvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgH0W7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:59:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2366 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727993AbgH0W7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:59:24 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RMxIgv029747
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:59:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=OU8HHbDfrFaaqvigrUP0RZeqd3x4IeJEBKrNtLzMVZU=;
 b=EGb78lvqN+QXYOoU8sJUqYu0Bb30s/5Wf028df1YmlitTc4dnwONtDvlrCWTymYK//SI
 HOk2A8M4/m2wMNa095FBFGQqa+PgCXpESMMkGGrMJkhW2X4/h+EiXJPrhY0pInka6MED
 LqRmmdUqLCZpTPH+s6VZtE2Sp1OkJgIjDsY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 335up67yce-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:59:23 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 27 Aug 2020 15:58:45 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 6846F393DEE1; Thu, 27 Aug 2020 15:58:44 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH v1 2/4] mm: kmem: remove redundant checks from get_obj_cgroup_from_current()
Date:   Thu, 27 Aug 2020 15:58:41 -0700
Message-ID: <20200827225843.1270629-3-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200827225843.1270629-1-guro@fb.com>
References: <20200827225843.1270629-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_14:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=768
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270174
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are checks for current->mm and current->active_memcg
in get_obj_cgroup_from_current(), but these checks are redundant:
memcg_kmem_bypass() called just above performs same checks.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9c08d8d14bc0..5d847257a639 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2919,9 +2919,6 @@ __always_inline struct obj_cgroup *get_obj_cgroup_f=
rom_current(void)
 	if (memcg_kmem_bypass())
 		return NULL;
=20
-	if (unlikely(!current->mm && !current->active_memcg))
-		return NULL;
-
 	rcu_read_lock();
 	if (unlikely(current->active_memcg))
 		memcg =3D rcu_dereference(current->active_memcg);
--=20
2.26.2

