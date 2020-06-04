Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277ACC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D4AC2065C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgFDJHC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:07:02 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:54656 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgFDJHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:07:02 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jun 2020 05:07:01 EDT
Received: from proxy01.sjtu.edu.cn (smtp185.sjtu.edu.cn [202.120.2.185])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id 8617F1008CA2F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 17:01:08 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by proxy01.sjtu.edu.cn (Postfix) with ESMTP id 7CC8F20426A48
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 17:01:08 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XFgF8pTuBOzj for <linux-kernel@vger.kernel.org>;
        Thu,  4 Jun 2020 17:01:08 +0800 (CST)
Received: from fans-air.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: Fan_Yang@sjtu.edu.cn)
        by proxy01.sjtu.edu.cn (Postfix) with ESMTPSA id 5490820426998
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 17:01:07 +0800 (CST)
From:   Fan Yang <Fan_Yang@sjtu.edu.cn>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Subject: [PATCH v3] mm: Fix mremap not considering huge pmd devmap
Message-Id: <A82D1BB5-D868-489A-BFED-9FCE71649A46@sjtu.edu.cn>
Date:   Thu, 4 Jun 2020 17:01:07 +0800
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The original code in mm/mremap.c checks huge pmd by:

		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {

However, a DAX mapped nvdimm is mapped as huge page (by default) but
it is not transparent huge page (_PAGE_PSE | PAGE_DEVMAP).  This
commit changes the condition to include the case.

This addresses CVE-2020-10757.

Fixes: 5c7fb56e5e3f ("mm, dax: dax-pmd vs thp-pmd vs hugetlbfs-pmd")
Cc: <stable@vger.kernel.org>
Reported-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
Signed-off-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
Tested-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

---

Changelog v2->v3:
- Added "Acked-by: Kirill..."

Changelog v1->v2:
- Removed some paragraph in commit msg, removed the comment in
  mm/mremap.c, and added a NOTE in where pmd_trans_huge is defined.
- Added "Reviewed-by: Dan..."
- Added "Fixes: 5c7fb56e5e3f..."
- Added "Cc: <stable@vger.kernel.org>"
---
 arch/x86/include/asm/pgtable.h | 1 +
 mm/mremap.c                    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 4d02e64af1b3..19cdeebfbde6 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -257,6 +257,7 @@ static inline int pmd_large(pmd_t pte)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_large */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
 	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
diff --git a/mm/mremap.c b/mm/mremap.c
index 6aa6ea605068..57b1f999f789 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -266,7 +266,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		new_pmd = alloc_new_pmd(vma->vm_mm, vma, new_addr);
 		if (!new_pmd)
 			break;
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
+		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) || pmd_devmap(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE) {
 				bool moved;
 				/* See comment in move_ptes() */
-- 
2.25.4


