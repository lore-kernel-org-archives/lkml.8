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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2280DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6D22080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KwOZWN5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHRPzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:55:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40658 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgHRPr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:47:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IFSPYJ006850;
        Tue, 18 Aug 2020 15:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=woaSbfOB/Qmr2EOwVWJ2i+ae6OF0n03FE+3J5rEFxO8=;
 b=KwOZWN5m1hLeNUmJrg23h116swkfloDRdX6TZ1Cj4B9jZyZuSmzD1OsUFLDexBhzdunJ
 6puD5NT7gcbmk/q9kvis4bdqV/4F9IAAngDiN+9FMdJLhKIjsZpLlYb+gepR8e6pIZah
 g4bvW8nUn0Grpu30ML6oB9qdAyn0fXnepWWFCxKtZ5qzRm7X1Dp6mOcEe1pcITz2ojOR
 7MxzH+Wnh6ujwu2UNcDKtrgYRuvKHnANm/YEiPWCxrCz1Zi8t8piTNji4U3O0Y8cgsSr
 IzWDW0jERU8bIhOymlW1USNHP/BwHiI8ljQ1lWl5JKp0s0tWX1vS3cYs7y4tV2Wk4V9D 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32x74r5q62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 15:47:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07IFYuP7129633;
        Tue, 18 Aug 2020 15:47:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32xsmxd0b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 15:47:24 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07IFlNaM011736;
        Tue, 18 Aug 2020 15:47:23 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Aug 2020 08:47:23 -0700
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Liam.Howlett@Oracle.com
Subject: [PATCH 2/2] mm/mmap: Add inline munmap_vma_range() for code readability
Date:   Tue, 18 Aug 2020 11:47:07 -0400
Message-Id: <20200818154707.2515169-2-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818154707.2515169-1-Liam.Howlett@Oracle.com>
References: <20200818154707.2515169-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two locations that have a block of code for munmapping a vma
range.  Change those two locations to use a function and add meaningful
comments about what happens to the arguments, which was unclear in the
previous code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 48 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6026353035966..b59b4e5889b5c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -577,6 +577,33 @@ static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
 
 	return vma->vm_next;
 }
+
+/*
+ * munmap_vma_range() - munmap VMAs that overlap a range.
+ * @mm: The mm struct
+ * @start: The start of the range.
+ * @len: The length of the range.
+ * @pprev: pointer to the pointer that will be set to previous vm_area_struct
+ * @rb_link: the rb_node
+ * @rb_parent: the parent rb_node
+ *
+ * Find all the vm_area_struct that overlap from @start to
+ * @end and munmap them.  Set @pprev to the previous vm_area_struct.
+ *
+ * Returns: -ENOMEM on munmap failure or 0 on success.
+ */
+static inline int
+munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long len,
+		 struct vm_area_struct **pprev, struct rb_node ***link,
+		 struct rb_node **parent, struct list_head *uf)
+{
+
+	while (find_vma_links(mm, start, start + len, pprev, link, parent))
+		if (do_munmap(mm, start, len, uf))
+			return -ENOMEM;
+
+	return 0;
+}
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -1724,13 +1751,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			return -ENOMEM;
 	}
 
-	/* Clear old maps */
-	while (find_vma_links(mm, addr, addr + len, &prev, &rb_link,
-			      &rb_parent)) {
-		if (do_munmap(mm, addr, len, uf))
-			return -ENOMEM;
-	}
-
+	/* Clear old maps, set up prev, rb_link, rb_parent, and uf */
+	if (munmap_vma_range(mm, addr, len, &prev, &rb_link, &rb_parent, uf))
+		return -ENOMEM;
 	/*
 	 * Private writable mapping: check memory availability
 	 */
@@ -3056,14 +3079,9 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
 	if (error)
 		return error;
 
-	/*
-	 * Clear old maps.  this also does some error checking for us
-	 */
-	while (find_vma_links(mm, addr, addr + len, &prev, &rb_link,
-			      &rb_parent)) {
-		if (do_munmap(mm, addr, len, uf))
-			return -ENOMEM;
-	}
+	/* Clear old maps, set up prev, rb_link, rb_parent, and uf */
+	if (munmap_vma_range(mm, addr, len, &prev, &rb_link, &rb_parent, uf))
+		return -ENOMEM;
 
 	/* Check against address space limits *after* clearing old maps... */
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
-- 
2.28.0

