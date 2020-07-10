Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9632078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ud9rqALw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGJSnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgGJSnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:43:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CA1C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 11:43:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 1so2900645pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYuroEkm2iKOQxY6pj/gfqkhyxMO++xcs210DAcWS70=;
        b=Ud9rqALwJwmlDroSos/tgzBr1/jqR2mvO0gazUk7wMLcl0gyyUiK511mYTvHKT+I/M
         Ebm9rlUvx5ZI3dexD4v440S94Z75Xk1eLU681iVvNkn3SxTlLQOl9LVqWYK5IyCvYcR+
         GSu1LCZW7TiXHYmqASYx0LVYFCI4nDHypM3png5NhrhYLbz/pezt9PSRNE5Sjk7wXIqg
         YoJ79x5kiNgLVQXIVTK2rXHa53Rk56vRvD3U+blcAjgjjNeEYFCct6ArNy9ckox64Jnz
         8hKCwIe8QAnfJbyqOintnkgL3Ty7NdjT9pObQLGLx2eyYqAynljaDhbieUw4Fq702ApJ
         sKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYuroEkm2iKOQxY6pj/gfqkhyxMO++xcs210DAcWS70=;
        b=toS4a81epj4ELIwdYICGDanEindLdzEmQOiJj7j/lQN2lTLsz6NM9iehuw1opjy95t
         OVpC5Xm0SUd+0NzeFb0f3c8IqnG5pu6IN+PKi/A2Why/WOwhMtPQCRAVGj7aHWZuakUr
         SXnq6NklnbFE6KzXgGewhsvX0TUeEG23tac0w3oiIXxDgMCugPm9dOKkKWZnbeDYCPl9
         XfwYdZ75VYnV9YyGPZ4ZyB+xnbBmyKDrEbg7RG2oEt62ESDovOTyqoYS/vmgeeZgA1UB
         /kSCoteCFDvCbg6Rxc799IUCWlTWMQ5VeBqU7NH2OFGhTVeuZMVAPK5RKR0hSLMW9beP
         NzLw==
X-Gm-Message-State: AOAM532Xt67p67km+0CsdBmpDKvg/VBRe32XQiOiJ/8KY3TPBAAikcRQ
        nzsEDjSCavOg+MRzl+7270Nd5I3/PpqU/hkjFr7V1g==
X-Google-Smtp-Source: ABdhPJzgdHO8Mp22WU4RPyqzLeCf3yqG9KDfs06VetMTYFiqYUcaP+D3wd7FaFZdDGwFvWoud3nL3arTIibJw19iIl4=
X-Received: by 2002:aa7:9303:: with SMTP id 3mr54726895pfj.108.1594406603521;
 Fri, 10 Jul 2020 11:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200709221102.323356-1-cesarb@cesarb.eti.br> <CAHk-=wjUEmO4GiC9mCyzZ8_WS=ZWgfg6CnpxPSLq=uoF1F3Xyw@mail.gmail.com>
In-Reply-To: <CAHk-=wjUEmO4GiC9mCyzZ8_WS=ZWgfg6CnpxPSLq=uoF1F3Xyw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Jul 2020 11:43:12 -0700
Message-ID: <CAKwvOdnbtbetfN5zF51QOXVhrutE8ak4uPe82iY6g9f6gwk=Vg@mail.gmail.com>
Subject: Re: [PATCH] Restore gcc check in mips asm/unroll.h
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Cesar Eduardo Barros <cesarb@cesarb.eti.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 5:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jul 9, 2020 at 3:11 PM Cesar Eduardo Barros
> <cesarb@cesarb.eti.br> wrote:
> >
> > While raising the gcc version requirement to 4.9, the compile-time check
> > in the unroll macro was accidentally changed from being used on gcc and
> > clang to being used on clang only.
> >
> > Restore the gcc check, changing it from "gcc >= 4.7" to "all gcc".
>
> This is clearly a thinko on my side: the old
>
>     CONFIG_GCC_VERSION >= 40700
>
> became pointless, so I removed, it, but it was mixed with an "||" so
> we actually wanted to make it unconditional on gcc, and instead now it
> checks for CLANG version even when it shouldn't.
>
> My bad, and your patch is obviously correct.
>
> At the same time, I do wonder if  we could just remove the check for
> CLANG_VERSION >= 80000 too, and just remove all the compiler check
> hackery entirely?

What I'd really like to see as a policy in the kernel going forward in
that ANY new commit that adds some hack or workaround for a specific
compiler version add a comment about which toolchain version was
problematic, that way when we drop support for that version years
later, we can drop whatever hacks and technical debt we've accumulated
to support that older version.  I'd prefer a comment that can be
`grep`ed rather than a commit message that may need to be searched.
That way when bump the compiler version we can grep for comparisons
against that version and start cleaning up code.

The case that comes to mind:
commit 87e0d4f0f37f ("kbuild: disable clang's default use of
-fmerge-all-constants")
cites https://bugs.llvm.org/show_bug.cgi?id=18538
The fix for which shipped shortly after reported in clang-6.
https://github.com/ClangBuiltLinux/linux/issues/9
Looking at the dates between kernel patch and toolchain patch, I guess
that the kernel patch authors didn't know what release that workaround
would be fixed in, but basically they need it for CLANG_VERSION <=
600001.
We can remove that entirely if we commit to a minimally supported
version of clang.

Also, I'm a little salty still about our conversation with
asm_volatile_goto:
https://lore.kernel.org/lkml/20180907222109.163802-1-ndesaulniers@google.com/
I think lore is missing your response, that triggered a v2:
https://lore.kernel.org/lkml/20181031182909.169342-1-ndesaulniers@google.com/
(Strange, I literally cannot find evidence that you ever responded to
that...am I going crazy? Looks like my work email has been being
auto-deleted because...lawyers) (lkml.org is missing it:
https://lkml.org/lkml/2018/9/7/1628, and I didn't have our mailing
list set up then).
You also know how I feel about empty asm statements (`asm("");`). ;)

Anyways, the point is "please tag these workarounds with a toolchain
version somehow such that someday we may pay off our debts."

>
> Older versions of clang weren't very good at compiling the Linux
> kernel in the first place. Do people actually use old clang versions?
> That sounds like a really bad idea.
>
> People who used to build the kernel with clang tended to actually get
> their clang version from the clang git sources afaik (I still do, but
> that's because I test experimental new features that aren't released
> yet), exactly because back in the bad old days there were so many

Thanks for the endorsement. :P

What's the latest on that `clac` in exception handlers discussion?

> problems.
>
> These days you can use release versions, but they'd presumably not be
> older than clang-8.
>
> Adding Nick - is it really reasonable to build any kernel with any
> clang version before 8.0.0?

TL;DR: probably not.

For Pixel 2, we shipped a Clang built kernel using clang-4.  Since
then I've moved it to be using near ToT Clang (clang-11).  That device
was aarch64 with no hard dependency on `asm goto` (only x86 added
that, and only in 4.20, so not really an issue for stable kernel
branches older than that).  `asm goto` support shipped in clang-9.

>
> It turns out that the arm side also has a check for clang < 8 because
> of -mcmodel=tiny, so raising the minimum required clang version to
> that would solve that issue too.
>
> Right now we don't mention minimum clang/llvm versions in our docs at
> all, because we only mention gcc. Mayeb this would be good to clarify.

Yeah, I think so, too.

Are you planning on attending plumbers? I'm planning a session on
talking about this more, which I think would be helpful.  What I
really want is the CI people in the room, because I don't want to
claim version X+ is supported if we don't have the CI coverage of it.
Also, there's a few footnotes as to our compatibility table at the
moment; completely missing backends, broken backends, targets we only
got working recently, etc. etc. etc..  I also think we need to be
delicate in the wording for what tools are required for building a
kernel vs optional or substitutes.

Will older versions of clang work? It's highly likely and we don't
have a list of what if anything is actually broken with them.  But if
we can get CI coverage for the latest release or two, I'm happy to
commit to supporting just those.
--
Thanks,
~Nick Desaulniers
