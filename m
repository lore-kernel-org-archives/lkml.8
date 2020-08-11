Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E57C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA852076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjZ+a0ET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHKSkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:40:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20469 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725862AbgHKSkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597171200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ehldQ7u2RFp9mhKtKspgyBES/eNp3K3u2HvNYnpxyMk=;
        b=DjZ+a0ETY+hQ90/efkPFV91UtoChYOLHKX+IltzjWCVMmbz7k4m7WizmsoNvVbSgjwzCFh
        21vfFspgCyvmiVFIZtFMs8lLm7d8WyNQy+ksOI/OT3kxhPjwkETbqXWA4A7UMkCw25IHLo
        ME+ZYF8d6FmfNc2YI6Lrh2MFh0mMS0Y=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-30_l_fi1O72Z8aZmhqIVog-1; Tue, 11 Aug 2020 14:39:55 -0400
X-MC-Unique: 30_l_fi1O72Z8aZmhqIVog-1
Received: by mail-io1-f69.google.com with SMTP id e73so4562513iof.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 11:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ehldQ7u2RFp9mhKtKspgyBES/eNp3K3u2HvNYnpxyMk=;
        b=Hb5e6vnwmspsU2JmzAgnivONngmpd8XCIpmNwEh961bFYcJgLeM90D/ovtmyF8QFCo
         ktFOS8kQ/dCoDLwbvNmbuQhc/1KHfSkKXY9gVIsXgYH1sw+L9vjfY1iqEOI0TmKyc1DT
         pe86EUE9lghzH+GkVsd4ENJeeRBGnnXHFYF+ylp4j68EZGMPSMz0YFxO+lD5qraSNy9m
         cWP5YAU/DmD3dGoeTmyIX+3NBMxaljUPfeiIWPsMsP36At6l07wxgA32AJ3OJ55tNFTA
         6mTJcuvqz6IsFOHgnWjou1vr3hGsBVngB+rWKjG0zXd94XHb6JKK1jteh46XbyS3dlnZ
         keJg==
X-Gm-Message-State: AOAM530nmtXz56BDh9terI7UydiR0KQuSXnwSHrO8HXPAqL39oFTN1Fp
        kNq6nvgSifVyFTQSTmRMuzNdCU34jXoPvcCfMIcppN6TknP6PwcMeEyq9LHsA+szfo4RN6ow+0Z
        tD/9V8MHbfxCpUTtK4TpQW27N
X-Received: by 2002:a92:1f4f:: with SMTP id i76mr24616587ile.226.1597171194629;
        Tue, 11 Aug 2020 11:39:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybSqRuf4y/mJQfGPNNf9rnhVxAmfLnpKyaH8o923KU+hMchJrC8pd6QdUfXzedlL1GyN1QPg==
X-Received: by 2002:a92:1f4f:: with SMTP id i76mr24616564ile.226.1597171194326;
        Tue, 11 Aug 2020 11:39:54 -0700 (PDT)
Received: from localhost.localdomain (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id v17sm13864621ilj.33.2020.08.11.11.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 11:39:52 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Subject: [PATCH v3] mm/gup: Allow real explicit breaking of COW
Date:   Tue, 11 Aug 2020 14:39:50 -0400
Message-Id: <20200811183950.10603-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from commit 17839856fd58 ("gup: document and work around "COW can
break either way" issue", 2020-06-02), explicit copy-on-write behavior is
enforced for private gup pages even if it's a read-only.  It is achieved by
always passing FOLL_WRITE to emulate a write.

That should fix the COW issue that we were facing, however above commit could
also break userfaultfd-wp and applications like umapsort [1,2].

One general routine of umap-like program is: userspace library will manage page
allocations, and it will evict the least recently used pages from memory to
external storages (e.g., file systems).  Below are the general steps to evict
an in-memory page in the uffd service thread when the page pool is full:

  (1) UFFDIO_WRITEPROTECT with mode=WP on some to-be-evicted page P, so that
      further writes to page P will block (keep page P clean)
  (2) Copy page P to external storage (e.g. file system)
  (3) MADV_DONTNEED to evict page P

Here step (1) makes sure that the page to dump will always be up-to-date, so
that the page snapshot in the file system is consistent with the one that was
in the memory.  However with commit 17839856fd58, step (2) can potentially hang
itself because e.g. if we use write() to a file system fd to dump the page
data, that will be a translated read gup request in the file system driver to
read the page content, then the read gup will be translated to a write gup due
to the new enforced COW behavior.  This write gup will further trigger
handle_userfault() and hang the uffd service thread itself.

I think the problem will go away too if we replace the write() to the file
system into a memory write to a mmaped region in the userspace library, because
normal page faults will not enforce COW, only gup is affected.  However we
cannot forbid users to use write() or any form of kernel level read gup.

One solution is actually already mentioned in commit 17839856fd58, which is to
provide an explicit BREAK_COW scemantics for enforced COW.  Then we can still
use FAULT_FLAG_WRITE to identify whether this is a "real write request" or an
"enfornced COW (read) request".

With the enforced COW, we also need to inherit UFFD_WP bit during COW because
now COW can happen with UFFD_WP enabled (previously, it cannot).

Since at it, rename the variable in __handle_mm_fault() from "dirty" to "cow"
to better suite its functionality.

[1] https://github.com/LLNL/umap-apps/blob/develop/src/umapsort/umapsort.cpp
[2] https://github.com/LLNL/umap

CC: Marty Mcfadden <mcfadden8@llnl.gov>
CC: Maya B. Gokhale <gokhale2@llnl.gov>
CC: Andrea Arcangeli <aarcange@redhat.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Jann Horn <jannh@google.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Kirill Shutemov <kirill@shutemov.name>
CC: Jan Kara <jack@suse.cz>
Fixes: 17839856fd588f4ab6b789f482ed3ffd7c403e1f
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v3:
- inherit UFFD_WP bit for COW too
- take care of huge page cases
- more comments
v2:
- apply FAULT_FLAG_BREAK_COW correctly when FOLL_BREAK_COW [Christoph]
- removed comments above do_wp_page which seems redundant
---
 include/linux/mm.h |  3 +++
 mm/gup.c           |  6 ++++--
 mm/huge_memory.c   | 12 +++++++++++-
 mm/memory.c        | 39 +++++++++++++++++++++++++++++++--------
 4 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f6a82f9bccd7..a1f5c92b44cb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -409,6 +409,7 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_BREAK_COW: Do COW explicitly for the fault (even for read).
  *
  * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
  * whether we would allow page faults to retry by specifying these two
@@ -439,6 +440,7 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_REMOTE			0x80
 #define FAULT_FLAG_INSTRUCTION  		0x100
 #define FAULT_FLAG_INTERRUPTIBLE		0x200
+#define FAULT_FLAG_BREAK_COW			0x400
 
 /*
  * The default fault flags that should be used by most of the
@@ -2756,6 +2758,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
 #define FOLL_PIN	0x40000	/* pages must be released via unpin_user_page */
 #define FOLL_FAST_ONLY	0x80000	/* gup_fast: prevent fall-back to slow gup */
+#define FOLL_BREAK_COW  0x100000 /* request for explicit COW (even for read) */
 
 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
diff --git a/mm/gup.c b/mm/gup.c
index d8a33dd1430d..c33e84ab9c36 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -870,6 +870,8 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 		return -ENOENT;
 	if (*flags & FOLL_WRITE)
 		fault_flags |= FAULT_FLAG_WRITE;
+	if (*flags & FOLL_BREAK_COW)
+		fault_flags |= FAULT_FLAG_BREAK_COW;
 	if (*flags & FOLL_REMOTE)
 		fault_flags |= FAULT_FLAG_REMOTE;
 	if (locked)
@@ -1076,7 +1078,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 			}
 			if (is_vm_hugetlb_page(vma)) {
 				if (should_force_cow_break(vma, foll_flags))
-					foll_flags |= FOLL_WRITE;
+					foll_flags |= FOLL_BREAK_COW;
 				i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &nr_pages, i,
 						foll_flags, locked);
@@ -1095,7 +1097,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		}
 
 		if (should_force_cow_break(vma, foll_flags))
-			foll_flags |= FOLL_WRITE;
+			foll_flags |= FOLL_BREAK_COW;
 
 retry:
 		/*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 206f52b36ffb..c88f773d03af 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1296,7 +1296,17 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 	if (reuse_swap_page(page, NULL)) {
 		pmd_t entry;
 		entry = pmd_mkyoung(orig_pmd);
-		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+		entry = pmd_mkdirty(entry);
+		if (pmd_uffd_wp(orig_pmd))
+			/*
+			 * This can happen when an uffd-wp protected page is
+			 * copied due to enfornced COW.  When it happens, we
+			 * need to keep the uffd-wp bit even after COW, and
+			 * make sure write bit is kept cleared.
+			 */
+			entry = pmd_mkuffd_wp(pmd_wrprotect(entry));
+		else
+			entry = maybe_pmd_mkwrite(entry, vma);
 		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
 			update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		unlock_page(page);
diff --git a/mm/memory.c b/mm/memory.c
index c39a13b09602..b27b555a9df8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2706,7 +2706,17 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		entry = pte_sw_mkyoung(entry);
-		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+		entry = pte_mkdirty(entry);
+		if (pte_uffd_wp(vmf->orig_pte))
+			/*
+			 * This can happen when an uffd-wp protected page is
+			 * copied due to enfornced COW.  When it happens, we
+			 * need to keep the uffd-wp bit even after COW, and
+			 * make sure write bit is kept cleared.
+			 */
+			entry = pte_mkuffd_wp(pte_wrprotect(entry));
+		else
+			entry = maybe_mkwrite(entry, vma);
 		/*
 		 * Clear the pte entry and flush it first, before updating the
 		 * pte with the new entry. This will avoid a race condition
@@ -2900,7 +2910,13 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
-	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
+	/*
+	 * Userfaultfd-wp only cares about real writes.  E.g., enforced COW for
+	 * read does not count.  When that happens, we will do the COW with the
+	 * UFFD_WP bit inherited from the original PTE/PMD.
+	 */
+	if ((vmf->flags & FAULT_FLAG_WRITE) &&
+	    userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return handle_userfault(vmf, VM_UFFD_WP);
 	}
@@ -3290,7 +3306,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		put_page(swapcache);
 	}
 
-	if (vmf->flags & FAULT_FLAG_WRITE) {
+	if (vmf->flags & (FAULT_FLAG_WRITE | FAULT_FLAG_BREAK_COW)) {
 		ret |= do_wp_page(vmf);
 		if (ret & VM_FAULT_ERROR)
 			ret &= VM_FAULT_ERROR;
@@ -4117,7 +4133,14 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf, pmd_t orig_pmd)
 {
 	if (vma_is_anonymous(vmf->vma)) {
-		if (userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
+		/*
+		 * Userfaultfd-wp only cares about real writes.  E.g., enforced
+		 * COW for read does not count.  When that happens, we will do
+		 * the COW with the UFFD_WP bit inherited from the original
+		 * PTE/PMD.
+		 */
+		if ((vmf->flags & FAULT_FLAG_WRITE) &&
+		    userfaultfd_huge_pmd_wp(vmf->vma, orig_pmd))
 			return handle_userfault(vmf, VM_UFFD_WP);
 		return do_huge_pmd_wp_page(vmf, orig_pmd);
 	}
@@ -4241,7 +4264,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		goto unlock;
 	}
-	if (vmf->flags & FAULT_FLAG_WRITE) {
+	if (vmf->flags & (FAULT_FLAG_WRITE | FAULT_FLAG_BREAK_COW)) {
 		if (!pte_write(entry))
 			return do_wp_page(vmf);
 		entry = pte_mkdirty(entry);
@@ -4281,7 +4304,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		.pgoff = linear_page_index(vma, address),
 		.gfp_mask = __get_fault_gfp_mask(vma),
 	};
-	unsigned int dirty = flags & FAULT_FLAG_WRITE;
+	bool cow = flags & (FAULT_FLAG_WRITE | FAULT_FLAG_BREAK_COW);
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -4308,7 +4331,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 
 			/* NUMA case for anonymous PUDs would go here */
 
-			if (dirty && !pud_write(orig_pud)) {
+			if (cow && !pud_write(orig_pud)) {
 				ret = wp_huge_pud(&vmf, orig_pud);
 				if (!(ret & VM_FAULT_FALLBACK))
 					return ret;
@@ -4346,7 +4369,7 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 			if (pmd_protnone(orig_pmd) && vma_is_accessible(vma))
 				return do_huge_pmd_numa_page(&vmf, orig_pmd);
 
-			if (dirty && !pmd_write(orig_pmd)) {
+			if (cow && !pmd_write(orig_pmd)) {
 				ret = wp_huge_pmd(&vmf, orig_pmd);
 				if (!(ret & VM_FAULT_FALLBACK))
 					return ret;
-- 
2.26.2

