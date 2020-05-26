Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E54C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A916020776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdyQtTqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgEZP7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgEZP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:58:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D29CC03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:58:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so10269395pgm.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7yc95hCwkWEN+v9r46J5YAvFPMk9mORHt815pdcg/k=;
        b=VdyQtTqGLVpzwyT0yK2q09yOYYGaPYBDeCrZPf6I3lP9sXj6eaeXtjYSbyWcjRcRVB
         IGVz7YLs+Mpo3PmGTYJjrcr+BBt+vcQUrIJAS4e+QQ37Rxhg3+DCbAGxTd4yiQ8z435E
         o3L4IkwjkizhVyu435UKCyXEJljrpvBj39AoqqiJNiuCfPzRGu4ImQPH63XzFpL4C8gK
         Y7+cuLRftNAdfACfm+tmw7G5DyA0DMQcYlmfoTvh0G/864P5+InIOhiLeUwJhXnAoXbw
         NceTxmjYrWI8gE66byoWpprW9h75l5uX2SkR4pdwzgvSLWh9TBYr2xjqkcHSo/140StA
         XVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7yc95hCwkWEN+v9r46J5YAvFPMk9mORHt815pdcg/k=;
        b=M8ctndrHkmkT7QCueRNkyNjRfjWeQSvZ4QuX5vs3vo27UWmwBRIKiObP8GxJXt1F8v
         ci73pj2LAVAvTkADsSh6zzoI5tvje3SyIeSL/TYyoIWEEdYqX+iV59/QiRYxm1XuuF4t
         UoWAkYGjQDE4qAN0R8/3WL6WmKoM05dO/Hy2lZoYX8yaoy3MXuN+5VsKV23iHwdTfooL
         vW/m+JTa3crxJOO2bWrI5k8S0cvpbZ7W8GQbCV3E2dwLAWE5+CVYxG5JhqkYJd7WDTe2
         uREmsNojSdREKsKkRwyzqgzoGTZmtPrg3H1bYw83NIkSHVA+Zilotrhw/WJN4utVXUCm
         c4zw==
X-Gm-Message-State: AOAM531Dx2v9giFizWZ4KZiCAOEVPfp/F345y16q9660I3rHG8rxp1S6
        cvSar5q8bGHvPerBJ6C48WDVeOawiHjYLF+Fz1obEQ==
X-Google-Smtp-Source: ABdhPJzM65WN8McT+MdJ+HQHekoZwZ6spY5wjKzL3/1sjXl3L/xw6V7J34HUU8eCCAPAIehKgGdM18vgi9GtcuminmE=
X-Received: by 2002:aa7:8c44:: with SMTP id e4mr22491829pfd.108.1590508738615;
 Tue, 26 May 2020 08:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <10f4fb0b-1012-b0e6-af05-0aa5a906de21@redhat.com>
 <20200520193637.6015-1-ndesaulniers@google.com> <CAK7LNAS_PMz9r3e1UcuM+r18JC2KeM2RqGOms1u3kVzN_N1MmA@mail.gmail.com>
 <CAKwvOd=jOr4ZaLx-dSNTqZnGRATY1PZktUfu4JGWKRwRH=Ujnw@mail.gmail.com>
 <CAK7LNARofo7wawEF4EcA2-wxnQkKw+WFoJ36EOeYFTUrthRfrA@mail.gmail.com> <CA+icZUXwNLG3ojWMhTuNkvR0AYtc1+BG6neOLZo56CB7ij01JQ@mail.gmail.com>
In-Reply-To: <CA+icZUXwNLG3ojWMhTuNkvR0AYtc1+BG6neOLZo56CB7ij01JQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 May 2020 08:58:47 -0700
Message-ID: <CAKwvOdn-zRA88QWc2EtLB4M9+VN_yLpzXXa+AGHW668sF2_z+Q@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: support compressed debug info
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Nick Clifton <nickc@redhat.com>,
        David Blaikie <blakie@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 12:48 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> *** The opposite is the case. ***
>
> Here, I am on a Samsung SandyBridge CPU/GPU aka 2nd generation
> ultrabook series runing Debian/testing AMD64.
>
> A slightly modified Debian-kernel linux-config takes me approx. 5 (in
> words five) hours of compiling and generating Debian packages.
>
> Plus, testing.
> Plus, testing.
> Plus, testing.
>
> In Linux-next times I run the whole Linux-Test-Project tests plus some
> FIO tests.
>
> Finally, I decide depending from what is new and interesting to me to
> attend a full single Linux-kernel release cycle.
> The last was Linux v5.3 which was the first release to be
> compile/link-able - with no modifications - with LLVM/Clang/LLD v9.0.
> For upcoming Linux v5.7 I have built each single RC Linux-kernel and
> used it in my daily work!
> Since RC1 - for me running on bare metal counts - checking QEMU or
> other VM is nice - but showed me that says sometimes nothing.
>
> Plus, I am building llvm-toolchains (LLVM/Clang/LLD) and testing with
> them (and report if needed).

This is a lot of invaluable work.  It means the world to me Sedat!

>
> "...if we diligently credit our idea reporters, they will, hopefully,
> be inspired to help us again in the future."
>
> These are some motivating words...
>
> My Tested-by is like a certificate - like a "Made in Germany" seal :-).

I love this, it is.  Maybe if folks on this thread are bored, they
could help me with a personal project of mine?
https://github.com/nickdesaulniers/What-Open-Source-Means-To-Me
We could use more German, and Japanese.

>
> Virtual Greeting from North-West Germany,
> - Sedat -

-- 
Thanks,
~Nick Desaulniers
