Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8360C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904CA2065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgENVMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:12:21 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56445 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgENVMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:12:21 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MGiAs-1jMdpB0NFq-00DqYR for <linux-kernel@vger.kernel.org>; Thu, 14 May
 2020 23:12:19 +0200
Received: by mail-qv1-f47.google.com with SMTP id v15so37125qvr.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:12:18 -0700 (PDT)
X-Gm-Message-State: AOAM531yCoJpyJ+CP0pbwG8cjse8rhpMDWgqhQywde2WVGjGYHPsKJfr
        e1PZY3vrfwV8I2bmXpctoEPuTCL/djKtMNVj/ks=
X-Google-Smtp-Source: ABdhPJw+hOXAPKqhss7jyQwmscQ+zLP90XxY8njrxYkgNmAOyzRHjnKyJ1EnZ5pV37wBywYSy8Mi3+xNly2MaNrB+Gw=
X-Received: by 2002:a0c:eb11:: with SMTP id j17mr396214qvp.197.1589490737968;
 Thu, 14 May 2020 14:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200503145017.GA5074@afzalpc> <CAK8P3a3OC5UO72rTDWi6+XgmExJmkATEjscq8hns8Bng06OpcQ@mail.gmail.com>
 <20200504091018.GA24897@afzalpc> <CAK8P3a25sZ9B+AE=EJyJZSU91CkBLLR6p2nixw_=UAbczg3RiQ@mail.gmail.com>
 <20200511142113.GA31707@afzalpc> <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc> <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc> <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514162535.GP1551@shell.armlinux.org.uk>
In-Reply-To: <20200514162535.GP1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 May 2020 23:12:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2KR+O5Ua5hsNgzLQV5-V1pat6JH_WM10Es-oUhXO2OgA@mail.gmail.com>
Message-ID: <CAK8P3a2KR+O5Ua5hsNgzLQV5-V1pat6JH_WM10Es-oUhXO2OgA@mail.gmail.com>
Subject: Re: ARM: static kernel in vmalloc space
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9U2falEcLllQAn3jNc9KAf297+bJuds4lQ+bmMyTLrrjtnr7BwG
 W43qgl53aPs+ZnWlsiqS/0Akfr1GMstY4usQbNFIaX4FPJS5yiRfm5xfCxBBVta2OYMa1MB
 ea0/Xo4nQW6jqDDyprK/s1pi9PewIbMF2MMr/le34a8yxc/wiij+hkwgcO0VXsjRfvRmfgd
 TU2z33vKUJ9eVIfTlhDHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:55XKTpTDyD4=:ndYmtHh06pmOoLnuWpOqsw
 ypa/gE/xCZc2vNBX9d7qQGG9GdVLW5wWZGr3cdNJVAnjXqpNNriqp5nB5hE0KjqLEVbhohu3m
 39+2awWt3QGQZIj1YPhiCO3di/0qQa/YJi0b7/c7SxvxKpkYe7UvSbzOnflpJAelX8jjLE9tI
 Ar2oGeZGwpM96x+cYhASre7MqwbglNsghQqYp3ebVUOd8iSNyZw8oJaIjIsCbe5dErIBF3Hmu
 3dHecHGKgSt1p8XmUr8STvAun4s/YuzGtfYibw+bRVjz7fvg+yG6QIDTKcJmBZzI2jo8z5MWQ
 CIRKZusMptM89AkM16VRjB1z66GB+j+gJbHHCgDrcixMIUgIdrs3h2kIafWLO+c4FFbGqZ5Sv
 Nk1lTD/Xs/VvwoGNcUTWeRpJ47AljIsqnr1MZb4hp5cHbw0uEfNnfQ+80jnJTiktSXmYpajmz
 BMV+/+isVxxibDf6XL9bk7F4BcwFrRhVTzLLLqaPdX4NqcuPHdpZmupAcYLVsghlu4aEUS3jD
 SWusCFYo44+A+Qw2TVoGrijK2lHqDnr/Xl+ou2NLDMFwoF5QIarZFfDQ/dcVmmHcEchrbL0YE
 XGLAHAUqV+yTP3IIN1Hls1douJYCL1hOd+3dVLaUXsN7b1EL5GAQNIvn171+zLZ6eFDkM1XVR
 OI8S3t9MT7/NBuotTh74FeGHXMSuq882MPmMnGwvwU1P5JFet090xR41RshssXw7qtHmaDZLQ
 UIwQyYhNJZw4IjgHXTDwZ3IpFd8Jlr23iRgYonKiOiKccU6WSpPZm+WsNnPLNGvW8YLJ5vqr5
 Nl08Lklz0dmfPD9H/fySM5yLVRp5Dkx2e+8vUiVlPTWYtJGuig=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 6:25 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Thu, May 14, 2020 at 02:41:11PM +0200, Arnd Bergmann wrote:
> > On Thu, May 14, 2020 at 1:18 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> > It's clearly possible to do something very similar for older chips
> > (v6 or v7 without LPAE, possibly even v5), it just gets harder
> > while providing less benefit.
>
> Forget about doing this for anything without a PIPT cache - or you're
> going to end up having to flush the data cache each time you enter or
> exit the kernel.

Right, let's forget I said anything about v5 or earlier ;-)

I expected the non-aliasing VIPT caches to work the same as PIPT, can
you clarify if there is something to be aware of for those? I see that some
ARMv8 chips and most ARMv6 chips (not OMAP2 and Realview) are
of that kind, and at we clearly don't want to break running on ARMv8 at
least.

Anyway my point was that it's best to only do it for LPAE anyway, everything
else being a distraction, as the only non-LPAE SoCs I could find with
support for over 2GB are some of the higher-end i.MX6 versions and the
original highbank.

      Arnd
