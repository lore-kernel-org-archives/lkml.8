Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F119C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFC2207D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgETOqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:46:37 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgETOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:46:37 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M8yU2-1jfHsS43HC-00635K; Wed, 20 May 2020 16:46:35 +0200
Received: by mail-qk1-f169.google.com with SMTP id 142so3777850qkl.6;
        Wed, 20 May 2020 07:46:34 -0700 (PDT)
X-Gm-Message-State: AOAM531pJVNy2rqeddo+bEaedt/o7zabkZawqZOmKGnPWqf3yFS2laIg
        3mi7zM2cr/ReA08fgMnbnTz8uRPX2jY6hXDO60E=
X-Google-Smtp-Source: ABdhPJypyX4heAr8jTclXxNAM/F9gqjiDJaAB+OY94A6vygzYebCNAhZrJgCDtF9wxcn3J21WQxZOGR9j7pCMgQrZhQ=
X-Received: by 2002:a37:46c9:: with SMTP id t192mr2136041qka.3.1589985993796;
 Wed, 20 May 2020 07:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200519131327.1836482-1-arnd@arndb.de> <20200519181034.58c67eb5bea24aae24d33421@linux-foundation.org>
 <CAK8P3a281ZLKwkWCKkAdQvA6=XA4=+mKWbwEzK_BR4Uu1c5DNQ@mail.gmail.com> <CAMuHMdUx9zKbc7n164Gi+N9k-NhmbgXtU+Z4yZ9SvdxeCMtJKw@mail.gmail.com>
In-Reply-To: <CAMuHMdUx9zKbc7n164Gi+N9k-NhmbgXtU+Z4yZ9SvdxeCMtJKw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 May 2020 16:46:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0+RWNUroSAtdVazxMV=o+FYpTX9Wvkbr5gODh4=zODkQ@mail.gmail.com>
Message-ID: <CAK8P3a0+RWNUroSAtdVazxMV=o+FYpTX9Wvkbr5gODh4=zODkQ@mail.gmail.com>
Subject: Re: [PATCH] sh: include linux/time_types.h for sockios
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:b37uLIBrkCHgv4k2PH+HERQcOSyA0KYzXqw8DvcE2yw3JW2DIxe
 Xh+X+ga+AkhCv93hrN2oMUrAkkbfYIz+38vok9RTy4bViJroDzncnfdhehHefKfWSzqubVz
 UkZ+Y/QhIZbP9/eGDIRDrgYj1lJVRAA9kHtw3nkrzkumb6q3Pzxl+xB/fYiM1MrNBQpNZxW
 Nk12BSgxO8MlVCLwycS2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pp97+cetrdM=:WHm0MWpOr9t/XF13Oz0t7W
 DkI/b9ZdeAIhgHeTaUxiFo3Y4KA97wNoUPlyNQ74yQ2JN7DVb8B+tj1rpBerwHl/7IUzQfgjo
 Zds7VsfwKpm5OJwqTowgOT71tumCeeh6l2JLxcvfI4BJY2zuwOyPupfPXewVXrEYUsTkQ6RVP
 s7LZow9wh87jK3D4JN1inhguBGlFSY3igna8Jk5e6qQz9L6D2vSF1CWuQJRMPiy7PhiyO4z2x
 Fxt886DN7Xtw9z3vqFA5cvYYPl9NMbf7uKlRlEADAbLL76oi6L29OJAYKwzez6I/bjX2oxDTE
 ak5tzm2V6D/1Vi/hQW1vSWkRVZ1fv6EqqxJvDA5JLOi4frFkolKf2wxkTMoILbJ+9mXYYy/ZE
 0lAoMZyiVtaLuDUkqH/XQeCHwpN5xDjK1OGDWD43dRA6VSDLDc3c9rJ8GSp6cVAWyQqvKnVbk
 w/2JERyxhkndpuXQunQkllsGechjnXjc06ivRLZVHwWsavwZhhCs/26dCxB0yKONQQHYNA2+W
 QNpbkfYDwGNK4lrSRfkqIaj//Xw7Xqvb+g7yVAEha9ZmEcIUGyN17o96jlnjEoTcrXwh46kkT
 YoXUsRIuFohwwU3wq1eNmFrozTIcEFTVPtq34S0vdK65tzwHXAd+S0ukO6Pue0RZ57W8uXzaw
 3suN3vyZYrg74rtuF8s6w6pMaeBdBrKeXaWH+ZDLLMU9EXEk+hjLg2aL2U8nxi+XJBDIKe+fy
 0o2AOw3XEQpTvjmJ0aSNTib26JDp4FsPeJ36+LtvrGCEkPKhTzB3U65PFTFxvvhJgezPsEtdv
 ib5Zda7WH4e/yeNfW35++HqEDXmug1PldclpKjokueokoDynfc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 1:47 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, May 20, 2020 at 10:32 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, May 20, 2020 at 3:10 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > On Tue, 19 May 2020 15:13:13 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > > > Using the socket ioctls on arch/sh (and only there) causes build
> > > > time problems when __kernel_old_timeval/__kernel_old_timespec are
> > > > not already visible to the compiler.
> > > >
> > > > Add an explict include line for the header that defines these
> > > > structures.
> > >
> > > I can grab this.
> >
> > Thanks!
> >
> > > > Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > > Fixes: 8c709f9a0693 ("y2038: sh: remove timeval/timespec usage from headers")
> > > > Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")
> > >
> > > cc:stable?
> >
> > Yes, I missed that.
>
> Doesn't matter, the stable bots will pick it up anyway, based on the Fixes tag.

I normally prefer to be explicit, as some bug fixes may address
something that has been caused by an earlier commit, but should not
be backported for some reason.

      Arnd
