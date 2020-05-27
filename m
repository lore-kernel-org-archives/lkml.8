Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73526C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CAD8207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgE0Mb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:31:26 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52487 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgE0MbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:31:25 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N3bb1-1ivknH0RIR-010ZZl for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 14:31:24 +0200
Received: by mail-qk1-f172.google.com with SMTP id c185so9965730qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:31:23 -0700 (PDT)
X-Gm-Message-State: AOAM5316YI3pT+kXks7wwJZUYj+IgmtR2tKN1NQ5bEAhbkS5HKyG7CNo
        P6NjU2DwTg+Hr3F8+/f1sRw6f/iiemrYgBr4F9o=
X-Google-Smtp-Source: ABdhPJy+DIja/rYj4frYWtQK9fb6NOOBdkItZSOJngfCTwueSXdO4GIuDHPs8sOzmDUB9tIsxetSsQlRzOrUfhK6DMI=
X-Received: by 2002:a37:434b:: with SMTP id q72mr4003383qka.352.1590582683017;
 Wed, 27 May 2020 05:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200527103236.148700-1-elver@google.com> <CAK8P3a1MFgRxm6=+9WZKNzN+Nc5fhrDso6orSNQaaa-0yqygYA@mail.gmail.com>
 <CA+icZUWtzu0ONUSy0E27Mq1BrdO79qNaY3Si-PDhHZyF8M4S5g@mail.gmail.com>
In-Reply-To: <CA+icZUWtzu0ONUSy0E27Mq1BrdO79qNaY3Si-PDhHZyF8M4S5g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 14:31:06 +0200
X-Gmail-Original-Message-ID: <CAK8P3a04=mVQgSrvDhpVxQj50JEFDn_xMhYrvjmUnLYTWH3QXQ@mail.gmail.com>
Message-ID: <CAK8P3a04=mVQgSrvDhpVxQj50JEFDn_xMhYrvjmUnLYTWH3QXQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:RZEd1IDi31CFLHqM/PVJubG9aykZPIKmvo2DAIiIX7Q/CrtzNdo
 qQrk16AKnOwoGul7/a0bZSylHZs5sysIC56JY2bgWORZzhfvfUelHcQhuZ21BunT+ck8xce
 1ScpsWoL0sc+Ik+X7XTGu4MMNX7s5wRs+/7Oo0jhTIeDkXjCNrjtyTfJ7+gZmdWiOYJ5lod
 35T2pRTmhbgu0NEQKrEfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:67xoUZ9rMd8=:x+4WxF7+pml6DkU+TsT9zU
 GcB96kdNt7W65Jcsn6EtR+o0S+iQbyktk5TYe1sLOEeskcSSKmv23cy9yBJ19+tzVEtU9OrJQ
 CJRgFReVnavhNmRFT6ODS7axmiTHBPTY7nlD+R/LsLAkrhmMVL616Yc/MAHBohdGSwO4YQKCV
 N3tMlhhy4yQatOcctAGdd7CpbTgnxFJeQzgk/6e8QaXOYt35ebVZMEo+TwLOqxyBZROeYjCrf
 7c1wf414YExyFl4RGtVca2HrUiOdeB8TPWDyXQZzoZpYW2ArzcKPF3QH5CT98i7jlUvK6mmZ/
 LnVoeFlkWqh+Bb9UnbgYF6NTdwuNAqChEp+YBxEtE1LT78PDwWYZj2WBd1HoSobmSO89uDQMD
 4SrArx1t9PeiB4Q7xw3fXSVsolzjswvLNNyZibaMWCFpHPs3FEpyei/h5gdnpjCOknQKSBh9n
 Y+43n8ucoslIGvBf3P88nOZRJEhUadOwVcdX/6tKosLaljMj8EW+qyKEZ9GOdbbXCSOSyLeYm
 jCbUu0XzYpN80Ivp7bNnCL6aoD8J8GKGzKQ/NLLQWwGq3YRZHC95eKXsoBJK2fIPSkK3WNSv3
 6Zf0GmQ+N4UEcncvW47qAzZTbrZ2Gi3jZ4KLa9QzXa/oOI7E6N3Y9SJCzIAEWSGbfXo/j+ZB8
 K5i7uvRa7xGk1k9VI4mp06RKVlKoOiaaJOQcxBW+e7uq1LP1wlAO0gk5toXfaPzZ7Ql0YKqD/
 qp/I+fxXl60r653AygGZiB7ObWjgTAHHaEX9bdkQf/jd2718+W0kh/9EW3KsrLtlloTqcTJoL
 yfB55PWTcF69pxYyyJDj79cXGNeZxqM/7IdH1QSe9+RoTgDDWE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 1:36 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Wed, May 27, 2020 at 1:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, May 27, 2020 at 12:33 PM Marco Elver <elver@google.com> wrote:
> >
> > This gives us back 80% of the performance drop on clang, and 50%
> > of the drop I saw with gcc, compared to current mainline.
> >
> > Tested-by: Arnd Bergmann <arnd@arndb.de>
> >
>
> Hi Arnd,
>
> with "mainline" you mean Linux-next aka Linux v5.8 - not v5.7?

I meant v5.7.

> I have not seen __unqual_scalar_typeof(x) in compiler_types.h in Linux v5.7.
>
> Is there a speedup benefit also for Linux v5.7?
> Which patches do I need?

v5.7-rc is the baseline and is the fastest I currently see. On certain files,
I saw an intermittent 10x slowdown that was already fixed earlier, now
linux-next
is more like 2x slowdown for me and 1.2x with this patch on top, so we're
almost back to the speed of linux-5.7.

      Arnd
