Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07776C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D002C2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgD0LMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:12:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgD0LMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:12:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 23D26B7D0142531E8707;
        Mon, 27 Apr 2020 19:12:17 +0800 (CST)
Received: from host-suse12sp4.huawei.com (10.67.133.23) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Apr 2020 19:12:07 +0800
From:   Shijie Hu <hushijie3@huawei.com>
To:     <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <nixiaoming@huawei.com>, <wangxu72@huawei.com>,
        <wangkefeng.wang@huawei.com>, <yangerkun@huawei.com>,
        <wangle6@huawei.com>, <cg.chen@huawei.com>
Subject: [PATCH] [RFC]hugetlbfs: Get unmapped area below TASK_UNMAPPED_BASE for hugetlbfs
Date:   Mon, 27 Apr 2020 19:10:36 +0800
Message-ID: <20200427111036.74983-1-hushijie3@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 32-bit programs, the address space is limited. When the normal mmap
consumes the space above TASK_UNMAPPED_BASE on legacy mode, it can still
successfully obtain unmapped area below TASK_UNMAPPED_BASE, but mmap or
shmat for huge pages will fail. This seems "not fair".

When the request for huge pages fails, fall back to reuse mmap_min_addr
~ TASK_UNMAPPED_BASE for hugetlbfs.

Signed-off-by: Shijie Hu <hushijie3@huawei.com>
---
 fs/hugetlbfs/inode.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index aff8642f0c2e..0f5997394aaa 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -224,7 +224,21 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	info.high_limit = TASK_SIZE;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
-	return vm_unmapped_area(&info);
+	addr = vm_unmapped_area(&info);
+
+	/*
+	 * A failed request for huge pages very likely causes application
+	 * failure, so fall back to the top-down function here.
+	 */
+	if (unlikely(offset_in_page(addr))) {
+		VM_BUG_ON(addr != -ENOMEM);
+		info.flags = VM_UNMAPPED_AREA_TOPDOWN;
+		info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+		info.high_limit = TASK_UNMAPPED_BASE;
+		addr = vm_unmapped_area(&info);
+	}
+
+	return addr;
 }
 #endif
 
-- 
2.12.3

