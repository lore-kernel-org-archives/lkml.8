Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B24EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 22:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 215FB206C0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 22:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8scnWxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgHHWiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 18:38:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725950AbgHHWiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 18:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596926289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hm04VRSPNOWAWag6GBV43qqvwU0AE+7Ghd/jAhwulxw=;
        b=i8scnWxkEJ+0+rAQT244f0b7gV8e21ha6q3hJqO5JGdR0YuvavLSg39Ki7jn/7hdqK/5mH
        zVeHth/xjIhPOYQVMsGpkf8vCP6FMKcTBWUEEMY0aQMVexZj6fwVBefsq0aqy1gPwEqkZs
        0B5KAT5GgKprrf4FOC3WeINbr6jUSc0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-UI7m8kqpOICFjbLNCyyseA-1; Sat, 08 Aug 2020 18:38:06 -0400
X-MC-Unique: UI7m8kqpOICFjbLNCyyseA-1
Received: by mail-qt1-f200.google.com with SMTP id h10so4660460qtc.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 15:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hm04VRSPNOWAWag6GBV43qqvwU0AE+7Ghd/jAhwulxw=;
        b=mXU/nuoTsPWx1h3sozQVHnPiLpNR4O9rYwucDH74/LK3WUCZZxNVLhg2iQtjsHTefi
         q1PNebV4rqHrWMNbOMbIGrkS2K6+XLn/tmh/DdngpUFXtEHiErupvg0KSJrtth5M2Fm3
         ocYOP2sMrOJsHAgGYN5LdQvVmaC11EP7ORnBT4Jx09ljyJupM5NyAGsnPd43tu8pi8zD
         RAJijBp5wZIEeEclXqWZcuNaQJvf78uDIC63VwNYyJm5OcDWRHyXR6RQ/K7az1gJmBww
         Plf3LRTpBcJD3S+EFg1yYyC1AKb+BuTbwd7FqgvqFi0eNivYzDLxPJ2RqxiXVm/oJFEs
         RNnA==
X-Gm-Message-State: AOAM531PXxkVOuHTLGwgxesU6U1DXir4r2FQvgHwwSNryZxXYYEb4GXq
        mIvWICOldc+hPgGTK//u9W2maeEkw4HXoUpWPmBuGHg82Pwu/5f3Gr5BDIQ9RlKCbgrMj0cth8S
        yBthgquPsJTnObHK+1Z7Y6HJm
X-Received: by 2002:a05:6214:1841:: with SMTP id d1mr5532516qvy.135.1596926285681;
        Sat, 08 Aug 2020 15:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmPVIWEUNy8xotgKUcg/jyaIL5QwRv/NmfY6IdCt6CqLIa+lxmHQ6UDh54vnPKDo5WtuB7WQ==
X-Received: by 2002:a05:6214:1841:: with SMTP id d1mr5532502qvy.135.1596926285378;
        Sat, 08 Aug 2020 15:38:05 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id h20sm9797647qkk.79.2020.08.08.15.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 15:38:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Subject: [PATCH] mm/gup: Allow real explicit breaking of COW
Date:   Sat,  8 Aug 2020 18:38:02 -0400
Message-Id: <20200808223802.11451-1-peterx@redhat.com>
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

[1] https://github.com/LLNL/umap-apps/blob/develop/src/umapsort/umapsort.cpp
[2] https://github.com/LLNL/umap

CC: Marty Mcfadden <mcfadden8@llnl.gov>
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
 include/linux/mm.h |  3 +++
 mm/gup.c           |  4 ++--
 mm/memory.c        | 15 ++++++++++++---
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f6a82f9bccd7..dacba5c7942f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -409,6 +409,7 @@ extern pgprot_t protection_map[16];
  * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
  * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
  * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
+ * @FAULT_FLAG_BREAK_COW: Do COW explicitly for the fault (even for read)
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
index d8a33dd1430d..02267f5797a7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1076,7 +1076,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 			}
 			if (is_vm_hugetlb_page(vma)) {
 				if (should_force_cow_break(vma, foll_flags))
-					foll_flags |= FOLL_WRITE;
+					foll_flags |= FOLL_BREAK_COW;
 				i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &nr_pages, i,
 						foll_flags, locked);
@@ -1095,7 +1095,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		}
 
 		if (should_force_cow_break(vma, foll_flags))
-			foll_flags |= FOLL_WRITE;
+			foll_flags |= FOLL_BREAK_COW;
 
 retry:
 		/*
diff --git a/mm/memory.c b/mm/memory.c
index c39a13b09602..0c819056374e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2900,7 +2900,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 
-	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
+	if ((vmf->flags & FAULT_FLAG_WRITE) &&
+	    userfaultfd_pte_wp(vma, *vmf->pte)) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		return handle_userfault(vmf, VM_UFFD_WP);
 	}
@@ -3290,7 +3291,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		put_page(swapcache);
 	}
 
-	if (vmf->flags & FAULT_FLAG_WRITE) {
+	/*
+	 * We'll do a COW if it's a write or the caller wants explicit COW
+	 * behavior (even if it's a read operation)
+	 */
+	if (vmf->flags & (FAULT_FLAG_WRITE | FAULT_FLAG_BREAK_COW)) {
 		ret |= do_wp_page(vmf);
 		if (ret & VM_FAULT_ERROR)
 			ret &= VM_FAULT_ERROR;
@@ -4241,7 +4246,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		goto unlock;
 	}
-	if (vmf->flags & FAULT_FLAG_WRITE) {
+	/*
+	 * We'll do a COW if it's a write or the caller wants explicit COW
+	 * behavior (even if it's a read operation)
+	 */
+	if (vmf->flags & (FAULT_FLAG_WRITE | FAULT_FLAG_BREAK_COW)) {
 		if (!pte_write(entry))
 			return do_wp_page(vmf);
 		entry = pte_mkdirty(entry);
-- 
2.26.2

