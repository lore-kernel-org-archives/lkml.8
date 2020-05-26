Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135ABC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED96220787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbgEZMTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:19:38 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731015AbgEZMTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:19:37 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M1HmE-1jbtrZ3BjG-002saG for <linux-kernel@vger.kernel.org>; Tue, 26 May
 2020 14:19:35 +0200
Received: by mail-qt1-f175.google.com with SMTP id i68so15891567qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:19:35 -0700 (PDT)
X-Gm-Message-State: AOAM532Ae+BXV0G+53KiIvJJEjthnSLnIHhOyLXc+LPrWg84Q9XeZZ3g
        /YT1d8h6D7+YIrj7CC7ZSGfc5Nbwr0OIB5MQIKQ=
X-Google-Smtp-Source: ABdhPJwdD1D/KIQJZpMZeGW018U6HWC8yka4YAqI3CIEYgVww9sz2HdZxhqCV/zv/PcyZ7/B1gLTyWI084lrF1/gt+A=
X-Received: by 2002:ac8:1844:: with SMTP id n4mr902345qtk.142.1590495574644;
 Tue, 26 May 2020 05:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200521142047.169334-1-elver@google.com> <20200521142047.169334-10-elver@google.com>
 <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
 <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com> <20200526120245.GB27166@willie-the-truck>
In-Reply-To: <20200526120245.GB27166@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 May 2020 14:19:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a29BNwvdN1YNzoN966BF4z1QiSxdRXTP+BzhM9H07LoYQ@mail.gmail.com>
Message-ID: <CAK8P3a29BNwvdN1YNzoN966BF4z1QiSxdRXTP+BzhM9H07LoYQ@mail.gmail.com>
Subject: Re: [PATCH -tip v3 09/11] data_race: Avoid nested statement expression
To:     Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>,
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
X-Provags-ID: V03:K1:SE/gvWfeE/SIzGMqtl2A7Q68ELumP+NF2vxdMaVGdsuooOGS7oQ
 AXlaZqD/Bvl2LS/gorZuENzakgLPCaNxABbf/iOiwKlkaj9v4/0F33VLlLKNnxO834yrgHL
 WhryL4Pxw1lA7IXqT4maY0Q5nVyS0yMg+npx6BqfK3yBUEvA+A2jODF16EQj3L43lP7wxQS
 ljzAhrAgXEGuT1KbISNFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ELzj+VvYnQo=:185uAJ9MGsse8OYnf45WCV
 4/2P+DWDdBDCb4LaKhYWsNhzLY3coCVLT3wvgST7mZ4HLcUGoSjuXCltA/jZph2p6nSx8+kmy
 PQaWu2F9Iz6m4SIb+gnCAUEVOd0U1CvuwHdcetWp4P38aafPd1GZRh1RN32WHPPpBpinXCchl
 jCRZNhPPUIiWkprcZPQrSFOzS4myHO8qtIlwhZgyyG/pT8e+kqkuCJR2qvbPu8XEAgusllWcD
 3Tdxfpn/DIZ9gDZ+HKy4p5BQ2vbQCHh0qX6mQvQuCp3iZf767hZ2WocP4H/5D6P8ro+esa4SU
 JkySshoi9VDQt06l1g6MVlxhvadGXv010K/qO5H8R9gHRK53+nCGT4grN3AwPja5hA4961jZj
 nMYwUt/3E8vkPLTbsL/6Cltd/fWpM4V5ugx6IuIg/WfHlbf9XgRfzqZ0oZiInLZOCZd0I7S8+
 vo9FywNV56sFbsPBgAB0Azfpo9O+r8c0R5uBYFyk1d3uY1emtutFZaLS4sB5eeWkhpl+iOS66
 yepci+ri1jTcRNOY+DDHyhTHc9wMW3bwFoVMVrXc83RlwlJITNkcOpuhRVM1kOl6HOm3dMi4X
 gG0P8TytIqtNy0RRDfFGFX/EU//EtKIPYgxwzusQdT/HWQlRVKMSK7xriLDoDkeAMhIjg7U3i
 Bw9AH1iiL1mp3WGpCCk9Sh7Zq8lUeuvFfqcOvMLrIMpjZm7/lskUzC7flCMXv43GCMrKwVCM6
 zb/ekI+BM4IDu18NO7nAchcYGpleF5O/oji/DLouC8bICgCtAxikpjajZ596DWXVEF4rI04Ku
 bxhCDObEo0YLy3fwyAUfY1B+rvyM02QpHfdpmDGJzrolMmsUXE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 2:02 PM Will Deacon <will@kernel.org> wrote:
> On Tue, May 26, 2020 at 12:42:16PM +0200, Arnd Bergmann wrote:
> >
> > I find this patch only solves half the problem: it's much faster than
> > without the
> > patch, but still much slower than the current mainline version. As far as I'm
> > concerned, I think the build speed regression compared to mainline is not yet
> > acceptable, and we should try harder.
> >
> > I have not looked too deeply at it yet, but this is what I found from looking
> > at a file in a randconfig build:
> >
> > Configuration: see https://pastebin.com/raw/R9erCwNj
>
> So this .config actually has KCSAN enabled. Do you still see the slowdown
> with that disabled?

Yes, enabling or disabling KCSAN seems to make no difference to
compile speed in this config and source file, I still get the 12 seconds
preprocessing time and 9MB file size with KCSAN disabled, possibly
a few percent smaller/faster. I actually thought that CONFIG_FTRACE
had a bigger impact, but disabling that also just reduces the time
by a few percent rather than getting it down to the expected milliseconds.

> Although not ideal, having a longer compiler time when
> the compiler is being asked to perform instrumentation doesn't seem like a
> show-stopper to me.

I agree in general, but building an allyesconfig kernel is still an important
use case that should not take twice as long after a small kernel change
regardless of whether a new feature is used or not. (I have not actually
compared the overall build speed for allmodconfig, as this takes a really
long time at the moment)

        Arnd
