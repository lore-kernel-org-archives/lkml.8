Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF65FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B215220725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGJJ25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:28:57 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47754 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726787AbgGJJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:28:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0U2HJelZ_1594373332;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U2HJelZ_1594373332)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 17:28:53 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, yang.shi@linux.alibaba.com, thomas_os@shipmail.org,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        richard.weiyang@linux.alibaba.com, peterx@redhat.com,
        aneesh.kumar@linux.ibm.com, willy@infradead.org,
        thellstrom@vmware.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com
Subject: [Patch v5 1/3] mm/mremap: it is sure to have enough space when extent meets requirement
Date:   Fri, 10 Jul 2020 17:28:33 +0800
Message-Id: <20200710092835.56368-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200710092835.56368-1-richard.weiyang@linux.alibaba.com>
References: <20200710092835.56368-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

old_end is passed to these two function to check whether there is enough
space to do the move, while this check is done before invoking these
functions.

These two functions only would be invoked when extent meets the
requirement and there is one check before invoking these functions:

    if (extent > old_end - old_addr)
        extent = old_end - old_addr;

This implies (old_end - old_addr) won't fail the check in these two
functions.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/huge_mm.h |  2 +-
 mm/huge_memory.c        |  7 ++-----
 mm/mremap.c             | 10 ++++------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 71f20776b06c..17c4c4975145 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -42,7 +42,7 @@ extern int mincore_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			unsigned long addr, unsigned long end,
 			unsigned char *vec);
 extern bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
-			 unsigned long new_addr, unsigned long old_end,
+			 unsigned long new_addr,
 			 pmd_t *old_pmd, pmd_t *new_pmd);
 extern int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			unsigned long addr, pgprot_t newprot,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 78c84bee7e29..1e580fdad4d0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1722,17 +1722,14 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
 }
 
 bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
-		  unsigned long new_addr, unsigned long old_end,
-		  pmd_t *old_pmd, pmd_t *new_pmd)
+		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	spinlock_t *old_ptl, *new_ptl;
 	pmd_t pmd;
 	struct mm_struct *mm = vma->vm_mm;
 	bool force_flush = false;
 
-	if ((old_addr & ~HPAGE_PMD_MASK) ||
-	    (new_addr & ~HPAGE_PMD_MASK) ||
-	    old_end - old_addr < HPAGE_PMD_SIZE)
+	if ((old_addr & ~HPAGE_PMD_MASK) || (new_addr & ~HPAGE_PMD_MASK))
 		return false;
 
 	/*
diff --git a/mm/mremap.c b/mm/mremap.c
index 5dd572d57ca9..de27b12c8a5a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -193,15 +193,13 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 
 #ifdef CONFIG_HAVE_MOVE_PMD
 static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
-		  unsigned long new_addr, unsigned long old_end,
-		  pmd_t *old_pmd, pmd_t *new_pmd)
+		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	spinlock_t *old_ptl, *new_ptl;
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t pmd;
 
-	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
-	    || old_end - old_addr < PMD_SIZE)
+	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK))
 		return false;
 
 	/*
@@ -273,7 +271,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 				if (need_rmap_locks)
 					take_rmap_locks(vma);
 				moved = move_huge_pmd(vma, old_addr, new_addr,
-						    old_end, old_pmd, new_pmd);
+						      old_pmd, new_pmd);
 				if (need_rmap_locks)
 					drop_rmap_locks(vma);
 				if (moved)
@@ -293,7 +291,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			if (need_rmap_locks)
 				take_rmap_locks(vma);
 			moved = move_normal_pmd(vma, old_addr, new_addr,
-					old_end, old_pmd, new_pmd);
+						old_pmd, new_pmd);
 			if (need_rmap_locks)
 				drop_rmap_locks(vma);
 			if (moved)
-- 
2.20.1 (Apple Git-117)

