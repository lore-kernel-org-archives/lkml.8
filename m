Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019F7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34A8206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404873AbgDNDjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:39:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404832AbgDNDjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:39:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 96C7A3D5AC211402FCB5;
        Tue, 14 Apr 2020 11:39:15 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Apr 2020 11:39:06 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <akpm@linux-foundation.org>, <sjenning@redhat.com>,
        <ddstreet@ieee.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] mm: use false for bool variable
Date:   Tue, 14 Apr 2020 11:45:30 +0800
Message-ID: <1586835930-47076-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

mm/zbud.c:246:1-20: WARNING: Assignment of 0/1 to bool variable
mm/mremap.c:777:2-8: WARNING: Assignment of 0/1 to bool variable
mm/huge_memory.c:525:9-10: WARNING: return of 0/1 in function
'is_transparent_hugepage' with return type bool

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 mm/huge_memory.c | 2 +-
 mm/mremap.c      | 2 +-
 mm/zbud.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6ecd104..5f42805 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -522,7 +522,7 @@ void prep_transhuge_page(struct page *page)
 bool is_transparent_hugepage(struct page *page)
 {
 	if (!PageCompound(page))
-		return 0;
+		return false;
 
 	page = compound_head(page);
 	return is_huge_zero_page(page) ||
diff --git a/mm/mremap.c b/mm/mremap.c
index a7e282e..3ac7ced 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -774,7 +774,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 out:
 	if (offset_in_page(ret)) {
 		vm_unacct_memory(charged);
-		locked = 0;
+		locked = false;
 	}
 	if (downgraded)
 		up_read(&current->mm->mmap_sem);
diff --git a/mm/zbud.c b/mm/zbud.c
index de5dd4d..bc93aa4 100644
--- a/mm/zbud.c
+++ b/mm/zbud.c
@@ -243,7 +243,7 @@ static struct zbud_header *init_zbud_page(struct page *page)
 	zhdr->last_chunks = 0;
 	INIT_LIST_HEAD(&zhdr->buddy);
 	INIT_LIST_HEAD(&zhdr->lru);
-	zhdr->under_reclaim = 0;
+	zhdr->under_reclaim = false;
 	return zhdr;
 }
 
-- 
2.6.2

