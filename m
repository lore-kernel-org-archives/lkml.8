Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B45C3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1AB214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="W2fo0a5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgCDK25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:28:57 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:1303 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgCDK2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:28:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 7370F3FE3D;
        Wed,  4 Mar 2020 11:28:51 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=W2fo0a5E;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xE_mC59_WbOz; Wed,  4 Mar 2020 11:28:50 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 5A4603FCD5;
        Wed,  4 Mar 2020 11:28:50 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 5EEC53605FD;
        Wed,  4 Mar 2020 11:28:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1583317728; bh=YWEV2L/GcJ/BB131ReqWiiuK/xyWwF22eft0YAMzYMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2fo0a5EPnmBYoU528KAmsMJbf5JwP9aQUc7vBUF2tq1NSLiL58UYXznsxYwCy6Zo
         2sPG69nObSpsZ3OmA6GmWPoAvtwnBzbaFws2FebHsTf5OreODPgYXQvQ/9oEGc9564
         8QOY/JTgTw31j4rmBFEtM4FjmXVBT8HSIGmdFd5U=
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
        Dan Williams <dan.j.williams@intel.com>,
        Roland Scheidegger <sroland@vmware.com>
Subject: [PATCH v6 5/9] drm/ttm, drm/vmwgfx: Support huge TTM pagefaults
Date:   Wed,  4 Mar 2020 11:28:36 +0100
Message-Id: <20200304102840.2801-6-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304102840.2801-1-thomas_os@shipmail.org>
References: <20200304102840.2801-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Support huge (PMD-size and PUD-size) page-table entries by providing a
huge_fault() callback.
We still support private mappings and write-notify by splitting the huge
page-table entries on write-access.

Note that for huge page-faults to occur, either the kernel needs to be
compiled with trans-huge-pages always enabled, or the kernel needs to be
compiled with trans-huge-pages enabled using madvise, and the user-space
app needs to call madvise() to enable trans-huge pages on a per-mapping
basis.

Furthermore huge page-faults will not succeed unless buffer objects and
user-space addresses are aligned on huge page size boundaries.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Roland Scheidegger <sroland@vmware.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c            | 161 ++++++++++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c |   2 +-
 include/drm/ttm/ttm_bo_api.h               |   3 +-
 3 files changed, 161 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 389128b8c4dd..0af14835504c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -156,6 +156,89 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(ttm_bo_vm_reserve);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/**
+ * ttm_bo_vm_insert_huge - Insert a pfn for PUD or PMD faults
+ * @vmf: Fault data
+ * @bo: The buffer object
+ * @page_offset: Page offset from bo start
+ * @fault_page_size: The size of the fault in pages.
+ * @pgprot: The page protections.
+ * Does additional checking whether it's possible to insert a PUD or PMD
+ * pfn and performs the insertion.
+ *
+ * Return: VM_FAULT_NOPAGE on successful insertion, VM_FAULT_FALLBACK if
+ * a huge fault was not possible, or on insertion error.
+ */
+static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
+					struct ttm_buffer_object *bo,
+					pgoff_t page_offset,
+					pgoff_t fault_page_size,
+					pgprot_t pgprot)
+{
+	pgoff_t i;
+	vm_fault_t ret;
+	unsigned long pfn;
+	pfn_t pfnt;
+	struct ttm_tt *ttm = bo->ttm;
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+
+	/* Fault should not cross bo boundary. */
+	page_offset &= ~(fault_page_size - 1);
+	if (page_offset + fault_page_size > bo->num_pages)
+		goto out_fallback;
+
+	if (bo->mem.bus.is_iomem)
+		pfn = ttm_bo_io_mem_pfn(bo, page_offset);
+	else
+		pfn = page_to_pfn(ttm->pages[page_offset]);
+
+	/* pfn must be fault_page_size aligned. */
+	if ((pfn & (fault_page_size - 1)) != 0)
+		goto out_fallback;
+
+	/* Check that memory is contiguous. */
+	if (!bo->mem.bus.is_iomem) {
+		for (i = 1; i < fault_page_size; ++i) {
+			if (page_to_pfn(ttm->pages[page_offset + i]) != pfn + i)
+				goto out_fallback;
+		}
+	} else if (bo->bdev->driver->io_mem_pfn) {
+		for (i = 1; i < fault_page_size; ++i) {
+			if (ttm_bo_io_mem_pfn(bo, page_offset + i) != pfn + i)
+				goto out_fallback;
+		}
+	}
+
+	pfnt = __pfn_to_pfn_t(pfn, PFN_DEV);
+	if (fault_page_size == (HPAGE_PMD_SIZE >> PAGE_SHIFT))
+		ret = vmf_insert_pfn_pmd_prot(vmf, pfnt, pgprot, write);
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	else if (fault_page_size == (HPAGE_PUD_SIZE >> PAGE_SHIFT))
+		ret = vmf_insert_pfn_pud_prot(vmf, pfnt, pgprot, write);
+#endif
+	else
+		WARN_ON_ONCE(ret = VM_FAULT_FALLBACK);
+
+	if (ret != VM_FAULT_NOPAGE)
+		goto out_fallback;
+
+	return VM_FAULT_NOPAGE;
+out_fallback:
+	count_vm_event(THP_FAULT_FALLBACK);
+	return VM_FAULT_FALLBACK;
+}
+#else
+static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
+					struct ttm_buffer_object *bo,
+					pgoff_t page_offset,
+					pgoff_t fault_page_size,
+					pgprot_t pgprot)
+{
+	return VM_FAULT_FALLBACK;
+}
+#endif
+
 /**
  * ttm_bo_vm_fault_reserved - TTM fault helper
  * @vmf: The struct vm_fault given as argument to the fault callback
@@ -163,6 +246,7 @@ EXPORT_SYMBOL(ttm_bo_vm_reserve);
  * @num_prefault: Maximum number of prefault pages. The caller may want to
  * specify this based on madvice settings and the size of the GPU object
  * backed by the memory.
+ * @fault_page_size: The size of the fault in pages.
  *
  * This function inserts one or more page table entries pointing to the
  * memory backing the buffer object, and then returns a return code
@@ -176,7 +260,8 @@ EXPORT_SYMBOL(ttm_bo_vm_reserve);
  */
 vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 				    pgprot_t prot,
-				    pgoff_t num_prefault)
+				    pgoff_t num_prefault,
+				    pgoff_t fault_page_size)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ttm_buffer_object *bo = vma->vm_private_data;
@@ -268,6 +353,13 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 		prot = pgprot_decrypted(prot);
 	}
 
+	/* We don't prefault on huge faults. Yet. */
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && fault_page_size != 1) {
+		ret = ttm_bo_vm_insert_huge(vmf, bo, page_offset,
+					    fault_page_size, prot);
+		goto out_io_unlock;
+	}
+
 	/*
 	 * Speculatively prefault a number of pages. Only error on
 	 * first page.
@@ -334,7 +426,7 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 		return ret;
 
 	prot = vma->vm_page_prot;
-	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT);
+	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT, 1);
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
 		return ret;
 
@@ -344,6 +436,66 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
 }
 EXPORT_SYMBOL(ttm_bo_vm_fault);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/**
+ * ttm_pgprot_is_wrprotecting - Is a page protection value write-protecting?
+ * @prot: The page protection value
+ *
+ * Return: true if @prot is write-protecting. false otherwise.
+ */
+static bool ttm_pgprot_is_wrprotecting(pgprot_t prot)
+{
+	/*
+	 * This is meant to say "pgprot_wrprotect(prot) == prot" in a generic
+	 * way. Unfortunately there is no generic pgprot_wrprotect.
+	 */
+	return pte_val(pte_wrprotect(__pte(pgprot_val(prot)))) ==
+		pgprot_val(prot);
+}
+
+static vm_fault_t ttm_bo_vm_huge_fault(struct vm_fault *vmf,
+				       enum page_entry_size pe_size)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	pgprot_t prot;
+	struct ttm_buffer_object *bo = vma->vm_private_data;
+	vm_fault_t ret;
+	pgoff_t fault_page_size = 0;
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+
+	switch (pe_size) {
+	case PE_SIZE_PMD:
+		fault_page_size = HPAGE_PMD_SIZE >> PAGE_SHIFT;
+		break;
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
+	case PE_SIZE_PUD:
+		fault_page_size = HPAGE_PUD_SIZE >> PAGE_SHIFT;
+		break;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		return VM_FAULT_FALLBACK;
+	}
+
+	/* Fallback on write dirty-tracking or COW */
+	if (write && ttm_pgprot_is_wrprotecting(vma->vm_page_prot))
+		return VM_FAULT_FALLBACK;
+
+	ret = ttm_bo_vm_reserve(bo, vmf);
+	if (ret)
+		return ret;
+
+	prot = vm_get_page_prot(vma->vm_flags);
+	ret = ttm_bo_vm_fault_reserved(vmf, prot, 1, fault_page_size);
+	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		return ret;
+
+	dma_resv_unlock(bo->base.resv);
+
+	return ret;
+}
+#endif
+
 void ttm_bo_vm_open(struct vm_area_struct *vma)
 {
 	struct ttm_buffer_object *bo = vma->vm_private_data;
@@ -445,7 +597,10 @@ static const struct vm_operations_struct ttm_bo_vm_ops = {
 	.fault = ttm_bo_vm_fault,
 	.open = ttm_bo_vm_open,
 	.close = ttm_bo_vm_close,
-	.access = ttm_bo_vm_access
+	.access = ttm_bo_vm_access,
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	.huge_fault = ttm_bo_vm_huge_fault,
+#endif
 };
 
 static struct ttm_buffer_object *ttm_bo_vm_lookup(struct ttm_bo_device *bdev,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index f07aa857587c..17a5dca7b921 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -477,7 +477,7 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
 	else
 		prot = vm_get_page_prot(vma->vm_flags);
 
-	ret = ttm_bo_vm_fault_reserved(vmf, prot, num_prefault);
+	ret = ttm_bo_vm_fault_reserved(vmf, prot, num_prefault, 1);
 	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
 		return ret;
 
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 66ca49db9633..4fc90d53aa15 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -732,7 +732,8 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
 
 vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
 				    pgprot_t prot,
-				    pgoff_t num_prefault);
+				    pgoff_t num_prefault,
+				    pgoff_t fault_page_size);
 
 vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf);
 
-- 
2.21.1

