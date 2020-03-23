Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69853C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3332073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjFqGhYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCWU7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:59:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45975 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWU7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:59:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id b9so6436733pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xqhu8EFAw1B+vwPIY2LLkJ+U/Fss8OnI2hLctcUjwWw=;
        b=pjFqGhYpMPSKekBGIJuJa2qADVG1c18oqoewRykYs4MG5SBj0kbyj7pjvxQZ3bCzEO
         CfflW9qHv4AWg5DUuoEf6ZzUplBVxMnFp2xo2NEjRuXHJznW0aXLwcbbc6JknsbKjxXS
         Ms3z6QA654G22zDfOQuqFWq2a9T/U/cPfBHupqdeDbTOnpBTwQO7EGKMaqICK4jN3Y90
         FVJcOr18V5bdUqQtCOVRSl2onAHCQ0qlYc5wfEf9hmbuOFv51XkE9MqY0+oRxEW4ngl5
         /H0q4svXU9woiJaAYxl4JH4Lav6y4e+L5o78FEso8fFtkmtJX1xpJcuAqMFYuEDmRkaE
         8Djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xqhu8EFAw1B+vwPIY2LLkJ+U/Fss8OnI2hLctcUjwWw=;
        b=YWmcbmJLaNaYf4aimmmxTwOFgV1szc9nYg2alQsxWCjp5xM0HKnwfueFd6HOuO9J0l
         ibCkrMV42FdgliStbY4D6npxotmiQNLJVB1ioQ9i8O1sUl2yl4mZZ/h2xbfW28PU/lVm
         FHeK//vY/c1CUrbLq1m0CgfHZyheD3qgnU+BRD6ocZQ6iar8aO1Rrv6AxIWcd0tLdBwG
         aFk/8QbixSzsNf4lJ9GT4/ueDSurP7VInsgviJkp4LuQ+dvhHBu8TibUE4w7EOJUQziK
         WrgYGs8sqm7cp3JtsNkCZHE+GWAkHEz1b2kZv8Q359bUR97c9FnGejWc7uM4UceR0tu6
         nLpw==
X-Gm-Message-State: ANhLgQ2d7p/Twp1BacfcouUwYU+JnzHpNqA9BVVgvfc5B2ztUiBJ9KVU
        rNeiC29QD5FgZJlxmT7b7752LGaH1ho8kaZu7L3Ccg==
X-Google-Smtp-Source: ADFU+vujXi16+EeUy5CAyTl7xv4wIRoWyv1OHrHO9pU4LxSbOgj0NEhNTs5BmMka/Z/ccVEyZPQHZW+rOAOL53eQa28=
X-Received: by 2002:a17:902:820a:: with SMTP id x10mr19727811pln.179.1584997158821;
 Mon, 23 Mar 2020 13:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200323020844.17064-1-masahiroy@kernel.org> <20200323020844.17064-5-masahiroy@kernel.org>
In-Reply-To: <20200323020844.17064-5-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Mar 2020 13:59:06 -0700
Message-ID: <CAKwvOd=PgZcYrkf6urQGhjS0Ti7_nJ+hRswQSjo9MvcWGBCE=w@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86: remove always-defined CONFIG_AS_CFI_SECTIONS
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 7:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> CONFIG_AS_CFI_SECTIONS was introduced by commit 9e565292270a ("x86:
> Use .cfi_sections for assembly code").
>
> We raise the minimal supported binutils version from time to time.
> The last bump was commit 1fb12b35e5ff ("kbuild: Raise the minimum
> required binutils version to 2.21").

Looks like 2.21 was released in 2010, binutils gained support for
cfi_sections in 2009.  There's been some bug fixes to its support over
the years, but we can always add more specific checks later if
necessary.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> I confirmed the code in $(call as-instr,...) can be assembled by the
> binutils 2.21 assembler and also by LLVM integrated assembler.
>
> Remove CONFIG_AS_CFI_SECTIONS, which is always defined.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/x86/Makefile             | 6 ++----
>  arch/x86/include/asm/dwarf2.h | 2 --
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index dd275008fc59..e4a062313bb0 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -177,8 +177,6 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
>         KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
>  endif
>
> -cfi-sections := $(call as-instr,.cfi_sections .debug_frame,-DCONFIG_AS_CFI_SECTIONS=1)
> -
>  # does binutils support specific instructions?
>  asinstr += $(call as-instr,pshufb %xmm0$(comma)%xmm0,-DCONFIG_AS_SSSE3=1)
>  avx_instr := $(call as-instr,vxorps %ymm0$(comma)%ymm1$(comma)%ymm2,-DCONFIG_AS_AVX=1)
> @@ -188,8 +186,8 @@ sha1_ni_instr :=$(call as-instr,sha1msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA1_NI=
>  sha256_ni_instr :=$(call as-instr,sha256msg1 %xmm0$(comma)%xmm1,-DCONFIG_AS_SHA256_NI=1)
>  adx_instr := $(call as-instr,adox %r10$(comma)%r10,-DCONFIG_AS_ADX=1)
>
> -KBUILD_AFLAGS += $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> -KBUILD_CFLAGS += $(cfi-sections) $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> +KBUILD_AFLAGS += $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
> +KBUILD_CFLAGS += $(asinstr) $(avx_instr) $(avx2_instr) $(avx512_instr) $(sha1_ni_instr) $(sha256_ni_instr) $(adx_instr)
>
>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>
> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
> index d6697aab5706..5d3e7507cbbd 100644
> --- a/arch/x86/include/asm/dwarf2.h
> +++ b/arch/x86/include/asm/dwarf2.h
> @@ -22,7 +22,6 @@
>  #define CFI_ESCAPE             .cfi_escape
>  #define CFI_SIGNAL_FRAME       .cfi_signal_frame
>
> -#if defined(CONFIG_AS_CFI_SECTIONS)
>  #ifndef BUILD_VDSO
>         /*
>          * Emit CFI data in .debug_frame sections, not .eh_frame sections.
> @@ -39,6 +38,5 @@
>           */
>         .cfi_sections .eh_frame, .debug_frame
>  #endif
> -#endif
>
>  #endif /* _ASM_X86_DWARF2_H */
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200323020844.17064-5-masahiroy%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
