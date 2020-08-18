Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4F1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BE52075B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvkd25vZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHRGMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgHRGMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:12:51 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BEDC061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 23:12:50 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z5so13753891qtc.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fmtjrw2NiRGUWmA+xNP8VLGlgPN22hDvuJd6RREZ1Uk=;
        b=hvkd25vZfBDuvPo6q33UmkfPOceVCVVmb65CH18K1GUDLyKlQ15oUB6XrL0MtXnusD
         JA7S6ecr6aTA9/jpVWkI4nsjHMnxUEnuZub7SALSoC/PwiQRAi1vHP3dBwQWdN3Q8LGj
         u3aQMJNkdFjRXPJl5yoikLOsLuqNkQMNBrZy/33KVY2fKCnPudfJYWMr/GnzFc/7McLP
         HBQ6jRmZiu7NXkCofQeTIm0cirWJR66MLsOcNpcqlDli1/f9c1c257d0Psfg8wEyQdbC
         QCH7vc9Urt48UXscwfp4cSibk4sLYdpp5F+orh6o0aENePXWjMde353uftORuYZovKFn
         TlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fmtjrw2NiRGUWmA+xNP8VLGlgPN22hDvuJd6RREZ1Uk=;
        b=bQPkur3ZOLWaBuXIdgC5Wy3cKSz2j6dAs3peyoEn9f91AQyaVgVUBXy+0YvJlIhEIU
         SKZDUfkv/pVqWXpjTbRXvivO+i+JZa7l8NaVnc0yYJuHiSFIh6pCSAJ1SnNmz2UXPGrP
         iIoQ6JCtI5yXBRyNJoJ1DvuZq3P3vWymPJg2M8ykwxW8FXaJS6aFEkwqEqs1/dziM9vr
         eIThfZBS62P4wbZ7qbxFO05UjAFSl6+7IGINlbViG4rwbdeHOMHljV5XgxEBn7kpPDY9
         kpzjUdANGJwLX2uWOQDfY4HiYN92OHLE4R22EZk7ZjjIPhI3S4FkLFGt/cvM502utdB0
         a5VA==
X-Gm-Message-State: AOAM531vOFE6uvmQgOxIL3THAYhvJlWZSv9fEzRFaw45cXLszBmSeJo1
        nHt0Fx/36YkfpFWkgthWoI5tdNZ1Ww==
X-Google-Smtp-Source: ABdhPJwO+ELc+8ooufEtScS6e9Hlf7aAhZms+rK0szynExIR0CufYA7M7iBCYg4m4ltCXb6qLigMMsz8rA==
X-Received: by 2002:a0c:b681:: with SMTP id u1mr17324890qvd.189.1597731169792;
 Mon, 17 Aug 2020 23:12:49 -0700 (PDT)
Date:   Tue, 18 Aug 2020 08:12:35 +0200
In-Reply-To: <20200818061239.29091-1-jannh@google.com>
Message-Id: <20200818061239.29091-2-jannh@google.com>
Mime-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 1/5] binfmt_elf_fdpic: Stop using dump_emit() on user
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
2.28.0.220.ged08abb693-goog

