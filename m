Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84209C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF80206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgE0L1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:27:11 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:35123 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgE0L1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:27:10 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MXXhv-1jVttD35Z9-00YwXx for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 13:27:08 +0200
Received: by mail-qk1-f175.google.com with SMTP id 205so10785812qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:27:08 -0700 (PDT)
X-Gm-Message-State: AOAM530vg0P08A0uFEzxS6AWocI6316m1BDTKGSkEie1ktEmna+w7PZ7
        fO7OgZJlM9f4emP04fHSsjWlb3J46UAIDG3cnJU=
X-Google-Smtp-Source: ABdhPJyMxE/W5GNu5lFSY1EOd7K9CvUP7yQNK8/+Tbr1HASdaxQjcTSuBjo0aDfkhpRntAs3TlQQ9L0EYFa8/53Vb04=
X-Received: by 2002:a37:434b:: with SMTP id q72mr3711430qka.352.1590578827661;
 Wed, 27 May 2020 04:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200527103236.148700-1-elver@google.com>
In-Reply-To: <20200527103236.148700-1-elver@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 13:26:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1MFgRxm6=+9WZKNzN+Nc5fhrDso6orSNQaaa-0yqygYA@mail.gmail.com>
Message-ID: <CAK8P3a1MFgRxm6=+9WZKNzN+Nc5fhrDso6orSNQaaa-0yqygYA@mail.gmail.com>
Subject: Re: [PATCH -tip] compiler_types.h: Optimize __unqual_scalar_typeof
 compilation time
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:J3mYKozi9qcfSPfrL19tbd/nl686s0nV1s9lUV7w/3ZibJ4OaI/
 6LMFOclqEandcqWFMX9im0hpI48GoOBgizJmm0LhaYvZyvv7szhdWDTsRImII8th1mfY9hi
 3aLED4+LHnzsOnrPoBiWos5ZKViJfaak2G0bF7rGRiuU7uvrUVgdnWQKOYIrcVTl4EcDi60
 ZfQzqOshlrtKbkQTRCe3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a0cE8+5pDVw=:oE+/BmVkRS4ikqU8wqm5RB
 yTbWeRGeg+e2PC7X0eRgGWkLzjNQh1zk+AtbNhT0tNf0EuZv726t+vN2Ik56iaxI3z6IPGTDD
 G5OQ4oV+lVL6BedS2crdC2kj3QQhCoLMjJKo+psxl/1qSkoO+6OdwWURXK+OT4Dat9QqMgt5A
 RRPo1Usd17GVQNREgt+SO7GWqJVA06RuedEOZMnUvxKiJxh3WArsrfTx1QNaa9QqLx9g5HJi5
 +eHk1Z/AUJZacURbpFdcv77p8+MtlZoExon3gRenBj14iNLXVHqTLUZEOQuYYcUMkz8T09yDS
 EyLk9zwyTpg5zF7wNqJyVs1f+4FYRG6r42DbG0+iAzE33Mfym6vtFRnfl4t5xlfbN5x1OuFaZ
 f9RzOKnk5jURhFYrMOT294bMhit+WNe4gLV1OZElEftS19iHjKuu0HyCuLmzRA7V314/8ANsU
 IQBzEWbeRfQj8Wwyv3f1lyw/EvBcGKYPmODIIutAGhdAnS0lGCZcKmF89NPk28xroX2Elq0wi
 hiSfdpvz1ys4mhqJ7BStYKem0Ro4mAAk6jPAsdewX0/i8bDVKiXYeTGB9u7jSMU9v7eRNWrvk
 Q/l1GEMdGzlXe/0NI0x+iwWKo9s1Ea9xV7eMgOdQ5SuivVQMEc0kgiS3wBGDSA+qr1ATKKe/n
 HP+DAZRjKQ9P65M7Zx+8TTW+9JBPtO7p5RG7JbzjPBPBDdA3tRTSFf9Ne8a8oyabWAwWKlGRk
 O0E6urzPwz3LG6Cn+xi/ZnVka9ujlpAJgswoAdOq1lHpn8pQGlxuadjKT017J/8NBvHmbvocc
 rWb1L6PWZa7irgUcm14yyVtk3Doewbe+fkHvrtgXy3I15D1mkg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 12:33 PM Marco Elver <elver@google.com> wrote:
>
> If the compiler supports C11's _Generic, use it to speed up compilation
> times of __unqual_scalar_typeof(). GCC version 4.9 or later and
> all supported versions of Clang support the feature (the oldest
> supported compiler that doesn't support _Generic is GCC 4.8, for which
> we use the slower alternative).
>
> The non-_Generic variant relies on multiple expansions of
> __pick_integer_type -> __pick_scalar_type -> __builtin_choose_expr,
> which increases pre-processed code size, and can cause compile times to
> increase in files with numerous expansions of READ_ONCE(), or other
> users of __unqual_scalar_typeof().
>
> Summary of compile-time benchmarking done by Arnd Bergmann [1]:
>
>         <baseline normalized time>  clang-11   gcc-9
>         this patch                      0.78    0.91
>         ideal                           0.76    0.86
>
> [1] https://lkml.kernel.org/r/CAK8P3a3UYQeXhiufUevz=rwe09WM_vSTCd9W+KvJHJcOeQyWVA@mail.gmail.com
>
> Further compile-testing done with:
>         gcc 4.8, 4.9, 5.5, 6.4, 7.5, 8.4;
>         clang 9, 10.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marco Elver <elver@google.com>

This gives us back 80% of the performance drop on clang, and 50%
of the drop I saw with gcc, compared to current mainline.

Tested-by: Arnd Bergmann <arnd@arndb.de>
