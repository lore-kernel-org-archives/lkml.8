Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74852C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5429020736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FPRFXl+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgDWSCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbgDWSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:02:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E989EC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:02:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g6so3255164pgs.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTaob3GXlKSGBoHiidXYon5bU7beeaSSUatTlUsNcXM=;
        b=FPRFXl+ySfTpa6qObRY4UYxQfZ0Bk5a6zpBffPArz+JYY8nzILJr5feyZcA05p5Xal
         1l0YBe61kG0ZjeQRTxfXz6HJVC9TmeYaVz1K3ucYtJXndT90Nn6nL0tX9JRK4qKNQbT5
         l9ePIsH2473VC2WTT3Tr0hjRDjhZi1iLERi9h9xaIrhvc/ags9rYBIVcYlnnK+8Hcefl
         YjhlwMrnj1xQLw3kOID7di9fkZbLsH3A8bSEniAdOE+3Si53tyvPFK+FgUqxTJK9zxP1
         bCOCk2FvPHK8cZtg9AqtVdtFfCIIx1SehirMFY0tAGVGf8d+MxCTgoHfkd4qpaF7h712
         XORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTaob3GXlKSGBoHiidXYon5bU7beeaSSUatTlUsNcXM=;
        b=e5zN4Pjd2iUrMlwHqMNmhPdQInAJaTP3OpcyeH7TjO8WCadntbp93LZEUVIVvBiIi6
         psCOCfbpPpwU34IMFhC52r1vKJtmwMHJMS9Td1wPh8fuagsWDvq+4iGDidn+AFiw4UAC
         yGc8rZzo+CaEU70ny8q6CtdCi+9gLwuiC8+u2WOELjGz1s54IC8O0DiILHYVlKquchAx
         pPjme75e0cxtajmjbulcNm2/5SQ973h1V7JiNdce1IesG3p81BHhPsk8c5d/VF6KBNQt
         kh4QVZFq+qgaW6aqG9GT0AZUGfbqWdJvSNBUjk96w63nwG/y4MeE9a4PgLXHKMdY7XRP
         FFxQ==
X-Gm-Message-State: AGi0Pubw05gmVTA3oVa1If5TSli9SNdwhe2UEohUTtURS/3dTYOWvT71
        QqSwLy+9NfeJ5nv2BWTtJL470v3rdOrBJ7f/2js5XQ==
X-Google-Smtp-Source: APiQypIWeuheKFnLWSavqi9t/zLL3BUkESMr888s3W2ijUBXvFH2XLwUXwsigNei3c/4WZqcIhmICSd0VFUWZcleJBQ=
X-Received: by 2002:a62:5c6:: with SMTP id 189mr4877524pff.39.1587664941107;
 Thu, 23 Apr 2020 11:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de> <20200422102309.GA26846@zn.tnic>
 <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
 <20200422192113.GG26846@zn.tnic> <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
 <20200422212605.GI26846@zn.tnic> <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
 <20200423125300.GC26021@zn.tnic> <20200423161126.GD26021@zn.tnic> <20200423173058.GE26021@zn.tnic>
In-Reply-To: <20200423173058.GE26021@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Apr 2020 11:02:09 -0700
Message-ID: <CAKwvOdmmuE=o-bGpraR1rJdzDgf2UYvgcx2-S7cdGSFWWkWurA@mail.gmail.com>
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, next try
To:     Borislav Petkov <bp@alien8.de>
Cc:     Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 10:31 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Apr 23, 2020 at 06:12:24PM +0200, Borislav Petkov wrote:
> > Ok,
> >
> > I have tried to summarize our odyssey so far and here's what I came up
> > with. Just built latest gcc from the git repo and it seems to work.
> >
> > Next I need to come up with a slick way of testing the compiler...
>
> Maybe something like this. Seems to work with both.
>
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Thu, 23 Apr 2020 19:28:28 +0200
> Subject: [PATCH] Check compiler
>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

It's too bad that $(CC) isn't exported yet; IIUC we include the arch
specific Makefiles then later export $(CC).  If that was the case, we
could just use $(CC) in the shell script, rather than passing it along
as an argument.  Oh well.

> ---
>  arch/x86/Makefile             | 4 ++++
>  scripts/x86-check-compiler.sh | 9 +++++++++
>  2 files changed, 13 insertions(+)
>  create mode 100755 scripts/x86-check-compiler.sh
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 00e378de8bc0..38d3eec5062e 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -1,6 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Unified Makefile for i386 and x86_64
>
> +#  Check the compiler
> +sane_compiler := $(shell $(srctree)/scripts/x86-check-compiler.sh $(CC))
> +$(if $(sane_compiler),$(error $(CC) check failed. Aborting),)

If I add `echo "hello world"` to the end of
scripts/x86-check-compiler.sh to verify this stops a build, this is
the error message I would observe:
arch/x86/Makefile:6: *** clang check failed. Aborting.  Stop.

> +
>  # select defconfig based on actual architecture
>  ifeq ($(ARCH),x86)
>    ifeq ($(shell uname -m),x86_64)
> diff --git a/scripts/x86-check-compiler.sh b/scripts/x86-check-compiler.sh
> new file mode 100755
> index 000000000000..b2b5b54b6939
> --- /dev/null
> +++ b/scripts/x86-check-compiler.sh
> @@ -0,0 +1,9 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Check whether the compiler tail-call optimizes across an asm() statement.
> +# Fail the build if it does.
> +
> +echo "int foo(int a); int bar(int a) { int r = foo(a); asm(\"\"); return r; }" |\
> +            $* -O2 -x c -c -S - -o - 2>/dev/null |\
> +            grep -E "^[[:blank:]]+jmp[[:blank:]]+.*"
> --
> 2.21.0
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
Thanks,
~Nick Desaulniers
