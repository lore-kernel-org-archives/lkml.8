Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00B4C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895B820656
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 19:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/GwqTcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgBMTVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 14:21:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45658 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgBMTU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:20:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so2712705pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 11:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tWByifXTfTLSvTHBdOgNdc61Tx0bKdK4+4EitI5eUyQ=;
        b=g/GwqTcHMujuRPSIGkaNZOKKUzu6n0k5JDa+0GvfOcsjntn3041wOpkGKhUTJXN/KS
         +q29YzqJsGlxpDiPtVLLf8yMg2JyKeda1WCQYLmpksHKD3qONuAeRrpf5ovqFvqL4EMt
         SmrYagWiQuZ+Qt1Rkfp3tmKOYLgVftLiXmYms7G5UF6QzhlW9kQI9zKnGx9APrFfgS3e
         SkuW2HXzPOctNP5sX+crPK6Deo0ziia5TyqH+0DFOMeaZt++uJyTDro6Q4LvELSMjd5f
         CuHYMyw2bE6530kJU1TaSw8DshOvrrc2ikC60zVKlCFchLZQSSUw4t3QY4vwdfrZFxmv
         eOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tWByifXTfTLSvTHBdOgNdc61Tx0bKdK4+4EitI5eUyQ=;
        b=lVKcRP1u+semaEKwcG9m1fHcJ/iCiS1AD1KteBlSY26AsS3BcDGGC0ihG1dkmvB2cM
         BIgtRHvTQ51CkjFdSc9KxXEYNC4iVmnWrlHF392UEz7S5wWYy01OMIecgMVv54mZx54k
         DQLxxEKSFWz6BCfiK/1DpyRCeq6KYY8PX67/OnvIcZIt69PjnYWMejdiiSC5lMfqSudT
         Dau/PkFbPIhXUsF/7rNxbkHyJ2NoVC7b+sq3ChJ1200ZICzHcmOWMiRbDrKOU09HXl7L
         GBYS0ViK3Na9lDlWHAarL/yxnvNmBEnIHJ6xtxaXUMQaV/eVf7dkXHKfIf+14DnnxtrS
         ah5w==
X-Gm-Message-State: APjAAAXG8ol3gArJZwOrZxIjzzBPlkYpI7tKeIwh9aeTREhGKnaHN9hp
        g19J+KOkuMuP+YM5zfZ+9qtaew==
X-Google-Smtp-Source: APXvYqw6MsMPsfumIN7OCZb8q/n+/Ph7J355QCqIqL3HOpt3Eci4dPMBhU+ezBKgDB9DoFSL4wXNtw==
X-Received: by 2002:a17:90a:2545:: with SMTP id j63mr7048904pje.128.1581621658693;
        Thu, 13 Feb 2020 11:20:58 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id l37sm3331916pjb.15.2020.02.13.11.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 11:20:58 -0800 (PST)
Date:   Thu, 13 Feb 2020 11:20:55 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     jpoimboe@redhat.com, peterz@infradead.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: ignore .L prefixed local symbols
Message-ID: <20200213192055.23kn5pp3s6gwxamq@google.com>
References: <20200213184708.205083-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200213184708.205083-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-13, Nick Desaulniers wrote:
>Top of tree LLVM has optimizations related to
>-fno-semantic-interposition to avoid emitting PLT relocations for
>references to symbols located in the same translation unit, where it
>will emit "local symbol" references.
>
>Clang builds fall back on GNU as for assembling, currently. It appears a
>bug in GNU as introduced around 2.31 is keeping around local labels in
>the symbol table, despite the documentation saying:
>
>"Local symbols are defined and used within the assembler, but they are
>normally not saved in object files."

If you can reword the paragraph above mentioning the fact below without being
more verbose, please do that.

If the reference is within the same section which defines the .L symbol,
there is no outstanding relocation. If the reference is outside the
section, there will be an R_X86_64_PLT32 referencing .L

>When objtool searches for a symbol at a given offset, it's finding the
>incorrectly kept .L<symbol>$local symbol that should have been discarded
>by the assembler.
>
>A patch for GNU as has been authored.  For now, objtool should not treat
>local symbols as the expected symbol for a given offset when iterating
>the symbol table.

Agree. binutils 2.31~2.34 will be affected. objtool has to work around
the existing releases.

>commit 644592d32837 ("objtool: Fail the kernel build on fatal errors")
>exposed this issue.
>
>Link: https://github.com/ClangBuiltLinux/linux/issues/872
>Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html#Symbol-Names
>Link: https://sourceware.org/ml/binutils/2020-02/msg00243.html
>Link: https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/286292010
>Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
>Debugged-by: Fangrui Song <maskray@google.com>
>Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
>Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>---
>Build tested allyesconfig with ToT Clang and GCC 9.2.1.
>Boot tested defconfig with ToT Clang and GCC 9.2.1.
>
> tools/objtool/elf.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
>index edba4745f25a..9c1e3cc928b0 100644
>--- a/tools/objtool/elf.c
>+++ b/tools/objtool/elf.c
>@@ -63,7 +63,8 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
>
> 	list_for_each_entry(sym, &sec->symbol_list, list)
> 		if (sym->type != STT_SECTION &&
>-		    sym->offset == offset)
>+		    sym->offset == offset &&
>+		    strstr(sym->name, ".L") != sym->name)

!strncmp(sym->name, ".L", 2)

.L in the middle of a symbol name may be rare, though.

> 			return sym;
>
> 	return NULL;
>-- 
>2.25.0.225.g125e21ebc7-goog
>
