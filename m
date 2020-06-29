Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406A9C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243162053B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qf7Kj9RQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgF2TEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbgF2TCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:43 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719FAC030795
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:26:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so8452266pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xYRvEczki6SokBOpOA5suBGpzozsRhEF1obfHkhFJwc=;
        b=Qf7Kj9RQv2Uwgg5IXZW1Z7ZfH0OInb0ASxj+6NzLv4hmT0NJVcFX9iJOO0oOEu15Ef
         SphtZYxc7EsMJfoytGYMsSi/ueoMdBH1bH92bWNG0FmvX1qEepQFMcxHcidFvOiT/M5V
         7aBjFjdvSCQQAHxG+pQZg1QtMuLQDlQPe9A6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xYRvEczki6SokBOpOA5suBGpzozsRhEF1obfHkhFJwc=;
        b=rCMEp+ca2KhwSPkKi8Q3elOa79lGCqxE1zS/buK2IwgtFmbSKy7hB7D65u7nk5om1z
         JG9+HQrdv5g+n4SwzpQbZPa8mS5O3ZTv8ZwMbzHpmt6HP0owj8RVbxo9gq4obgQN7Bqx
         GzDiELv5gDhKtiSciIWEtWcJabIENBt0anNetn6Ce2nKY1YyjXFzobK2rtBVwhtV9dhZ
         EzWGxany21o0WJ6j3uqfrEIF1q4FPT+A/uSdMCzgwHZf0+pQv+RQKg/MuWEUUjZeAg1j
         ljNx9xzXIkG8Tfvsl5PybNCyctV8AbBynT3PBXtB4H2XFfoOf7G8gQgO7ybzt2k0T4xz
         0UHg==
X-Gm-Message-State: AOAM531DPOwUmabauzC/lvlbICd2Vrssr95kBblHmVolQsAEmPv18v/l
        oSta+ACyt51muKoSq0LguDOt4eW+9tA=
X-Google-Smtp-Source: ABdhPJz3+oy3gajcG8dAQMMSbTkeXIAtNo/xWVhFTQQwhHjceydnACPNN409qxnfp1AYBd1saiZa5w==
X-Received: by 2002:a65:63d4:: with SMTP id n20mr11219744pgv.213.1593444395814;
        Mon, 29 Jun 2020 08:26:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p8sm174642pgs.29.2020.06.29.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:26:34 -0700 (PDT)
Date:   Mon, 29 Jun 2020 08:26:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v3 4/9] x86/build: Warn on orphan section placement
Message-ID: <202006290819.955CF6743@keescook>
References: <20200624014940.1204448-5-keescook@chromium.org>
 <202006250240.J1VuMKoC%lkp@intel.com>
 <202006270840.E0BC752A72@keescook>
 <CANpmjNMtFbc_jQU6iNfNx-4wwQF4DY3uaOB1dCPZ3dMqXx6smg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMtFbc_jQU6iNfNx-4wwQF4DY3uaOB1dCPZ3dMqXx6smg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 04:54:13PM +0200, Marco Elver wrote:
> On Sat, 27 Jun 2020 at 17:44, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Jun 25, 2020 at 02:36:27AM +0800, kernel test robot wrote:
> > > I love your patch! Perhaps something to improve:
> > > [...]
> > > config: x86_64-randconfig-a012-20200624 (attached as .config)
> >
> > CONFIG_KCSAN=y
> >
> > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 1d4c87335d5236ea1f35937e1014980ba961ae34)
> > > [...]
> > > All warnings (new ones prefixed by >>):
> > >
> > >    ld.lld: warning: drivers/built-in.a(mfd/mt6397-irq.o):(.init_array.0) is being placed in '.init_array.0'
> >
> > As far as I can tell, this is a Clang bug. But I don't know the
> > internals here, so I've opened:
> > https://bugs.llvm.org/show_bug.cgi?id=46478
> >
> > and created a work-around patch for the kernel:
> 
> Thanks, minor comments below.
> 
> With KCSAN this is:
> 
> Tested-by: Marco Elver <elver@google.com>

Thanks!

> 
> 
> > commit 915f2c343e59a14f00c68f4d7afcfdc621de0674
> > Author: Kees Cook <keescook@chromium.org>
> > Date:   Sat Jun 27 08:07:54 2020 -0700
> >
> >     vmlinux.lds.h: Avoid KCSAN's unwanted sections
> 
> Since you found that it's also KASAN, this probably wants updating.

Yeah, I found that while testing the v4 series and updated the patch
there.

> >     KCSAN (-fsanitize=thread) produces unwanted[1] .eh_frame and .init_array.*
> >     sections. Add them to DISCARDS, except with CONFIG_CONSTRUCTORS, which
> >     wants to keep .init_array.* sections.
> >
> >     [1] https://bugs.llvm.org/show_bug.cgi?id=46478
> >
> >     Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index f8a5b2333729..41c8c73de6c4 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -195,7 +195,9 @@ endif
> >  # Workaround for a gcc prelease that unfortunately was shipped in a suse release
> >  KBUILD_CFLAGS += -Wno-sign-compare
> >  #
> > -KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> > +KBUILD_AFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
> > +KBUILD_CFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
> > +KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
> 
> Why are they needed? They are not mentioned in the commit message.

This was a mis-applied chunk (I also noticed this in the v4).

> > +/*
> > + * Clang's -fsanitize=thread produces unwanted sections (.eh_frame
> > + * and .init_array.*), but CONFIG_CONSTRUCTORS wants to keep any
> > + * .init_array.* sections.
> > + * https://bugs.llvm.org/show_bug.cgi?id=46478
> > + */
> > +#if defined(CONFIG_KCSAN) && !defined(CONFIG_CONSTRUCTORS)
> 
> CONFIG_KASAN as well?
> 
> > +#define KCSAN_DISCARDS                                                 \
> > +       *(.init_array) *(.init_array.*)                                 \
> > +       *(.eh_frame)
> > +#elif defined(CONFIG_KCSAN) && defined(CONFIG_CONSTRUCTORS)
> > +#define KCSAN_DISCARDS                                                 \
> > +       *(.eh_frame)
> > +#else
> > +#define KCSAN_DISCARDS
> > +#endif
> > +
> >  #define DISCARDS                                                       \
> >         /DISCARD/ : {                                                   \
> >         EXIT_DISCARDS                                                   \
> >         EXIT_CALL                                                       \
> > +       KCSAN_DISCARDS                                                  \
> 
> Maybe just 'SANITIZER_DISCARDS'?

Sure! I will rename it.

> 
> >         *(.discard)                                                     \
> >         *(.discard.*)                                                   \
> >         *(.modinfo)                                                     \
> >
> > --
> > Kees Cook

-- 
Kees Cook
