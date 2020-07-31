Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0018FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAA7208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFtthBoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbgGaSh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbgGaShu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:37:50 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89BAC061756
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:37:49 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q19so11996682qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zM3dgZxHGwtay7ZIQFv5BfEN+wOLWmAIUQFsf0Z3VmM=;
        b=BFtthBoRgol9XG317wAbOOs8b3fmBcxnN4gRYza0RdTrAsjfH3ZwO3XGL+rCXTtCZ4
         F95dChkyhFDXLdpt1lGuZLUOpz/r7lH4pM472mxsHfNpc/YAhxPS2LG2Yt+AQ6vUZ2nG
         q5dzLReYFQw5ZNt5VCCiKG17ZCMVs/5OIqgITys2e16+h7LA4NQIZwXcOZ0bigIsBn43
         +hhYBgkK4U4pdRnEEpP6mgN4dvfKgzuUt4el9T0LEdioVrYohOwN2cJQNc8pPqKzjug+
         VyEi2Q1pRgqkXgNvd5yQrTrhhaMy8Yx/AjjGaDTZlgqlfKP84hr5gHxIP7NHpi3Z8pzv
         ek+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zM3dgZxHGwtay7ZIQFv5BfEN+wOLWmAIUQFsf0Z3VmM=;
        b=mHwD+leqzMZG4w8Lxrtp+MDvMR/2P4h10z0987rZ9TgUKcSTmSgKhesT4yQXTdyYIK
         T4CqrhfAZuz2iGRlyXsm5rcWQ32gvu24m4VZDFZlFLp9Yw89Qg1cmBYczCZ76HlgZmVp
         UoB1cjFIA/loliEQ/xP+KMdkJppqFPIrD3Di8fadrYibtPHYMK5+5A5TbYK+ZcBS44KG
         EJw2oWY2OeHZycRQBxOlEkGLX67U0GZS5EHQbtFplqcJIpBACvW/NFsROFIPjlZMRtH6
         aXC2lACBDLf8RI+b2MZtd4w9/vjvSp9qRF/7xNFE2VZkXoGM9G50m/1Qt/AjwHBqsxuA
         Wysg==
X-Gm-Message-State: AOAM533qaK9bFmL147C7+ii7ZM2xozSPOEloiZ9fZPmTCeVteVKq6FNb
        Z9hukVYCRFWrgUuKXAkhu/1/c8107aQqdM0=
X-Google-Smtp-Source: ABdhPJw4wK2solpSAa9OS8kiQw3oru0YdaMJ2eowgQYyITB1BZNtnL6yi4fCRgDUasoEcAIU5TCh2fggQDEOMMY=
X-Received: by 2002:a0c:fa85:: with SMTP id o5mr5404015qvn.91.1596220669093;
 Fri, 31 Jul 2020 11:37:49 -0700 (PDT)
Date:   Fri, 31 Jul 2020 14:37:43 -0400
In-Reply-To: <20200731183745.1669355-1-ckennelly@google.com>
Message-Id: <20200731183745.1669355-2-ckennelly@google.com>
Mime-Version: 1.0
References: <20200731183745.1669355-1-ckennelly@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 1/2 v2] fs/binfmt_elf: Use PT_LOAD p_align values for suitable
 start address.
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>
Cc:     David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>,
        Hugh Dickens <hughd@google.com>,
        Andrew Morton <akpm@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ELF loading mechancism provides page-aligned mappings.  This
can lead to the program being loaded in a way unsuitable for
file-backed, transparent huge pages when handling PIE executables.

For binaries built with increased alignment, this limits the number of
bits usable for ASLR, but provides some randomization over using fixed
load addresses/non-PIE binaries.

Tested: verified program with -Wl,-z,max-page-size=0x200000 loading
Signed-off-by: Chris Kennelly <ckennelly@google.com>
---
 fs/binfmt_elf.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 9fe3b51c116a6..24e80302b497d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -421,6 +421,25 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
 	return 0;
 }
 
+static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
+{
+	unsigned long alignment = 0;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		if (cmds[i].p_type == PT_LOAD) {
+			/* skip non-power of two alignments */
+			if (cmds[i].p_align & (cmds[i].p_align - 1))
+				continue;
+			if (cmds[i].p_align > alignment)
+				alignment = cmds[i].p_align;
+		}
+	}
+
+	/* ensure we align to at least one page */
+	return ELF_PAGEALIGN(alignment);
+}
+
 /**
  * load_elf_phdrs() - load ELF program headers
  * @elf_ex:   ELF header of the binary whose program headers should be loaded
@@ -1008,6 +1027,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		int elf_prot, elf_flags;
 		unsigned long k, vaddr;
 		unsigned long total_size = 0;
+		unsigned long alignment;
 
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
@@ -1086,6 +1106,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				load_bias = ELF_ET_DYN_BASE;
 				if (current->flags & PF_RANDOMIZE)
 					load_bias += arch_mmap_rnd();
+				alignment = maximum_alignment(
+					elf_phdata, elf_ex->e_phnum);
+				if (alignment)
+					load_bias &= ~(alignment - 1);
 				elf_flags |= MAP_FIXED;
 			} else
 				load_bias = 0;
-- 
2.28.0.163.g6104cc2f0b6-goog

