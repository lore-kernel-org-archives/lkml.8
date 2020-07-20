Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBF0C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6B222CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgGTDfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:35:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbgGTDfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:35:11 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 30396483EE3751D14E82;
        Mon, 20 Jul 2020 11:35:07 +0800 (CST)
Received: from huawei.com (10.175.100.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Jul 2020
 11:35:05 +0800
From:   Tang Yizhou <tangyizhou@huawei.com>
To:     <linux-mm@kvack.org>
CC:     <linux-next@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH -next] mm/gup.c: Fix the comment of return value for populate_vma_page_range()
Date:   Mon, 20 Jul 2020 11:43:03 +0800
Message-ID: <20200720034303.29920-1-tangyizhou@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of populate_vma_page_range() is consistent with
__get_user_pages(), and so is the function comment of return value.

Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 2cc5eba44362..a55f1ec712e9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1386,7 +1386,8 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
  *
  * This takes care of mlocking the pages too if VM_LOCKED is set.
  *
- * return 0 on success, negative error code on error.
+ * Return either number of pages pinned in the vma, or a negative error
+ * code on error.
  *
  * vma->vm_mm->mmap_lock must be held.
  *
-- 
2.17.1

