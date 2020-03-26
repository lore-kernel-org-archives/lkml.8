Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA38C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E613220722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nmtehlTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCZV1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:27:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28642 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbgCZV1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:27:30 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QLRDRu005444
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:27:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=ItdNQw/noJ2LMBcAUV/ubfbzHSp3eHum+DlAmoEqdLc=;
 b=nmtehlTr87KQZK4+IS6E58ipvNG2OYYaSN3+YrD+zHNvdz2wDRjqvD71mCgY6XpKdA6L
 noieTJEMKFCqXqXOY5zOPxD5Rk5blwTmGb07i5QW47+OCVe7j/WKEV8S/jTjGAmEEarB
 liwZoW9AnO/GZayILcVqgjlSCD48swIPzkk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yx2xpas09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:27:29 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 26 Mar 2020 14:27:28 -0700
Received: by devbig020.ftw1.facebook.com (Postfix, from userid 179119)
        id 7ECC858C1E71; Thu, 26 Mar 2020 14:27:28 -0700 (PDT)
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
Date:   Thu, 26 Mar 2020 14:27:18 -0700
Message-ID: <20200326212718.3798742-2-aslan@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326212718.3798742-1-aslan@fb.com>
References: <20200326212718.3798742-1-aslan@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_13:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260156
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With introduction of numa node interface for CMA, this patch is for using that
interface for allocating memory on numa nodes if NUMA is configured.
This will be more efficient  and cleaner because first, instead of iterating
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
 
 	reserved = 0;
 	for_each_node_state(nid, N_ONLINE) {
-		unsigned long min_pfn = 0, max_pfn = 0;
 		int res;
-#ifdef CONFIG_NUMA
-		unsigned long start_pfn, end_pfn;
-		int i;
 
-		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
-			if (!min_pfn)
-				min_pfn = start_pfn;
-			max_pfn = end_pfn;
-		}
-#else
-		min_pfn = min_low_pfn;
-		max_pfn = max_low_pfn;
-#endif
 		size = min(per_node, hugetlb_cma_size - reserved);
 		size = round_up(size, PAGE_SIZE << order);
-
-		if (size > ((max_pfn - min_pfn) << PAGE_SHIFT) / 2) {
-			pr_warn("hugetlb_cma: cma_area is too big, please try less than %lu MiB\n",
-				round_down(((max_pfn - min_pfn) << PAGE_SHIFT) *
-					   nr_online_nodes / 2 / SZ_1M,
-					   PAGE_SIZE << order));
-			break;
-		}
-
-		res = cma_declare_contiguous(PFN_PHYS(min_pfn), size,
-					     PFN_PHYS(max_pfn),
+		
+		
+#ifndef CONFIG_NUMA
+		nid = NUMA_NO_NODE
+#endif		
+		res = cma_declare_contiguous_nid(0, size,
+					     0, 
 					     PAGE_SIZE << order,
 					     0, false,
-					     "hugetlb", &hugetlb_cma[nid]);
+					     "hugetlb", &hugetlb_cma[nid], nid);		
+
 		if (res) {
-			phys_addr_t begpa = PFN_PHYS(min_pfn);
-			phys_addr_t endpa = PFN_PHYS(max_pfn);
-			pr_warn("%s: reservation failed: err %d, node %d, [%pap, %pap)\n",
-				__func__, res, nid, &begpa, &endpa);
+			pr_warn("%s: reservation failed: err %d, node %d\n",
+				__func__, res, nid);
 			break;
 		}
 
-- 
2.17.1

