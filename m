Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524D4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A59F21974
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGNDFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:05:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbgGNDFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:05:03 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3E5588FE5E4EB98F451C;
        Tue, 14 Jul 2020 11:05:00 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Jul 2020
 11:04:53 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: mmap: Merge vma after call_mmap() if possible
Date:   Tue, 14 Jul 2020 11:07:44 +0800
Message-ID: <1594696064-1409-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

The vm_flags may be changed after call_mmap() because drivers may set some
flags for their own purpose. As a result, we failed to merge the adjacent
vma due to the different vm_flags as userspace can't pass in the same one.
Try to merge vma after call_mmap() to fix this issue.

Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mmap.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 59a4682ebf3f..9568117471f8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1689,7 +1689,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		struct list_head *uf)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma, *prev;
+	struct vm_area_struct *vma, *prev, *merge;
 	int error;
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged = 0;
@@ -1773,6 +1773,20 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto unmap_and_free_vma;
 
+		/* If vm_flags changed after call_mmap(), we should try merge vma again
+		 * as we may succeed this time.
+		 */
+		if (unlikely(vm_flags != vma->vm_flags && prev)) {
+			merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
+				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
+			if (merge) {
+				fput(file);
+				vm_area_free(vma);
+				vma = merge;
+				goto unmap_writable;
+			}
+		}
+
 		/* Can addr have changed??
 		 *
 		 * Answer: Yes, several device drivers can do it in their
@@ -1795,6 +1809,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
+unmap_writable:
 		if (vm_flags & VM_SHARED)
 			mapping_unmap_writable(file->f_mapping);
 		if (vm_flags & VM_DENYWRITE)
-- 
2.19.1

