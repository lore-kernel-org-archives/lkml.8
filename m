Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F845C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A71520737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NocHiOsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388086AbgFIBDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:03:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15684 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727988AbgFHXHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:45 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058N0rbe022442
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jun 2020 16:07:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=zcj5cOhikHZGYmyFMPbMGzx/9MYXkskZJ2rJF+Ro4jw=;
 b=NocHiOsjw9jTPBS/c+d55kE77oTboZehrmtF4vNJ63lmc6Cc2pqOhsY6kGEc8jwcuTNm
 yXw+P1E+aaj0DU+iKy1LAIv6zug/9Z+ahumLCxsKMrYfInvwaedL2hY9VIXwSCxm4Vet
 5j+fd25Y4kTk2rAmzLF1Bvth8cbfK+/CYNg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31gtucqnb6-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 16:07:45 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Jun 2020 16:07:08 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id 74E821D8FE5A; Mon,  8 Jun 2020 16:07:00 -0700 (PDT)
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
Subject: [PATCH v6 16/19] mm: memcg/slab: remove redundant check in memcg_accumulate_slabinfo()
Date:   Mon, 8 Jun 2020 16:06:51 -0700
Message-ID: <20200608230654.828134-17-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200608230654.828134-1-guro@fb.com>
References: <20200608230654.828134-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 priorityscore=1501 cotscore=-2147483648 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=782
 clxscore=1015 phishscore=0 mlxscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080160
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcg_accumulate_slabinfo() is never called with a non-root
kmem_cache as a first argument, so the is_root_cache(s) check
is redundant and can be removed without any functional change.

Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
2.25.4

