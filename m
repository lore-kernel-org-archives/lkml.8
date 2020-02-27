Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E74AC4BA3C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301D624688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgB0F40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:56:26 -0500
Received: from foss.arm.com ([217.140.110.172]:46020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgB0F4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:56:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C17E31B;
        Wed, 26 Feb 2020 21:56:25 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E615C3F73B;
        Wed, 26 Feb 2020 21:56:22 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     vbabka@suse.cz, Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] mm/vma: Move VM_NO_KHUGEPAGED into generic header
Date:   Thu, 27 Feb 2020 11:26:03 +0530
Message-Id: <1582782965-3274-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582782965-3274-1-git-send-email-anshuman.khandual@arm.com>
References: <1582782965-3274-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move VM_NO_KHUGEPAGED into generic header (include/linux/mm.h). This just
makes sure that no VMA flag is scattered in individual function files any
longer. While at this, fix an old comment which is no longer valid. This
should not cause any functional change.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mm.h | 4 +++-
 mm/khugepaged.c    | 2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..7cb7a5c564fb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -356,10 +356,12 @@ extern unsigned int kobjsize(const void *objp);
 
 /*
  * Special vmas that are non-mergable, non-mlock()able.
- * Note: mm/huge_memory.c VM_NO_THP depends on this definition.
  */
 #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
 
+/* This mask prevents VMA from being scanned with khugepaged */
+#define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
+
 /* This mask defines which mm->def_flags a process can inherit its parent */
 #define VM_INIT_DEF_MASK	VM_NOHUGEPAGE
 
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

