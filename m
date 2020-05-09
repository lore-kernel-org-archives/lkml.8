Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF49C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 15:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F67D21473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 15:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGwdlqQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgEIPnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 11:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgEIPnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 11:43:42 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB3C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 08:43:40 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id c18so4298489ile.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lEIOZtiJn4C44cp9H/kzfk5fMu6jd8Gvk2kf7XAUT3o=;
        b=UGwdlqQA3m+b9Wg6a49Hwx3fQgTFQhq1p4ImuMAB3MkbEBgWLZCNgiIRyWo0tpu6b/
         I58M7mVzZghIs2YX1R+4zzdlAbwX1PY+EgyhRod8ZGZ3WPjOIi2/4/z3wOeJX/Sknh2m
         BNoLrk7wkAJSPf7V12qgSlPYMnhUPsKE8VaZRLUwcfe82imr57du6Bo5OrYtCvZ0/mij
         tIdI29U2pXmU9YpO2syHa9NVu6Qoi0lBJ5x9kokdAm8A0RiZGt1mvkNsEdRTGNoOri2I
         2GHJyN4e3utPl2fYrJz5KgkXXYUd959OZ6c1imW2tC4ko5cJ3+mFDlhQ6CpMOn/TYR0X
         H0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lEIOZtiJn4C44cp9H/kzfk5fMu6jd8Gvk2kf7XAUT3o=;
        b=MVEAyFyAwa8fQIMJdtguS6hYGyojJU4YGAm+S00xBFAfgREIJ+HX1oJ3WrIRjHgdBz
         Dyy8Vqf1QnGvsgNG070zU8XXBOnV+gW/hROXC9UCZl/Ik2pddBKf4Erqo634CDubOtr3
         FCG2fjzr+t0tuOhFz+edo5sTJfOgAa6ojq0Eu6E8AgZ+Vw7BNPsSQQzncRBY4z+bOsHI
         HuTmIrvGtfGIFTY5D9TpL8Bpcr4x5PfFozC4rzZGcaSOvg4tDLbjieBaoX0pFma2lg9K
         OZqd/qzcUBeQJ1Cv6HuOhl+CLrN/Wh3X22tQsXL/jIOClUQfUOAaHAYFA/458D7fTg2r
         c+QA==
X-Gm-Message-State: AGi0PuYiHLRTdVxRb0sOANJZKA0lamCZDNTaaXF4nz+JlUHx/xBq1Hxy
        qXSfUpg2YOqi8RiH9JyqwtuPPQzMo3o8/FZ2Sw==
X-Google-Smtp-Source: APiQypJOeOZEVWNePluYSilGtyJDJSN71OUtRPQkxSTG1FY8gDB/Q7oH+anSCMBIX0BhsMhliqxYV2twrYxAs9S+POg=
X-Received: by 2002:a05:6e02:d0c:: with SMTP id g12mr7913391ilj.27.1589039019986;
 Sat, 09 May 2020 08:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200508182835.228107-1-ndesaulniers@google.com>
 <20200508183230.229464-1-ndesaulniers@google.com> <CAHp75Vcsi9o2eUbyozhmPEz6Tfd_6ZFk2q-vcdrm9QxcVPQwMA@mail.gmail.com>
In-Reply-To: <CAHp75Vcsi9o2eUbyozhmPEz6Tfd_6ZFk2q-vcdrm9QxcVPQwMA@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sat, 9 May 2020 11:43:27 -0400
Message-ID: <CAMzpN2j4PhMMxZ6SOGxV9SfdbEZyuTNM-qNSTCZ8dv+irzi+4A@mail.gmail.com>
Subject: Re: [PATCH v5] x86: bitops: fix build regression
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
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

On Sat, May 9, 2020 at 8:20 AM Andy Shevchenko
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

Yes.  The operand width modifiers have been around a long time but not
well documented until more recently.

--
Brian Gerst
