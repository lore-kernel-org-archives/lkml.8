Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E14C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17515206F7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgFPBfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:35:10 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:51736 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbgFPBfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:35:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U.jHwZU_1592270980;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0U.jHwZU_1592270980)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jun 2020 09:29:48 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: thp: remove debug_cow switch
Date:   Tue, 16 Jun 2020 09:29:40 +0800
Message-Id: <1592270980-116062-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3917c80280c93a7123f1a3a6dcdb10a3ea19737d ("thp: change CoW
semantics for anon-THP"), the CoW page fault of THP has been rewritten,
debug_cow is not used anymore.  So, just remove it.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/huge_mm.h |  7 -------
 mm/huge_memory.c        | 21 ---------------------
 2 files changed, 28 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 71f2077..b8d7c36 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -181,13 +181,6 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
-#ifdef CONFIG_DEBUG_VM
-#define transparent_hugepage_debug_cow()				\
-	(transparent_hugepage_flags &					\
-	 (1<<TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG))
-#else /* CONFIG_DEBUG_VM */
-#define transparent_hugepage_debug_cow() 0
-#endif /* CONFIG_DEBUG_VM */
 
 extern unsigned long thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len, unsigned long pgoff,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 78c84be..2f585d2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -303,24 +303,6 @@ static ssize_t hpage_pmd_size_show(struct kobject *kobj,
 static struct kobj_attribute hpage_pmd_size_attr =
 	__ATTR_RO(hpage_pmd_size);
 
-#ifdef CONFIG_DEBUG_VM
-static ssize_t debug_cow_show(struct kobject *kobj,
-				struct kobj_attribute *attr, char *buf)
-{
-	return single_hugepage_flag_show(kobj, attr, buf,
-				TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG);
-}
-static ssize_t debug_cow_store(struct kobject *kobj,
-			       struct kobj_attribute *attr,
-			       const char *buf, size_t count)
-{
-	return single_hugepage_flag_store(kobj, attr, buf, count,
-				 TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG);
-}
-static struct kobj_attribute debug_cow_attr =
-	__ATTR(debug_cow, 0644, debug_cow_show, debug_cow_store);
-#endif /* CONFIG_DEBUG_VM */
-
 static struct attribute *hugepage_attr[] = {
 	&enabled_attr.attr,
 	&defrag_attr.attr,
@@ -329,9 +311,6 @@ static ssize_t debug_cow_store(struct kobject *kobj,
 #ifdef CONFIG_SHMEM
 	&shmem_enabled_attr.attr,
 #endif
-#ifdef CONFIG_DEBUG_VM
-	&debug_cow_attr.attr,
-#endif
 	NULL,
 };
 
-- 
1.8.3.1

