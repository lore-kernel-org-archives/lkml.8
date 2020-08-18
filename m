Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BFCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890312076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQI6Q38E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHRR4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgHRR4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:56:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927ECC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:56:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f5so9559293plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Ygro6ZmmBrAQ3Ge0EmFg9GP+aL+Ga3m5lt2/R8NNas=;
        b=XQI6Q38EghTc5vUI/aD1z4EwDR1oK8MqdnV1yp3t0SWOJAkD3MCYIAeE7NDmqUPlo9
         yWE1k2OKBB0gq9ig2IfaIwNotcHm6U04mWX7zMKau0ODENqPSQXZszwxzcB5ET/KQaZ3
         wMh1SFAHA+zFgMrLVv87vpWA2I5hCE7ebZhbR2zG2mTy00bS53LBdIDYx2GU2nbInmob
         a0fHDUHzbUxzDoAMBMlbnkHhkYpqlPPgQj/cpNveb7U3j/TYqimaX8A4RJ4Qx2kj/cAb
         HA5GsJ9apBYm7bLPkG2UxfFHBeo3CoDCZPu6h+kFdoSK0L1elq0pdj6y8whN/UbDt9Sw
         1H5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ygro6ZmmBrAQ3Ge0EmFg9GP+aL+Ga3m5lt2/R8NNas=;
        b=FRA4pI3huxr136hg2Xtrwq99AShacDCL5HrWFQXfUWAmdBI3Rt8dzDf73KxT0PkBz5
         1rLnn5loISbDfMc4W3psYxSXo25vn2ncg+8+BItLW6e+qZ360Qd0AWCg1nfAWUM0ML4m
         8PxsI39OvLF6qWItyGrsEpZ8O4nCaJF7lfgCDTF9JJnkp8TLVCCS8ysyYKY+s01QMJ0V
         aB3P5azO1IpwL6rZi3SBJLsuKUDvbDunuhrUXk39fI9rDL9ZCUS2d7Ybc1IAC+0MCwmR
         js/cRsC+tOcqeeTs6TlrSd9S3yj6k+0Mt4c1cHp5uFnEgu3xaLaTk4L9da8CA5lzfIK2
         NZ+w==
X-Gm-Message-State: AOAM531Tm3+ush9xwCC8CV/EhWere/sXuaT7OBu0x9kWcaOmPk6RkjJT
        dgbjy/5A/GqoXs1Zb6w6UCtq31v+CH33QbFnq89UcA==
X-Google-Smtp-Source: ABdhPJyeROL9HRysZlPErl7V5nWgRHsn034kbuZotHXaMjGv8zMYJXZEEIF51l0+2rBOfBQqg6dLHYSLr6VHCTPGE4E=
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr15848823plb.179.1597773410297;
 Tue, 18 Aug 2020 10:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220212.338670-1-ndesaulniers@google.com> <fae91af3-4e08-a929-e5c3-25271ad7324b@zytor.com>
In-Reply-To: <fae91af3-4e08-a929-e5c3-25271ad7324b@zytor.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Aug 2020 10:56:39 -0700
Message-ID: <CAKwvOdk6A4AqTtOsD34WNwxRjyTvXP8KCNj2xfNWYdPT+sLHwQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
To:     "H. Peter Anvin" <hpa@zytor.com>
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

On Mon, Aug 17, 2020 at 3:44 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 2020-08-17 15:02, Nick Desaulniers wrote:
> > -ffreestanding typically inhibits "libcall optimizations" where calls to
> > certain library functions can be replaced by the compiler in certain
> > cases to calls to other library functions that may be more efficient.
> > This can be problematic for embedded targets that don't provide full
> > libc implementations.
> >
> > -ffreestanding inhibits all such optimizations, which is the safe
> > choice, but generally we want the optimizations that are performed. The
> > Linux kernel does implement a fair amount of libc routines. Instead of
> > -ffreestanding (which makes more sense in smaller images like kexec's
> > purgatory image), prefer -fno-builtin-* flags to disable the compiler
> > from emitting calls to functions which may not be defined.
> >
> > If you see a linkage failure due to a missing symbol that's typically
> > defined in a libc, and not explicitly called from the source code, then
> > the compiler may have done such a transform.  You can either implement
> > such a function (ie. in lib/string.c) or disable the transform outright
> > via -fno-builtin-* flag (where * is the name of the library routine, ie.
> > -fno-builtin-bcmp).
> >
>
> This is arguably exactly the wrong way around.
>
> The way this *should* be done is by opt-in, not opt-out, which by almost
> definition ends up being a game of whack-a-mole, like in this case
> stpcpy(). Furthermore, it is unlikely that people will remember what
> options to flip when and if stpcpy() happens to be implemented in the
> kernel.
>
> The problem here is twofold:
>
> 1. The user would be expected to know what kind of the optimizations the
> compiler can do on what function, which is private knowledge to the
> compiler.
>
> 2. The only way to override -fno-builtin is by a header file with macros
> overriding the function names with __builtin, but that doesn't tell the
> compiler proper anything about the execution environment.
>
> So the Right Thing is for the compiler authors to change the way
> -ffreestanding works.

Sir, this is an Arby's

There are things all across the compilation landscape that make we
want to pontificate or even throw a tantrum in an Arby's.  Would I?
Well, no, I'm just trying to flip burgers or shovel the elephant
sh...or w/e they do at Arby's (I've never actually been; I detest
roast beef).

Would it be interesting to have a way of opting in, as you describe,
such that your compiler knew exactly what kind of embedded environment
it was targeting?  Maybe, but I'd argue that opting out is just the
other side of the same coin. Heads, I win; tails, you lose. That the
opt in or opt out list is shorter for a given project is not
particularly interesting.  Should we change the semantics of a fairly
commonly used compiler flag that multiple toolchains are in agreement
of, then fix all of the breakage in all of the code that relied on
those semantics?  I'm afraid that ship may have already
sailed...probably 20 or 30 years ago.

> -ffreestanding means, by definition, that there
> are no library calls (other than libgcc or whatever else is supplied
> with the compiler) that the compiler can call. That is currently an
> all-or-nothing choice, or at least one choice per C standard implemented.

Yes?

>
> Instead, a compile job with -ffreestanding should be able to provide a
> list of standard C functions that the compiler may call, and thus the
> compiler actually can do the right thing depending on which exact
> functions it would consider calling. This list is probably most easily
> supplied in the form of a header file with #pragma directives.
>
>         -hpa
>
>

Here we have a one line patch for keeping the build green.  If there's
some compiler feature you'd like implemented, let's sit down sometime
and work out the details.  I'll even buy you a beer.  But right now,
sir, the Arby's is on fire.  Please take your soapbox outside.

--
Thanks,
~Nick Desaulniers
