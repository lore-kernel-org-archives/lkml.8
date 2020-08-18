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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A687AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816AB2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScWCp387"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHRGNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgHRGM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:12:58 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17988C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 23:12:58 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 195so12440619qke.14
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 23:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BQ6deNARx/tr049/coZN1ctnBsmm6qw6/g2K/OuqjPA=;
        b=ScWCp387mFONX1TRBXREQ33OJC79OiceR3AT7pe+fbYNruJ/cF79js7PVNcKdsqPDZ
         BTp7uhi1083v5EBt6Uppic6CT6DkZCElwoMRkhSSYggi6vKf9l4WpEIlB6RERBTJMNdM
         fZiO3/eIHW3UfOorwOBSFG5F2PsfxLoTtZ87LvIKmkzN27a8Xuwr7Y31057R2GF+aJHX
         93E/1L9ITCo5UiEqejSGzxniroi3FHAYidFVlj72bQrHMtWuBkFNxUEW9YMRz2enbLSV
         G8/0r/4ylw5EbaG706fv6kMwkKApmrMMjh8P8HRffVbxfy0gyZcd1IpInr1gQGk7qJS5
         vjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BQ6deNARx/tr049/coZN1ctnBsmm6qw6/g2K/OuqjPA=;
        b=L8xTn8+OKeRlU405Yj1lmOLVTdPBTvAgjXLaNzD9QVEXb2joQlEblEqVt0iTUYnyco
         v9Ckgzjb+dK1Ci90+BE3gNt/rxVkIkwJB1uNX768x+t2ELlOLAF7CtKnjqs/Xeo/23Mt
         ZBrkmN0VlAdnE9nEmrj7dWLHHDdt3KiSg0LrTU55dEQmA7zEvLv59yj9V0JlBO2F3oY4
         mCW4Xbs76eOHzjjcL+kMRBlmmZfcpT1H4OBGzQ8m1UkMuMWQf0BxDjOQjeH603uFtDV+
         2HDdJAoj+ezrsTNRAWuNYLMl/zroRmeTwvi18evnaSpEm3dLJzr7Wd3zVdk1erpL9bqd
         FGww==
X-Gm-Message-State: AOAM530/HEMmCbobA7mbMexoo1VJWUL+v4qSys2pqMEhVNsrKrjc6jl2
        U2F9fyG55LiH/v0i9MLC5tlqfXjpsQ==
X-Google-Smtp-Source: ABdhPJyh/6VtzjvXkSvgr3+1RQjgt+P+1s2URdDDGUndrNNa2/EOYOf/bFUg8TykIbv7qlhxxhrVQHJBzA==
X-Received: by 2002:ad4:4c0a:: with SMTP id bz10mr17004710qvb.78.1597731177252;
 Mon, 17 Aug 2020 23:12:57 -0700 (PDT)
Date:   Tue, 18 Aug 2020 08:12:37 +0200
In-Reply-To: <20200818061239.29091-1-jannh@google.com>
Message-Id: <20200818061239.29091-4-jannh@google.com>
Mime-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 3/5] coredump: Refactor page range dumping into common helper
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

Both fs/binfmt_elf.c and fs/binfmt_elf_fdpic.c need to dump ranges of pages
into the coredump file. Extract that logic into a common helper.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/binfmt_elf.c          | 22 ++--------------------
 fs/binfmt_elf_fdpic.c    | 18 +++---------------
 fs/coredump.c            | 34 ++++++++++++++++++++++++++++++++++
 include/linux/coredump.h |  2 ++
 4 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13d053982dd7..5fd11a25d320 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2419,26 +2419,8 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
 			vma = next_vma(vma, gate_vma)) {
-		unsigned long addr;
-		unsigned long end;
-
-		end = vma->vm_start + vma_filesz[i++];
-
-		for (addr = vma->vm_start; addr < end; addr += PAGE_SIZE) {
-			struct page *page;
-			int stop;
-
-			page = get_dump_page(addr);
-			if (page) {
-				void *kaddr = kmap(page);
-				stop = !dump_emit(cprm, kaddr, PAGE_SIZE);
-				kunmap(page);
-				put_page(page);
-			} else
-				stop = !dump_skip(cprm, PAGE_SIZE);
-			if (stop)
-				goto end_coredump;
-		}
+		if (!dump_user_range(cprm, vma->vm_start, vma_filesz[i++]))
+			goto end_coredump;
 	}
 	dump_truncate(cprm);
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index a53f83830986..76e8c0defdc8 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1534,21 +1534,9 @@ static bool elf_fdpic_dump_segments(struct coredump_params *cprm)
 		if (!maydump(vma, cprm->mm_flags))
 			continue;
 
-		for (addr = vma->vm_start; addr < vma->vm_end;
-							addr += PAGE_SIZE) {
-			bool res;
-			struct page *page = get_dump_page(addr);
-			if (page) {
-				void *kaddr = kmap(page);
-				res = dump_emit(cprm, kaddr, PAGE_SIZE);
-				kunmap(page);
-				put_page(page);
-			} else {
-				res = dump_skip(cprm, PAGE_SIZE);
-			}
-			if (!res)
-				return false;
-		}
+		if (!dump_user_range(cprm, vma->vm_start,
+				     vma->vma_end - vma->vm_start))
+			return false;
 	}
 	return true;
 }
diff --git a/fs/coredump.c b/fs/coredump.c
index 5e24c06092c9..6042d15acd51 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -876,6 +876,40 @@ int dump_skip(struct coredump_params *cprm, size_t nr)
 }
 EXPORT_SYMBOL(dump_skip);
 
+#ifdef CONFIG_ELF_CORE
+int dump_user_range(struct coredump_params *cprm, unsigned long start,
+		    unsigned long len)
+{
+	unsigned long addr;
+
+	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
+		struct page *page;
+		int stop;
+
+		/*
+		 * To avoid having to allocate page tables for virtual address
+		 * ranges that have never been used yet, and also to make it
+		 * easy to generate sparse core files, use a helper that returns
+		 * NULL when encountering an empty page table entry that would
+		 * otherwise have been filled with the zero page.
+		 */
+		page = get_dump_page(addr);
+		if (page) {
+			void *kaddr = kmap(page);
+
+			stop = !dump_emit(cprm, kaddr, PAGE_SIZE);
+			kunmap(page);
+			put_page(page);
+		} else {
+			stop = !dump_skip(cprm, PAGE_SIZE);
+		}
+		if (stop)
+			return 0;
+	}
+	return 1;
+}
+#endif
+
 int dump_align(struct coredump_params *cprm, int align)
 {
 	unsigned mod = cprm->pos & (align - 1);
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 7a899e83835d..f0b71a74d0bc 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -16,6 +16,8 @@ extern int dump_skip(struct coredump_params *cprm, size_t nr);
 extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
 extern int dump_align(struct coredump_params *cprm, int align);
 extern void dump_truncate(struct coredump_params *cprm);
+int dump_user_range(struct coredump_params *cprm, unsigned long start,
+		    unsigned long len);
 #ifdef CONFIG_COREDUMP
 extern void do_coredump(const kernel_siginfo_t *siginfo);
 #else
-- 
2.28.0.220.ged08abb693-goog

