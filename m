Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0BEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C162075A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgE0TCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:02:07 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgE0TCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:02:06 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MIKs0-1jq4X13IGa-00ENRg for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 21:02:03 +0200
Received: by mail-qk1-f170.google.com with SMTP id c185so603004qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:02:03 -0700 (PDT)
X-Gm-Message-State: AOAM532sB6/jeilJxtLLBEaXpr2jz6ByCtGym3NGq0T2o9bnmBdLUCjB
        rZmdLn3Q+za9YUJZ+u4HBombIWwOk2MbLUYr+jg=
X-Google-Smtp-Source: ABdhPJwq+qdSIbiijJoMpTV5KNo+HMxDbqV0keMpndldq1/phr5UvORkX0XTaSA40f5jDgNW7TVRTxEO5JZKmpceUbo=
X-Received: by 2002:a37:554:: with SMTP id 81mr1438379qkf.394.1590606122697;
 Wed, 27 May 2020 12:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134016.753354-1-arnd@arndb.de> <20200527152406.GD59947@C02TD0UTHF1T.local>
 <CAKwvOdn637hSboMnMV=S5f1wbiEnc6qtnrn=fpeCGtvr2W_Daw@mail.gmail.com>
 <CAK8P3a3-L-AQomvTcBv-KH1cVVu6uYNT_-2Ofir3UgwzGjcSug@mail.gmail.com> <20200527183517.uhph2pvnkyf6c5p7@google.com>
In-Reply-To: <20200527183517.uhph2pvnkyf6c5p7@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 21:01:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1tSKYeDDmAK3o6thazjbua-KmxRNQPX9448qjgp8iV=g@mail.gmail.com>
Message-ID: <CAK8P3a1tSKYeDDmAK3o6thazjbua-KmxRNQPX9448qjgp8iV=g@mail.gmail.com>
Subject: Re: [PATCH] arm64: disable -fsanitize=shadow-call-stack for big-endian
To:     Fangrui Song <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qfCIxHU4xtkU6kYOiO4WR3efKPvSdChPUMWYT7MQfvzYolSB8jv
 Y5gF1HOmqT2scxeMbIzA5JukozrBXoFJgAqlO84UZp+DtqzCvYPdCV1lkRltI+kw6v9GcwH
 QrvuoHu9Td6sAzn2vyhLYl/CtMaZZx5ZZe71chLDRJNhtRulH+7Wpfnb6V0B0sSwYV3zBif
 8E/t/izOcWLtS7O/OpuOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kxf/pA2iKbg=:YMVjswfl+2uwSk9O8I7tAu
 E6m5LCqOZ0hzeuWYt9NjZnfQ7NFyQZbmXcirP/Elq7O7vyEo7p1P6vfWAbW7+MERVTkIWXYO3
 jsRQ7hqCdKNgCv27/3hlqtl0PJfJ+wSDLDugVln4xwaptUJcc4BEPNqeoU74oZ1Re5JAyLj4c
 HcIMqu4mqwvOVuGKFCS0xTtQuSCXxghhY/DrZdMOd6Lw3LmLxN7Tmiu0Sh3ULI8hsk/6oOjQq
 1Y0lZTvO2hhesoWxmp+M4mTvPMFgFNru5yMp7y6xfMAX86hfy2u74rjrpC/BHnV61Tg1fi8Lh
 FkJpg7bU6keabe5T0QruI8xe2huiD74G4PqDVoR0fkq7xFDFtMF82x35fxTGRjp3nOlVIk5ce
 KrSHnHiKYFGm1ra4zQj3eAmlDI6SHLjvdqLuMm6pBP9tmXtBBnQ0jnM4A68lwtq5l3LH+Zwp0
 d1ETm/2jLP3bKsplX4mO1VIka1RqalNxvmwWz0L7fjaTf2qn1t8Wt9jPiH/m8Omwzo/gQnIqJ
 I9FzRvC2HbVPld7w4kcQVwsNmZEqspSHeGlrOoLerkn/pXXfq3iuhnUv7JGoSjrAyVUzTs/so
 1N+cD3i/g64jn2B1HYceLfzOr1k+nwZXvqAz8R5H6SEznUZ9C4oydOTCoYuq7BDX4MoJN1nba
 rd4Pw9P/19RzstcsWUYH8V2Orfm9mMZHcUSf8PSE38Q7tXRuHrEFUizA3WchvPyZY+rWU9UF3
 A6ihFz+im+YIdVCM+RemxJ4vXPS4lo0VVtJP1iLqqlnogQTKxZcBwXu9dhNDhUhjN16627eCJ
 Jmn3zqNhLtky999MOq8LKmm6hsaLpW2IMah1/AIbQhu5FxdsFg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:35 PM 'Fangrui Song' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
> On 2020-05-27, Arnd Bergmann wrote:
> >On Wed, May 27, 2020 at 7:28 PM 'Nick Desaulniers' via Clang Built
> >Linux <clang-built-linux@googlegroups.com> wrote:
> >>
> >> On Wed, May 27, 2020 at 8:24 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >> >
> >> > On Wed, May 27, 2020 at 03:39:46PM +0200, Arnd Bergmann wrote:
> >> > > clang-11 and earlier do not support -fsanitize=shadow-call-stack
> >> > > in combination with -mbig-endian, but the Kconfig check does not
> >> > > pass the endianess flag, so building a big-endian kernel with
> >> > > this fails at build time:
> >> > >
> >> > > clang: error: unsupported option '-fsanitize=shadow-call-stack' for target 'aarch64_be-unknown-linux'
> >> > >
> >> > > Change the Kconfig check to let Kconfig figure this out earlier
> >> > > and prevent the broken configuration. I assume this is a bug
> >> > > in clang that needs to be fixed, but we also have to work
> >> > > around existing releases.
> >> > >
> >> > > Fixes: 5287569a790d ("arm64: Implement Shadow Call Stack")
> >> > > Link: https://bugs.llvm.org/show_bug.cgi?id=46076
> >> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> >
> >> > I suspect this is similar to the patchable-function-entry issue, and
> >> > this is an oversight that we'd rather fix toolchain side.
> >> >
> >> > Nick, Fangrui, thoughts?
> >>
> >> Exactly, Fangrui already has a fix: https://reviews.llvm.org/D80647.
> >> Thanks Fangrui!
> >
> >Ok, great! I had opened the bug first so I could reference it in the
> >commit changelog, it seems the fix came fast than I managed to
> >send out the kernel workaround.
> >
> >Do we still want the kernel workaround anyway to make it work
> >with older clang versions, or do we expect to fall back to not
> >use the integrated assembler for the moment?
>
> We can condition it on `CLANG_VERSION >= 100001` (assuming Tom (CCed)
> is happy (and there is still time) cherrying pick the two commits https://bugs.llvm.org/show_bug.cgi?id=46076 to clang 10.0.1)

Good idea. I assume we will keep requiring fairly recent clang versions
for a while now, so chances are that 10.1 or 11.0 becomes the minimum
supported version not too far in the future and then the workaround can
be dropped again.

       Arnd
