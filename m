Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B837C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2A422464
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgAQXXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:23:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:9953 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbgAQXXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:23:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 15:23:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="306388163"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga001.jf.intel.com with ESMTP; 17 Jan 2020 15:23:04 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, kirill@shutemov.name,
        yang.shi@linux.alibaba.com, richardw.yang@linux.intel.com,
        thellstrom@vmware.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/5] mm/mremap: it is sure to have enough space when extent meets requirement
Date:   Sat, 18 Jan 2020 07:22:51 +0800
Message-Id: <20200117232254.2792-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200117232254.2792-1-richardw.yang@linux.intel.com>
References: <20200117232254.2792-1-richardw.yang@linux.intel.com>
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

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 include/linux/huge_mm.h |  2 +-
 mm/huge_memory.c        |  7 ++-----
 mm/mremap.c             | 11 ++++-------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 0b84e13e88e2..2a5281ca46c8 100644
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
index 5b2876942639..8f1bbbf01f5b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1871,17 +1871,14 @@ static pmd_t move_soft_dirty_pmd(pmd_t pmd)
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
index bcc7aa62f2d9..c2af8ba4ba43 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -193,16 +193,13 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 
 #ifdef CONFIG_HAVE_MOVE_PMD
 static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
-		  unsigned long new_addr, unsigned long old_end,
-		  pmd_t *old_pmd, pmd_t *new_pmd)
+		  unsigned long new_addr, pmd_t *old_pmd, pmd_t *new_pmd)
 {
 	spinlock_t *old_ptl, *new_ptl;
 	struct mm_struct *mm = vma->vm_mm;
 	pmd_t pmd;
 
-	if ((old_addr & ~PMD_MASK) ||
-	    (new_addr & ~PMD_MASK) ||
-	    old_end - old_addr < PMD_SIZE)
+	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK))
 		return false;
 
 	/*
@@ -274,7 +271,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 				if (need_rmap_locks)
 					take_rmap_locks(vma);
 				moved = move_huge_pmd(vma, old_addr, new_addr,
-						    old_end, old_pmd, new_pmd);
+						      old_pmd, new_pmd);
 				if (need_rmap_locks)
 					drop_rmap_locks(vma);
 				if (moved)
@@ -294,7 +291,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			if (need_rmap_locks)
 				take_rmap_locks(vma);
 			moved = move_normal_pmd(vma, old_addr, new_addr,
-					old_end, old_pmd, new_pmd);
+						old_pmd, new_pmd);
 			if (need_rmap_locks)
 				drop_rmap_locks(vma);
 			if (moved)
-- 
2.17.1

