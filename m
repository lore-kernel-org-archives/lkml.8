Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55907C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1A820735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhFOnMH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgDVAO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgDVAOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:14:49 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CBEC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:47 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w6so523469qtt.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/eDOjnM9HRS8OZpDk6pfMhfG32YpgGHrkgLs3JMHIzE=;
        b=mhFOnMH/PFj8RkvZsUJ1VayE7RcJCiCKYRKPCTgHI/fvOovo1BaQA8sWItdsVrCd/T
         otCFheAAbr+9nY7JfJbtd9rFN77Nmb3bQLd1EZ1FaJMm266MHuGxGP9QKjcS1flE40NY
         hrlF6yDVCIG9TDEPSLHJ4ND1d7OwiLuEutGlvdSaGyw3Nms6jlWfCja48ssqqLSd4QqK
         e3ClRzD/PywU8gG42OJcjZBW7tkCk4vn5HujRCV1q9gADsHVr/9d7nZaXbbMBifVSCB5
         MDhFhmxmT7QuB91O++3TdnH5sPBTZJrysrMbrwqMIFlTns+fI6RNpAI3TwTrxAuqYovt
         +MQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/eDOjnM9HRS8OZpDk6pfMhfG32YpgGHrkgLs3JMHIzE=;
        b=VksMLnReWaJWw5fNLvntKBzZKJOIeXV3nFRStffCLA1+avOe6O/uwvR64ySARtRHTz
         RhK9nmLevB8LphnyGd1Ox/bHUmVgURsPFAEINBiPeEOSBXzD0ZRxgmgU/O1nGglfiHYD
         6JqlT/EujHvAK4XfUcW8Ww5vPesWID/J8aPRi1prqLfBD1B6jkq3pL/UiHX2qoP/PC+e
         AONecKjES8cl5TBDJqPdiMcFJVBssA/Gf3FroiqxKeMEIapVXCXx/7ky8aYu0v+/koxu
         fG+al+OcPlbZcsDcfK2TR4I38/iQSIK8iTvA4fpyY1lUV43/RfNivECyerTXn4RwFkYn
         IPug==
X-Gm-Message-State: AGi0PuarNrWksh7KqmbX7X8f3yLfLdZZh8Ch66DPSmW/5MnYEKWM5HGK
        H1yafk/Ic5Bec4zNusMTtq9xlzda08w=
X-Google-Smtp-Source: APiQypLkCgZ5QyMRA2Kls797eOnq3Fvv4/RJFRvdM8oKCvxtZFU9mbexebet60I1wVNAoL/zP89dxl6R5Vw=
X-Received: by 2002:a0c:facb:: with SMTP id p11mr22619057qvo.17.1587514486557;
 Tue, 21 Apr 2020 17:14:46 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:14:21 -0700
In-Reply-To: <20200422001422.232330-1-walken@google.com>
Message-Id: <20200422001422.232330-10-walken@google.com>
Mime-Version: 1.0
References: <20200422001422.232330-1-walken@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v5 09/10] mmap locking API: add mmap_assert_locked
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
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mmap_assert_locked to assert that mmap_sem is held.

Signed-off-by: Michel Lespinasse <walken@google.com>
---
 fs/userfaultfd.c          |  6 +++---
 include/linux/mmap_lock.h | 10 ++++++++++
 mm/gup.c                  |  2 +-
 mm/memory.c               |  2 +-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 9c645eee1a59..12b492409040 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -234,7 +234,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *ptep, pte;
 	bool ret = true;
 
-	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
+	mmap_assert_locked(mm);
 
 	ptep = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
 
@@ -286,7 +286,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *pte;
 	bool ret = true;
 
-	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
+	mmap_assert_locked(mm);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -405,7 +405,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * Coredumping runs without mmap_sem so we can only check that
 	 * the mmap_sem is held, if PF_DUMPCORE was not set.
 	 */
-	WARN_ON_ONCE(!rwsem_is_locked(&mm->mmap_sem));
+	mmap_assert_locked(mm);
 
 	ctx = vmf->vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 9e104835a0d1..f7a3a9550cc5 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_MMAP_LOCK_H
 #define _LINUX_MMAP_LOCK_H
 
+#include <linux/mmdebug.h>
+
 #define MMAP_LOCK_INITIALIZER(name) \
 	.mmap_sem = __RWSEM_INITIALIZER(name.mmap_sem),
 
@@ -73,4 +75,12 @@ static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 	up_read_non_owner(&mm->mmap_sem);
 }
 
+static inline void mmap_assert_locked(struct mm_struct *mm)
+{
+	if (IS_ENABLED(CONFIG_LOCKDEP) && debug_locks)
+		VM_BUG_ON_MM(!lockdep_is_held(&mm->mmap_sem), mm);
+	else
+		VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+}
+
 #endif /* _LINUX_MMAP_LOCK_H */
diff --git a/mm/gup.c b/mm/gup.c
index 0404e52513b2..e12993ceb711 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1403,7 +1403,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	VM_BUG_ON(end   & ~PAGE_MASK);
 	VM_BUG_ON_VMA(start < vma->vm_start, vma);
 	VM_BUG_ON_VMA(end   > vma->vm_end, vma);
-	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+	mmap_assert_locked(mm);
 
 	gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK;
 	if (vma->vm_flags & VM_LOCKONFAULT)
diff --git a/mm/memory.c b/mm/memory.c
index e6dd3309c5a3..20f98ea8968e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1214,7 +1214,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 		next = pud_addr_end(addr, end);
 		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
-				VM_BUG_ON_VMA(!rwsem_is_locked(&tlb->mm->mmap_sem), vma);
+				mmap_assert_locked(tlb->mm);
 				split_huge_pud(vma, pud, addr);
 			} else if (zap_huge_pud(tlb, vma, pud, addr))
 				goto next;
-- 
2.26.1.301.g55bc3eb7cb9-goog

