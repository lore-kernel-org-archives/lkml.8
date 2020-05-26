Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3056C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE25B2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390798AbgEZTAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:00:42 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41755 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390758AbgEZTAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:00:39 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MHWzP-1jqYz61nhB-00DWzw for <linux-kernel@vger.kernel.org>; Tue, 26 May
 2020 21:00:37 +0200
Received: by mail-qt1-f172.google.com with SMTP id z1so4970154qtn.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:00:37 -0700 (PDT)
X-Gm-Message-State: AOAM533FP+3xy5hEgTc6kzXBQ37uL+tJvBpF1gubijXOwzz56oKi1jfr
        OAcaKIo+hejGlvUo2is1mtFEMYXWkB+kiLC0Otk=
X-Google-Smtp-Source: ABdhPJyxFIBjrso5flwbMzskJ0iFERf9bCDL1IHkg8XbIOolDiFbZCM5y+BlNca+wOzMJlz82Rirzft1rGNKPreeS40=
X-Received: by 2002:ac8:1844:: with SMTP id n4mr300518qtk.142.1590519636182;
 Tue, 26 May 2020 12:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200521142047.169334-1-elver@google.com> <20200521142047.169334-10-elver@google.com>
 <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
 <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
 <20200526120245.GB27166@willie-the-truck> <CAK8P3a29BNwvdN1YNzoN966BF4z1QiSxdRXTP+BzhM9H07LoYQ@mail.gmail.com>
 <CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com> <20200526173312.GA30240@google.com>
In-Reply-To: <20200526173312.GA30240@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 May 2020 21:00:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ZawPnzmzx4q58--M1h=v4X-1GtQLiwL1=G6rDK8=Wpg@mail.gmail.com>
Message-ID: <CAK8P3a3ZawPnzmzx4q58--M1h=v4X-1GtQLiwL1=G6rDK8=Wpg@mail.gmail.com>
Subject: Re: [PATCH -tip v3 09/11] data_race: Avoid nested statement expression
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YZvZtYzPL/ad9yexnmdrNznL+6Kj7ZbcdRnrfB6SJ6T3EEGT3S2
 1eZZL4jOMAVQMUSFSBEq6hpa87+1QwMQ0GGLzBKA/gpyJX3TDL0E0TN0QVzba/RTcJ2/fvG
 40MgQOmvi5nEEWeQ4yBoYAHqLzEfwOLrWkaHqh8WwPTsOaQbBVn81rOKdEsgrtbClT4NFaW
 chuPy9zVoZmuxh+bwXgdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kgXZ+s1WhxA=:j4tArGneAtjwl0yJKAWwBc
 yi3MVuFvE7LnXEgNrHZW3f+eHQaS/ssYpHTnuE3egIWG4ZTScgWkYnigUpl62Kex4A/8hTquW
 JrOHIshNbWkEiF5Xrgy9SGk1CZ5Dd9J8dAQk3tqt+c0Jjw9E8Cw7OnyJWNKV5LeK0XJFrcgtb
 Nx3KYK3q7W71sTh6XbKSDxUng2giWHY0nJq5ErFb0/L89Dv1pNWnZMAcNFoicYPPpJ+XjxGDq
 tRKyHqDnQRBw0LIVP//J7SHqq7S8h2Fm12tBkQVSQXCIxgF6XTtF5VdcUa5ns2R7JBcxhE1LG
 qKolhuXVGyxoGpCEI9+rF4K2GYXhfe4jRoLarZ8V7aTM1kDSfi+kcWsm3P3XVHGLTLZ97bKv/
 bSKHxL76gfRx/VSLfRRzOM5MSBihiOEmf8A/q2XEy6vLNhw/ed0Lun98pFJKqFKALwihrdNyd
 GD/hibBnWWySRJ6C/Rlzn9XbXh3f/D1F78HK5ygtwlmCjnXJDRPJXYECwQ2dALUue9o26sYqL
 GXMrIe+y8ZtSilfYHg4blo7wpQ7HNpWKmwQZ31snQA41u6f+P7GKcTdaDiZZyXbPgf4HfWMfv
 ojePz5MIKUrWTxuJMydE4LGAwRqHks/vryh6il680wuvvbu6EIxmeG2whycUOSs8PGG49SX4c
 hEIGV3rtdLSo1xxu4S4+qHW4AFXjCfL+bcNMFfY0elQH2CjnZTPyVPeGuK2tRwB2EqK0RR1KJ
 ZBRxjKxhF13CH1RqgW8L3x8gilZSbuIx15X4A7TJlj2cDa4NG4ocXx0ikGf8kJOc686uyxdKZ
 4g5elRdpIp4oEIgspvrJ5D68769mW3UlU5j6zo6N9USY3yV7HA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 7:33 PM 'Marco Elver' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
> On Tue, 26 May 2020, Marco Elver wrote:
> > On Tue, 26 May 2020 at 14:19, Arnd Bergmann <arnd@arndb.de> wrote:
> > Note that an 'allyesconfig' selects KASAN and not KCSAN by default.
> > But I think that's not relevant, since KCSAN-specific code was removed
> > from ONCEs. In general though, it is entirely expected that we have a
> > bit longer compile times when we have the instrumentation passes
> > enabled.
> >
> > But as you pointed out, that's irrelevant, and the significant
> > overhead is from parsing and pre-processing. FWIW, we can probably
> > optimize Clang itself a bit:
> > https://github.com/ClangBuiltLinux/linux/issues/1032#issuecomment-633712667
>
> Found that optimizing __unqual_scalar_typeof makes a noticeable
> difference. We could use C11's _Generic if the compiler supports it (and
> all supported versions of Clang certainly do).
>
> Could you verify if the below patch improves compile-times for you? E.g.
> on fs/ocfs2/journal.c I was able to get ~40% compile-time speedup.

Yes, that brings both the preprocessed size and the time to preprocess it
with clang-11 back to where it is in mainline, and close to the speed with
gcc-10 for this particular file.

I also cross-checked with gcc-4.9 and gcc-10 and found that they do see
the same increase in the preprocessor output, but it makes little difference
for preprocessing performance on gcc.

       Arnd
