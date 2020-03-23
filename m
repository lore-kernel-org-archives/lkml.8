Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A096C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6CF206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="feX6+u7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgCWXeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:34:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33966 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbgCWXeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:34:17 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NNToaL010477
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 16:34:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=TFuepEPf414fwKUx8fUSllPVzmQmzijzT+qxEdW3TSY=;
 b=feX6+u7uG9Xh1cq25YFpJYGEnbKg/mVvuYaAyn1oWb8fRA7mSr19JeW5VFyeDj1LLbzH
 pTcTfByWEyQ94Z9koUqryWee6UOqa+4kdzcIz5pM2ZhIwEB/Qz0Gr+IMM4YSap674S2i
 s3KINtSZxJ4aNvWLDe8J3H2xIciyW9jXHXs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yy3gy10d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 16:34:16 -0700
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 23 Mar 2020 16:34:15 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 221B33BEC28CF; Mon, 23 Mar 2020 16:34:13 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Aslan Bakirov <aslan@fb.com>, Michal Hocko <mhocko@kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2] mm: hugetlb: fix per-node size calculation for hugetlb_cma
Date:   Mon, 23 Mar 2020 16:34:11 -0700
Message-ID: <20200323233411.2407279-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323221411.2152675-1-guro@fb.com>
References: <20200323221411.2152675-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_10:2020-03-23,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230116
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aslan found a bug in the per-node hugetlb_cma area size calculation:
the total remaining size should cap the per-node area size instead
of be the minimal possible allocation.

Without the fix:
[    0.004136] hugetlb_cma: reserve 2048 MiB, up to 1024 MiB per node
[    0.004138] cma: Reserved 2048 MiB at 0x0000000180000000
[    0.004139] hugetlb_cma: reserved 2048 MiB on node 0

With the fix:
[    0.006780] hugetlb_cma: reserve 2048 MiB, up to 1024 MiB per node
[    0.006786] cma: Reserved 1024 MiB at 0x00000001c0000000
[    0.006787] hugetlb_cma: reserved 1024 MiB on node 0
[    0.006788] cma: Reserved 1024 MiB at 0x00000003c0000000
[    0.006789] hugetlb_cma: reserved 1024 MiB on node 1

Reported-by: Aslan Bakirov <aslan@fb.com>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 456f4c010fea..44b47c2b6fab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5590,7 +5590,7 @@ void __init hugetlb_cma_reserve(int order)
 		min_pfn = min_low_pfn;
 		max_pfn = max_low_pfn;
 #endif
-		size = max(per_node, hugetlb_cma_size - reserved);
+		size = min(per_node, hugetlb_cma_size - reserved);
 		size = round_up(size, PAGE_SIZE << order);
 
 		if (size > ((max_pfn - min_pfn) << PAGE_SHIFT) / 2) {
-- 
2.25.1

