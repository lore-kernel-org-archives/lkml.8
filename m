Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E8CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6871020772
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NuXj/bvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgHRTZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgHRTZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:25:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE27C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:25:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s14so3709392plp.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VmA06WjlqS7hJumtglP3Mb+v0u9+PDAlYaWZ4/eDGk=;
        b=NuXj/bviyolsRmu1RDbGz62VrMp2i+ohDBzBrMXgR+/HnFYFj/0i0LEFqlai3FiY2c
         kuQgJP40nkVZmAvEHb01vxOtwtfup5F8I4t3mmfPA+JMwR2OdWbevHG/++mRPaoSZ+h6
         Z/neGTcxbz6ZHKdi4jqvnpQ4DQ8Cy5OdPvx3EMxID0/JEPk+WBINjqEkq3YcIbZmoS2r
         1B7rxYFTF2g1fMnX1C70UCaAcNU/xYAcR/TZpQqoOOKgNip49d0iNQhJGyD+AV/QVjCh
         TRn/YZCIZQDPIXv4IxI3aAoQ+nmd0FFaUsj7vVZz7F5wClGHzyNTrcwNLtaaVTN+eYKe
         U/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VmA06WjlqS7hJumtglP3Mb+v0u9+PDAlYaWZ4/eDGk=;
        b=Lgc9smvdTJwl9iRC9TDnN9oWaD68WACF9B4doEXnoSIMeSQvcaPAPysQfb5B2Rgo1Y
         3dt+4C687rERGVwhbOOugh8+dz6VjT0U4iubjsXW7Uc8+ooXytNDDBYjQUtv4R/sBAZb
         DHoGkGZ8DvJcBewGlaf10kkt3tUzsC/ldD2cwqadRp/47fhF1/gdtuePe0GuMzvxNgkG
         XrQf/bDn8jAadud8nHVZgP7jhUViz0Tc+V1xeZ8ahn2aPVC4fg1eXhXrHH/0n2Xbzko9
         jSHvutgFlOk3w/jFTq6B6mYQQGELhnreoWcdqrKmyEXDCp/0mbi1eG7NJV4Lt7g8YmES
         t9cg==
X-Gm-Message-State: AOAM533P9j44N64j64tFQ0ewPLzHnBvw2Qd9eHMP+rCgl2aq/DwK6Kyh
        R+fVTjwgZAyMTzU/HdufCzaXOJ3gKrPwZ8zsNpUp2A==
X-Google-Smtp-Source: ABdhPJwxx1f0NE1gsAd0REazhAGW9P8NHb/mLCL8RGa65Vokt+VBDaggXlEgOnSEpKnk0JZgk7WbE+XpHf3q4L/Ml+g=
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr1162103pjp.32.1597778741520;
 Tue, 18 Aug 2020 12:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220212.338670-1-ndesaulniers@google.com>
 <fae91af3-4e08-a929-e5c3-25271ad7324b@zytor.com> <CAKwvOdk6A4AqTtOsD34WNwxRjyTvXP8KCNj2xfNWYdPT+sLHwQ@mail.gmail.com>
 <76071c24-ec6f-7f7a-4172-082bd574d581@zytor.com> <CAHk-=wiPeRQU_5JXCN0TLoW-xHZHp7dmrhx0wyXUSKxiCxE02Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiPeRQU_5JXCN0TLoW-xHZHp7dmrhx0wyXUSKxiCxE02Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Aug 2020 12:25:30 -0700
Message-ID: <CAKwvOdkut+GTLxX9U=hxDC8SaugW487XD_98d9yFU2VzShyz0A@mail.gmail.com>
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Clement Courbet <courbet@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Aug 18, 2020 at 12:03 PM H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > I'm not saying "change the semantics", nor am I saying that playing
> > whack-a-mole *for a limited time* is unreasonable. But I would like to go back
> > to the compiler authors and get them to implement such a #pragma: "this
> > freestanding implementation *does* support *this specific library function*,
> > and you are free to call it."
>
> I'd much rather just see the library functions as builtins that always
> do the right thing (with the fallback being "just call the standard
> function").
>
> IOW, there's nothing wrong with -ffreestanding if you then also have
> __builtin_memcpy() etc, and they do the sane compiler optimizations
> for memcpy().
>
> What we want to avoid is the compiler making *assumptions* based on
> standard names, because we may implement some of those things
> differently.
>
> And honestly, a compiler that uses 'bcmp' is just broken. WTH? It's
> the year 2020, we don't use bcmp. It's that simple. Fix your damn
> broken compiler and use memcmp. The argument that memcmp is more
> expensive than bcmp is garbage legacy thinking from four decades ago.
>
> It's likely the other way around, where people have actually spent
> time on memcmp, but not on bcmp.
>
> If somebody really *wants* to use bcmp, give them the "Get off my
> lawn" flag, and leave them alone. But never ever should "use bcmp" be
> any kind of default behavior. That's some batshit crazy stuff.
>
>                Linus

You'll have to ask Clement about that.  I'm not sure I ever saw the
"faster bcmp than memcmp" implementation, but I was told "it exists"
when I asked for a revert when all of our kernel builds went red.
-- 
Thanks,
~Nick Desaulniers
