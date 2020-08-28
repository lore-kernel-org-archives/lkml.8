Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137E0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D2620665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgH1ILF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:11:05 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:42718 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728629AbgH1IKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:10:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U750IIp_1598602237;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U750IIp_1598602237)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Aug 2020 16:10:37 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH] mm/mmap: leave adjust_next as virtual address instead of page frame number
Date:   Fri, 28 Aug 2020 16:10:31 +0800
Message-Id: <20200828081031.11306-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of convert adjust_next between virtual address and page frame
number, let's just store the virtual address into adjust_next.

Also, this patch fixes one typo in the comment of
vma_adjust_trans_huge().

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/huge_memory.c | 4 ++--
 mm/mmap.c        | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 78c84bee7e29..2c633ba14440 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2300,13 +2300,13 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 
 	/*
 	 * If we're also updating the vma->vm_next->vm_start, if the new
-	 * vm_next->vm_start isn't page aligned and it could previously
+	 * vm_next->vm_start isn't hpage aligned and it could previously
 	 * contain an hugepage: check if we need to split an huge pmd.
 	 */
 	if (adjust_next > 0) {
 		struct vm_area_struct *next = vma->vm_next;
 		unsigned long nstart = next->vm_start;
-		nstart += adjust_next << PAGE_SHIFT;
+		nstart += adjust_next;
 		if (nstart & ~HPAGE_PMD_MASK &&
 		    (nstart & HPAGE_PMD_MASK) >= next->vm_start &&
 		    (nstart & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= next->vm_end)
diff --git a/mm/mmap.c b/mm/mmap.c
index 90b1298d4222..e4c9bbfd4103 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -758,7 +758,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			 * vma expands, overlapping part of the next:
 			 * mprotect case 5 shifting the boundary up.
 			 */
-			adjust_next = (end - next->vm_start) >> PAGE_SHIFT;
+			adjust_next = (end - next->vm_start);
 			exporter = next;
 			importer = vma;
 			VM_WARN_ON(expand != importer);
@@ -768,7 +768,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			 * split_vma inserting another: so it must be
 			 * mprotect case 4 shifting the boundary down.
 			 */
-			adjust_next = -((vma->vm_end - end) >> PAGE_SHIFT);
+			adjust_next = -(vma->vm_end - end);
 			exporter = vma;
 			importer = next;
 			VM_WARN_ON(expand != importer);
@@ -840,8 +840,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	}
 	vma->vm_pgoff = pgoff;
 	if (adjust_next) {
-		next->vm_start += adjust_next << PAGE_SHIFT;
-		next->vm_pgoff += adjust_next;
+		next->vm_start += adjust_next;
+		next->vm_pgoff += adjust_next >> PAGE_SHIFT;
 	}
 
 	if (root) {
-- 
2.20.1 (Apple Git-117)

