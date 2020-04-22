Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE339C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F1620882
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DaY4T/zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgDVUrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:47:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47634 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726688AbgDVUrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:47:35 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 03MKlDr6016495
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Hykg6WsrgVmw6TWTlba89R7ac35mb59AST82Spw8Ueo=;
 b=DaY4T/zGNAQpSLQNeTvBNaMch+Xpvg73/m5UGXZNA7IWFl2SBzvN8gl/xiyoB3ukARyM
 RABGxT9guKB4pWOwvuaIp1hkzKcsakCE9480BcUE9ZVujNT4Gow4AccBpOOwlIYBTJ5f
 OGnTDdNuPWJOOLaO0AlmYcbOul2cQkKM3G4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 30jatkntpc-16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:33 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 22 Apr 2020 13:47:25 -0700
Received: by devvm4439.prn2.facebook.com (Postfix, from userid 111017)
        id 023A522935817; Wed, 22 Apr 2020 13:47:17 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm4439.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 16/19] mm: memcg/slab: remove redundant check in memcg_accumulate_slabinfo()
Date:   Wed, 22 Apr 2020 13:47:05 -0700
Message-ID: <20200422204708.2176080-17-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200422204708.2176080-1-guro@fb.com>
References: <20200422204708.2176080-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_07:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=769
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220159
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcg_accumulate_slabinfo() is never called with a non-root
kmem_cache as a first argument, so the is_root_cache(s) check
is redundant and can be removed without any functional change.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slab_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index c045afb9724e..52164ad0f197 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1087,9 +1087,6 @@ memcg_accumulate_slabinfo(struct kmem_cache *s, str=
uct slabinfo *info)
 	struct kmem_cache *c;
 	struct slabinfo sinfo;
=20
-	if (!is_root_cache(s))
-		return;
-
 	c =3D memcg_cache(s);
 	if (c) {
 		memset(&sinfo, 0, sizeof(sinfo));
--=20
2.25.3

