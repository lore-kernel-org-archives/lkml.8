Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C24CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E08A21473
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HYsGJJVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390520AbgDCKTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:19:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8448 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727835AbgDCKTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:19:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033AIVPL004391
        for <linux-kernel@vger.kernel.org>; Fri, 3 Apr 2020 03:19:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=rYLNhGZMyqhovJovjX76P2bG2KmXlNxofH857A2yacM=;
 b=HYsGJJVr6ex8PCN4Lq6zrZ0SsNcrC0cNwPbtcUO1VOnNw+uW2Nljb45wAaW2iSq/dnqV
 KL+UpuirHl4pIHdxh8hOCEbkkkV2bKkuLYMcei0EcfpdkgdszxHbsWmilU/ElNgcJT20
 wLwsKkj9KzyreeByioQl80tuPqb4PL/ZRw8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3053438c4d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 03:19:16 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 3 Apr 2020 03:19:16 -0700
Received: by devbig020.ftw1.facebook.com (Postfix, from userid 179119)
        id A5B6058C2D29; Fri,  3 Apr 2020 03:19:13 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Aslan Bakirov <aslan@fb.com>
Smtp-Origin-Hostname: devbig020.ftw1.facebook.com
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <riel@surriel.com>, <guro@fb.com>,
        <mhocko@kernel.org>, <hannes@cmpxchg.org>,
        Aslan Bakirov <aslan@fb.com>
Smtp-Origin-Cluster: ftw1c07
Subject: [PATCH 2/2] mm: hugetlb: Use node interface of cma
Date:   Fri, 3 Apr 2020 03:18:43 -0700
Message-ID: <20200403101843.406634-2-aslan@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403101843.406634-1-aslan@fb.com>
References: <20200403101843.406634-1-aslan@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_07:2020-04-02,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=1 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030090
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With introduction of numa node interface for CMA, this patch is for using=
 that
interface for allocating memory on numa nodes if NUMA is configured.
This will be more efficient  and cleaner because first, instead of iterat=
ing
mem range of each numa node, cma_declare_contigueous_nid() will do
its own address finding if we pass 0 for  both min_pfn and max_pfn,
second, it can also handle caseswhere NUMA is not configured
by passing NUMA_NO_NODE as an argument.

In addition, checking if desired size of memory is available or not,
is happening in cma_declare_contiguous_nid()  because base and
limit will be determined there, since 0(any) for  base and
0(any) for limit is passed as argument to the function.

Signed-off-by: Aslan Bakirov <aslan@fb.com>
---
 mm/hugetlb.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b9f0c903c4cf..62989220c4ff 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5573,42 +5573,24 @@ void __init hugetlb_cma_reserve(int order)
=20
 	reserved =3D 0;
 	for_each_node_state(nid, N_ONLINE) {
-		unsigned long min_pfn =3D 0, max_pfn =3D 0;
 		int res;
-#ifdef CONFIG_NUMA
-		unsigned long start_pfn, end_pfn;
-		int i;
=20
-		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
-			if (!min_pfn)
-				min_pfn =3D start_pfn;
-			max_pfn =3D end_pfn;
-		}
-#else
-		min_pfn =3D min_low_pfn;
-		max_pfn =3D max_low_pfn;
-#endif
 		size =3D min(per_node, hugetlb_cma_size - reserved);
 		size =3D round_up(size, PAGE_SIZE << order);
-
-		if (size > ((max_pfn - min_pfn) << PAGE_SHIFT) / 2) {
-			pr_warn("hugetlb_cma: cma_area is too big, please try less than %lu M=
iB\n",
-				round_down(((max_pfn - min_pfn) << PAGE_SHIFT) *
-					   nr_online_nodes / 2 / SZ_1M,
-					   PAGE_SIZE << order));
-			break;
-		}
-
-		res =3D cma_declare_contiguous(PFN_PHYS(min_pfn), size,
-					     PFN_PHYS(max_pfn),
+	=09
+	=09
+#ifndef CONFIG_NUMA
+		nid =3D NUMA_NO_NODE
+#endif	=09
+		res =3D cma_declare_contiguous_nid(0, size,
+					     0,=20
 					     PAGE_SIZE << order,
 					     0, false,
-					     "hugetlb", &hugetlb_cma[nid]);
+					     "hugetlb", &hugetlb_cma[nid], nid);	=09
+
 		if (res) {
-			phys_addr_t begpa =3D PFN_PHYS(min_pfn);
-			phys_addr_t endpa =3D PFN_PHYS(max_pfn);
-			pr_warn("%s: reservation failed: err %d, node %d, [%pap, %pap)\n",
-				__func__, res, nid, &begpa, &endpa);
+			pr_warn("%s: reservation failed: err %d, node %d\n",
+				__func__, res, nid);
 			break;
 		}
=20
--=20
2.24.1

