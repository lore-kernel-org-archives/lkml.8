Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803EFC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEEE24672
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgB0F4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:56:34 -0500
Received: from foss.arm.com ([217.140.110.172]:46058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbgB0F4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:56:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02BB430E;
        Wed, 26 Feb 2020 21:56:32 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DF7F3F73B;
        Wed, 26 Feb 2020 21:56:29 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     vbabka@suse.cz, Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] mm/vma: Make is_vma_temporary_stack() available for general use
Date:   Thu, 27 Feb 2020 11:26:05 +0530
Message-Id: <1582782965-3274-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582782965-3274-1-git-send-email-anshuman.khandual@arm.com>
References: <1582782965-3274-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the declaration and definition for is_vma_temporary_stack() are
scattered. Lets make is_vma_temporary_stack() helper available for general
use and also drop the declaration from (include/linux/huge_mm.h) which is
no longer required. While at this, rename this as vma_is_temporary_stack()
in line with existing helpers. This should not cause any functional change.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/huge_mm.h |  4 +---
 include/linux/mm.h      | 14 ++++++++++++++
 mm/khugepaged.c         |  2 +-
 mm/mremap.c             |  2 +-
 mm/rmap.c               | 16 +---------------
 5 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5aca3d1bdb32..31c39f4a5518 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -87,8 +87,6 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
 #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
 
-extern bool is_vma_temporary_stack(struct vm_area_struct *vma);
-
 extern unsigned long transparent_hugepage_flags;
 
 /*
@@ -100,7 +98,7 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 	if (vma->vm_flags & VM_NOHUGEPAGE)
 		return false;
 
-	if (is_vma_temporary_stack(vma))
+	if (vma_is_temporary_stack(vma))
 		return false;
 
 	if (test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c5d2fd889bdf..2b7e201eb12a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -544,6 +544,20 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
 	return !vma->vm_ops;
 }
 
+static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
+{
+	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
+
+	if (!maybe_stack)
+		return false;
+
+	if ((vma->vm_flags & VM_STACK_INCOMPLETE_SETUP) ==
+						VM_STACK_INCOMPLETE_SETUP)
+		return true;
+
+	return false;
+}
+
 static inline bool vma_is_foreign(struct vm_area_struct *vma)
 {
 	if (!current->mm)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 494443628850..c659c68728bc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -421,7 +421,7 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 	}
 	if (!vma->anon_vma || vma->vm_ops)
 		return false;
-	if (is_vma_temporary_stack(vma))
+	if (vma_is_temporary_stack(vma))
 		return false;
 	return !(vm_flags & VM_NO_KHUGEPAGED);
 }
diff --git a/mm/mremap.c b/mm/mremap.c
index af363063ea23..9438c8568f34 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -133,7 +133,7 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	 * such races:
 	 *
 	 * - During exec() shift_arg_pages(), we use a specially tagged vma
-	 *   which rmap call sites look for using is_vma_temporary_stack().
+	 *   which rmap call sites look for using vma_is_temporary_stack().
 	 *
 	 * - During mremap(), new_vma is often known to be placed after vma
 	 *   in rmap traversal order. This ensures rmap will always observe
diff --git a/mm/rmap.c b/mm/rmap.c
index b3e381919835..b2acbe31b625 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1696,23 +1696,9 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	return ret;
 }
 
-bool is_vma_temporary_stack(struct vm_area_struct *vma)
-{
-	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
-
-	if (!maybe_stack)
-		return false;
-
-	if ((vma->vm_flags & VM_STACK_INCOMPLETE_SETUP) ==
-						VM_STACK_INCOMPLETE_SETUP)
-		return true;
-
-	return false;
-}
-
 static bool invalid_migration_vma(struct vm_area_struct *vma, void *arg)
 {
-	return is_vma_temporary_stack(vma);
+	return vma_is_temporary_stack(vma);
 }
 
 static int page_mapcount_is_zero(struct page *page)
-- 
2.20.1

