Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7D8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFE620760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5CGcKvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgFJXav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJXav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:30:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08D7C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:30:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q8so3886949qkm.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EqxFOEid1yw84Q1FNZAR72QP068PBSmquC7v1z9apLE=;
        b=t5CGcKvuoX3CG7zJYULItgVy06tVzd0hd3wR8qPdboQ++0yabyR+9R41tUtsNvPYxd
         dERjOdXgOzm2+J+Vt7TyD9unYbiJzzQHD0uVEMYg0vNNGAjTf2YubJ2yeuUJ6qWZCI/Q
         ivmFjOg+KGE7I0M5QbMLYw8BD71iVj3NsHbUW7QB9QleT+TEV1Ai+CREucHOVZ9xlsRQ
         t6NzINvzjg0UzNRiPRQY6WN15NU1QCD8w5/emgcp5BIXAFXQh4j9vXtggkKIjP7iBPpk
         LYQ8d3dZC+41WFPgze1qYoINVyDzK/1aDBUuKPfnm41iQYv+tREZnDnd1r3l0XJXstj+
         aLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EqxFOEid1yw84Q1FNZAR72QP068PBSmquC7v1z9apLE=;
        b=oUyqnLLezlhA5StdeR/+cZH0SNDzt2/e7Z9GoQqtjTckHYusFiINZTSJ2vxkGHPO3o
         09m3p2K8KXPDAWSwGr0KfyEaRrNVF1XYFuCfDRxZ4XH4mIuUJf+yMDQYF8jYG9tnD0LR
         2lMA/pLP40399d2/wpjC8WnP38NtMFWgngTVwup2QzdSknVDtL+gNozH7iYlWNafPVVk
         olC24zv1ba+HFep6MNvQPNFBlXlP86tTgEz5Fd+MXixS8jaJMx4NGnb+0ttJw6y9NrSo
         2RxVuy3lrd48kqWoYyu1v7xC+rWvKUskJHZyyGYvTIs/esiiVUUZ6NoNIpeDQUIb3H2D
         l4Dg==
X-Gm-Message-State: AOAM532i90qYpcASx/pqvSxBDOeEcDA795trCqwN3p9GPmK8b2RhraLB
        FMEtMvDyWQuuOpKrd8i+/JU=
X-Google-Smtp-Source: ABdhPJzcpySUfvdvmJoQWTBzEe8NelzmoxQhWHXcUtIiMt1xshl7OB/D2JDVRzQsKVBq0R1ygEfJOA==
X-Received: by 2002:a05:620a:5e9:: with SMTP id z9mr5397165qkg.459.1591831849011;
        Wed, 10 Jun 2020 16:30:49 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s4sm873822qkh.120.2020.06.10.16.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 16:30:48 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 10 Jun 2020 19:30:46 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Makefile: Improve compressed debug info support detection
Message-ID: <20200610233046.GA2941409@rani.riverdale.lan>
References: <20200610063715.v2qrqvwtegdxdwzl@google.com>
 <20200610191106.2662548-1-nivedita@alum.mit.edu>
 <CAKwvOdnF9xhrs+FP4QXo6uXxgHMfHO8NvPYs1=KDE2ZyhCw2QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnF9xhrs+FP4QXo6uXxgHMfHO8NvPYs1=KDE2ZyhCw2QQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 02:27:55PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 10, 2020 at 12:11 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Commit
> >   10e68b02c861 ("Makefile: support compressed debug info")
> > added support for compressed debug sections.
> >
> > Support is detected by checking
> > - does the compiler support -gz=zlib
> > - does the assembler support --compressed-debug-sections=zlib
> > - does the linker support --compressed-debug-sections=zlib
> >
> > However, the gcc driver's support for this option is somewhat
> > convoluted. The driver's builtin specs are set based on the version of
> > binutils that it was configured with, and it reports an error only if
> > the assembler (or linker) is actually invoked.
> >
> > The cc-option check in scripts/Kconfig.include does not invoke the
> > assembler, so the gcc driver reports success even if it does not support
> > the option being passed to the assembler.
> 
> Thanks for the patch! In that case, should we consider dropping the
> cc-option check from the Kconfg then, too?
> 
> It seems it would help for clang-4 and older, since they do error
> about the unknown option, but I'm not too worried about trying to
> support that version of Clang with this config.

Also for gcc4 which doesn't support this at all -- that will report
error on cc-option. We don't need to support it, but we shouldn't let it
be enabled either.

> 
> > Combined with an installed
> > version of binutils that is more recent than the one the compiler was
> > built with, it is possible for all three tests to succeed, yet an actual
> > compilation with -gz=zlib to fail.
> 
> It kind of sounds like the assembler must be invoked to verify this
> will work for the cflags then?
> 

Yes, the gcc driver reports an error when deciding what to pass to the
assembler for -gz=zlib, if it was configured with a linker that does not
support the flag. It's even more weird actually -- if it was configured
with a linker that supports the flag but an assembler that doesn't, it
will silently eat the flag when calling the assembler. At least that
won't break anything, though none of the .o files will be compressed.

> >
> > Moreover, it is unnecessary to explicitly pass
> > --compressed-debug-sections=zlib to the assembler via -Wa, since the
> > driver will do that automatically.
> >
> > Convert the as-option to just -gz=zlib, simplifying it as well as
> > performing a better test of the gcc driver's capabilities.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> Does this imply all feature tests of as-option with -W(comma)... are
> broken?  IIUC, then the assembler is still not invoked, much as in
> this case?  (as in they all pass when maybe they should not?)  (or
> based on below, maybe just the Kconfig from 74afda4016a74 in
> arch/arm64/Kconfig, AS_HAS_PAC)

No, as-option does invoke the assembler. The problem here is that with
-Wa, the option is only seen by the assembler, not the gcc driver. So it
will succeed because the assembler supports it, but it will not test
whether the gcc driver also supports it.

> 
> In the other thread, you discussed -c vs -s.  It looks like -c is used
> for as-option, so I expect the assembler to be invoked.
> 
> Maybe we should look at the mismatch between Kbuild and Kconfig
> regarding -c vs -s in scripts/Kbuild.include vs
> scripts/Kconfig.include?  Otherwise it sounds like cc-option cannot be
> used to check for `-Wa,` flags in Kconfig, since if the assembler is
> never invoked, it may appear that GCC has support for
> -Wa,--compress-debug-sections=zlib when it indeed does not.
> 

Yeah, we might want to fix the mismatch there.  In Kconfig, there aren't
any instances of cc-option being used with -Wa, but there certainly are
in Kbuild. It actually originally used to only run the preprocessor and
got fixed to at least run the compiler in commit
  3bed1b7b9d79 ("kbuild: use -S instead of -E for precise cc-option test in Kconfig")

> > ---
> >  Makefile          | 2 +-
> >  lib/Kconfig.debug | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 839f9fee22cb..cb29e56f227a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -842,7 +842,7 @@ endif
> >
> >  ifdef CONFIG_DEBUG_INFO_COMPRESSED
> >  DEBUG_CFLAGS   += -gz=zlib
> > -KBUILD_AFLAGS  += -Wa,--compress-debug-sections=zlib
> > +KBUILD_AFLAGS  += -gz=zlib
> >  KBUILD_LDFLAGS += --compress-debug-sections=zlib
> >  endif
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index cb98741601bd..94ce36be470c 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -229,7 +229,7 @@ config DEBUG_INFO_COMPRESSED
> >         bool "Compressed debugging information"
> >         depends on DEBUG_INFO
> >         depends on $(cc-option,-gz=zlib)
> > -       depends on $(as-option,-Wa$(comma)--compress-debug-sections=zlib)
> > +       depends on $(as-option,-gz=zlib)
> >         depends on $(ld-option,--compress-debug-sections=zlib)
> >         help
> >           Compress the debug information using zlib.  Requires GCC 5.0+ or Clang
> > --
> > 2.26.2
> >
> 
> 
> --
> Thanks,
> ~Nick Desaulniers
