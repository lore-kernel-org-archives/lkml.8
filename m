Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E654AC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D3121927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgBZEvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:51:22 -0500
Received: from foss.arm.com ([217.140.110.172]:58866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgBZEvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:51:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEEEC1FB;
        Tue, 25 Feb 2020 20:51:20 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.16.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 25B8D3FA00;
        Tue, 25 Feb 2020 20:51:18 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm/vma: Make is_vma_temporary_stack() available for general use
Date:   Wed, 26 Feb 2020 10:20:58 +0530
Message-Id: <1582692658-3294-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582692658-3294-1-git-send-email-anshuman.khandual@arm.com>
References: <1582692658-3294-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the declaration and definition for is_vma_temporary_stack() are
scattered. Lets make is_vma_temporary_stack() helper available for general
use and also drop the declaration from (include/linux/huge_mm.h) which is
no longer required. This should not cause any functional change.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/huge_mm.h |  2 --
 include/linux/mm.h      | 14 ++++++++++++++
 mm/rmap.c               | 14 --------------
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5aca3d1bdb32..87f46b11efe8 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -87,8 +87,6 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
 #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
 
-extern bool is_vma_temporary_stack(struct vm_area_struct *vma);
-
 extern unsigned long transparent_hugepage_flags;
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2fd4b9bec4be..3bbd9c06171b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -543,6 +543,20 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
 	return !vma->vm_ops;
 }
 
+static inline bool is_vma_temporary_stack(struct vm_area_struct *vma)
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
diff --git a/mm/rmap.c b/mm/rmap.c
index b3e381919835..3d9d5e372710 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1696,20 +1696,6 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
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
 	return is_vma_temporary_stack(vma);
-- 
2.20.1

