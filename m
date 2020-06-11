Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E73C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9099220720
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbW0KEGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgFKVJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 17:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgFKVJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 17:09:35 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF65EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 14:09:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v24so2801540plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 14:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHMJFXhsuTqudS+iH/9s75IdmWWzAX89Y6jkRhlQC84=;
        b=JbW0KEGZ9j+cEaHm0rZ95qN8lU9FSixYjlKu1RklhbiroddM0UMw9KV0yhs3g58oam
         Ul7jBYIFuvAhXHISm0cA2R5WYSGm6zdt5nJb+CawsEGxXpEJvG1crPlycGaq4pNwSkyS
         Td7BoKOCVx8XwE+qjIHmauAOFKfo/BYqpGg8bk8g49FwmdO17lQUJ6zQwkxAhyrilMFX
         GVS4sUySkWCWPitfgOcq9sdtQmP0IbqnuFqspQF/Sfma1NGdM5Ha7voZFAbybBHBTyeF
         E6PQdNJJA4Jy2exLOkJY7O4U8WdV3Ldl6hsGyBh5aeWrSUdiMXXECX4eQQ4Xmxk7pNOo
         9nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHMJFXhsuTqudS+iH/9s75IdmWWzAX89Y6jkRhlQC84=;
        b=uFdI9g0vG41YRManX/PaQQIfDitsEiFSbY/b/NHHQ41WHkjZvKNu8/ROf847q43dUv
         zLWnlUGgHJcXXvOODQ5a9Wuj3YEpynfXkA9mVn8lVT9qjmWaZhFpzyAeCLWF1p4YjcD9
         eCo3n9rCVH+H3DJkki3lDJr1AZrlUGaJyDmTwwGRGiUZuCccUtdxKhIcED4WzV7/bio4
         cykqfAbu78SetAbFDEoq0zmv8/M23Q5jaiHnuPwa4TKYxggFLNfsX1DSgpV/pqszdN7a
         Cmr6Fd9tFpWSQTP7zOTKxfMR8TbFy25rKgyf9q20umNo2EImBMI9RNi6x7vSuYftIEpS
         KRSA==
X-Gm-Message-State: AOAM530YnsOxHzvNK0GYOeGPu4u08CNKd1Tcn0V8dkyk5seA+jw6/W4V
        v5xvIslq0Dj/cLfm8B+LUQSOtu7Y3jW4AKj+J8SQqw==
X-Google-Smtp-Source: ABdhPJw7oRp2q2uDrmwToyO/TU8rthydadFc4D/arZLRkYOvYL0DwQH4Kk9VhzM4AmIrMS9Ah/xooa3+CA8gNoeg1/c=
X-Received: by 2002:a17:902:7201:: with SMTP id ba1mr8546090plb.223.1591909772866;
 Thu, 11 Jun 2020 14:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200610063715.v2qrqvwtegdxdwzl@google.com> <20200610191106.2662548-1-nivedita@alum.mit.edu>
 <CAKwvOdnF9xhrs+FP4QXo6uXxgHMfHO8NvPYs1=KDE2ZyhCw2QQ@mail.gmail.com> <20200610233046.GA2941409@rani.riverdale.lan>
In-Reply-To: <20200610233046.GA2941409@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Jun 2020 14:09:21 -0700
Message-ID: <CAKwvOdnddAjiXDKA8fp3n2NN+R=Syp2N5DHbp1j=VRzM1dNnRw@mail.gmail.com>
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

On Wed, Jun 10, 2020 at 4:30 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Jun 10, 2020 at 02:27:55PM -0700, Nick Desaulniers wrote:
> > On Wed, Jun 10, 2020 at 12:11 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > Commit
> > >   10e68b02c861 ("Makefile: support compressed debug info")
> > > added support for compressed debug sections.
> > >
> > > Support is detected by checking
> > > - does the compiler support -gz=zlib
> > > - does the assembler support --compressed-debug-sections=zlib
> > > - does the linker support --compressed-debug-sections=zlib
> > >
> > > However, the gcc driver's support for this option is somewhat
> > > convoluted. The driver's builtin specs are set based on the version of
> > > binutils that it was configured with, and it reports an error only if
> > > the assembler (or linker) is actually invoked.
> > >
> > > The cc-option check in scripts/Kconfig.include does not invoke the
> > > assembler, so the gcc driver reports success even if it does not support
> > > the option being passed to the assembler.
> >
> > Thanks for the patch! In that case, should we consider dropping the
> > cc-option check from the Kconfg then, too?
> >
> > It seems it would help for clang-4 and older, since they do error
> > about the unknown option, but I'm not too worried about trying to
> > support that version of Clang with this config.
>
> Also for gcc4 which doesn't support this at all -- that will report
> error on cc-option. We don't need to support it, but we shouldn't let it
> be enabled either.

ah, right, good to fail early in that case then.

>
> >
> > > Combined with an installed
> > > version of binutils that is more recent than the one the compiler was
> > > built with, it is possible for all three tests to succeed, yet an actual
> > > compilation with -gz=zlib to fail.
> >
> > It kind of sounds like the assembler must be invoked to verify this
> > will work for the cflags then?
> >
>
> Yes, the gcc driver reports an error when deciding what to pass to the
> assembler for -gz=zlib, if it was configured with a linker that does not
> support the flag. It's even more weird actually -- if it was configured
> with a linker that supports the flag but an assembler that doesn't, it
> will silently eat the flag when calling the assembler. At least that
> won't break anything, though none of the .o files will be compressed.

Not sure whether we'd like to prevent the option from being selectable
in that case, or just to silently not compress the debug info.  Given
that the compression is an optimization, it doesn't hurt to silently
not do it, but it would be nice to notify the user their toolchain may
have been misconfigured.  Though another part of me feels "garbage in,
garbage out."

>
> > >
> > > Moreover, it is unnecessary to explicitly pass
> > > --compressed-debug-sections=zlib to the assembler via -Wa, since the
> > > driver will do that automatically.
> > >
> > > Convert the as-option to just -gz=zlib, simplifying it as well as
> > > performing a better test of the gcc driver's capabilities.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> >
> > Does this imply all feature tests of as-option with -W(comma)... are
> > broken?  IIUC, then the assembler is still not invoked, much as in
> > this case?  (as in they all pass when maybe they should not?)  (or
> > based on below, maybe just the Kconfig from 74afda4016a74 in
> > arch/arm64/Kconfig, AS_HAS_PAC)
>
> No, as-option does invoke the assembler. The problem here is that with
> -Wa, the option is only seen by the assembler, not the gcc driver. So it
> will succeed because the assembler supports it, but it will not test
> whether the gcc driver also supports it.

^ Those 2 last sentences should go in the commit message, as the
current form doesn't allude to that.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> >
> > In the other thread, you discussed -c vs -s.  It looks like -c is used
> > for as-option, so I expect the assembler to be invoked.
> >
> > Maybe we should look at the mismatch between Kbuild and Kconfig
> > regarding -c vs -s in scripts/Kbuild.include vs
> > scripts/Kconfig.include?  Otherwise it sounds like cc-option cannot be
> > used to check for `-Wa,` flags in Kconfig, since if the assembler is
> > never invoked, it may appear that GCC has support for
> > -Wa,--compress-debug-sections=zlib when it indeed does not.
> >
>
> Yeah, we might want to fix the mismatch there.  In Kconfig, there aren't
> any instances of cc-option being used with -Wa, but there certainly are
> in Kbuild. It actually originally used to only run the preprocessor and

Yep. Got it.

> got fixed to at least run the compiler in commit
>   3bed1b7b9d79 ("kbuild: use -S instead of -E for precise cc-option test in Kconfig")
>
> > > ---
> > >  Makefile          | 2 +-
> > >  lib/Kconfig.debug | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 839f9fee22cb..cb29e56f227a 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -842,7 +842,7 @@ endif
> > >
> > >  ifdef CONFIG_DEBUG_INFO_COMPRESSED
> > >  DEBUG_CFLAGS   += -gz=zlib
> > > -KBUILD_AFLAGS  += -Wa,--compress-debug-sections=zlib
> > > +KBUILD_AFLAGS  += -gz=zlib

I verified that Clang will still produce compressed debug info
sections for .s/.S input with -gz=zlib.  So this doesn't regress
anything, AFAICT.

Thanks for the patch.

> > >  KBUILD_LDFLAGS += --compress-debug-sections=zlib
> > >  endif
> > >
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index cb98741601bd..94ce36be470c 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -229,7 +229,7 @@ config DEBUG_INFO_COMPRESSED
> > >         bool "Compressed debugging information"
> > >         depends on DEBUG_INFO
> > >         depends on $(cc-option,-gz=zlib)
> > > -       depends on $(as-option,-Wa$(comma)--compress-debug-sections=zlib)
> > > +       depends on $(as-option,-gz=zlib)
> > >         depends on $(ld-option,--compress-debug-sections=zlib)
> > >         help
> > >           Compress the debug information using zlib.  Requires GCC 5.0+ or Clang
> > > --
> > > 2.26.2
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
