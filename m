Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38586C47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214B4206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgD3Ulc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:41:32 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:50525 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727108AbgD3Ulb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:41:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tx7vcTH_1588279279;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tx7vcTH_1588279279)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 May 2020 04:41:27 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 linux-next PATCH 1/2] mm: khugepaged: add exceed_max_ptes_* helpers
Date:   Fri,  1 May 2020 04:41:18 +0800
Message-Id: <1588279279-61908-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max_ptes_{swap|none|shared} are defined to tune the behavior of
khugepaged.  The are checked at a couple of places with open coding.
Replace the opencoding to exceed_pax_ptes_{swap|none_shared} helpers to
improve the readability.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/khugepaged.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a02a4c5..0c8d30b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -339,6 +339,21 @@ struct attribute_group khugepaged_attr_group = {
 };
 #endif /* CONFIG_SYSFS */
 
+static inline bool exceed_max_ptes_none(unsigned int *nr_ptes)
+{
+	return (++(*nr_ptes) > khugepaged_max_ptes_none);
+}
+
+static inline bool exceed_max_ptes_swap(unsigned int *nr_ptes)
+{
+	return (++(*nr_ptes) > khugepaged_max_ptes_swap);
+}
+
+static inline bool exceed_max_ptes_shared(unsigned int *nr_ptes)
+{
+	return (++(*nr_ptes) > khugepaged_max_ptes_shared);
+}
+
 int hugepage_madvise(struct vm_area_struct *vma,
 		     unsigned long *vm_flags, int advice)
 {
@@ -604,7 +619,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		if (pte_none(pteval) || (pte_present(pteval) &&
 				is_zero_pfn(pte_pfn(pteval)))) {
 			if (!userfaultfd_armed(vma) &&
-			    ++none_or_zero <= khugepaged_max_ptes_none) {
+			    !exceed_max_ptes_none(&none_or_zero)) {
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
@@ -624,7 +639,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		VM_BUG_ON_PAGE(!PageAnon(page), page);
 
 		if (page_mapcount(page) > 1 &&
-				++shared > khugepaged_max_ptes_shared) {
+				exceed_max_ptes_shared(&shared)) {
 			result = SCAN_EXCEED_SHARED_PTE;
 			goto out;
 		}
@@ -1234,7 +1249,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	     _pte++, _address += PAGE_SIZE) {
 		pte_t pteval = *_pte;
 		if (is_swap_pte(pteval)) {
-			if (++unmapped <= khugepaged_max_ptes_swap) {
+			if (!exceed_max_ptes_swap(&unmapped)) {
 				/*
 				 * Always be strict with uffd-wp
 				 * enabled swap entries.  Please see
@@ -1252,7 +1267,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		}
 		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
 			if (!userfaultfd_armed(vma) &&
-			    ++none_or_zero <= khugepaged_max_ptes_none) {
+			    !exceed_max_ptes_none(&none_or_zero)) {
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
@@ -1286,7 +1301,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		}
 
 		if (page_mapcount(page) > 1 &&
-				++shared > khugepaged_max_ptes_shared) {
+				exceed_max_ptes_shared(&shared)) {
 			result = SCAN_EXCEED_SHARED_PTE;
 			goto out_unmap;
 		}
@@ -1961,7 +1976,7 @@ static void khugepaged_scan_file(struct mm_struct *mm,
 			continue;
 
 		if (xa_is_value(page)) {
-			if (++swap > khugepaged_max_ptes_swap) {
+			if (exceed_max_ptes_swap(&swap)) {
 				result = SCAN_EXCEED_SWAP_PTE;
 				break;
 			}
-- 
1.8.3.1

