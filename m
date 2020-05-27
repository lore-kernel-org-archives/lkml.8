Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4949FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B15F2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgE0Muk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:50:40 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40779 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgE0Muj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:50:39 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M4bA0-1jcHM340LG-001iuT for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 14:50:38 +0200
Received: by mail-qt1-f182.google.com with SMTP id y1so8302052qtv.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:50:37 -0700 (PDT)
X-Gm-Message-State: AOAM533XfK+m0PwVoC+cdZqeF0LQ4SigZG+CSvh/ATeRHQ8V5JcaWRn0
        A1u+eE8mSQ3DySJyjaRiNTim4YdfnUtKGYxsIHA=
X-Google-Smtp-Source: ABdhPJx20udF+dw7mm7gvALJ3Shi6o19LcsetLnO/1t3pasrdggEXONy0LdbDLSI8is7yzMeSPhw064eSdt94SBno7I=
X-Received: by 2002:ac8:1844:: with SMTP id n4mr3896231qtk.142.1590583836877;
 Wed, 27 May 2020 05:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200527103236.148700-1-elver@google.com> <CAK8P3a1MFgRxm6=+9WZKNzN+Nc5fhrDso6orSNQaaa-0yqygYA@mail.gmail.com>
 <CA+icZUWtzu0ONUSy0E27Mq1BrdO79qNaY3Si-PDhHZyF8M4S5g@mail.gmail.com>
 <CAK8P3a04=mVQgSrvDhpVxQj50JEFDn_xMhYrvjmUnLYTWH3QXQ@mail.gmail.com> <CA+icZUXVSTxDYJwXLyAwZd91cjMPcPRpeAR72JKqkqa-wRNnWg@mail.gmail.com>
In-Reply-To: <CA+icZUXVSTxDYJwXLyAwZd91cjMPcPRpeAR72JKqkqa-wRNnWg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 14:50:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3i0kPf8dRg7Ko-33hsb+LkP=P05uz2tGvg5B43O-hFvg@mail.gmail.com>
Message-ID: <CAK8P3a3i0kPf8dRg7Ko-33hsb+LkP=P05uz2tGvg5B43O-hFvg@mail.gmail.com>
Subject: Re: [PATCH -tip] compiler_types.h: Optimize __unqual_scalar_typeof
 compilation time
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
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
X-Provags-ID: V03:K1:kFETjL0+C0Lrv27og+SqcX6djBmuPQsR8i4Uc7qTUGqX6Fu17v8
 TsDgE4gP+Y+HJH+seBGW9tUZ7m/YYigAElbE8+QtHQS2wZr1d8kWOKfWtELRENSIwJW8+Xm
 VvbFEeIdIEwmooVUeGLsZDUa03NHI393HLXfsa1rdzD0QZ31BrbYNqC8QL4K5CqiKYI3Bc7
 MQ5znmJ9EilxBkYAfVdsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yjc2mT/onzY=:2XXZzBi0EkKMa6VcNef6+k
 pwwHctM9w/RAvHjm/z6MXXXWZWMz6HE2A9U9t5AmqnVffTXypwrasnwFjK7ylScGfju0Gfi9P
 zWDKRrvAAWbcVFPfG+m5/xPG/gm/ar8AVI4H1z0wd0HzJZnerFicXbuHg/uqvY+nNnhHa1HBe
 eXVH4Bjm8NpyzImznrliC4keKsdXt8Y2ylnbe2dNQBKUle7I8SUau9qHY/AVkqcj6B6qsDYt3
 J2QkfgFAbSTHKaBz9rJR6B6lXsSOV8wqMgkka5IomGgSFfWV4hq4598+nEhrV2ekUENQfDz4E
 wE0MZPEogKM/lu+mFjPWKkYx25VoL8S+/Qobj0mrgHWchkaxpH8XBxvtPYMltHOmwCC/+ReS1
 ns1G2H424cNfaQUYndZ1TdsDv4xxSkHKYkqSN0utAT0nTli2JKaOrzXd6cUXV3nya01e0art0
 9foTKexYAIjGfNoXElHmWRrlfnx9J4W7GFAR44XapW00iOdhwwZ3AUIp10YgAN1qSdyLNbJMe
 Hj05pE35FriQctvmm+SdI4/onKuk/23Kdn9Ah2mlgBxPGI1i2GT4oAmLnfGJcp8bHZV84IbwA
 txTuyQRduD3qYv9/eo4BtqUay0NRN2SDGFhj4VLLmli8TN0BM0GWCu8WzIuhMrvTWFJzMv1FV
 +rigUuOEVcYT9tyiGX+qxkt8fq7n6H0xBbodU2XHacuKyI54PQUV4eMBz6G/OmTGfFil+rNCE
 UyQFzf6jW9k660J40mF6oFTWKJz19BRWtGnfzpg2Abm8bKo6+D8/ofJJEjQ/4cs9Awob0/SQa
 5nnEM9+SJZQtQ7BMRSW61sFb+4oNI6NI4QcQ1Y1Wh8F6bSudnE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 2:35 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Wed, May 27, 2020 at 2:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, May 27, 2020 at 1:36 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > On Wed, May 27, 2020 at 1:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Wed, May 27, 2020 at 12:33 PM Marco Elver <elver@google.com> wrote:
> > > >
> > > > This gives us back 80% of the performance drop on clang, and 50%
> > > > of the drop I saw with gcc, compared to current mainline.
> > > >
> > > > Tested-by: Arnd Bergmann <arnd@arndb.de>
> > > >
> > >
> > > Hi Arnd,
> > >
> > > with "mainline" you mean Linux-next aka Linux v5.8 - not v5.7?
> >
> > I meant v5.7.
> >
> > > I have not seen __unqual_scalar_typeof(x) in compiler_types.h in Linux v5.7.
> > >
> > > Is there a speedup benefit also for Linux v5.7?
> > > Which patches do I need?
> >
> > v5.7-rc is the baseline and is the fastest I currently see. On certain files,
> > I saw an intermittent 10x slowdown that was already fixed earlier, now
> > linux-next
> > is more like 2x slowdown for me and 1.2x with this patch on top, so we're
> > almost back to the speed of linux-5.7.
> >
>
> Which clang version did you use - and have you set KCSAN kconfigs -
> AFAICS this needs clang-11?

I'm currently using clang-11, but I see the same problem with older
versions, and both with and without KCSAN enabled. I think the issue
is mostly the deep nesting of macros that leads to code bloat.

        Arnd
