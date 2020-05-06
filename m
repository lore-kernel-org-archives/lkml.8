Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09D2C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36072068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgEFK3J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:29:09 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:60075 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgEFK3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:29:08 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MD9Ox-1jNmq203jl-0095nl for <linux-kernel@vger.kernel.org>; Wed, 06 May
 2020 12:29:07 +0200
Received: by mail-qk1-f169.google.com with SMTP id 23so1354370qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 03:29:06 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ9rqVWW2WDFNBR01tVoBGyKzybHwIZcCnfLwH67ZnSUOGZhZam
        TgjTtEczLpTsqEagNizFu5gV4hkb23YBInvh3gI=
X-Google-Smtp-Source: APiQypLplZDjvgilEtNOvewSJ4/Rigx9zKpijezGZjbjJHJFpHNinyeAHrYJil4GkKYLbPsidhx2J3DNgSsgw1MT/WA=
X-Received: by 2002:a37:aa82:: with SMTP id t124mr7608771qke.3.1588760945935;
 Wed, 06 May 2020 03:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200505141546.824573-1-arnd@arndb.de> <30d49e6d-570b-f6fd-3a6f-628abcc8b127@suse.com>
 <CAK8P3a0mWH=Zcq180+cTRMpqOkGt05xDP1+kCTP6yc9grAg2VQ@mail.gmail.com>
 <48893239-dde9-4e94-040d-859f4348816d@suse.com> <CAK8P3a2_7+_a_cwDK1cwfrJX4azQJhd_Y0xB18cCUn6=p7fVsg@mail.gmail.com>
 <2c6e4b36-6618-1889-55c4-16eeb1ef6f57@suse.com>
In-Reply-To: <2c6e4b36-6618-1889-55c4-16eeb1ef6f57@suse.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 May 2020 12:28:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a05wLCy0GT88mc451h3uXuU86aZ7XC=YXYXi12J0dFJkw@mail.gmail.com>
Message-ID: <CAK8P3a05wLCy0GT88mc451h3uXuU86aZ7XC=YXYXi12J0dFJkw@mail.gmail.com>
Subject: Re: [PATCH] xenbus: avoid stack overflow warning
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Yan Yankovskyi <yyankovskyi@gmail.com>, Wei Liu <wl@xen.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:6DGL6ePIVowI5ADFNHUf0pHfFmh8vfXmng/tiZDheNg7HItF0uc
 V9nFJQKI+OY2IlkhsI7Hg+n9znchrD4Rr9BTtD/njpbhgTu27mASA5TBwweXNBc+J6cimPH
 uMqIENvy722zYcx95zageDUmQhf/LYhYl3J991l2fQx0+PlgzvDqOxztW6qvZQqFObhqzwU
 2gImdXAy6zEhlhVvb86MQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:by0lQNdOh9A=:5m76rTrjSeCd3UnHmfkMOI
 bwZzCevCBF83rtZveOFMlMJoAi+PsKryA6m6jco2p0tRSrlhdeSTit+hlvQFPebx2vTOqO3eN
 OD6NwInbLRu3WjwloYAGZu65f0FKMwNB2KpAmniVbg+0+MVWmOmZRzHhbs7lMIXRzWUSYCtmb
 sJH/QMKcCWRlC4xEHcuOhNenW7qdndX2gjZrYKXma8JChmJUst5wz1J2Wa9IKf9BYXOlWvX+I
 jE4GXKGhbjmKPnNVgvr8x7tDK/3hzLfb5DUDAOVxC+Gp1AHbMB3Gr1cr9nlQtbsAvXDf+EXLk
 x9Ud7VHYeBMolir0yPH1Jss7sWU3TBWGZbpzy830p7dzCq8q4RANaRywVFsSLXkuevPsWbK+a
 G6pVbeyXP5qROdik6eRzoz3fnlVD9RSuLOB9teXqjxI8Vz9sFTgQlavfWd95XYyajVKPLe0kl
 kCukU86c9YY9jIqu0MHGBXV7HjZh0WnCjZAC5jokWs9WS/jt2QMYuVIpn+tmfiqaPntMaLPUt
 J1D3+6RzhwIn88A0uya04Attp6KFJBOaqJJa/U+4XGU0/LL5z9L32W0/Rdh/vA4BfH2IPUqbp
 TFKCJPWBxTdtC3LbmAbqdHgtmlWm4nGUNuP88q5aQvffpiU5lHvv2zJuECcgqSEoprkWdLLEl
 eH8VieVjDKwlTXLopLR8mjDuV9Uqavn17miO+6YsobwUWOxu5V5WcHQYEqRqyPGl0jOz5PyN2
 kKK9+3fKufbLEr9WveEaTP6TkvqIMw2i7lumow18lMOxXFr5eZx3uXiKx4c9yYM7LJuAvaT0q
 6v/IZbYodTHLnEBarc8KAhPr41LmueiIFppLEn9mm8Iv3qDA2s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 7:12 AM Jürgen Groß <jgross@suse.com> wrote:
>
> On 05.05.20 22:57, Arnd Bergmann wrote:
> > On Tue, May 5, 2020 at 6:02 PM Jürgen Groß <jgross@suse.com> wrote:
> >> On 05.05.20 17:01, Arnd Bergmann wrote:
> >>> On Tue, May 5, 2020 at 4:34 PM Jürgen Groß <jgross@suse.com> wrote:
> >>>> On 05.05.20 16:15, Arnd Bergmann wrote:
> >>>
> >>> I considered that as well, and don't really mind either way. I think it does
> >>> get a bit ugly whatever we do. If you prefer the union, I can respin the
> >>> patch that way.
> >>
> >> Hmm, thinking more about it I think the real clean solution would be to
> >> extend struct map_ring_valloc_hvm to cover the pv case, too, to add the
> >> map and unmap arrays (possibly as a union) to it and to allocate it
> >> dynamically instead of having it on the stack.
> >>
> >> Would you be fine doing this?
> >
> > This is a little more complex than I'd want to do without doing any testing
> > (and no, I don't want to do the testing either) ;-)
> >
> > It does sound like a better approach though.
>
> I take this as you are fine with me writing the patch and adding you as
> "Reported-by:"?

Yes, definitely. Thanks!

     Arnd
