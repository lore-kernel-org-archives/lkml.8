Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3ABC4BA0D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9591D21927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgBZEvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:51:16 -0500
Received: from foss.arm.com ([217.140.110.172]:58828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgBZEvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:51:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CE0B328;
        Tue, 25 Feb 2020 20:51:14 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.16.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 776CF3FA00;
        Tue, 25 Feb 2020 20:51:12 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/vma: Move VM_NO_KHUGEPAGED into generic header
Date:   Wed, 26 Feb 2020 10:20:56 +0530
Message-Id: <1582692658-3294-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582692658-3294-1-git-send-email-anshuman.khandual@arm.com>
References: <1582692658-3294-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move VM_NO_KHUGEPAGED into generic header (include/linux/mm.h). This just
makes sure that no VMA flag is scattered in individual function files any
longer. While at this, fix an old comment which is no longer valid.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mm.h | 3 ++-
 mm/khugepaged.c    | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..6f7e400e6ea3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -287,6 +287,8 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
 #define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
 
+#define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
+
 #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
 #define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_1	33	/* bit only usable on 64-bit architectures */
@@ -356,7 +358,6 @@ extern unsigned int kobjsize(const void *objp);
 
 /*
  * Special vmas that are non-mergable, non-mlock()able.
- * Note: mm/huge_memory.c VM_NO_THP depends on this definition.
  */
 #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908743cb..494443628850 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -308,8 +308,6 @@ struct attribute_group khugepaged_attr_group = {
 };
 #endif /* CONFIG_SYSFS */
 
-#define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
-
 int hugepage_madvise(struct vm_area_struct *vma,
 		     unsigned long *vm_flags, int advice)
 {
-- 
2.20.1

