Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21440C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEDAF20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TT3Hlsrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHRSA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHRSAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:00:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73501C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:00:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ep8so9575278pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyB4pRDJBveesx+DUtW+5ZFcTskYb5n8BU0PlbnfnQk=;
        b=TT3Hlsrs/mu4UmXylL6i2vWT4k+JLUcPQy0IRWK10ixwQ9fyS+vI5f6d+uD2IXXZut
         99X3OASTGInBitChHeiKlVI5wOVCENDYDya36/FbtT554wJijmw4ooB+ZKooD3AjcKgb
         w6MKTqNMRCGTA3dEtt2eCr/WXTblLpK6Rb2TkfyM/DzcCUvZGTwzSr4PGl2GjXFrhoGH
         PDfpG64lJbCoStDn2RPM99hNimcioeWRNNRchqnwjTxrLhGbdfKJfyhVb6Ts5/Mpf008
         gQ9Ee5zCntT/sLejF/FVfDbLbexG4avEfhBvuNi13cZq4EZM/tI59HJpPZ1of8yIo5zo
         6mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyB4pRDJBveesx+DUtW+5ZFcTskYb5n8BU0PlbnfnQk=;
        b=L7r5URetAduL3EFxmD7gz6estvYqzGYU2OF/rdnbcgSyxhbf2nguNQq0+3k2pQiOdg
         OsH0lYY6DkKvgrrFI+I+g18BxrOtM4QPSRjRDnWRab2Q1j9mcG0hqW1QNlyqrA1tCx29
         EyLrvU1TuxQODiznJINlwSsiGGLkpAvyfw7XpRTS9eG75lfz4DKETOy+0f544cL9ZZ+g
         AY4OWK4oBMX+HnfNcJRnKBBKNQ+HjlWu6U6EjBSa3FqyQqbewQXyKxEuM7WstL619KQd
         r54VGGYBY5evT3P+YoA+RoHSWh1nOUe/rd1bmqHRInqK7ZpzNYLs9elTqJL0DS/ZsVDm
         o4hg==
X-Gm-Message-State: AOAM5318jdhY1MZqgY0syMPjdlZje3w/eaL9cSVFktJNhhl35KAjEVks
        T0RQXgPRD9nmMVFJUyJH2Zob0u80fXwcT6RGqiOnsQ==
X-Google-Smtp-Source: ABdhPJxvC+Goaa7jQZI2Ls91WkQiWwleNdpeUsQ3EPcOTKvrXorm4E3fZCHGEvi7vIDZCxyOO7u0zSwMWNL8i9JW9RE=
X-Received: by 2002:a17:90a:3ad1:: with SMTP id b75mr846390pjc.25.1597773612681;
 Tue, 18 Aug 2020 11:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220212.338670-1-ndesaulniers@google.com>
 <20200817220212.338670-3-ndesaulniers@google.com> <20200818054428.GA2540870@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200818054428.GA2540870@ubuntu-n2-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Aug 2020 11:00:01 -0700
Message-ID: <CAKwvOdm8iKUbfFP3a-2GjB1XQXp36Y9+B4kp2KX5iKbH-f0vDA@mail.gmail.com>
Subject: Re: [PATCH 2/4] Revert "lib/string.c: implement a basic bcmp"
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 10:44 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Aug 17, 2020 at 03:02:10PM -0700, Nick Desaulniers wrote:
> > This reverts commit 5f074f3e192f10c9fade898b9b3b8812e3d83342.
> >
> > Use `-fno-builtin-bcmp` instead.
> >
> > The issue with using `-fno-builtin-*` flags was that they were not
> > retained during an LTO link with LLVM.  This was fixed in clang-11 by
> > https://reviews.llvm.org/D71193
> > (0508c994f0b14144041f2cfd3ba9f9a80f03de08), which is also the minimum
> > supported version of clang for LTO.
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  Makefile               |  1 +
> >  include/linux/string.h |  3 ---
> >  lib/string.c           | 20 --------------------
> >  3 files changed, 1 insertion(+), 23 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 211a1b6f6478..722ff5864275 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -964,6 +964,7 @@ endif
> >  # to provide implementations of these routines, then prevent the compiler from
> >  # emitting calls to what will be undefined symbols.
> >  KBUILD_CFLAGS        += -fno-builtin-stpcpy
> > +KBUILD_CFLAGS        += -fno-builtin-bcmp
>
> I personally think that this hunk should be its own patch before this
> one then have this patch just be the revert, that way there is no
> regression across a bisect (if one were to ever occur) and so the revert
> is a straight 'git revert', rather than have something else mixed in
> that requires reading the actual changelog text.
>
> No objections if you disagree though.

That's a great idea.  I considered it before sending, but I think it
would be interesting to divorce the KBUILD changes which can be picked
up quickly from the latter changes.  Will send a V2.

>
> >  # include additional Makefiles when needed
> >  include-y                    := scripts/Makefile.extrawarn
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index b1f3894a0a3e..f3bdb74bc230 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -155,9 +155,6 @@ extern void * memscan(void *,int,__kernel_size_t);
> >  #ifndef __HAVE_ARCH_MEMCMP
> >  extern int memcmp(const void *,const void *,__kernel_size_t);
> >  #endif
> > -#ifndef __HAVE_ARCH_BCMP
> > -extern int bcmp(const void *,const void *,__kernel_size_t);
> > -#endif
> >  #ifndef __HAVE_ARCH_MEMCHR
> >  extern void * memchr(const void *,int,__kernel_size_t);
> >  #endif
> > diff --git a/lib/string.c b/lib/string.c
> > index 6012c385fb31..69328b8353e1 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -922,26 +922,6 @@ __visible int memcmp(const void *cs, const void *ct, size_t count)
> >  EXPORT_SYMBOL(memcmp);
> >  #endif
> >
> > -#ifndef __HAVE_ARCH_BCMP
> > -/**
> > - * bcmp - returns 0 if and only if the buffers have identical contents.
> > - * @a: pointer to first buffer.
> > - * @b: pointer to second buffer.
> > - * @len: size of buffers.
> > - *
> > - * The sign or magnitude of a non-zero return value has no particular
> > - * meaning, and architectures may implement their own more efficient bcmp(). So
> > - * while this particular implementation is a simple (tail) call to memcmp, do
> > - * not rely on anything but whether the return value is zero or non-zero.
> > - */
> > -#undef bcmp
> > -int bcmp(const void *a, const void *b, size_t len)
> > -{
> > -     return memcmp(a, b, len);
> > -}
> > -EXPORT_SYMBOL(bcmp);
> > -#endif
> > -
> >  #ifndef __HAVE_ARCH_MEMSCAN
> >  /**
> >   * memscan - Find a character in an area of memory.
> > --
> > 2.28.0.220.ged08abb693-goog
> >
>
> Cheers,
> Nathan



-- 
Thanks,
~Nick Desaulniers
