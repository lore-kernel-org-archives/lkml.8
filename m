Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C3C54FD4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F43620A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="FnJNWVZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgCXULv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:11:51 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:37910 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgCXULs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:11:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 373543F504;
        Tue, 24 Mar 2020 21:11:46 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=FnJNWVZ2;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NsUB7riQ5ocS; Tue, 24 Mar 2020 21:11:41 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id EBB5E3F4E7;
        Tue, 24 Mar 2020 21:11:40 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 87B9B360308;
        Tue, 24 Mar 2020 21:11:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1585080700; bh=LllKBqw2wO4T5iGYWqMCexSSQNGBp2Vkl1w4YNHgngg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnJNWVZ2FVePl3FNGME5FwHpcjnGLBsjHXUNR0BlfOXIHzYdyus3mEgodbgqsEoL6
         yhAWDtTJlFUt2ReT31asqI0kmkUTByl3zNPv00xJR30ZQx4av/4oTrtBSMvmAHWJ8L
         p3QWRYlnrKAkhJPBNQ8i8vYA9ML/T/TKJFS0WjoU=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        "Thomas Hellstrom (VMware)" <thomas_os@shipmail.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v7 2/9] mm: Introduce vma_is_special_huge
Date:   Tue, 24 Mar 2020 21:11:16 +0100
Message-Id: <20200324201123.3118-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200324201123.3118-1-thomas_os@shipmail.org>
References: <20200324201123.3118-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Thomas Hellstrom (VMware)" <thomas_os@shipmail.org>

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
Signed-off-by: Thomas Hellstrom (VMware) <thomas_os@shipmail.org>
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h | 17 +++++++++++++++++
 mm/huge_memory.c   |  6 +++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c54fb96cb1e6..bdd79a72bb42 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2867,6 +2867,23 @@ extern long copy_huge_page_from_user(struct page *dst_page,
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
index 24ad53b4dfc0..19c8d462ab08 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1802,7 +1802,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	orig_pmd = pmdp_huge_get_and_clear_full(tlb->mm, addr, pmd,
 			tlb->fullmm);
 	tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
-	if (vma_is_dax(vma)) {
+	if (vma_is_special_huge(vma)) {
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
@@ -2066,7 +2066,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 */
 	pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
-	if (vma_is_dax(vma)) {
+	if (vma_is_special_huge(vma)) {
 		spin_unlock(ptl);
 		/* No zero page support yet */
 	} else {
@@ -2175,7 +2175,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
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

