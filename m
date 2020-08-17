Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8440BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E18B20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SISFndTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390331AbgHQShO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgHQShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:37:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1FC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:37:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a79so8636199pfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qs4A+yO1as0umF/I9cYQ72bVP8PG6ZMKCk38nSsEIIo=;
        b=SISFndTkcUp1pFH8U2YJFkEw+BBQKq+fPBX0eplQ0w0CvJ7hvE9YNjpKcE135MBPmF
         aNGX23frr8ivsWZfRpIx6QCzwGTIyYb009KwfQPglZxUaQMAGseC48uBHP5u3tXn4Y41
         viemUxJp2fH19u/cR+4Li1Qh5Yt0qX3bEb5ezK61MDWVsYXc/1sy3x2sYodeRPMh73jt
         xacOsf6vqOjFVkL95ZrjdTHG5h3gxGixIkz2LYtqd7u/MxXS0iLkVgfIv7u6C2Ff4QiG
         OitIeDihGZSyo+I7KjXFEdUHSxPnYEEbNqC2Pjx3klB0C8VMJtcc/qPNYa4pZMBABFm+
         FJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qs4A+yO1as0umF/I9cYQ72bVP8PG6ZMKCk38nSsEIIo=;
        b=gplkAo12rIeQeSho07rMgTrAM2aDRgvmmCG9RganMlkW7x4a8urXUxi639tzW0/FAq
         +WJpN5b2eq2GzMqbB/VmST5ymqA0t90uamCi+xGf8zOm0aZhurG+UEZCOvffnF2cUSLy
         twoLJ1/K6sRq+QbJK9PyqK1OmglX5wjhYoN2Aqh6nf1tqh9xbXP6GAcP59rAYlgtT7E+
         qlXaaXD+/e0ajfkIRIJGeoJMVVlhfqTnBfbHR1CF/x/aF0cdkkdyWf62xsTKKEk4bf9R
         dS2Jg8Z+rrXPPu3+SKOTkJ4K7ouMxzCGq+lKKkmdf5kf9vb/OmtUbSoLtAIUDTdSU5rf
         pCvQ==
X-Gm-Message-State: AOAM5306TFvmf1rXIytrulg27MgNHXgnbczXdfJL3puuWtMXSzEYc8CY
        +okILe27JXV5wPV0B4+CBTw2PHNXm3AeeWLIg3mWYA==
X-Google-Smtp-Source: ABdhPJzSDKc0EvCiFo6KHm47j9PJB2kRpSihpJykKUkv7WSSdYOXLHmnjugILSKRGo8bc2gUQ1TMZ0JAA8w0atuBhWw=
X-Received: by 2002:a05:6a00:14d0:: with SMTP id w16mr12126301pfu.39.1597689420744;
 Mon, 17 Aug 2020 11:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200815014006.GB99152@rani.riverdale.lan> <20200815020946.1538085-1-ndesaulniers@google.com>
 <202008150921.B70721A359@keescook> <CAKwvOdnyHfx6ayqEoOr3pb_ibKBAG9vj31LuKE+f712W=7LFKA@mail.gmail.com>
 <457a91183581509abfa00575d0392be543acbe07.camel@perches.com>
 <CAKwvOdk4PRi45MXCtg4kmeN6c1AK5w9EJ1XFBJ5GyUjwEtRj1g@mail.gmail.com>
 <ccacb2a860151fdd6ce95371f1e0cd7658a308d1.camel@perches.com>
 <CAKwvOd=QkpmdWHAvWVFtogsDom2z_fA4XmDF6aLqz1czjSgZbQ@mail.gmail.com>
 <20200816001917.4krsnrik7hxxfqfm@google.com> <CA+icZUW=rQ-e=mmYWsgVns8jDoQ=FJ7kdem1fWnW_i5jx-6JzQ@mail.gmail.com>
 <20200816150217.GA1306483@rani.riverdale.lan> <CABCJKucsXufD6rmv7qQZ=9kLC7XrngCJkKA_WzGOAn-KfcObeA@mail.gmail.com>
In-Reply-To: <CABCJKucsXufD6rmv7qQZ=9kLC7XrngCJkKA_WzGOAn-KfcObeA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Aug 2020 11:36:49 -0700
Message-ID: <CAKwvOd=Ns4_+amT8P-7yQ56xUdDmL=1zDUThF-OmFKhexhJPdg@mail.gmail.com>
Subject: Re: [PATCH v2] lib/string.c: implement stpcpy
To:     Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>, Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 10:14 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Sun, Aug 16, 2020 at 8:02 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Sun, Aug 16, 2020 at 07:22:35AM +0200, Sedat Dilek wrote:
> > > On Sun, Aug 16, 2020 at 2:19 AM 'Fangrui Song' via Clang Built Linux
> > > <clang-built-linux@googlegroups.com> wrote:
> > > >
> > > > Adding a definition without a declaration for stpcpy looks good.
> > > > Clang LTO will work.
> > > >
> > > > (If the kernel does not want to provide these routines,
> > > > is http://git.kernel.org/linus/6edfba1b33c701108717f4e036320fc39abe1912
> > > > probably wrong? (why remove -ffreestanding from the main Makefile) )
> > > >
> > >
> > > We had some many issues in arch/x86 where *FLAGS were removed or used
> > > differently and had to re-add them :-(.
> > >
> > > So if -ffreestanding is used in arch/x86 and was! used in top-level
> > > Makefile - it makes sense to re-add it back?
> > > ( I cannot speak for archs other than x86. )
> > >
> > > - Sedat -
> >
> > -ffreestanding disables _all_ builtins and libcall optimizations, which
> > is probably not desirable. If we added it back, we'd need to also go

I agree.

> > back to #define various string functions to the __builtin versions.
> >
> > Though I don't understand the original issue, with -ffreestanding,
> > sprintf shouldn't have been turned into strcpy in the first place.

Huh? The original issue for this thread is because `-ffreestanding`
*isn't* being used for most targets (oh boy, actually mixed usage by
ARCH. Looks like MIPS, m68k, superH, xtensa, and 32b x86 use it?); and
I'm not suggesting it be used.

> > 32-bit still has -ffreestanding -- I wonder if that's actually necessary
> > any more?

Fair question.  Someone will have to go chase git history, since
0a6ef376d4ba covers it up.  If anyone has any tricks to do so quickly;
I'd love to know.  I generally checkout the commit prior, then use vim
fugitive to get git blame.

> > Why does -fno-builtin-stpcpy not work with clang LTO? Isn't that a
> > compiler bug?

Yes; Sami found a recent patch that looks to me like it may have
recently solved that bug.
https://reviews.llvm.org/D71193 which landed Dec 12 2019. The bug
report was based on
https://github.com/ClangBuiltLinux/linux/issues/416#issuecomment-472231304
(Issue reported March 8 2019).  And I do recall being able to
reproduce the bug when I sent
commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")

Now that that is fixed as reported by Sami below, I don't mind sending
a revert for 5f074f3e192f that adds -fno-builtin-bcmp, because the
current implementation of bcmp isn't useful.

That said, this libcall optimization/transformation (sprintf->stpcpy)
does look useful to me.  Kees, do you have thoughts on me providing
the implementation without exposing it in a header vs using
-fno-builtin-stpcpy?  (I would need to add the missing EXPORT_SYMBOL,
as pointed out by 0day bot and on the github thread).  I don't care
either way; I'd just like your input before sending a V+1.  Maybe
better to just not implement it and never implement it?

>
> I just confirmed that adding -fno-builtin-stpcpy to KBUILD_CFLAGS does
> work with LTO as well.
>
> Sami

-- 
Thanks,
~Nick Desaulniers
