Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E6BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D58206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AL2O2+Mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFJV2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgFJV2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:28:10 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F27C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:28:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a45so2413143pje.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwps3c311yg/MfAkhuFrXNzWVeR3Kl/1PpIlzVubD9w=;
        b=AL2O2+Mq9RUcdHaCOovRWqzV5qa8/KYWOREbqMw8pLmJCR5vQoddwquiTZ91KjfhOs
         p+3ac1kKvIUSGM5Ss0Ko5eUHizcJMkt07eFm2zS2cNr2K9ansB/jNw9Z867A2Cru+cXL
         vDqO/yqjmR0+As98a9cqsu3CUDj9nZp9hblnzKGsq32xcm8AUzMPAo3o56ivjcyQIhFv
         +sxoLTzbIlIvZPUSCtn8WTQfYKVDj7sCSifiyjt2x7wFlE+bsctxEAiWG4lo+y2hx86Y
         X+U9iZEEQGMe0GoE+Yeto4PdJKum8Yn6JaAn0Q7zTFUFowBhhnAsQhgdpZ2n3ZQCw+NT
         Ttpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwps3c311yg/MfAkhuFrXNzWVeR3Kl/1PpIlzVubD9w=;
        b=PkyVDAujEOVQjg+0YZqVTgS0tOG9y0MkPsf8FbaDbF/MoG/SnlmA4ZTL5pQvV7PR7b
         yyPm186vY1BI8OjolOK+a20VsvzRoH56u944ctLc4AaKT1k8b16GJskdZyLvrlpinOjD
         2PrjNXrmPczJowYBlpWJ7piOUeiFNprgB8VngycD8IzEc2X0hnCjq8yeATiVSbbimgX2
         ZZdWkzLPpjDX95xBwSMPEMd23r09YBJuk8QDj/29Ce0ZO+X2Q71oQeBmpxnpXbwb8jZg
         3ERqH/D4xU4ZSt2PYS7wmCSU+JeuL+Vl1ks8oQc3gkmKLBUdSzXjfPl52blDEFHlI/PM
         hdTg==
X-Gm-Message-State: AOAM533xL4ybKB5azPe1JYJY0KAT97RTaFVs0d45NRzfcEFjHjGbHAnv
        SY8AuJUwlDMP6Kh/QozbZ4zj/Hkck9KjZ/nNqu55KQ==
X-Google-Smtp-Source: ABdhPJzQoc5g0+hNPGe2UT6wYxUXchnwfRw6R7nV2592yFe/w2hzyQchCtCwUqCw0SWrSTEaACTbvLknYLjLoAJfyzI=
X-Received: by 2002:a17:902:7201:: with SMTP id ba1mr4515817plb.223.1591824487405;
 Wed, 10 Jun 2020 14:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200610063715.v2qrqvwtegdxdwzl@google.com> <20200610191106.2662548-1-nivedita@alum.mit.edu>
In-Reply-To: <20200610191106.2662548-1-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Jun 2020 14:27:55 -0700
Message-ID: <CAKwvOdnF9xhrs+FP4QXo6uXxgHMfHO8NvPYs1=KDE2ZyhCw2QQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Improve compressed debug info support detection
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 12:11 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Commit
>   10e68b02c861 ("Makefile: support compressed debug info")
> added support for compressed debug sections.
>
> Support is detected by checking
> - does the compiler support -gz=zlib
> - does the assembler support --compressed-debug-sections=zlib
> - does the linker support --compressed-debug-sections=zlib
>
> However, the gcc driver's support for this option is somewhat
> convoluted. The driver's builtin specs are set based on the version of
> binutils that it was configured with, and it reports an error only if
> the assembler (or linker) is actually invoked.
>
> The cc-option check in scripts/Kconfig.include does not invoke the
> assembler, so the gcc driver reports success even if it does not support
> the option being passed to the assembler.

Thanks for the patch! In that case, should we consider dropping the
cc-option check from the Kconfg then, too?

It seems it would help for clang-4 and older, since they do error
about the unknown option, but I'm not too worried about trying to
support that version of Clang with this config.

> Combined with an installed
> version of binutils that is more recent than the one the compiler was
> built with, it is possible for all three tests to succeed, yet an actual
> compilation with -gz=zlib to fail.

It kind of sounds like the assembler must be invoked to verify this
will work for the cflags then?

>
> Moreover, it is unnecessary to explicitly pass
> --compressed-debug-sections=zlib to the assembler via -Wa, since the
> driver will do that automatically.
>
> Convert the as-option to just -gz=zlib, simplifying it as well as
> performing a better test of the gcc driver's capabilities.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Does this imply all feature tests of as-option with -W(comma)... are
broken?  IIUC, then the assembler is still not invoked, much as in
this case?  (as in they all pass when maybe they should not?)  (or
based on below, maybe just the Kconfig from 74afda4016a74 in
arch/arm64/Kconfig, AS_HAS_PAC)

In the other thread, you discussed -c vs -s.  It looks like -c is used
for as-option, so I expect the assembler to be invoked.

Maybe we should look at the mismatch between Kbuild and Kconfig
regarding -c vs -s in scripts/Kbuild.include vs
scripts/Kconfig.include?  Otherwise it sounds like cc-option cannot be
used to check for `-Wa,` flags in Kconfig, since if the assembler is
never invoked, it may appear that GCC has support for
-Wa,--compress-debug-sections=zlib when it indeed does not.

> ---
>  Makefile          | 2 +-
>  lib/Kconfig.debug | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 839f9fee22cb..cb29e56f227a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -842,7 +842,7 @@ endif
>
>  ifdef CONFIG_DEBUG_INFO_COMPRESSED
>  DEBUG_CFLAGS   += -gz=zlib
> -KBUILD_AFLAGS  += -Wa,--compress-debug-sections=zlib
> +KBUILD_AFLAGS  += -gz=zlib
>  KBUILD_LDFLAGS += --compress-debug-sections=zlib
>  endif
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index cb98741601bd..94ce36be470c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -229,7 +229,7 @@ config DEBUG_INFO_COMPRESSED
>         bool "Compressed debugging information"
>         depends on DEBUG_INFO
>         depends on $(cc-option,-gz=zlib)
> -       depends on $(as-option,-Wa$(comma)--compress-debug-sections=zlib)
> +       depends on $(as-option,-gz=zlib)
>         depends on $(ld-option,--compress-debug-sections=zlib)
>         help
>           Compress the debug information using zlib.  Requires GCC 5.0+ or Clang
> --
> 2.26.2
>


--
Thanks,
~Nick Desaulniers
