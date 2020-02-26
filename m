Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E08DC4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1054720732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4604xpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgBZBTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:19:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37724 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbgBZBTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:19:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id z12so442592pgl.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 17:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+WJdtiodK7smJaw6cytKeNqvxCywC6JW8awTtYsnT4=;
        b=l4604xpw1I8955q9AJdeAjThTj77w5HfTFVsOgRzhxDZ0vM6gMjC8oeO4rqZCFsaox
         ZL/o13PdpDkiVgbVPLqS6E4izZOSUR739tueSpiptZML8g4LElY0KhMqkuFeS5sObhOF
         JOwdK51GnNpY+2ZwrKbnYeyV+VFN6Du8fjnf3/1QsQPpwNPdNxhHtDj5pkuJlxDpVS2R
         GhGoL68sm/V/cldSwdhNvaxy4/NszTqHPJLbJPMUZmgJKwjoLJu60kFbSsur5dceh/zE
         WEd4v0dzMW8UnaLMEd6VNNLYRRyYIg9MqkoKj1DKF8Svrkj+Fg2YjvcbJYCRg7b1NOzN
         c4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+WJdtiodK7smJaw6cytKeNqvxCywC6JW8awTtYsnT4=;
        b=M+iBiSmtufNm7RtO9mUaiOMN8xMTmT/o3GtFoI5KEH1E4wd+db1DFIo8pnpqQo+VHJ
         xlyG0/xEK+RW6BhAB0pe6NdZi4ElC5UzakJYD8TMhfSmiAvsEYcgr6QIrENu2vEct6o/
         9FH22nYZ+34DH2N0k0JIk0l/KQuRBpXaZLTd2KDydJ0yaTlTmku8PDVgSq/mkswquZM4
         o5O0uK2QkkAnSt1jUCKrextliU/Sd8gFgmLJBBnm3BhU8hcwdSwjYKfbzYhI8Og1/R8U
         SvhoZFd/hatUlPLNNTgIObF6k4bVWptpq9vB5u1BVX/4Nxl7pqW8NwMAfWetFK4nLRIb
         7ajQ==
X-Gm-Message-State: APjAAAXwSJ6x0D/2Iwd7U0NG4jvdRgTacTGk8RcwVeXBLVWrM3RLHwh4
        5Dwebv0+dtyK26Kk7/D4iejb6c8ajx/ZvC+BWtb6yw==
X-Google-Smtp-Source: APXvYqyFxxd/7WafHcDRoH/+bFVruaVRPaqgsu+toTd8xnHclFNprOOCvoG32q9BcOQU7IT9T9jFz+V88xx6R08lb38=
X-Received: by 2002:aa7:8545:: with SMTP id y5mr1551644pfn.185.1582679973137;
 Tue, 25 Feb 2020 17:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20200226004608.8128-1-trishalfonso@google.com>
In-Reply-To: <20200226004608.8128-1-trishalfonso@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 25 Feb 2020 17:19:21 -0800
Message-ID: <CAFd5g45gqZcJ6v3KSDuBffgBzfZ+=GJ2oCuSurYehoMHBK0Grg@mail.gmail.com>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        aryabinin@virtuozzo.com, Dmitry Vyukov <dvyukov@google.com>,
        David Gow <davidgow@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        kasan-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 4:46 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
>
> Make KASAN run on User Mode Linux on x86_64.
>
> Depends on Constructor support in UML - "[RFC PATCH] um:
> implement CONFIG_CONSTRUCTORS for modules"
> (https://patchwork.ozlabs.org/patch/1234551/) by Johannes Berg.
>
> The location of the KASAN shadow memory, starting at
> KASAN_SHADOW_OFFSET, can be configured using the
> KASAN_SHADOW_OFFSET option. UML uses roughly 18TB of address
> space, and KASAN requires 1/8th of this. The default location of
> this offset is 0x7fff8000 as suggested by Dmitry Vyukov. There is
> usually enough free space at this location; however, it is a config
> option so that it can be easily changed if needed.
>
> The UML-specific KASAN initializer uses mmap to map
> the roughly 2.25TB of shadow memory to the location defined by
> KASAN_SHADOW_OFFSET. kasan_init() utilizes constructors to initialize
> KASAN before main().
>
> Disable stack instrumentation on UML via KASAN_STACK config option to
> avoid false positive KASAN reports.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>

A couple of minor nits (well one nit and one question), but overall
this looks good to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  arch/um/Kconfig                  | 13 +++++++++++++
>  arch/um/Makefile                 |  6 ++++++
>  arch/um/include/asm/common.lds.S |  1 +
>  arch/um/include/asm/kasan.h      | 32 ++++++++++++++++++++++++++++++++
>  arch/um/kernel/dyn.lds.S         |  5 ++++-
>  arch/um/kernel/mem.c             | 18 ++++++++++++++++++
>  arch/um/os-Linux/mem.c           | 22 ++++++++++++++++++++++
>  arch/um/os-Linux/user_syms.c     |  4 ++--
>  arch/x86/um/Makefile             |  3 ++-
>  arch/x86/um/vdso/Makefile        |  3 +++
>  lib/Kconfig.kasan                |  2 +-
>  11 files changed, 104 insertions(+), 5 deletions(-)
>  create mode 100644 arch/um/include/asm/kasan.h
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 0917f8443c28..fb2ad1fb05fd 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -8,6 +8,7 @@ config UML
>         select ARCH_HAS_KCOV
>         select ARCH_NO_PREEMPT
>         select HAVE_ARCH_AUDITSYSCALL
> +       select HAVE_ARCH_KASAN if X86_64
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ASM_MODVERSIONS
>         select HAVE_UID16
> @@ -200,6 +201,18 @@ config UML_TIME_TRAVEL_SUPPORT
>
>           It is safe to say Y, but you probably don't need this.
>
> +config KASAN_SHADOW_OFFSET
> +       hex
> +       depends on KASAN
> +       default 0x7fff8000

nit: It looks like you chose the default that Dmitry suggested. Some
explanation of this in the help would probably be good.

> +       help
> +         This is the offset at which the ~2.25TB of shadow memory is
> +         mapped and used by KASAN for memory debugging. This can be any
> +         address that has at least KASAN_SHADOW_SIZE(total address space divided
> +         by 8) amount of space so that the KASAN shadow memory does not conflict
> +         with anything. The default is 0x7fff8000, as it fits into immediate of
> +         most instructions.
> +
>  endmenu

[...]

> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 81f5464ea9e1..5b54f3c9a741 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -125,7 +125,7 @@ config KASAN_STACK_ENABLE
>
>  config KASAN_STACK
>         int
> -       default 1 if KASAN_STACK_ENABLE || CC_IS_GCC
> +       default 1 if (KASAN_STACK_ENABLE || CC_IS_GCC) && !UML

Up to the KASAN people, but I think you can probably move this to
arch/um/Kconfig. There is some advantage to having all the UML
specific Kconfigery in arch/um/Kconfig, but there are also already a
lot of things that specify !UML outside of arch/um/.

>         default 0
>
>  config KASAN_S390_4_LEVEL_PAGING
> --
> 2.25.0.265.gbab2e86ba0-goog
>
