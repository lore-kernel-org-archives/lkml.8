Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD01C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC454206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sho0d9Wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404590AbgDCQhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:37:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47028 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgDCQhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=g4YKikYQtnB0AnubBFeONulKSeVzYL29a8W4iHit2bY=; b=sho0d9WtMchVQg/GM9WCgcSHfa
        HyhG4jCxXzEda1YA7ngOuXk44i6naIf0b9lB+v8zQFKec4KRrNa014NPG/390zOvTUbtB8z23dA1r
        kyJMDqe48dACeFcDXJiFz8F4PUF/QsgIVgZzxbO1Xph4nl/GfKMPB+WDBHP/rToRhYGlAvgM8dOC2
        PJPhrVaFiOtZkv5Yqn/IU6WOPyOyVCM3wXJt1m8a0WgPsxLWu+v+kmDCBKr6JlSyWUNm+9kqrXGG8
        OL8LrrZU8FAv3VNgKipNSPAn8OlqtIjl4NAqxntpP+1cc8VVHK8vcoVqPDfuWqaCrzLiHRqxpxAME
        zUewE0SQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKPJm-0003Dx-91; Fri, 03 Apr 2020 16:37:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD5123060FD;
        Fri,  3 Apr 2020 18:37:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C85F22B124BED; Fri,  3 Apr 2020 18:37:16 +0200 (CEST)
Date:   Fri, 3 Apr 2020 18:37:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] module: Harden STRICT_MODULE_RWX
Message-ID: <20200403163716.GV20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We're very close to enforcing W^X memory, refuse to load modules that
violate this principle per construction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/module.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2044,9 +2044,28 @@ static void module_enable_x(const struct
 	frob_text(&mod->core_layout, set_memory_x);
 	frob_text(&mod->init_layout, set_memory_x);
 }
+
+static int module_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+			       char *secstrings, struct module *mod)
+{
+	int i;
+
+	for (i = 0; i < hdr->e_shnum; i++) {
+		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE))
+			return -ENOEXEC;
+	}
+
+	return 0;
+}
+
 #else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 static void module_enable_nx(const struct module *mod) { }
 static void module_enable_x(const struct module *mod) { }
+static int module_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+			       char *secstrings, struct module *mod)
+{
+	return 0;
+}
 #endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 
 
@@ -3378,6 +3397,11 @@ static struct module *layout_and_allocat
 	if (err < 0)
 		return ERR_PTR(err);
 
+	err = module_rwx_sections(info->hdr, info->sechdrs,
+				  info->secstrings, info->mod);
+	if (err < 0)
+		return ERR_PTR(err);
+
 	/* We will do a special allocation for per-cpu sections later. */
 	info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
 
