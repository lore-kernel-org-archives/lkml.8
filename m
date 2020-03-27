Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FB5C2BA11
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D4720787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oy+pJbNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgC0Wvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:51:31 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50799 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgC0Wv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:51:29 -0400
Received: by mail-pl1-f202.google.com with SMTP id k10so8089903plx.17
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xbfzfU9BuZhYVtZI+f7wZqdjFxjb/Cu4ZDBLeXOeWh4=;
        b=oy+pJbNfN27cWWr81XSBaziJYK6CASpEPROsDy+RxWz/gsUiIHaho5ILpjN+1rWoFe
         RZhgrmyC1NEzv4mWNRVD6rMrblcdvgRDl9vwC/Hpb5tWi9WpeMARBdyviuOShwXU+eIj
         0wKuYmua2wLVH4PldXOQn01xAJfMu+UgEsxgbSzE3zHtEhUTZbpR8NMkdjhHIETiRSvy
         ejXTRfhBCmaEMEOYUQSpakroSZaqXVgU3VIGeY3DYOs6WCXz/XscvuhN2I2VXBbMvwb4
         Xlddmz8hpGwBRuywv2TIOtvKKl0P4zPYZ1oj/HFJKvmdX1OXKTqs6LYjMPwYUkM5VRj1
         WZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xbfzfU9BuZhYVtZI+f7wZqdjFxjb/Cu4ZDBLeXOeWh4=;
        b=rmGo0EKE11Uz6Jz7yR8Dy8vX2AJ+tNED8PXIaQKBaczXtFQwI/AYeTmcgzeD7FUdWa
         yklZiZAfaYyeWPiKA5Fxy57r2Imbn2rke7WRkvG1/ZoO0Oaprad/IvyubErQPu4TyFTE
         ecmfyQHaQ0g5R8M9cDg7QsyfKGU9yN9W6GRh9TuGdrwkxxOjOuS8nfzn12w7cPMxUymO
         5MzkWLMe7IzZR2un6ieNXrjDkkXWX/1yOKFdlM3KV8FxSfhoeWfP0ssqvBa5Coh1kv7G
         PWV1Do8h+GjGqZbGxNSxjbLph2RoQvDMLZkQMNJt6ffLxZc9VKW21/02Xh7DDeMRO9Ne
         u6iQ==
X-Gm-Message-State: ANhLgQ3s4jIDfQpgLU99Jq+jslQLvQP1HFHRFM5Rkzj8GTwxV012u+kc
        A8PwKb6FQDjesWJmHWQy8a/elJ0Ogaw=
X-Google-Smtp-Source: ADFU+vvWd0IqiXiflyLpZ9mh9GOnzskLcl81XiO1ntJlLp1NZ1mpzt1ePzWvfoNKv3KayCXYoxGRvL7WJ5Y=
X-Received: by 2002:a17:90a:222d:: with SMTP id c42mr1811170pje.16.1585349487110;
 Fri, 27 Mar 2020 15:51:27 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:51:01 -0700
In-Reply-To: <20200327225102.25061-1-walken@google.com>
Message-Id: <20200327225102.25061-10-walken@google.com>
Mime-Version: 1.0
References: <20200327225102.25061-1-walken@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 09/10] mmap locking API: use lockdep_assert_held
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

