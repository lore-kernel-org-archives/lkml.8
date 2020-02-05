Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD00C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C8420702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="UZZATccw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgBEMyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:54:55 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:34414 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgBEMy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:54:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id BE3653F545;
        Wed,  5 Feb 2020 13:54:24 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=UZZATccw;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id egtu1W7Qy1Bb; Wed,  5 Feb 2020 13:54:23 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 90C913F36B;
        Wed,  5 Feb 2020 13:54:18 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 0F98336037C;
        Wed,  5 Feb 2020 13:54:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1580907258; bh=LiTyLLIByG+Sgb2g/bWGf0WAGY1HDe6N6KfEq6OX0aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZZATccwPkAF46V0bdOCO4h8eMdld70EPG8meGn/GY+KNUGZp7YSjwehi1tcRKq1E
         AHsFKz1i98VOXGxMbsafLfVdZ677pjC/5kygr2zXAHfQgYZEb8GuVvSHDgdUZl+F+G
         gfbKyD4+unuSqHsF/tJD6KlJsRWSjie4jbuL8TJk=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 2/9] mm: Introduce vma_is_special_huge
Date:   Wed,  5 Feb 2020 13:53:46 +0100
Message-Id: <20200205125353.2760-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200205125353.2760-1-thomas_os@shipmail.org>
References: <20200205125353.2760-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

For VM_PFNMAP and VM_MIXEDMAP vmas that want to support transhuge pages
and -page table entries, introduce vma_is_special_huge() that takes the
same codepaths as vma_is_dax().

The use of "special" follows the definition in memory.c, vm_normal_page():
"Special" mappings do not wish to be associated with a "struct page"
(either it doesn't exist, or it exists but they don't want to touch it)

For PAGE_SIZE pages, "special" is determined per page table entry to be
able to deal with COW pages. But since we don't have huge COW pages,
we can classify a vma as either "special huge" or "normal huge".

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 include/linux/mm.h | 17 +++++++++++++++++
 mm/huge_memory.c   |  6 +++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0157d293935f..d370ce2932a1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2822,6 +2822,23 @@ extern long copy_huge_page_from_user(struct page *dst_page,
 				const void __user *usr_src,
 				unsigned int pages_per_huge_page,
 				bool allow_pagefault);
+
+/**
+ * vma_is_special_huge - Are transhuge page-table entries considered special?
+ * @vma: Pointer to the struct vm_area_struct to consider
+ *
+ * Whether transhuge page-table entries are considered "special" following
+ * the definition in vm_normal_page().
+ *
+ * Return: true if transhuge page-table entries should be considered special,
+ * false otherwise.
+ */
+static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
+{
+	return vma_is_dax(vma) || (vma->vm_file &&
+				   (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)));
+}
+
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 41a0fbddc96b..f8d24fc3f4df 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1789,7 +1789,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	orig_pmd = pmdp_huge_get_and_clear_full(tlb->mm, addr, pmd,
 			tlb->fullmm);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	if (vma_is_dax(vma)) {
+	if (vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
@@ -2053,7 +2053,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
-	if (vma_is_dax(vma)) {
+	if (vma_is_special_huge(vma)) {
 		spin_unlock(ptl);
 		/* No zero page support yet */
 	} else {
@@ -2162,7 +2162,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		 */
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(mm, pmd);
-		if (vma_is_dax(vma))
+		if (vma_is_special_huge(vma))
 			return;
 		page = pmd_page(_pmd);
 		if (!PageDirty(page) && pmd_dirty(_pmd))
-- 
2.21.1

