Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB609C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 19:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0209206F6
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 19:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgFGT0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 15:26:45 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgFGT0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 15:26:44 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MmQUL-1jHRY22MM5-00iRsH for <linux-kernel@vger.kernel.org>; Sun, 07 Jun
 2020 21:26:43 +0200
Received: by mail-qk1-f170.google.com with SMTP id q8so15265692qkm.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 12:26:43 -0700 (PDT)
X-Gm-Message-State: AOAM530DeStpF5AUWZdTFvjwje5uwVKJKtI8n9xuLnyKZpPaOlTRFbnT
        MIm1DRHcVPYwUA/M4E1kKt8hM5gsv3KMQbdbsx4=
X-Google-Smtp-Source: ABdhPJxoTJcGMMjDIPqtPgt9iAWNs6NJAJ0wdQasDHvaN7UjM0mCN9XrBavVzD8OMt18kVgrRaOq45itrFbsO0LZMJo=
X-Received: by 2002:a37:554:: with SMTP id 81mr19496641qkf.394.1591558002353;
 Sun, 07 Jun 2020 12:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200511142113.GA31707@afzalpc> <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc> <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc> <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc> <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc> <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
 <20200607125932.GA4576@afzalpc>
In-Reply-To: <20200607125932.GA4576@afzalpc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 7 Jun 2020 21:26:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2=o6RkONUoHTaR-2jpXg-wa-YnCYi0a4gAknYmvu8X7Q@mail.gmail.com>
Message-ID: <CAK8P3a2=o6RkONUoHTaR-2jpXg-wa-YnCYi0a4gAknYmvu8X7Q@mail.gmail.com>
Subject: Re: ARM: vmsplit 4g/4g
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jnEjANIvRpfY5WjlA4VhDwG3UxQnwa8DO2FkM6DwCH76XsBL323
 TBuHecc6WLVd21Txo/oRgrWD7+azhyq3mJG61PHS4VEkOi88Dwk5MWKIA9Y7u44lhjS7FI2
 NsPwF7lHcZbOe8ZLCcq20NCb9S1IEX/qx5/4aWq4zD+NYQ7nTm569nFgGWd/9Pixi+Ax8iz
 mOiXCTdO6WGae/oms0VQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:60aUizmMctM=:LhwFxQ6znscXLQwm3aAmyR
 /naRp0fnNj2mcTcL2wUuQruHXMbJOE8oL1dtOkHFV1uN7k+VR4Qv47AluhaCjC1xGcfdd0SPP
 f08lrmf/iysXm51pAc4uTeNgRXx1ThuvBMY7YUMg1yOIaVZT+h+YJuWrDhaaY8ynRbZBy9GHE
 ek6RrPO2ugOrN1D1/wfWdkTMe7i3wolspG5Hvcp0M1ZHPpAZaJTt015eQltSJgT2Rm7OSIo3y
 HHHLTanVngUEY03laFaC1XwoW9uIWTxOFJa/ideD3HMQIZaWvgA/K/jQajxcN74HkpAk8YXjr
 dz/0LRAnEtOvBYnt3YmmwmqrYAesPLtUi3ZBAgHaATutHqWImT/wW84bYaPWFfhcU6QULEGuL
 R54mlENMvNkkyxc99dAupI9mQ8Ep2Bo4d8SEOtlrdy4wzmIbUlrLxw/NzIKrpq2tdvu4kjeTf
 CdvLknEwjOi4wUdElIddLtZTMmwPGXVGwKfWjN5ScyfmCckd+ZEE6mg6DtoTNX2yP4k38GHsT
 3pZQRq3Zefq7y1ENq/AzOtxQfujCiSeTXnNaP0pHQVuNKrBjxyBeVszBllmtwb8zY03ZzAgz8
 GBKx0OUBxsSuEQHTiP2kPxMb91dzHaqtZbee6zKB0ACzR3OglJAgNBXEPuKMKK/1R3YeB0fdg
 ntjUMj2udm+CNK9HDX+T8XL/ykK8DL57ZcU8qp6ESiDk0MbTMaxha/Jpt2nBlDeq/MG86YuTw
 IJpEkLAroy6xlR7zs3Um30qbjGuWB+JPHmXkZy60nvR6RNiQzoNaXllChAdZYTalB9uwq1qH2
 ZGeUlJtpLXx8wrXfCHcXQwqH9PONvebQDXcf++tByaLLUXoC20=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 7, 2020 at 2:59 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> On Sat, May 16, 2020 at 09:35:57AM +0200, Arnd Bergmann wrote:
> > On Sat, May 16, 2020 at 8:06 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> > > Okay, so the conclusion i take is,
> > > 1. VMSPLIT 4G/4G have to live alongside highmem
> > > 2. For user space copy, do pinning followed by kmap
>
> > Right, though kmap_atomic() should be sufficient here
> > because it is always a short-lived mapping.
>
> get_user_pages_fast() followed by kmap_atomic() & then memcpy() seems
> to work in principle for user copy.

Nice!

I think you have to use get_user_pages() though instead of
get_user_pages_fast(),
in order to be able to check the permission bits to prevent doing a
copy_to_user()
into read-only mappings.

> Verified in a crude way by pointing TTBR0 to a location that has user
> pgd's cleared upon entry to copy_to_user() & restoring TTBR0 to
> earlier value after user copying was done and ensuring boot.

Do you want me to review the uaccess patch to look for any missing
corner cases, or do you want to do the whole set of user access helpers
first?

> Meanwhile more testing w/ kernel static mapping in vmalloc space
> revealed a major issue, w/ LPAE it was not booting. There were issues
> related to pmd handling, w/ !LPAE those issues were not present as pmd
> is in effect equivalent to pgd. The issues has been fixed, though now
> LPAE boots, but feel a kind of fragile, will probably have to revisit
> it.

Ok.

     Arnd
