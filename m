Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C36C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F9D20829
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q3h4vJ3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgHRP4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:56:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40640 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgHRPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:47:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IFSQTD006892;
        Tue, 18 Aug 2020 15:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=F6Oi0mM4LViFiJsPNqjBUOhmIWktb+jsw3EHBlvgXMg=;
 b=Q3h4vJ3Oco+MRw0Vn0W3t9xOSix3PSEVPcy+sv2EnucTq/Ab1+dUu2Up3SEqh48aFxwn
 MahDLpZahUM525g9IXSsbSOp/NA4R3PfemCzgvYNUNztm2GfBL8m9p8RCO0cKmhZ/7Ll
 QMm/h2ngvvGe+jLqzMB93fEv/78HkFdUFxhEy5XART1aVA1mqajUv/95ptoki2GJjIGg
 o8gwaAjYeVTSXWy2olXiBMD9uKuSpHYvNHH+AWp+wDbEBYQRRY0Uz82QvkCsNAjZvtke
 aqXLNgGqkFRg0yZpNKYqH1Fx6kiFDvE9yiU79vi39T88RiIdO3HmEXtIUd2D6I11T72D qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32x74r5q5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 15:47:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IFY09d027332;
        Tue, 18 Aug 2020 15:47:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32xsm35pey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 15:47:23 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07IFlMxo032678;
        Tue, 18 Aug 2020 15:47:22 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Aug 2020 08:47:22 -0700
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Liam.Howlett@Oracle.com
Subject: [PATCH 1/2] mm/mmap: Add inline vma_next() for readability of mmap code
Date:   Tue, 18 Aug 2020 11:47:06 -0400
Message-Id: <20200818154707.2515169-1-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three places that the next vma is required which uses the same
block of code.  Replace the block with a function and add comments on
what happens in the case where NULL is encountered.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 40248d84ad5fb..6026353035966 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -560,6 +560,23 @@ static int find_vma_links(struct mm_struct *mm, unsigned long addr,
 	return 0;
 }
 
+/*
+ * vma_next() - Get the next VMA.
+ * @mm: The mm_struct.
+ * @vma: The current vma.
+ *
+ * If @vma is NULL, return the first vma in the mm.
+ *
+ * Returns: The next VMA after @vma.
+ */
+static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+					 struct vm_area_struct *vma)
+{
+	if (!vma)
+		return mm->mmap;
+
+	return vma->vm_next;
+}
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -1131,10 +1148,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
-	if (prev)
-		next = prev->vm_next;
-	else
-		next = mm->mmap;
+	next = vma_next(mm, prev);
 	area = next;
 	if (area && area->vm_end == end)		/* cases 6, 7, 8 */
 		next = next->vm_next;
@@ -2625,7 +2639,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next = prev ? prev->vm_next : mm->mmap;
+	struct vm_area_struct *next = vma_next(mm, prev);
 	struct mmu_gather tlb;
 
 	lru_add_drain();
@@ -2824,7 +2838,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		if (error)
 			return error;
 	}
-	vma = prev ? prev->vm_next : mm->mmap;
+	vma = vma_next(mm, prev);
 
 	if (unlikely(uf)) {
 		/*
-- 
2.28.0

