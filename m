Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06F5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B8820890
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgE0J1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 05:27:12 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgE0J1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 05:27:11 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M58vU-1jcmPR1REy-001DGZ for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 11:27:09 +0200
Received: by mail-qk1-f169.google.com with SMTP id c185so9553227qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 02:27:09 -0700 (PDT)
X-Gm-Message-State: AOAM533EaXypvXV/RPIxrCu71t0DINIG6KNdkkKK9RWB+1dvKDp4i7n9
        pwU58BFWPJmmVxPFZ092O4sPGuW4TogAL7UQ5Cw=
X-Google-Smtp-Source: ABdhPJzkT5QDMDvcQ6ejl8sl6wd/LQhNAfsVk7IEt0pH2byVzyEGYVLDvQPCW4598CVgxFHaFoVEUY9oABgjhh3Wl9s=
X-Received: by 2002:ae9:c10d:: with SMTP id z13mr2828308qki.3.1590571628188;
 Wed, 27 May 2020 02:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200521142047.169334-1-elver@google.com> <20200521142047.169334-10-elver@google.com>
 <CAKwvOdnR7BXw_jYS5PFTuUamcwprEnZ358qhOxSu6wSSSJhxOA@mail.gmail.com>
 <CAK8P3a0RJtbVi1JMsfik=jkHCNFv+DJn_FeDg-YLW+ueQW3tNg@mail.gmail.com>
 <20200526120245.GB27166@willie-the-truck> <CAK8P3a29BNwvdN1YNzoN966BF4z1QiSxdRXTP+BzhM9H07LoYQ@mail.gmail.com>
 <CANpmjNOUdr2UG3F45=JaDa0zLwJ5ukPc1MMKujQtmYSmQnjcXg@mail.gmail.com>
 <20200526173312.GA30240@google.com> <CAK8P3a3ZawPnzmzx4q58--M1h=v4X-1GtQLiwL1=G6rDK8=Wpg@mail.gmail.com>
 <CAK8P3a3UYQeXhiufUevz=rwe09WM_vSTCd9W+KvJHJcOeQyWVA@mail.gmail.com>
 <20200527072248.GA9887@willie-the-truck> <CANpmjNO2A39XRQ9OstwKGKpZ6wQ4ebVcBNfH_ZhCTi8RG6WqYw@mail.gmail.com>
In-Reply-To: <CANpmjNO2A39XRQ9OstwKGKpZ6wQ4ebVcBNfH_ZhCTi8RG6WqYw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 11:26:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1BH5nXDK2VS7jWc_u2B1kztr4u9JMXhWF9-iZdrsb-7Q@mail.gmail.com>
Message-ID: <CAK8P3a1BH5nXDK2VS7jWc_u2B1kztr4u9JMXhWF9-iZdrsb-7Q@mail.gmail.com>
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
        Borislav Petkov <bp@alien8.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/I6/dQJLsm12Wrx747jKQ/XV7txwet5pFgidFgA1eiBkWeCl8gr
 WAutPPBp4SiXlVyj8HfUjJ+wkQACVQcKIc8wO9vmaLcZlkEbFJb40+eBJvRdwnNSw4zO666
 uJax3GKkUWuD76UVoy9ye21BTrhAn2e1bf4MMF/eD8aL1qhbOL4CnCWCGh/gh5ZXzWebyRd
 WErOCvN/ufEuejrIxX5UA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mRc7YvyaHpc=:zTEU4UgBfMQGw6t7xc7v4m
 g6d5VelbOf6WllApzNQxWHNI/dwmMM7RvvIHIjmqIRn0gPAi/2fqXUuyAzIIT0LJrknR6wrih
 KAJo7EUcK0VyXTlvQjp4sP8YPLGCOpbm0bEdBb2oi64ht5bWuN8KP7k0ml4xmhiAQ+YwSAxJo
 4DAgSe1big6AU7rrsIEPpBUTPj5Rye2RFAT5ecxpLBqhpedeiHmNZIQjyA+jJyVmj/AKfiYzD
 bYtaSfRQWnUT/V7VcBTz1A737/w1cs8hGtssIeMdhbXNfZbCVwks/XAYDVW8AIkfITEeX5tKH
 1JTlMtQfZyXr2ak3WnJQG5gr+eRahHk+8wQeFuWJno5nPa1JrGL80+AVnjMFEVr1zEZzqE9fk
 Mj3TIs+I4JQ211dgYwPT2m5miwWPVgbWgpDLJXPIqMWRMokOJUfMjhWh9/1YQPODCBaxXps2j
 OAwSW/cSEy9MGd9NyInBBYggaZU5A30lWuGYIx4qGP6DfmrfHZjtAkceglthpRjtwLPRyFNiP
 I0/T/rNsNI6dQGalZ+8XBXuAhgnQWprMog/Qo+AqYJgYFu+HnpGGnoZwrziA4WXTrj6uTF1DJ
 By/6Q+8EoBH9sPdmQHWd8Ymaq5ORKBarOmqwt+T+txkJtNd3UGDxM0Sd4zjxICTqGw32D2qpZ
 8x70qvOxFD3DJQFSXqVOZAYiACpFnq4lVSwYuvRKxoyDKnm2EKhQZW+VKXbt3/nEwjvTLMO2g
 AfOvZ27SRvl5l47UHJgsFmVtmHZozNrCyp3HmM6hOX/DsQrwHw/4tRSwhysyamtPLJUJHtBJO
 LR8l1x/7RtQS+9pai5BasFcxPo9fS4x3ulavmy7SMVqc5ADuTM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 9:44 AM 'Marco Elver' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
> On Wed, 27 May 2020 at 09:22, Will Deacon <will@kernel.org> wrote:
> >
> > Nice! FWIW, I'm planning to have Alpha override __READ_ONCE_SCALAR()
> > eventually, so that smp_read_barrier_depends() can disappear forever. I
> > just bit off more than I can chew for 5.8 :(
> >
> > However, '__unqual_scalar_typeof()' is still useful for
> > load-acquire/store-release on arm64, so we still need a better solution to
> > the build-time regression imo. I'm not fond of picking random C11 features
> > to accomplish that, but I also don't have any better ideas...
>
> We already use _Static_assert in the kernel, so it's not the first use
> of a C11 feature.
>
> > Is there any mileage in the clever trick from Rasmus?
> >
> > https://lore.kernel.org/r/6cbc8ae1-8eb1-a5a0-a584-2081fca1c4aa@rasmusvillemoes.dk
>
> Apparently that one only works with GCC 7 or newer, and is only
> properly defined behaviour since C11. It also relies on multiple
> _Pragma. I'd probably take the arguably much cleaner _Generic solution
> over that. ;-)

I'd have to try, but I suspect we could force gcc-4.9 or higher to
accept it by always passing --std=gnu11 instead of --std=gnu89,
but that still wouldn't help us with gcc-4.8, and it's definitely not
something we could consider changing for v5.8.

However, if we find a solution that is nicer and faster but does
requires C11 or some other features from a newer compiler,
I think making it version dependent is a good idea and lets us
drop the worse code eventually.

> I think given that Peter and Arnd already did some testing, and it
> works as intended, if you don't mind, I'll send a patch for the
> _Generic version. At least that'll give us a more optimized
> __unqual_scalar_typeof(). Any further optimizations to READ_ONCE()
> like you mentioned then become a little less urgent.

Right. I think there is still room for optimization around here, but
for v5.8 I'm happy enough with Marco's__unqual_scalar_typeof()
change. Stephen Rothwell is probably the one who's most affected
by compile speed, so it would be good to get an Ack/Nak from him
on whether this brings speed and memory usage back to normal
for him as well.

      Arnd
