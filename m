Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5473CC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 347D520786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598554958;
	bh=W45liDejHTP5rmlUV7WImpueTkFk7VlsoH4MM2hzleE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iqgSmegD9JsuHbii2eNAWY78RVIMYm4K8vWhCUk+K2KFbTJizTawnlGB9M8cZkEIF
	 e0Vw/x3iZa2UR/s+h0yomGMx1dki5m5wYKFiLpu0sTz7MdKMDHKfl8c5uM4h9LDMnb
	 aPUJf2xuAsshY/nO96X5qEdfWmHBn53ie3gcwG6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgH0TCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH0TCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:02:33 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC269C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:02:32 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h19so7635980ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFvIvXHhd/hYE56Z6ikG+RnfuV2qLxS/yEF1m7O4OeY=;
        b=VM66vHj/DMWeTlikVsUdxuFen7TVRMLCbMBAyqrBbdkGQCY6oTDrhI7/sxRlX1W99K
         2h1mm/ldBVsuF5WYprtKEfAB3BsDPD/sfrTxFXtuYDwugI7YTZSlhEmjwcIt5OAthLhQ
         NirIVxzswSC1dhN4apwYaWU+9vV6pgT/cFoD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFvIvXHhd/hYE56Z6ikG+RnfuV2qLxS/yEF1m7O4OeY=;
        b=a8ucFmSmPQTooIKGACkAzPmCxquXvqwPAQ41GVoe0AVTfKGiIqheMEE9800WJMuUvQ
         k0tWqfQHWtUsOn6yUmCHc0XFadUXmjXvqvB6L/Q7AyiuJx79foj/AZk9de1B8JHE6kwV
         4snQiNfBkEyTB26dVKX4ZcyTdDQwzKYE3tU7jYiI+0Aeh42LJ1GLzHUXKXUyUZOYV1KC
         U5wYd/bwmGs/M/SnOxvqWWszjeydlRzUnV3L2orX638ZZqO7Druj3qAYXCBu3iKC9Qj1
         Z62XUTm61X7E3JPO1pd86E8EXg6p1//7MmaVtJ4v2UBpHXlxjWLyzsdOo13vvbsMVmCr
         N6Tg==
X-Gm-Message-State: AOAM533oRFFmF3XqvVBXCOoG/cc7xWSHiiOA4XUZrjyS2eWwEek5Ddrd
        WJjtDFf6fTV0FliguxqLn/gKcdubah5l7Q==
X-Google-Smtp-Source: ABdhPJyP1CR8jWOFazDw75yJW1gVvQITy0UDhMDkxmxJt2ifMylpBLc+xaOehmoUnaHtKYmOWh/gdg==
X-Received: by 2002:a2e:b0e5:: with SMTP id h5mr3006086ljl.369.1598554950132;
        Thu, 27 Aug 2020 12:02:30 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id e15sm648693ljn.49.2020.08.27.12.02.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 12:02:29 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id i10so7678881ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:02:28 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr11182711ljp.312.1598554948218;
 Thu, 27 Aug 2020 12:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <202008271145.xE8qIAjp%lkp@intel.com> <20200827080558.GA3024@gondor.apana.org.au>
 <CAMj1kXHJrLtnJWYBKBYRtNHVS6rv51+crMsjLEnSqkud0BBaWw@mail.gmail.com>
 <20200827082447.GA3185@gondor.apana.org.au> <CAHk-=wg2RCgmW_KM8Gf9-3VJW1K2-FTXQsGeGHirBFsG5zPbsg@mail.gmail.com>
 <CAHk-=wgXW=YLxGN0QVpp-1w5GDd2pf1W-FqY15poKzoVfik2qA@mail.gmail.com> <202008271138.0FA7400@keescook>
In-Reply-To: <202008271138.0FA7400@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 12:02:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPasyJrDuwDnpHJS2TuQfExwe=px-SzLeN8GFMAQJPmQ@mail.gmail.com>
Message-ID: <CAHk-=wjPasyJrDuwDnpHJS2TuQfExwe=px-SzLeN8GFMAQJPmQ@mail.gmail.com>
Subject: Re: lib/crypto/chacha.c:65:1: warning: the frame size of 1604 bytes
 is larger than 1024 bytes
To:     Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:42 AM Kees Cook <keescook@chromium.org> wrote:
>
> Do you mean you checked both gcc and clang and it was only a problem with gcc?

I didn't check with clang, but Arnd claimed it was fine.

> (If so, I can tweak the "depends" below...)

Ugh.

Instead of making the Makefile even uglier, why don't you just make
this all be done in the Kconfig.

Also, I'm not seeing the point of your patch. You didn't actually
change anything, you just made a new config variable with the same
semantics as the old one.

Add a

        depends on CLANG

or something, with a comment saying that it doesn't work on gcc due to
excessive stack use.

> +ifdef CONFIG_UBSAN_OBJECT_SIZE
> +      CFLAGS_UBSAN += $(call cc-option, -fsanitize=object-size)
> +endif

All of this should be thrown out, and this code should use the proper
patterns for configuration entries in the Makefile, ie just

  ubsan-cflags-$(CONFIG_UBSAN_OBJECT_SIZE) += -fsanitize=object-size

and the Kconfig file is the thing that should check if that CC option
exists with

  config UBSAN_OBJECT_SIZE
        bool "Check for accesses beyond known object sizes"
        default UBSAN
        depends on CLANG  # gcc makes a mess of it
        depends on $(cc-option,-fsanitize-coverage=trace-pc)

and the same goes for all the other cases too:

>  ifdef CONFIG_UBSAN_MISC
>        CFLAGS_UBSAN += $(call cc-option, -fsanitize=shift)
>        CFLAGS_UBSAN += $(call cc-option, -fsanitize=integer-divide-by-zero)
>        CFLAGS_UBSAN += $(call cc-option, -fsanitize=unreachable)
>        CFLAGS_UBSAN += $(call cc-option, -fsanitize=signed-integer-overflow)
> -      CFLAGS_UBSAN += $(call cc-option, -fsanitize=object-size)
>        CFLAGS_UBSAN += $(call cc-option, -fsanitize=bool)
>        CFLAGS_UBSAN += $(call cc-option, -fsanitize=enum)
>  endif

and if you don't want to ask for them (which is a good idea), you keep that

    config UBSAN_MISC
        bool "Misc UBSAN.."

thing, and just make all of the above have the pattern of

    config UBSAN_OBJECT_SIZE
        def_bool UBSAN_MISC
        depends on CLANG  # gcc makes a mess of it
        depends on $(cc-option,-fsanitize-coverage=trace-pc)

which makes the Makefile much cleaner, and makes all our choices very
visible in the config file when they then get passed around.

We should basically strive for our Makefiles to have as little "ifdef"
etc magic as possible. We did the config work already, the Makefiles
should primarily just have those

   XYZ-$(CONFIG_OPTION) += abc

kind of lines (and then  you often end up having

  CFLAGS_UBSAN := $(ubsan-cflags-y)

at the end).

Doesn't that all look much cleaner?

                   Linus
