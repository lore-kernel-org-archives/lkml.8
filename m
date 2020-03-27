Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A4BC2D0EE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E46C208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 02:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKxR3ona"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgC0CL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 22:11:29 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:45220 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgC0CLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:11:24 -0400
Received: by mail-pf1-f201.google.com with SMTP id a188so7015689pfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 19:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xbfzfU9BuZhYVtZI+f7wZqdjFxjb/Cu4ZDBLeXOeWh4=;
        b=CKxR3ona0u2RmWR/xBiXd/BIIQOhDb5ow2tHB7KtIuqP+ipu+a9Y4l2DI7zNDKmFOl
         cKDWOas4/Ha6AVoNYg0QqMRXa1eBWkoAgP0aMwXZNyjP7xzj2ovpO+xZ9AgSnKaDt/jS
         lxJsqSxQcg8zr76VzevUeD4QSX7Sohhw1x34d1QvDYqLijCdWbl1fzWEpm76Qt5Ri1CU
         kn2ZPltn+MjMzxshnsHMQI6QAIZfSJaY0+YT8C9Oez5uvbfqQO5IvQcGrwUDqxpoF8cx
         dYFKGuGbBrm+eWaouSjJwq8ygg/dx9LHQSwyy3yuBXie4bKHK914vPwitmbybQAtW93j
         YHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xbfzfU9BuZhYVtZI+f7wZqdjFxjb/Cu4ZDBLeXOeWh4=;
        b=DDHgy+dSCCSgMwpTNfIqrzElxGZyjr7lfPLS+Tfn+7PJnXzrKeQkaXNrdIDz6ofXyh
         ++LAQGiEAECR+IFnL1Oapm5WQ1H9EewFNuYixblRkKMnF7q1nRk5DltID3ow1/kIZK+o
         jEJ+LtgFEx7f0X3uYY/IZvbMxvZcnC8pJ1xs6JNk/0QUetYch8IgSNf8CA69pPXf4UMR
         Gq7uA+8pFLAcwPMg5AsyIYISXA37vZZJOVDPiYlJdn+cGaNbGZokZiOr4hZOj1vNvVJy
         X5CnqdTbg1OuMQti3VvrqzOe+/pNYufbfgYENGeYDNl9DS2vzDY7FEE2AGD+jMzgyzYb
         8JhQ==
X-Gm-Message-State: ANhLgQ3Z3FpDJtRQbKs9GSlfRjWDKPo7XmpEL/haFMEi3Um2+WoG5dAl
        zmeuhJUW/Sf5R3Hxe/WtsSZh4CHr4Z4=
X-Google-Smtp-Source: ADFU+vtVAlUiFBKMsrFe3fbDpb5LQUuV30ffPeopL8PT/CYp/gJkXzxDRmTbcl6CF6Uc/4pStbEr2LuEO0U=
X-Received: by 2002:a17:90a:bf18:: with SMTP id c24mr3196953pjs.125.1585275083331;
 Thu, 26 Mar 2020 19:11:23 -0700 (PDT)
Date:   Thu, 26 Mar 2020 19:10:57 -0700
In-Reply-To: <20200327021058.221911-1-walken@google.com>
Message-Id: <20200327021058.221911-10-walken@google.com>
Mime-Version: 1.0
References: <20200327021058.221911-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 09/10] mmap locking API: use lockdep_assert_held
From:   Michel Lespinasse <walken@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Markus Elfring <Markus.Elfring@web.de>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use lockdep_assert_held when asserting that mmap_sem is held.

Using this instead of rwsem_is_locked makes the assertions more
tolerant of future changes to the lock type.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 fs/userfaultfd.c | 6 +++---
 mm/gup.c         | 2 +-
 mm/memory.c      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 5914eabd8185..ad1ce223ee6a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -234,7 +234,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *ptep, pte;
 	bool ret = true;
 
-	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
+	lockdep_assert_held(&mm->mmap_sem);
 
 	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
 
@@ -286,7 +286,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *pte;
 	bool ret = true;
 
-	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
+	lockdep_assert_held(&mm->mmap_sem);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -376,7 +376,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * Coredumping runs without mmap_sem so we can only check that
 	 * the mmap_sem is held, if PF_DUMPCORE was not set.
 	 */
-	WARN_ON_ONCE(!rwsem_is_locked(&mm->mmap_sem));
+	lockdep_assert_held(&mm->mmap_sem);
 
 	ctx = vmf->vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
diff --git a/mm/gup.c b/mm/gup.c
index d78965738e7e..1e225eba4787 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1154,7 +1154,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	VM_BUG_ON(end   & ~PAGE_MASK);
 	VM_BUG_ON_VMA(start < vma->vm_start, vma);
 	VM_BUG_ON_VMA(end   > vma->vm_end, vma);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+	lockdep_assert_held(&mm->mmap_sem);
 
 	gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK;
 	if (vma->vm_flags & VM_LOCKONFAULT)
diff --git a/mm/memory.c b/mm/memory.c
index 03fce44eee16..4c125f0a1df9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1202,7 +1202,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 		next = pud_addr_end(addr, end);
 		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
-				VM_BUG_ON_VMA(!rwsem_is_locked(&tlb->mm->mmap_sem), vma);
+				lockdep_assert_held(&tlb->mm->mmap_sem);
 				split_huge_pud(vma, pud, addr);
 			} else if (zap_huge_pud(tlb, vma, pud, addr))
 				goto next;
-- 
2.26.0.rc2.310.g2932bb562d-goog

