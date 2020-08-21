Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39451C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1009A2067C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBy1IzFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHUXuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:50:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39269 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726706AbgHUXuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598053811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZhKl54kX7dAPZ6/cV/ptJau3xXQpk6RfDHKjNDKypM=;
        b=BBy1IzFgkvGk7kSv3IOhAK6F/iUSs8sZO6EqD6ZeC+pKBKYrGQPKMhgKAxiIHCeaQzTGGA
        yRASklcpAqs/bAiBIn7sh27n2V5VhtjqIibFO6L07hJqsec+hBPjH3yJIV+3QOHHNho1Em
        TLXSZe7BB1BQFRseHy88jraVYUh9Hkw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-a7tK4xUmMg20G38lTupwCA-1; Fri, 21 Aug 2020 19:50:10 -0400
X-MC-Unique: a7tK4xUmMg20G38lTupwCA-1
Received: by mail-qk1-f200.google.com with SMTP id a130so2454960qkg.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZhKl54kX7dAPZ6/cV/ptJau3xXQpk6RfDHKjNDKypM=;
        b=PQ/3lE1hyCk2ERuD5T7qKdbX2t5xyV/5R4UJkOIdHh2ldctn3n84Tr+MBJtncUeNvN
         DZiPWTYZw+oU3AIpsyK+PWawdUDhmv/ps2ZaiHxGcMMM//C4CH4uiy5Zc0RVoMvw5If1
         k4svLrF/ILF92rkSoVUFarkkHt4rEiVbB5xBW3pFMg67sXrmSbnemesRDgGo8ECIoU8U
         AmG9sixjDnSSFN6hOOkkvi44AimNOIjX9Sw/4t3UglG4LPQ8P68YSwWeh4ID0/PeDUWK
         JQu72eZ26bUsVdGzXybGKNBTb04pKCI5BFUbo/vyT09bddpNNENRBQGqBLInoo920Gxo
         LbdA==
X-Gm-Message-State: AOAM532IX1K1neR7h9qy/hfjnVdti03SD8ZX1YOxhaKrCPRNKIC0XzzS
        lAw6V8Csd1eNihcm7xHc4UHDyFlr3WIJDF93qA+6zo1oQmY7OshzKJnYp0iVqKuSwX+5hSCLtfq
        FjQR2F4tJYoDmbx4Ov2ZldmbS
X-Received: by 2002:a05:620a:2ee:: with SMTP id a14mr5117546qko.42.1598053807825;
        Fri, 21 Aug 2020 16:50:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCp9W9gDh5acBlNIfiYG5rM0wjHTFslrPs84JBX5JFhkDSCN8tx21DaK1qtdFAUMH63KSNVQ==
X-Received: by 2002:a05:620a:2ee:: with SMTP id a14mr5117525qko.42.1598053807522;
        Fri, 21 Aug 2020 16:50:07 -0700 (PDT)
Received: from localhost.localdomain (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id t69sm2821600qka.73.2020.08.21.16.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 16:50:06 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>, peterx@redhat.com,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/4] mm/gup: Remove enfornced COW mechanism
Date:   Fri, 21 Aug 2020 19:49:57 -0400
Message-Id: <20200821234958.7896-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821234958.7896-1-peterx@redhat.com>
References: <20200821234958.7896-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the more strict (but greatly simplified) page reuse logic in do_wp_page(),
we can savely go back to the world where cow is not enforced with writes.

This (majorly) reverts commit 17839856fd588f4ab6b789f482ed3ffd7c403e1f.
There're some context differences due to some changes later on around it:

  2170ecfa7688 ("drm/i915: convert get_user_pages() --> pin_user_pages()", 2020-06-03)
  376a34efa4ee ("mm/gup: refactor and de-duplicate gup_fast() code", 2020-06-03)

Some lines moved back and forth with those, but this revert patch should have
striped out and covered all the enforced cow bits anyways.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |  8 -----
 mm/gup.c                                    | 40 +++------------------
 mm/huge_memory.c                            |  7 ++--
 3 files changed, 9 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 2c2bf24140c9..12b30075134a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -596,14 +596,6 @@ static int i915_gem_userptr_get_pages(struct drm_i915_gem_object *obj)
 				      GFP_KERNEL |
 				      __GFP_NORETRY |
 				      __GFP_NOWARN);
-		/*
-		 * Using __get_user_pages_fast() with a read-only
-		 * access is questionable. A read-only page may be
-		 * COW-broken, and then this might end up giving
-		 * the wrong side of the COW..
-		 *
-		 * We may or may not care.
-		 */
 		if (pvec) {
 			/* defer to worker if malloc fails */
 			if (!i915_gem_object_is_readonly(obj))
diff --git a/mm/gup.c b/mm/gup.c
index ae096ea7583f..bb93251194d8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -381,22 +381,13 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 }
 
 /*
- * FOLL_FORCE or a forced COW break can write even to unwritable pte's,
- * but only after we've gone through a COW cycle and they are dirty.
+ * FOLL_FORCE can write to even unwritable pte's, but only
+ * after we've gone through a COW cycle and they are dirty.
  */
 static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
 {
-	return pte_write(pte) || ((flags & FOLL_COW) && pte_dirty(pte));
-}
-
-/*
- * A (separate) COW fault might break the page the other way and
- * get_user_pages() would return the page from what is now the wrong
- * VM. So we need to force a COW break at GUP time even for reads.
- */
-static inline bool should_force_cow_break(struct vm_area_struct *vma, unsigned int flags)
-{
-	return is_cow_mapping(vma->vm_flags) && (flags & (FOLL_GET | FOLL_PIN));
+	return pte_write(pte) ||
+		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
 }
 
 static struct page *follow_page_pte(struct vm_area_struct *vma,
@@ -1067,11 +1058,9 @@ static long __get_user_pages(struct mm_struct *mm,
 				goto out;
 			}
 			if (is_vm_hugetlb_page(vma)) {
-				if (should_force_cow_break(vma, foll_flags))
-					foll_flags |= FOLL_WRITE;
 				i = follow_hugetlb_page(mm, vma, pages, vmas,
 						&start, &nr_pages, i,
-						foll_flags, locked);
+						gup_flags, locked);
 				if (locked && *locked == 0) {
 					/*
 					 * We've got a VM_FAULT_RETRY
@@ -1085,10 +1074,6 @@ static long __get_user_pages(struct mm_struct *mm,
 				continue;
 			}
 		}
-
-		if (should_force_cow_break(vma, foll_flags))
-			foll_flags |= FOLL_WRITE;
-
 retry:
 		/*
 		 * If we have a pending SIGKILL, don't keep faulting pages and
@@ -2689,19 +2674,6 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 		return -EFAULT;
 
 	/*
-	 * The FAST_GUP case requires FOLL_WRITE even for pure reads,
-	 * because get_user_pages() may need to cause an early COW in
-	 * order to avoid confusing the normal COW routines. So only
-	 * targets that are already writable are safe to do by just
-	 * looking at the page tables.
-	 *
-	 * NOTE! With FOLL_FAST_ONLY we allow read-only gup_fast() here,
-	 * because there is no slow path to fall back on. But you'd
-	 * better be careful about possible COW pages - you'll get _a_
-	 * COW page, but not necessarily the one you intended to get
-	 * depending on what COW event happens after this. COW may break
-	 * the page copy in a random direction.
-	 *
 	 * Disable interrupts. The nested form is used, in order to allow
 	 * full, general purpose use of this routine.
 	 *
@@ -2714,8 +2686,6 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
 	 */
 	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) && gup_fast_permitted(start, end)) {
 		unsigned long fast_flags = gup_flags;
-		if (!(gup_flags & FOLL_FAST_ONLY))
-			fast_flags |= FOLL_WRITE;
 
 		local_irq_save(flags);
 		gup_pgd_range(addr, end, fast_flags, pages, &nr_pinned);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2ccff8472cd4..7ff29cc3d55c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1291,12 +1291,13 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 }
 
 /*
- * FOLL_FORCE or a forced COW break can write even to unwritable pmd's,
- * but only after we've gone through a COW cycle and they are dirty.
+ * FOLL_FORCE can write to even unwritable pmd's, but only
+ * after we've gone through a COW cycle and they are dirty.
  */
 static inline bool can_follow_write_pmd(pmd_t pmd, unsigned int flags)
 {
-	return pmd_write(pmd) || ((flags & FOLL_COW) && pmd_dirty(pmd));
+	return pmd_write(pmd) ||
+	       ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pmd_dirty(pmd));
 }
 
 struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
-- 
2.26.2

