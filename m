Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15DAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F282070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHfiLahn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGXRUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgGXRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:20:30 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13705C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:20:30 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s127so6728075qkf.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IP2qzQ0kBQKVB32LO+oN88QxnZJT0sW8a2ViufOQFgg=;
        b=vHfiLahnORV8Mgzz/bB6y1WEWJGOiMoOdmyjw0j5lDyRuwUP6p0zp44Af9L9uhCx0j
         VUCeSS8G4lqXx4BxAPD7RVi87A155zHhlDCcZ6fkJ1kj8Otfn9ympj6TdEX09utbHa2v
         rivBFNYBSgFh4OopMGUgdlNq6pZBc3/pkru8DviJ9rgHvEK3p4xDhlURVfCTOdJ2hex1
         BIPNNLcg+9WZKZ7cxIeyZW4pDh1gb6VROcP9ULS0Wrt6dBlU0ZIjjnQIl/da44FHx4GA
         7LDU6+Df1krma+8qoX+MVawGkmU/XY1Ghc6ivIfamSAOxwg1mNDEbQu6nZG4i5ow/fhQ
         MOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IP2qzQ0kBQKVB32LO+oN88QxnZJT0sW8a2ViufOQFgg=;
        b=TF0DuYz+NfTGs4bx83JCv5HlXWrRU0KXY6MP9wcjytiIdVyH0BAAI/xWyF2KZR+gdy
         zh7GGZOHib8rLkqhmgCS6u0JFyCJVrIOhLDNsqu3jPDW6KuMhHt/P7XClktOswZbWMfE
         OFf63cUgcH8t93yxKNQ7BxgPic3+VnL4deY2NXV9FK40ImxY41ONh+3akfG1hpTXIs4k
         hAp5rvwRPB6OIfP/c+qbtvGTXkczVfL5rprNShFV2/kxAxaXTkzbqiC8nCDOvKmStmxZ
         qab0pJe5QPwbhqdOEr+xV93/3Up7CXZLmRm6hqDk/wc701z2oS5wgFF/Bz5nVbt79IT4
         pANA==
X-Gm-Message-State: AOAM5332OHtbK7HGuJIdKr5IUv8VQl7A9DYSgJlTIGHfzPLEzOqwh7e6
        CrZsqgzXwYX/mUPbc4bxVv49OXJjZ3zBqyg=
X-Google-Smtp-Source: ABdhPJyZThuJVZdmQqMDtzLbWwFTQjCM1XIfrvE9C7Og3e6GrQ5DsYrsRk+AFDkdpz9Tnf4eTL0jz4bGa0rvBhc=
X-Received: by 2002:ad4:424a:: with SMTP id l10mr10810463qvq.29.1595611229246;
 Fri, 24 Jul 2020 10:20:29 -0700 (PDT)
Date:   Fri, 24 Jul 2020 13:20:16 -0400
In-Reply-To: <20200724172016.608742-1-ckennelly@google.com>
Message-Id: <20200724172016.608742-2-ckennelly@google.com>
Mime-Version: 1.0
References: <20200724172016.608742-1-ckennelly@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 1/1] fs/binfmt_elf: Use PT_LOAD p_align values for suitable
 start address.
From:   Chris Kennelly <ckennelly@google.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        David Rientjes <rientjes@google.com>,
        Ian Rogers <irogers@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ELF loading mechancism provides page-aligned mappings.  This
can lead to the program being loaded in a way unsuitable for
file-backed, transparent huge pages when handling PIE executables.

Tested: verified program with -Wl,-z,max-page-size=0x200000 loading
Signed-off-by: Chris Kennelly <ckennelly@google.com>
---
 fs/binfmt_elf.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f4713ea76e827..83fadf66d25ef 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -418,6 +418,25 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
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
@@ -883,6 +902,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		int elf_prot, elf_flags;
 		unsigned long k, vaddr;
 		unsigned long total_size = 0;
+		unsigned long alignment;
 
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
@@ -960,6 +980,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
2.28.0.rc0.105.gf9edc3c819-goog

