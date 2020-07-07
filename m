Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B340C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC3820708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fcgFYG96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgGGRgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:36:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48034 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728440AbgGGRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:36:25 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 067HKvFd019860
        for <linux-kernel@vger.kernel.org>; Tue, 7 Jul 2020 10:36:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+V0/S8aoxdD+9WfM0wVUP71CBpAoqsAxGFDi+cevcRk=;
 b=fcgFYG96jeH2YCnHiID+EUvIkw/NZJEDAhzQOVpqIoO8a0ntN6UshhX6QuYes7S1G8Lk
 tsDjBIYZXxewrnEK2xYT6R1I9lKD2Edd/1uU75lP4xp/bWM3E23XNlU8AMQzNSPqpL7v
 /S/hJSbpRjvkL0qktD60PlMKdqhF+ixAbnc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 322n90nst4-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:36:24 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 7 Jul 2020 10:36:19 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 57716CDE8D7; Tue,  7 Jul 2020 10:36:17 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH 3/3] mm: kmem: switch to static_branch_likely() in memcg_kmem_enabled()
Date:   Tue, 7 Jul 2020 10:36:12 -0700
Message-ID: <20200707173612.124425-3-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707173612.124425-1-guro@fb.com>
References: <20200707173612.124425-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_09:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 cotscore=-2147483648 phishscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070120
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently memcg_kmem_enabled() is optimized for the kernel memory
accounting being off. It was so for a long time, and arguably the
reason behind was that the kernel memory accounting was initially an
opt-in feature. However, now it's on by default on both cgroup v1
and cgroup v2, and it's on for all cgroups. So let's switch over
to static_branch_likely() to reflect this fact.

Unlikely there is a significant performance difference, as the cost
of a memory allocation and its accounting significantly exceeds the
cost of a jump. However, the conversion makes the code look more
logically.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b8f52a3fed90..ab9322215b2e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1456,7 +1456,7 @@ void memcg_put_cache_ids(void);
=20
 static inline bool memcg_kmem_enabled(void)
 {
-	return static_branch_unlikely(&memcg_kmem_enabled_key);
+	return static_branch_likely(&memcg_kmem_enabled_key);
 }
=20
 static inline bool memcg_kmem_bypass(void)
--=20
2.26.2

