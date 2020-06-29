Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2981C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6912082F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEw0pNBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387735AbgF2Tnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387971AbgF2Tmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:42:43 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E32C02F023
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:54:26 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k15so15728162otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VYgNM/DVHPEkntLU/yBA/5PMKk3x04iIvLdywNiIUKs=;
        b=LEw0pNBjUt/k5mYtgdQzG5wULzkigu9dhAcGPJCpoSFHN0K3X4S/1RHnb6elfeLSw+
         XmsQ91PsH5Uc1TvkJ2t4OQq9VXXOekhEpjcwSDTKW7FelGNN7XmJZgaOLhbj/9zLJRZo
         Ow936VWRX3KPBqjArVUpA99VRCQfp40S5FN3LnUoxN2OCuzL+9JfVA8/xTv3VP1RQQxs
         K98osvYHYSli8F/gYDCXqvg0Y6ShnrHB51QqyyGY6qAb2QOduVGG7j75RVilj9leqN1V
         U1p+pWzBaTTsydLyCyIYg55RVcnBaYB5gIRx22uj8HkVz1LKw77dS6jMLUY1SOdUmfEY
         Ij+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYgNM/DVHPEkntLU/yBA/5PMKk3x04iIvLdywNiIUKs=;
        b=FsBO5ffgJdo6LrzHiaKIWlsj9N3rxlP+113+wEJnwZHkI0XpyuPTZY4PE1SEpDNzFa
         ibUCIYTqfdkT1pgQ1X4KdCNAQFykJ+OP0S4gjDhD1UpDBkGvGkI2M4wKyg4oaFEoKDYO
         koCjd0kSrrqZ2uDb9H++gv/NAWubiBf2SxzqyGd9zZkQz9Wlcd3gWqGAM+8OECCGXkPx
         ZQgZPQeVbK8HwoZ//IacW+tGc4qzYvS/iCCh9fIM1WmjBn7becPZdUGecCRf9bsfOktS
         GpUUjnk+A1KrG3VOK/a2WyLftzIJ4IUE+x/jpGnZRhgYe93yhUV9hgwjHYNTnrA9YF35
         Qg3g==
X-Gm-Message-State: AOAM531po9L1tMm5j09hxQVE7NBynUQRpOQfiDW66sZLJDwJlNkYSyY0
        STFDTH6wNJ1Vr8oBZs7FYwWCpvcHX8xEy1CTKWG5rA==
X-Google-Smtp-Source: ABdhPJyckXjh5IRpiR9K6i3vrxLY+tdC2eV4PshSeToL+m0/x/hlaJCCKXsszuWnnIyl5PtD4g1/M53Tp0Oe58zqikU=
X-Received: by 2002:a9d:638c:: with SMTP id w12mr12713578otk.251.1593442465246;
 Mon, 29 Jun 2020 07:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200624014940.1204448-5-keescook@chromium.org>
 <202006250240.J1VuMKoC%lkp@intel.com> <202006270840.E0BC752A72@keescook>
In-Reply-To: <202006270840.E0BC752A72@keescook>
From:   Marco Elver <elver@google.com>
Date:   Mon, 29 Jun 2020 16:54:13 +0200
Message-ID: <CANpmjNMtFbc_jQU6iNfNx-4wwQF4DY3uaOB1dCPZ3dMqXx6smg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] x86/build: Warn on orphan section placement
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020 at 17:44, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jun 25, 2020 at 02:36:27AM +0800, kernel test robot wrote:
> > I love your patch! Perhaps something to improve:
> > [...]
> > config: x86_64-randconfig-a012-20200624 (attached as .config)
>
> CONFIG_KCSAN=y
>
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 1d4c87335d5236ea1f35937e1014980ba961ae34)
> > [...]
> > All warnings (new ones prefixed by >>):
> >
> >    ld.lld: warning: drivers/built-in.a(mfd/mt6397-irq.o):(.init_array.0) is being placed in '.init_array.0'
>
> As far as I can tell, this is a Clang bug. But I don't know the
> internals here, so I've opened:
> https://bugs.llvm.org/show_bug.cgi?id=46478
>
> and created a work-around patch for the kernel:

Thanks, minor comments below.

With KCSAN this is:

Tested-by: Marco Elver <elver@google.com>


> commit 915f2c343e59a14f00c68f4d7afcfdc621de0674
> Author: Kees Cook <keescook@chromium.org>
> Date:   Sat Jun 27 08:07:54 2020 -0700
>
>     vmlinux.lds.h: Avoid KCSAN's unwanted sections

Since you found that it's also KASAN, this probably wants updating.

>     KCSAN (-fsanitize=thread) produces unwanted[1] .eh_frame and .init_array.*
>     sections. Add them to DISCARDS, except with CONFIG_CONSTRUCTORS, which
>     wants to keep .init_array.* sections.
>
>     [1] https://bugs.llvm.org/show_bug.cgi?id=46478
>
>     Signed-off-by: Kees Cook <keescook@chromium.org>
>
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index f8a5b2333729..41c8c73de6c4 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -195,7 +195,9 @@ endif
>  # Workaround for a gcc prelease that unfortunately was shipped in a suse release
>  KBUILD_CFLAGS += -Wno-sign-compare
>  #
> -KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> +KBUILD_AFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
> +KBUILD_CFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
> +KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)

Why are they needed? They are not mentioned in the commit message.

>  # Avoid indirect branches in kernel to deal with Spectre
>  ifdef CONFIG_RETPOLINE
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b1dca0762fc5..a44ee16abc78 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -934,10 +934,28 @@
>         EXIT_DATA
>  #endif
>
> +/*
> + * Clang's -fsanitize=thread produces unwanted sections (.eh_frame
> + * and .init_array.*), but CONFIG_CONSTRUCTORS wants to keep any
> + * .init_array.* sections.
> + * https://bugs.llvm.org/show_bug.cgi?id=46478
> + */
> +#if defined(CONFIG_KCSAN) && !defined(CONFIG_CONSTRUCTORS)

CONFIG_KASAN as well?

> +#define KCSAN_DISCARDS                                                 \
> +       *(.init_array) *(.init_array.*)                                 \
> +       *(.eh_frame)
> +#elif defined(CONFIG_KCSAN) && defined(CONFIG_CONSTRUCTORS)
> +#define KCSAN_DISCARDS                                                 \
> +       *(.eh_frame)
> +#else
> +#define KCSAN_DISCARDS
> +#endif
> +
>  #define DISCARDS                                                       \
>         /DISCARD/ : {                                                   \
>         EXIT_DISCARDS                                                   \
>         EXIT_CALL                                                       \
> +       KCSAN_DISCARDS                                                  \

Maybe just 'SANITIZER_DISCARDS'?

>         *(.discard)                                                     \
>         *(.discard.*)                                                   \
>         *(.modinfo)                                                     \
>
> --
> Kees Cook
