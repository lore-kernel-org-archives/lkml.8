Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BA3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414662076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHT8gDBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbgEXXA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387863AbgEXXA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:00:57 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1723C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:00:57 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y1so1990237qtv.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CNPpm47b3liyB6mHkF+tklV5gK5Nn1HOeTD74qXYWbA=;
        b=UHT8gDBwEarJYuBp/K8Rk2jAuqtG11We4C/i7dFFtURt5yV/E0vzt4Z0siFF7+KJGq
         bJPnoyn3vrquwn9aB3sgtgoxSQ68ZPuENQis9dAgiKsFEBZ2RkjMWJVaaAv/OEz5Xyuf
         U/aKv5u+Xkvj29v274kPtekrP6FEUozSYkeOAaGn/Sk4GAk67+r9cR2BI78AcM3lnu4j
         Rtl0IbsvYoOPklP9yhJPABlicbq/i79wj+IvXrjjY1QidSoSFvrkKo5pcIfJnR3OM4b9
         bLtQ9nNbsy++Yff8cpF0yacmdlBJlGqmt5Y1iKkQgGuSJ901ECQh7YDm5Aatb4iKr9tY
         yk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CNPpm47b3liyB6mHkF+tklV5gK5Nn1HOeTD74qXYWbA=;
        b=EjfXcyPXEC77f8DFyEDLJn5TDFOzVgo+FqDWr36rwnzr7fLZzrnc6h7n/Hp3RE/GnD
         oEXF02RhI3FLE6Ys5r6rzu/b+4bRfov0uYnIyaUGYGIoT+2BbmvMWIEjs0ZwG64hKFxU
         N24v/CG8IsmKzok3SVx/7UB61VzzgxIAuzyeHCRJfc6j5Ajtnd0Vq33DFjRSFKOx3weA
         OfcQXb1d/sXoL+blCEgvuXjij+hKskhigqR2eI2s4lvk3HxhU8F0BAfMAf2iFyk7e3m+
         6cPrMehdHlajPKZucvPHJtPdIygCxjlgHU7YVSqo3FHSc14DSpiGSle4GQVUA09o7YFp
         6ZMg==
X-Gm-Message-State: AOAM533ygqmNZLX9Ah9kwJOdcoGdF+noI2ZX3696QXskuls7MjB31j8e
        hpmrLyC+l8kodon1J+GVZqI=
X-Google-Smtp-Source: ABdhPJx0M+oibDZtsiiC+sR+8Sr8dqJPfLdaONrtMTe4Mq/sKCLnnKLQ3zfGAHis39I4dylHl5v5eQ==
X-Received: by 2002:ac8:66c3:: with SMTP id m3mr23024790qtp.262.1590361256614;
        Sun, 24 May 2020 16:00:56 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r138sm4004478qka.56.2020.05.24.16.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:00:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 24 May 2020 19:00:54 -0400
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] x86/boot: Add .text.startup to setup.ld
Message-ID: <20200524230054.GA280334@rani.riverdale.lan>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-2-nivedita@alum.mit.edu>
 <20200524221326.zo6zthdqecm2ke5t@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200524221326.zo6zthdqecm2ke5t@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 03:13:26PM -0700, Fangrui Song wrote:
> On 2020-05-24, Arvind Sankar wrote:
> >gcc puts the main function into .text.startup when compiled with -Os (or
> >-O2). This results in arch/x86/boot/main.c having a .text.startup
> >section which is currently not included explicitly in the linker script
> >setup.ld in the same directory.
> >
> >The BFD linker places this orphan section immediately after .text, so
> >this still works. However, LLD git, since [1], is choosing to place it
> >immediately after the .bstext section instead (this is the first code
> >section). This plays havoc with the section layout that setup.elf
> >requires to create the setup header, for eg on 64-bit:
> >
> >    LD      arch/x86/boot/setup.elf
> >  ld.lld: error: section .text.startup file range overlaps with .header
> >  >>> .text.startup range is [0x200040, 0x2001FE]
> >  >>> .header range is [0x2001EF, 0x20026B]
> >
> >  ld.lld: error: section .header file range overlaps with .bsdata
> >  >>> .header range is [0x2001EF, 0x20026B]
> >  >>> .bsdata range is [0x2001FF, 0x200398]
> >
> >  ld.lld: error: section .bsdata file range overlaps with .entrytext
> >  >>> .bsdata range is [0x2001FF, 0x200398]
> >  >>> .entrytext range is [0x20026C, 0x2002D3]
> >
> >  ld.lld: error: section .text.startup virtual address range overlaps
> >  with .header
> >  >>> .text.startup range is [0x40, 0x1FE]
> >  >>> .header range is [0x1EF, 0x26B]
> >
> >  ld.lld: error: section .header virtual address range overlaps with
> >  .bsdata
> >  >>> .header range is [0x1EF, 0x26B]
> >  >>> .bsdata range is [0x1FF, 0x398]
> >
> >  ld.lld: error: section .bsdata virtual address range overlaps with
> >  .entrytext
> >  >>> .bsdata range is [0x1FF, 0x398]
> >  >>> .entrytext range is [0x26C, 0x2D3]
> >
> >  ld.lld: error: section .text.startup load address range overlaps with
> >  .header
> >  >>> .text.startup range is [0x40, 0x1FE]
> >  >>> .header range is [0x1EF, 0x26B]
> >
> >  ld.lld: error: section .header load address range overlaps with
> >  .bsdata
> >  >>> .header range is [0x1EF, 0x26B]
> >  >>> .bsdata range is [0x1FF, 0x398]
> >
> >  ld.lld: error: section .bsdata load address range overlaps with
> >  .entrytext
> >  >>> .bsdata range is [0x1FF, 0x398]
> >  >>> .entrytext range is [0x26C, 0x2D3]
> >
> >Explicitly pull .text.startup into the .text output section to avoid
> >this.
> >
> >[1] https://reviews.llvm.org/D75225
> >
> >Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> >Reviewed-by: Fangrui Song <maskray@google.com>
> >---
> > arch/x86/boot/setup.ld | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> >index 24c95522f231..ed60abcdb089 100644
> >--- a/arch/x86/boot/setup.ld
> >+++ b/arch/x86/boot/setup.ld
> >@@ -20,7 +20,7 @@ SECTIONS
> > 	.initdata	: { *(.initdata) }
> > 	__end_init = .;
> >
> >-	.text		: { *(.text) }
> >+	.text		: { *(.text.startup) *(.text) }
> > 	.text32		: { *(.text32) }
> >
> > 	. = ALIGN(16);
> >-- 
> >2.26.2
> 
> Should .text.startup* be used instead? If -ffunction-sections is used,
> 
> // a.c
> int main() {}
> 
> gcc -O2 a.c                     # .text.startup
> gcc -Os a.c                     # .text.startup
> 
> gcc -O2 -ffunction-sections a.c # .text.startup.main
> gcc -Os -ffunction-sections a.c # .text.startup.main

It's probably unlikely we'll use function-sections on the setup code,
but *(.text.*) might be more future-proof, since gcc/clang might grow
the ability to stick code into .text.hot or .text.unlikely etc
automatically.

> 
> -----
> 
> In case anyone wants to CC a GCC dev for the citation that 
>   main compiles to `.text.startup` in -Os or -O2 mode, I have a small request
>   that `.text.startup.` probably makes more sense. See
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=95095
> 
> I made an llvm change recently https://reviews.llvm.org/D79600
