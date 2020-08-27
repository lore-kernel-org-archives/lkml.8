Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69873C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431CB22B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mwLQkW2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgH0PKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbgH0Lu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:50:58 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD7CC06123D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:52 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id gf10so2474595ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=37TD1tOgbExZK4EAyJ2auNMattkG66IuBeoEm2InRhU=;
        b=mwLQkW2eu135cvu7FtBkDyZdvLbrR4ESlq2qN0k/6PXfOdym4GlJSHKkQgZRQIApvg
         TNU2TA7NTgAq8W1RjGrPU5cfU2v13XgwY1Y286YXZR1RIgU1rBATGkuwy3UnVnEfzVzS
         h9gBAOJscFv841RTN5OFqgz0ZDFn2mr100yymtqXnZ90QYDN1zdwYNj0w3mZsZbXRoJm
         ApvuTLxP25AdJ3uWDj7M1DUDci1qtgVkkFgUVcI2lcMwK3aGaOSzeLI4NpF3Su/JRTmH
         cP3DWhLkdT8DKJZ11vVYL16N1ngL13i5DCLHElAc6DNRzZ2vCnjXQVgEWJqe8SDAXd7p
         Xrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=37TD1tOgbExZK4EAyJ2auNMattkG66IuBeoEm2InRhU=;
        b=HywBwjdhWeWARdkpqH30pYM/E2ZvBeLW0/UBy2vtEGcHm1dOeoV7Fj8PDu49GWjm70
         RIBXs87AFKopSwhW9Hyjc8ekusnbHh+QFw/gBFce4U49Cb+sENHqPuLi4PHq+KqRfPUx
         gNPWgxUhhi31MVYrW8zQ7S/eDFgC7s9hRbT7Ps57s0lvZAKqdHEO9eOM5oRSUkHUql5+
         0cA/ZCj7zZbDHazoOPpG1eFu68piYjURlfmvzNAuUawS8W15FH+vcXMISCCtWqe4E447
         RP9Mr2OWvyu/TqGy20hx2LK33a/egzFraLcj9njbRDDEXvcMKiksK5A0UyueMGEP90HP
         9OuA==
X-Gm-Message-State: AOAM530ohqwsLq6gJF/1Zv7FPTdzmEbOnUIe9hWZ9sbvtC2k44TeX3ft
        FZi95vWe7sCxqQoh9Zecym0OLwjfNg==
X-Google-Smtp-Source: ABdhPJwLTnajnvbze0tWFXuS4/QQ3qxi89bpi+PbXi3ya8YRbpq6nxuMIwJcqnNQknEdlR+GAxHngz9mBw==
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:a17:906:c7cd:: with SMTP id
 dc13mr20150907ejb.446.1598528991398; Thu, 27 Aug 2020 04:49:51 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:49:28 +0200
In-Reply-To: <20200827114932.3572699-1-jannh@google.com>
Message-Id: <20200827114932.3572699-4-jannh@google.com>
Mime-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v5 3/7] coredump: Refactor page range dumping into common helper
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
2.28.0.297.g1956fa8f8d-goog

