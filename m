Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB64DC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFBD20658
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584602467;
	bh=M/+gIwp7Og4UwL0x4S0nuR7p3ZYcveFGq7vavNhUOdg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FvnMBa0+SVWRe+FGm/25oFlAfKHXAjOxK464cuoEbya/IrJ93NhvDJyHUGw+iI2Vc
	 nfOoqj0kLNNDMe5ZjagUuMBjB6Xg9+cKSFP59m6g3EfbicQADWga1uENTEbmwWXnjt
	 3qKo8xiAEytlpPAO26kXUm7aDiE7nKbVqRTVjfEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgCSHVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:21:07 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:32234 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCSHVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:21:06 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 02J7KsFk016064;
        Thu, 19 Mar 2020 16:20:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 02J7KsFk016064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584602455;
        bh=7mIqQ7KnCxUIjZLM3J+eJp954uanv6Sg/97Cuvsmk4c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0/vp+6Jtj1Jf9pHf20OEFJxJhhrn1mdJev9TauRC4vXqodip+RusjM3QIkyoXis1P
         RtKrXhgPnx9bAnwpZGzTGG5qjOR6ezFT3A4rfttICM2tpkpovl58GKrKXRr/UDwdIp
         Y60Pw7ejP9xJxsenNXP3QzbbFAaJKJM06yBOYt8UYlomgIDwETTgCSczKjfjkbfyMG
         2G7y0R/tnf/F1Pn8P0oQrszyDyomurI+yJXSn7LjyaAh+2wc3gd3DDaWYFK8B2Ikut
         ptUU5vmyLHkd9ROwJEXs7oTVUGJHq+VvpoNYz6x61HxCO6afSfVOddEeO4N/OyJO7e
         47EuGeM4lyUOQ==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id t3so425719vkm.10;
        Thu, 19 Mar 2020 00:20:54 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3bozs7GTmtjtF35/3uuxbdfO5DpAvtjM8HBranG2JeWseAEh+d
        3POW/mWp8mv9sv7FCDzoCmhwuQTOot+TT8/Pdqw=
X-Google-Smtp-Source: ADFU+vuCxl0Onrw3EfkEIVZzViurJVhPaxrRYjvLS9lcpMK1fWxXsaeLxg0lCp9XSBbeKesKsW+vyK1hPHtm6/H5GpI=
X-Received: by 2002:a1f:32cf:: with SMTP id y198mr1387267vky.96.1584602453713;
 Thu, 19 Mar 2020 00:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200220110807.32534-1-masahiroy@kernel.org>
In-Reply-To: <20200220110807.32534-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 19 Mar 2020 16:20:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNARHBfp=gkVO9q3pC9o_w9PgNW=5AP95s1MR1tHLJV=0fg@mail.gmail.com>
Message-ID: <CAK7LNARHBfp=gkVO9q3pC9o_w9PgNW=5AP95s1MR1tHLJV=0fg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sparc,x86: vdso: remove meaningless undefining CONFIG_OPTIMIZE_INLINING
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Ping.
Could you pick up this series?


Thanks.


On Thu, Feb 20, 2020 at 8:08 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The code, #undef CONFIG_OPTIMIZE_INLINING, is not working as expected
> because <linux/compiler_types.h> is parsed before vclock_gettime.c
> since 28128c61e08e ("kconfig.h: Include compiler types to avoid missed
> struct attributes").
>
> Since then, <linux/compiler_types.h> is included really early by
> using the '-include' option. So, you cannot negate the decision of
> <linux/compiler_types.h> in this way.
>
> You can confirm it by checking the pre-processed code, like this:
>
>   $ make arch/x86/entry/vdso/vdso32/vclock_gettime.i
>
> There is no difference with/without CONFIG_CC_OPTIMIZE_FOR_SIZE.
>
> It is about two years since 28128c61e08e. Nobody has reported a
> problem (or, nobody has even noticed the fact that this code is not
> working).
>
> It is ugly and unreliable to attempt to undefine a CONFIG option from
> C files, and anyway the inlining heuristic is up to the compiler.
>
> Just remove the broken code.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>
> Changes in v2:
>   - fix a type
>   - add Acked-by
>
>  arch/sparc/vdso/vdso32/vclock_gettime.c     | 4 ----
>  arch/x86/entry/vdso/vdso32/vclock_gettime.c | 4 ----
>  2 files changed, 8 deletions(-)
>
> diff --git a/arch/sparc/vdso/vdso32/vclock_gettime.c b/arch/sparc/vdso/vdso32/vclock_gettime.c
> index 026abb3b826c..d7f99e6745ea 100644
> --- a/arch/sparc/vdso/vdso32/vclock_gettime.c
> +++ b/arch/sparc/vdso/vdso32/vclock_gettime.c
> @@ -4,10 +4,6 @@
>
>  #define        BUILD_VDSO32
>
> -#ifndef        CONFIG_CC_OPTIMIZE_FOR_SIZE
> -#undef CONFIG_OPTIMIZE_INLINING
> -#endif
> -
>  #ifdef CONFIG_SPARC64
>
>  /*
> diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
> index 9242b28418d5..3c26488db94d 100644
> --- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
> +++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
> @@ -1,10 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #define BUILD_VDSO32
>
> -#ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
> -#undef CONFIG_OPTIMIZE_INLINING
> -#endif
> -
>  #ifdef CONFIG_X86_64
>
>  /*
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200220110807.32534-1-masahiroy%40kernel.org.



-- 
Best Regards
Masahiro Yamada
