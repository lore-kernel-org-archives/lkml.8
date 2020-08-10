Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C905CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBB020791
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUA6eJgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHJO5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:57:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56566 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726464AbgHJO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597071427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X94MiDwUendf6JmPezLRdErQYPoOiP1KjRkqlgzcETw=;
        b=aUA6eJgtRiNeB+2ZzJxUF1L3qHpX+KMpPIPTBRAPRO+AzUC4XAlUY9qczZu9SxY7XIRnwr
        0zca3y1cjk94ZhjNdCPmxmbGtOYIck/Fw4z/kyxwyvwPtkiyu9ZVGqnq2l3hrR5+5tayR1
        iHqeM8xuXgQ6+sGsPTw8E+/ivWRYv8Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-ZsEWLDVINJinStJ8REi4EA-1; Mon, 10 Aug 2020 10:57:04 -0400
X-MC-Unique: ZsEWLDVINJinStJ8REi4EA-1
Received: by mail-qk1-f197.google.com with SMTP id v16so7173805qka.18
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X94MiDwUendf6JmPezLRdErQYPoOiP1KjRkqlgzcETw=;
        b=bTiCIn1u1ByUIrQx1VTRGCluyaU7hLl67boWYzEtdYfFmBDgNTCoaPBfLsivjHcv4P
         5asb7ndMc3S4gZVCoZ0b5JIojIgIudApXTZxUSMW7PmeHZ0wS13jqkfvAwMHXi7sDj2/
         tGsyIZmIH5dE+9NQXWvz0GXY55rK90cPZQ9T8sgsBp3Qowq62hImoJB6xOVDHvWFaoc0
         m7okt2c1ZsPhJhzzJ1pLEhxGUtvdG3jTBGUmxHWSMq/Czgn9+eXZ7zp4ZVHtV4/1HPWU
         ls22i6dEgGc+QfBYmIsmCmzCpmrDlXZY9UhqEG/tHMA8WbRmjb01O7vkpZj5+bSWUaId
         s08w==
X-Gm-Message-State: AOAM532L9WfvQ3/IGCYMCFPqylgeWMwvbgobR9QT72NHcSVYXKft5882
        Rgxm/TNQHoT6+yOIGoUhm/rkkzTgoaPnsyAsJeRYiCRYwDbQSdN2GMYbFTtmhZrQwsSoBsX42es
        S3IEF0b78oOkpLldsLgPcnF/I
X-Received: by 2002:a05:6214:542:: with SMTP id ci2mr27045352qvb.7.1597071423710;
        Mon, 10 Aug 2020 07:57:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc6QGdaHDoibk9FZRvLZyjwh25Olf6AnPr1gUhvePBSPpxAgBDa+c1O2p7J0VDk5BRjnhyiA==
X-Received: by 2002:a05:6214:542:: with SMTP id ci2mr27045321qvb.7.1597071423371;
        Mon, 10 Aug 2020 07:57:03 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id y3sm10557694qkd.132.2020.08.10.07.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:57:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] mm/gup: Allow real explicit breaking of COW
Date:   Mon, 10 Aug 2020 10:57:01 -0400
Message-Id: <20200810145701.129228-1-peterx@redhat.com>
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
v2:
- apply FAULT_FLAG_BREAK_COW correctly when FOLL_BREAK_COW [Christoph]
- removed comments above do_wp_page which seems redundant
---
 include/linux/mm.h | 3 +++
 mm/gup.c           | 6 ++++--
 mm/memory.c        | 7 ++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

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
diff --git a/mm/memory.c b/mm/memory.c
index c39a13b09602..7659b0e27a98 100644
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
@@ -3290,7 +3291,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		put_page(swapcache);
 	}
 
-	if (vmf->flags & FAULT_FLAG_WRITE) {
+	if (vmf->flags & (FAULT_FLAG_WRITE | FAULT_FLAG_BREAK_COW)) {
 		ret |= do_wp_page(vmf);
 		if (ret & VM_FAULT_ERROR)
 			ret &= VM_FAULT_ERROR;
@@ -4241,7 +4242,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
 		goto unlock;
 	}
-	if (vmf->flags & FAULT_FLAG_WRITE) {
+	if (vmf->flags & (FAULT_FLAG_WRITE | FAULT_FLAG_BREAK_COW)) {
 		if (!pte_write(entry))
 			return do_wp_page(vmf);
 		entry = pte_mkdirty(entry);
-- 
2.26.2

