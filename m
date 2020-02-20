Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA83C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D505206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGrCRELF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgBTQbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:31:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34086 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728895AbgBTQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9L3kuR+XaqVS60Nnta++nc2tju9iKXKamHTCQnp9pc=;
        b=eGrCRELFtrBm+XtiHrGAU0GEjG9lM/Bj/FrxGGlQlJYuoU52ytSCfcboMTIe4UhhHuHsPr
        8RL92wx5QHklBCS13JU5HLAvwqrYnNPff38nu1tALUZnZYITCwHoDiuBt6r9LukgMIiUVF
        sSiEuYgVTsHNlU11LgUW5VfdKVfekmc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-W6FBTHbHM_SgNIND2egRyA-1; Thu, 20 Feb 2020 11:31:29 -0500
X-MC-Unique: W6FBTHbHM_SgNIND2egRyA-1
Received: by mail-qk1-f198.google.com with SMTP id o22so3117975qko.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9L3kuR+XaqVS60Nnta++nc2tju9iKXKamHTCQnp9pc=;
        b=L7ktAMcTo4qnsQvDlnRCWpGnGDGMc2Ghj30gEvevZ/p9noNlfwVqK/zi9DALaERlpF
         IN/V/8defCWq4Cf/zd6xK4uQBLAPxyedFwuKkq4pYFf/K2Fourh9V8fLQxctmoVxpPK+
         3hZfyklr7m0NnEIpVJbIszEnELuSkADQyR9bce9qaef4pl5AXbViolxlyoBbHyHKL9BU
         yVmnB5kTVC8GkDmlV/6REoARjB0l8kgrqt1lEai1WdWia3nmP1f6FX0UZuTdAWlnyvxo
         iv6l+LO+VgCGL6m1iNI9NrTDUMSeyrYBrGjM6CAGTrfvZtx3Un3DGgq7gcVmE/gO50oX
         z6kA==
X-Gm-Message-State: APjAAAWGJlHUdJQOpnYpefnFmh94GQoF/PAdPStqlPqIEedfyUKH0CC9
        chsWUBf4AyBd+bJj/Wefco58d265iFWBOMBQ3KW4rkSNcwqHsFcXnyn1l+h4UVe1m+Gb4j0GVN6
        +0Vi48BlD3Mvg3/kPG+016guS
X-Received: by 2002:ac8:6645:: with SMTP id j5mr28015183qtp.167.1582216288208;
        Thu, 20 Feb 2020 08:31:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZ1v8pIHXw/fPS8Hi4ouLosLiEATFOhTUenSsG1Fl7k+AmpEctOpa9z1VoLDr9b7ewFskmjA==
X-Received: by 2002:ac8:6645:: with SMTP id j5mr28015126qtp.167.1582216287746;
        Thu, 20 Feb 2020 08:31:27 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:27 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Brian Geffon <bgeffon@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH v6 07/19] userfaultfd: wp: apply _PAGE_UFFD_WP bit
Date:   Thu, 20 Feb 2020 11:31:00 -0500
Message-Id: <20200220163112.11409-8-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, introduce two new flags MM_CP_UFFD_WP[_RESOLVE] for
change_protection() when used with uffd-wp and make sure the two new
flags are exclusively used.  Then,

  - For MM_CP_UFFD_WP: apply the _PAGE_UFFD_WP bit and remove _PAGE_RW
    when a range of memory is write protected by uffd

  - For MM_CP_UFFD_WP_RESOLVE: remove the _PAGE_UFFD_WP bit and recover
    _PAGE_RW when write protection is resolved from userspace

And use this new interface in mwriteprotect_range() to replace the old
MM_CP_DIRTY_ACCT.

Do this change for both PTEs and huge PMDs.  Then we can start to
identify which PTE/PMD is write protected by general (e.g., COW or soft
dirty tracking), and which is for userfaultfd-wp.

Since we should keep the _PAGE_UFFD_WP when doing pte_modify(), add it
into _PAGE_CHG_MASK as well.  Meanwhile, since we have this new bit, we
can be even more strict when detecting uffd-wp page faults in either
do_wp_page() or wp_huge_pmd().

After we're with _PAGE_UFFD_WP, a special case is when a page is both
protected by the general COW logic and also userfault-wp.  Here the
userfault-wp will have higher priority and will be handled first.
Only after the uffd-wp bit is cleared on the PTE/PMD will we continue
to handle the general COW.  These are the steps on what will happen
with such a page:

  1. CPU accesses write protected shared page (so both protected by
     general COW and uffd-wp), blocked by uffd-wp first because in
     do_wp_page we'll handle uffd-wp first, so it has higher priority
     than general COW.

  2. Uffd service thread receives the request, do UFFDIO_WRITEPROTECT
     to remove the uffd-wp bit upon the PTE/PMD.  However here we
     still keep the write bit cleared.  Notify the blocked CPU.

  3. The blocked CPU resumes the page fault process with a fault
     retry, during retry it'll notice it was not with the uffd-wp bit
     this time but it is still write protected by general COW, then
     it'll go though the COW path in the fault handler, copy the page,
     apply write bit where necessary, and retry again.

  4. The CPU will be able to access this page with write bit set.

Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  5 +++++
 mm/huge_memory.c   | 18 +++++++++++++++++-
 mm/memory.c        |  4 ++--
 mm/mprotect.c      | 17 +++++++++++++++++
 mm/userfaultfd.c   |  8 ++++++--
 5 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 547c7415ff92..01c6a534895f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1671,6 +1671,11 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 #define  MM_CP_DIRTY_ACCT                  (1UL << 0)
 /* Whether this protection change is for NUMA hints */
 #define  MM_CP_PROT_NUMA                   (1UL << 1)
+/* Whether this change is for write protecting */
+#define  MM_CP_UFFD_WP                     (1UL << 2) /* do wp */
+#define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
+#define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
+					    MM_CP_UFFD_WP_RESOLVE)
 
 extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b01765bee92..c56a83e0a184 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1942,6 +1942,8 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	bool preserve_write;
 	int ret;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
+	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	ptl = __pmd_trans_huge_lock(pmd, vma);
 	if (!ptl)
@@ -2008,6 +2010,17 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	entry = pmd_modify(entry, newprot);
 	if (preserve_write)
 		entry = pmd_mk_savedwrite(entry);
+	if (uffd_wp) {
+		entry = pmd_wrprotect(entry);
+		entry = pmd_mkuffd_wp(entry);
+	} else if (uffd_wp_resolve) {
+		/*
+		 * Leave the write bit to be handled by PF interrupt
+		 * handler, then things like COW could be properly
+		 * handled.
+		 */
+		entry = pmd_clear_uffd_wp(entry);
+	}
 	ret = HPAGE_PMD_NR;
 	set_pmd_at(mm, addr, pmd, entry);
 	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(entry));
@@ -2156,7 +2169,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	struct page *page;
 	pgtable_t pgtable;
 	pmd_t old_pmd, _pmd;
-	bool young, write, soft_dirty, pmd_migration = false;
+	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
 	unsigned long addr;
 	int i;
 
@@ -2238,6 +2251,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		write = pmd_write(old_pmd);
 		young = pmd_young(old_pmd);
 		soft_dirty = pmd_soft_dirty(old_pmd);
+		uffd_wp = pmd_uffd_wp(old_pmd);
 	}
 	VM_BUG_ON_PAGE(!page_count(page), page);
 	page_ref_add(page, HPAGE_PMD_NR - 1);
@@ -2271,6 +2285,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_mkold(entry);
 			if (soft_dirty)
 				entry = pte_mksoft_dirty(entry);
+			if (uffd_wp)
+				entry = pte_mkuffd_wp(entry);
 		}
 		pte = pte_offset_map(&_pmd, addr);
 		BUG_ON(!pte_none(*pte));
diff --git a/mm/memory.c b/mm/memory.c
index 3d8c7e8652e9..21cd818dfede 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2733,7 +2733,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
-	if (userfaultfd_wp(vma)) {
+	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return handle_userfault(vmf, VM_UFFD_WP);
 	}
@@ -3936,7 +3936,7 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
 {
 	if (vma_is_anonymous(vmf->vma)) {
-		if (userfaultfd_wp(vmf->vma))
+		if (userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
 			return handle_userfault(vmf, VM_UFFD_WP);
 		return do_huge_pmd_wp_page(vmf, orig_pmd);
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 1565058ebcfc..22a1c78e3f51 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -45,6 +45,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	int target_node = NUMA_NO_NODE;
 	bool dirty_accountable = cp_flags & MM_CP_DIRTY_ACCT;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
+	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
+	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 
 	/*
 	 * Can be called with only the mmap_sem for reading by
@@ -116,6 +118,19 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			if (preserve_write)
 				ptent = pte_mk_savedwrite(ptent);
 
+			if (uffd_wp) {
+				ptent = pte_wrprotect(ptent);
+				ptent = pte_mkuffd_wp(ptent);
+			} else if (uffd_wp_resolve) {
+				/*
+				 * Leave the write bit to be handled
+				 * by PF interrupt handler, then
+				 * things like COW could be properly
+				 * handled.
+				 */
+				ptent = pte_clear_uffd_wp(ptent);
+			}
+
 			/* Avoid taking write faults for known dirty pages */
 			if (dirty_accountable && pte_dirty(ptent) &&
 					(pte_soft_dirty(ptent) ||
@@ -302,6 +317,8 @@ unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 {
 	unsigned long pages;
 
+	BUG_ON((cp_flags & MM_CP_UFFD_WP_ALL) == MM_CP_UFFD_WP_ALL);
+
 	if (is_vm_hugetlb_page(vma))
 		pages = hugetlb_change_protection(vma, start, end, newprot);
 	else
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 44a5e5429fac..4a06613525ee 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -101,8 +101,12 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 		goto out_release;
 
 	_dst_pte = pte_mkdirty(mk_pte(page, dst_vma->vm_page_prot));
-	if ((dst_vma->vm_flags & VM_WRITE) && !wp_copy)
-		_dst_pte = pte_mkwrite(_dst_pte);
+	if (dst_vma->vm_flags & VM_WRITE) {
+		if (wp_copy)
+			_dst_pte = pte_mkuffd_wp(_dst_pte);
+		else
+			_dst_pte = pte_mkwrite(_dst_pte);
+	}
 
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
 	if (dst_vma->vm_file) {
-- 
2.24.1

