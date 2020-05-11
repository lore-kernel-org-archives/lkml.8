Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A01C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD4420714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rPnvvhM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbgEKRXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbgEKRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:23:05 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EC9C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:23:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z1so5041817pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlU0Pkz6j22HfbQ80ouXzz2uZEOYNyQ2PJlwm4Zo3WQ=;
        b=rPnvvhM7pnMqt96kcVjKpglyVZo17KrilC53ASlRznUT2hq5aRipQwuwIxw9iLFa0K
         laAZufC5GyLRiPWpjffqW3E08CTCXsiWClNyPeb2N060+P3ZDVoPxBgN6OCFDHx0J0JG
         c4go7yGcLP9Xf5+2+fLnboHalXp4SJWEFcgWxhljhYlVlAydacAyRPzV1k/zMNq7+r9l
         OAMzcnu01ah2Kt2ZycSxc/UNU2aJ4A2Ra427kpMT0ZWfNnZIs+l72hsxNKdSGMxG9wcd
         P1D2Cfq2HNET8q7C50DCQjuEtvKgoJs7bAUebMZmFZFIfjdpGKjLOWllEWLZxYoQXVO9
         ch9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlU0Pkz6j22HfbQ80ouXzz2uZEOYNyQ2PJlwm4Zo3WQ=;
        b=p9j6vammx/X1qwIvIN5M++0fKAXndvkoFPl1RPGnVj/FCz+BTA9xm8kbovsb8pHgkw
         sYw5RZX9coCZPsfsn2r+/cn7fvVBACHrk2+C521MxJTAeC+v7JmUbNLZGbYzmy/KE2RJ
         zB7tiAXkojyGO8kbrvIShAK02ojq9OJSav9TvxoWz1kO0k2o6xuLlJhDOSvMw1uLAS+n
         pF+PszLRLka9/2tMUdHmtSvvxy4HweQOfHYg78KRw1Ayym26IQkan3okiDElRM3w/Z8c
         gmK4XLri+/DlPYCfT9BhNlxjilI6Cz0+Nxb7Rqz1Tp0th9B8y/ruYNPBxa/VGHZajjOG
         NHhg==
X-Gm-Message-State: AGi0PuZErHqAQtNf3thM8DsJMvl+kLsSw4wXiR5p9+/Lt4WzppuNUGDN
        QsFEw1bxlYbLyT+pZah68q1qJY2BuFKPRBSGxkMyKA==
X-Google-Smtp-Source: APiQypKxAvopTHZOhx+05Dz1BqhBhXGjoDgrvs5Z85Uce20N4862DqDs0PkgV0opzCppXCOhH80ys+JRYAgXQdL1ygQ=
X-Received: by 2002:a63:6546:: with SMTP id z67mr15178554pgb.10.1589217784231;
 Mon, 11 May 2020 10:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200508182835.228107-1-ndesaulniers@google.com>
 <20200508183230.229464-1-ndesaulniers@google.com> <CAHp75Vcsi9o2eUbyozhmPEz6Tfd_6ZFk2q-vcdrm9QxcVPQwMA@mail.gmail.com>
In-Reply-To: <CAHp75Vcsi9o2eUbyozhmPEz6Tfd_6ZFk2q-vcdrm9QxcVPQwMA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 May 2020 10:22:50 -0700
Message-ID: <CAKwvOdn6YUZvatghWSScNcJMd2Y3_dfU5ZtY2in=DDYdFweVOQ@mail.gmail.com>
Subject: Re: [PATCH v5] x86: bitops: fix build regression
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Brian Gerst <brgerst@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Axtens <dja@axtens.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 5:20 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, May 8, 2020 at 9:35 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > This is easily reproducible via CC=clang+CONFIG_STAGING=y+CONFIG_VT6656=m.
> >
> > It turns out that if your config tickles __builtin_constant_p via
> > differences in choices to inline or not, these statements produce
> > invalid assembly:
> >
> > $ cat foo.c
> > long a(long b, long c) {
> >   asm("orb\t%1, %0" : "+q"(c): "r"(b));
> >   return c;
> > }
> > $ gcc foo.c
> > foo.c: Assembler messages:
> > foo.c:2: Error: `%rax' not allowed with `orb'
> >
> > Use the `%b` "x86 Operand Modifier" to instead force register allocation
> > to select a lower-8-bit GPR operand.
> >
> > The "q" constraint only has meaning on -m32 otherwise is treated as
> > "r". Not all GPRs have low-8-bit aliases for -m32.
> >
>
> Looks very good!
> One question though, does it work with minimum supported version of gcc?

Yes; the oldest version of GCC in godbolt.org is GCC 4.1.2 which
supports the syntax and generates the expected lower-8-bit register
operands.
-- 
Thanks,
~Nick Desaulniers
