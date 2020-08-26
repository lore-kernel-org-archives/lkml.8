Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C00C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBBBC2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UJqD/t3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgHZPPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgHZPPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:15:38 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B551C061757
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:38 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id s29so1950727qtc.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=W92EWp10cYvF5yPv3rgiIaePnIXh3IWgRNGaRIqgcR4=;
        b=UJqD/t3WSlOOwI6R+bovBLP0sPLAoFd9plz7oxgqCdZWBEXqS068KD0/WN83GUiYro
         AqMkBXVc1ZQW++VdRzH7wzupdkHlEeE8WdNHPNXIrAtApBfg/kUBE5w1O/QJ4oIRh7tV
         tb02uam4svDcll5gPdChagNY8GeENR2JwPo3cAmCZl9l0lPaA3lpuWAHtoTTZ/nY0xe3
         4n3EawWNVxHzX152yi+B+/xnFeZCesLvBc+9Yf0k6A6nYtvt0Cp/3xSdFHsZ6DIr3vdE
         P/v6YEhnOufPrYUBJwGNBZiHQ38brTulw+gui8aHniQAc42zBTvr/aWwOPvwZ19EuwvR
         oVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W92EWp10cYvF5yPv3rgiIaePnIXh3IWgRNGaRIqgcR4=;
        b=iTtQeuM3LByECH7SHstqM6smMbpDNMDQoN8EWt6UpN4KLA78B2bdo7PuC5JLLMMpDt
         1+jJa6gs/F9O/NDvko4F40tCgu4kb/tpCWof0OKtXV6xlQnzuoO7czOUHljJfXAQFqiC
         L0SlsbXDQ3J2kH1YpnxhH77JGXZ0SOWM2364a5HOFwj26ytHftO6Aq2RFiAZeRP/WxBj
         wsk552M/+y+RHcchYRGjJiw8iq/eX8KyCBDM9lXnUiokB1ZrdaMhP9qNme7KlEsnnFUX
         7Fu5TxzVCJw/a8KLPtNt99W/EMMFEvZL7+6KOvKKQaIeWT9IjL/PLJijRWf16z7xEzKv
         GNbw==
X-Gm-Message-State: AOAM533VJ0gYcI8KraK13+MsTWY6YIP88+NXZl6Kp7AJthc0XkoYSiQN
        L6OwT713v+Cs3YsAyWaS6PgFOFQa4Q==
X-Google-Smtp-Source: ABdhPJy7KDIKhCfICG40CVPo7QPb4NhJBMI2xLLuMFSRNzJ90NFTZ37qbydNf49iDwWC0KeljzXzUWr8og==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:ad4:46ac:: with SMTP id br12mr14699313qvb.236.1598454937463;
 Wed, 26 Aug 2020 08:15:37 -0700 (PDT)
Date:   Wed, 26 Aug 2020 17:14:44 +0200
In-Reply-To: <20200826151448.3404695-1-jannh@google.com>
Message-Id: <20200826151448.3404695-2-jannh@google.com>
Mime-Version: 1.0
References: <20200826151448.3404695-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v4 1/5] binfmt_elf_fdpic: Stop using dump_emit() on user
 pointers on !MMU
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_emit() is for kernel pointers, and VMAs describe userspace memory.
Let's be tidy here and avoid accessing userspace pointers under KERNEL_DS,
even if it probably doesn't matter much on !MMU systems - especially given
that it looks like we can just use the same get_dump_page() as on MMU if
we move it out of the CONFIG_MMU block.

One small change we have to make in get_dump_page() is to use
__get_user_pages_locked() instead of __get_user_pages(), since the
latter doesn't exist on nommu. On mmu builds, __get_user_pages_locked()
will just call __get_user_pages() for us.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/binfmt_elf_fdpic.c |  8 ------
 mm/gup.c              | 57 +++++++++++++++++++++----------------------
 2 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 50f845702b92..a53f83830986 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1529,14 +1529,11 @@ static bool elf_fdpic_dump_segments(struct coredump_params *cprm)
 	struct vm_area_struct *vma;
 
 	for (vma = current->mm->mmap; vma; vma = vma->vm_next) {
-#ifdef CONFIG_MMU
 		unsigned long addr;
-#endif
 
 		if (!maydump(vma, cprm->mm_flags))
 			continue;
 
-#ifdef CONFIG_MMU
 		for (addr = vma->vm_start; addr < vma->vm_end;
 							addr += PAGE_SIZE) {
 			bool res;
@@ -1552,11 +1549,6 @@ static bool elf_fdpic_dump_segments(struct coredump_params *cprm)
 			if (!res)
 				return false;
 		}
-#else
-		if (!dump_emit(cprm, (void *) vma->vm_start,
-				vma->vm_end - vma->vm_start))
-			return false;
-#endif
 	}
 	return true;
 }
diff --git a/mm/gup.c b/mm/gup.c
index ae096ea7583f..92519e5a44b3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1495,35 +1495,6 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		mmap_read_unlock(mm);
 	return ret;	/* 0 or negative error code */
 }
-
-/**
- * get_dump_page() - pin user page in memory while writing it to core dump
- * @addr: user address
- *
- * Returns struct page pointer of user page pinned for dump,
- * to be freed afterwards by put_page().
- *
- * Returns NULL on any kind of failure - a hole must then be inserted into
- * the corefile, to preserve alignment with its headers; and also returns
- * NULL wherever the ZERO_PAGE, or an anonymous pte_none, has been found -
- * allowing a hole to be left in the corefile to save diskspace.
- *
- * Called without mmap_lock, but after all other threads have been killed.
- */
-#ifdef CONFIG_ELF_CORE
-struct page *get_dump_page(unsigned long addr)
-{
-	struct vm_area_struct *vma;
-	struct page *page;
-
-	if (__get_user_pages(current->mm, addr, 1,
-			     FOLL_FORCE | FOLL_DUMP | FOLL_GET, &page, &vma,
-			     NULL) < 1)
-		return NULL;
-	flush_cache_page(vma, addr, page_to_pfn(page));
-	return page;
-}
-#endif /* CONFIG_ELF_CORE */
 #else /* CONFIG_MMU */
 static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 		unsigned long nr_pages, struct page **pages,
@@ -1569,6 +1540,34 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 }
 #endif /* !CONFIG_MMU */
 
+/**
+ * get_dump_page() - pin user page in memory while writing it to core dump
+ * @addr: user address
+ *
+ * Returns struct page pointer of user page pinned for dump,
+ * to be freed afterwards by put_page().
+ *
+ * Returns NULL on any kind of failure - a hole must then be inserted into
+ * the corefile, to preserve alignment with its headers; and also returns
+ * NULL wherever the ZERO_PAGE, or an anonymous pte_none, has been found -
+ * allowing a hole to be left in the corefile to save diskspace.
+ *
+ * Called without mmap_lock, but after all other threads have been killed.
+ */
+#ifdef CONFIG_ELF_CORE
+struct page *get_dump_page(unsigned long addr)
+{
+	struct vm_area_struct *vma;
+	struct page *page;
+
+	if (__get_user_pages_locked(current->mm, addr, 1, &page, &vma, NULL,
+				    FOLL_FORCE | FOLL_DUMP | FOLL_GET) < 1)
+		return NULL;
+	flush_cache_page(vma, addr, page_to_pfn(page));
+	return page;
+}
+#endif /* CONFIG_ELF_CORE */
+
 #if defined(CONFIG_FS_DAX) || defined (CONFIG_CMA)
 static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
 {
-- 
2.28.0.297.g1956fa8f8d-goog

