Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A89DC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1142075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXlr3vZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgHRXWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgHRXWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 19:22:21 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB0EC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 16:22:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so3958256plp.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 16:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Unuqp3MGw5DwpQFycwpHM5ISIgKNxiJLUmRKr6fcjrU=;
        b=qXlr3vZC9+Qh50P3/0qUoZoQ9MWvxcp4bPmCotB8cVo/A44amT///Fkpr+w+1KF6eA
         Gp8jqeTVDW47Kh1uh7URCwPvFaERouBJJImcQ4sLgiAyZdxh46Vei5Z5CDs6QOViwxYd
         w5Z4Z64AsWPq+ZPyJslrJCfbntSFDHiJYf3t3E3e+q3c6Ut7A8cRyi6Wx/k0XcWTgmjE
         AhzsMmvyksDD5MaFOgzfHarnmbB6yuz9dFFg4IjYAJEydOICbO9YaKgsIdWgtRvorNW8
         a/+7Qzh98gVLGNDJRKIqIYAhWsV40VNSDTzemhVUOaznMBBOQ6FLoWdmQ2ewDH8E+yxv
         Bz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Unuqp3MGw5DwpQFycwpHM5ISIgKNxiJLUmRKr6fcjrU=;
        b=INVfBt3G+ATJLRo+ASZx5/Xy9m0DOscX2G9syMTfjArGm+GL2cz6p5UO5uu5IjZYq6
         PTmJV81PG20ovUa/CfMRPC1W84ZCnPayDKdCTi/3udI5HqpwG6VDppE3LbpeWNNkqzAt
         a8g65rQWRiL8TCMNBX91MFDqFK3oLNVVZ3JwsBSl2Lz4qnvC7EGm1fSsKEw74hwkc837
         ALqdau/UpiJG17010GwEQ/S56RoJ/j94Cozz8AJJWGJ5lkgJC+x53Z8cy6thTSPlWyzk
         QbyIJpVKF7f11nARsAG9IvF5gYHMG8zNE4liWgUP0/MiNRZn7VJT5Mr+7fHbmsc5QTz3
         Fq8g==
X-Gm-Message-State: AOAM532ByLQohYexTP/OfJ3qrIG237bvHfT3ecyG0n+PKPDFt/oAfuvz
        hqo3lU8COf6Yht8seeVrA1CED+0i50ibyHaYRImi6A==
X-Google-Smtp-Source: ABdhPJyyI6tmInC4U9JAh/QQICeSlHcUjFxQTZdBW8PsBj4Y+AvoY4xK+5xzVtKqeAoR2aLOU8GmbsddP1xudxxbnRg=
X-Received: by 2002:a17:90a:3ad1:: with SMTP id b75mr1701568pjc.25.1597792940705;
 Tue, 18 Aug 2020 16:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220212.338670-1-ndesaulniers@google.com>
 <fae91af3-4e08-a929-e5c3-25271ad7324b@zytor.com> <CAKwvOdk6A4AqTtOsD34WNwxRjyTvXP8KCNj2xfNWYdPT+sLHwQ@mail.gmail.com>
 <76071c24-ec6f-7f7a-4172-082bd574d581@zytor.com> <CAHk-=wiPeRQU_5JXCN0TLoW-xHZHp7dmrhx0wyXUSKxiCxE02Q@mail.gmail.com>
 <20200818202407.GA3143683@rani.riverdale.lan> <CAKwvOdnfh9nWwu1xV=WDbETGiabwDxXxQDRCAfpa-+kSZijb9w@mail.gmail.com>
 <CAKwvOdkA4SC==vGZ4e7xqFG3Zo=fnhU=FgnSazmWkkVWhkaSYw@mail.gmail.com>
 <20200818214146.GA3196105@rani.riverdale.lan> <CAKwvOdnW8zjcxmHwu5PhHa1hMFu=S=qPh5gfC6tN7FrSE+3kKg@mail.gmail.com>
 <CAOrgDVO=NBaqGP2Fs6X4FHeLfbaAA7Km8i2ttcGf0kwfojmVSA@mail.gmail.com>
In-Reply-To: <CAOrgDVO=NBaqGP2Fs6X4FHeLfbaAA7Km8i2ttcGf0kwfojmVSA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Aug 2020 16:22:09 -0700
Message-ID: <CAKwvOdnk6PrHGB-zam-aAxKG119x2o21COxjV9DnhU=WH3wjjg@mail.gmail.com>
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
To:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Eli Friedman <efriedma@quicinc.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
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
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 3:05 PM D=C3=A1vid Bolvansk=C3=BD
<david.bolvansky@gmail.com> wrote:
>
> st 19. 8. 2020 o 0:00 Nick Desaulniers <ndesaulniers@google.com> nap=C3=
=ADsal(a):
> >
> > On Tue, Aug 18, 2020 at 2:41 PM Arvind Sankar <nivedita@alum.mit.edu> w=
rote:
> > >
> > > Note that -fno-builtin-foo seems to mean slightly different things in
> > > clang and gcc. From experimentation, clang will neither optimize a ca=
ll
> > > to foo, nor perform an optimization that introduces a call to foo. gc=
c
> > > will avoid optimizing calls to foo, but it can still generate new cal=
ls
> > > to foo while optimizing something else. Which means that
> > > -fno-builtin-{bcmp,stpcpy} only solves things for clang, not gcc. It'=
s
> > > just that gcc doesn't seem to have implemented those optimizations.
> >
> > Can you please share some godbolt links that demonstrate these observat=
ions?
> Here:
> https://godbolt.org/z/qjo5P6

Ok, when I implemented this version that used -fno-builtin-stpcpy, I
initially+locally had it added to CLANG_FLAGS rather than
KBUILD_CFLAGS, but changed it to KBUILD_CFLAGS because I believed that
BOTH compilers would not lower calls to foo given -fno-builtin-foo.
Since we have evidence that's not the case, maybe that's the final
solution and my final proposal (v3). A summary:

1. v1 "implement stpcpy"
https://lore.kernel.org/lkml/20200815002417.1512973-1-ndesaulniers@google.c=
om/T/#u
"Please don't provide more unsafe string functions to the kernel"
2. v2 "KBUILD_CFLAGS +=3D -fno-builtin-stpcpy"
https://lore.kernel.org/lkml/20200817220212.338670-1-ndesaulniers@google.co=
m/T/#t
"-fno-builtin-* doesn't work like that on GCC"
3. v3 "CLANG_FLAGS +=3D -fno-builtin-stpcpy" TODO

I'll argue that providing an implementation of stpcpy while hiding the
declaration from include/lib/string.h "for the possibility that GCC
may one day perform the same libcall optimization" as YAGNI, that we
may cross that bridge by resurrecting v1 (with the removal of the hunk
against include/lib/string.h).  This also defers adding more unsafe
string functions in the kernel.

Thoughts before I send the patch and write that up?
--=20
Thanks,
~Nick Desaulniers
