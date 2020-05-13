Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CACCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFC5204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbgEMOFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:05:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388325AbgEMOFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:05:11 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D722EC9559855ECE06E3;
        Wed, 13 May 2020 22:05:00 +0800 (CST)
Received: from host-suse12sp4.huawei.com (10.67.133.23) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 13 May 2020 22:04:50 +0800
From:   Shijie Hu <hushijie3@huawei.com>
To:     <mike.kravetz@oracle.com>
CC:     <will@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <wangxu72@huawei.com>,
        <wangkefeng.wang@huawei.com>, <yangerkun@huawei.com>,
        <wangle6@huawei.com>, <cg.chen@huawei.com>, <chenjie6@huawei.com>,
        <alex.huangjianhui@huawei.com>
Subject: [PATCH v4] hugetlbfs: Get unmapped area below TASK_UNMAPPED_BASE for hugetlbfs
Date:   Wed, 13 May 2020 21:57:42 +0800
Message-ID: <20200513135742.102064-1-hushijie3@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a final patch to solve that hugetlb_get_unmapped_area() can't
get unmapped area below mmap base for huge pages based on a few previous
discussions and patches from me.

I'm so sorry. When sending v2 and v3 patches, I forget to cc:
linux-mm@kvack.org and linux-kernel@vger.kernel.org. No records of these
two patches found on the https://lkml.org/lkml/.

Patch V1: https://lkml.org/lkml/2020/4/27/440

Changes in V2:
* Follow Mike's suggestions, move hugetlb_get_unmapped_area() routines
from "fs/hugetlbfs/inode.c" to "arch/arm64/mm/hugetlbpage.c", without
changing core code.
* Add mmap_is_legacy() function, and only fall back to the bottom-up
function on no-legacy mode.

Changes in V3:
* Add *bottomup() and *topdown() two function, and check if
mm->get_unmapped_area is equal to arch_get_unmapped_area() instead of
checking mmap_is_legacy() to determine which function should be used.

Changes in V4:
* Follow the suggestions of Will and Mike, move back this patch to core
code.

------

In a 32-bit program, running on arm64 architecture. When the address
space below mmap base is completely exhausted, shmat() for huge pages
will return ENOMEM, but shmat() for normal pages can still success on
no-legacy mode. This seems not fair.

For normal pages, get_unmapped_area() calling flows are:
    => mm->get_unmapped_area()
	if on legacy mode,
	    => arch_get_unmapped_area()
			=> vm_unmapped_area()
	if on no-legacy mode,
	    => arch_get_unmapped_area_topdown()
			=> vm_unmapped_area()

For huge pages, get_unmapped_area() calling flows are:
    => file->f_op->get_unmapped_area()
		=> hugetlb_get_unmapped_area()
			=> vm_unmapped_area()

To solve this issue, we only need to make hugetlb_get_unmapped_area() take
the same way as mm->get_unmapped_area(). Add *bottomup() and *topdown()
two functions, and check current mm->get_unmapped_area() to decide which 
one to use. If mm->get_unmapped_area is equal to arch_get_unmapped_area(),
hugetlb_get_unmapped_area() calls bottomup routine, otherwise calls topdown
routine.

Signed-off-by: Shijie Hu <hushijie3@huawei.com>
---
 fs/hugetlbfs/inode.c | 61 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 991c60c7ffe0..bbee893e88da 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -191,13 +191,60 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 #ifndef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 static unsigned long
+hugetlb_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
+
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = current->mm->mmap_base;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
+}
+
+static unsigned long
+hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
+
+	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+	info.length = len;
+	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.high_limit = current->mm->mmap_base;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	addr = vm_unmapped_area(&info);
+
+	/*
+	 * A failed mmap() very likely causes application failure,
+	 * so fall back to the bottom-up function here. This scenario
+	 * can happen with large stack limits and large mmap()
+	 * allocations.
+	 */
+	if (unlikely(offset_in_page(addr))) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.flags = 0;
+		info.low_limit = current->mm->mmap_base;
+		info.high_limit = TASK_SIZE;
+		addr = vm_unmapped_area(&info);
+	}
+
+	return addr;
+}
+
+static unsigned long
 hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
 
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
@@ -218,13 +265,11 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 			return addr;
 	}
 
-	info.flags = 0;
-	info.length = len;
-	info.low_limit = TASK_UNMAPPED_BASE;
-	info.high_limit = TASK_SIZE;
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
-	return vm_unmapped_area(&info);
+	if (mm->get_unmapped_area == arch_get_unmapped_area)
+		return hugetlb_get_unmapped_area_bottomup(file, addr, len,
+				pgoff, flags);
+	return hugetlb_get_unmapped_area_topdown(file, addr, len,
+			pgoff, flags);
 }
 #endif
 
-- 
2.12.3

