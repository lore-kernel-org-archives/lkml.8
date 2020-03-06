Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDA3C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475182072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="TMAyBXMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgCFIyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:54:23 -0500
Received: from hermes.aosc.io ([199.195.250.187]:33880 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFIyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:54:22 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 0B8624BC35;
        Fri,  6 Mar 2020 08:53:56 +0000 (UTC)
Message-ID: <5d72a8c6824b31163a303b5ef1526efe05121e5d.camel@aosc.io>
Subject: Re: [PATCH v2 2/2] drm/bridge: anx7688: Add anx7688 bridge driver
 support
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?gb2312?Q?Ond=810=940ej?= Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, Torsten Duwe <duwe@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Collabora Kernel ML <kernel@collabora.com>
Date:   Fri, 06 Mar 2020 16:53:46 +0800
In-Reply-To: <2a5a4a62-3189-e053-21db-983a4c766d44@collabora.com>
References: <20200213145416.890080-1-enric.balletbo@collabora.com>
         <20200213145416.890080-2-enric.balletbo@collabora.com>
         <CA+E=qVffVzZwRTk9K7=xhWn-AOKExkew0aPcyL_W1nokx-mDdg@mail.gmail.com>
         <CAFqH_53crnC6hLExNgQRjMgtO+TLJjT6uzA4g8WXvy7NkwHcJg@mail.gmail.com>
         <CA+E=qVfGiQseZZVBvmmK6u2Mu=-91ViwLuhNegu96KRZNAHr_w@mail.gmail.com>
         <CAFqH_505eWt9UU7Wj6tCQpQCMZFMfy9e1ETSkiqi7i5Zx6KULQ@mail.gmail.com>
         <CA+E=qVff5_hdPFdaG4Lrg7Uzorea=JbEdPoy+sQd7rUGNTTZ5g@mail.gmail.com>
         <5245a8e4-2320-46bd-04fd-f86ce6b17ce7@collabora.com>
         <CA+E=qVcyRW4LNC5db27d-8x-T_Nk9QAhkBPwu5rwthTc6ewbYA@mail.gmail.com>
         <20200305193505.4km5j7n25ph4b6hn@core.my.home>
         <2a5a4a62-3189-e053-21db-983a4c766d44@collabora.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1583484858;
        h=from:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
        bh=whGTAJHlYigYjZ8Bt9ei5nP1KSVeXS1a1/b/mBSwvdU=;
        b=TMAyBXMIAmUr2NuUqUbtT7YKm9o5pQpohi3Ru/es8GLfSDjPXde0A+J1u+DnXjsLe5YFth
        UFFzHRfgi/SE8ALhSwWtxB1k+SjQmXAbANQKyy/3tSei2JJzS+0W596rLI8ybTO2KACSXW
        PPVo+clmVSVLhe7dR5JlNCmgf/AM+DU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-03-06星期五的 09:46 +0100，Enric Balletbo i Serra写道：
> Hi Ondrej,
> 
> On 5/3/20 20:35, Ondřej Jirman wrote:
> > Hi,
> > 
> > On Thu, Mar 05, 2020 at 10:29:33AM -0800, Vasily Khoruzhick wrote:
> > > On Thu, Mar 5, 2020 at 7:28 AM Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com> wrote:
> > > > Hi Vasily,
> > > 
> > > CC: Icenowy and Ondrej
> > > > Would you mind to check which firmware version is running the
> > > > anx7688 in
> > > > PinePhone, I think should be easy to check with i2c-tools.
> > > 
> > > Icenowy, Ondrej, can you guys please check anx7688 firmware
> > > version?
> > 
> > i2cget 0 0x28 0x00 w
> > 0xaaaa
> > 
> > i2cget 0 0x28 0x02 w
> > 0x7688
> > 
> > i2cget 0 0x28 0x80 w
> > 0x0000
> > 
> 
> Can you check the value for 0x81 too?

root@ice-pinephone [ ~ ] # i2cdump 0 0x28
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x28, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: aa aa 88 76 ac 00 00 00 00 00 00 00 00 00 05 05    ???v?.........??
10: 30 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    0...............
20: 00 00 00 00 00 00 00 00 00 00 00 24 f2 e4 ff 00    ...........$??..
30: 06 40 00 04 94 11 20 ff ff 03 00 bf ff ff 10 01    ?@.??? ..?.?..??
40: 72 a4 00 09 00 08 05 84 15 40 17 00 00 0a 00 e0    r?.?.????@?..?.?
50: 00 00 00 0a 10 00 e0 df ff ff 00 00 00 10 71 00    ...??.??.....?q.
60: 10 10 04 29 2d 21 10 01 09 13 00 03 e8 13 88 00    ???)-!????.????.
70: 00 19 18 83 16 5c 11 00 ff 00 00 0d 04 38 42 07    .????\?....??8B?
80: 00 00 00 00 00 74 1b 19 44 08 75 00 00 00 00 00    .....t??D?u.....
90: 01 02 00 00 00 00 03 00 ff 30 00 59 01 00 00 00    ??....?..0.Y?...
a0: 00 ff fe ff ff 00 00 00 00 00 00 00 00 00 00 02    ..?............?
b0: 00 00 00 00 00 00 40 00 28 00 00 00 00 44 08 00    ......@.(....D?.
c0: 00 00 00 00 80 00 10 01 0a 10 18 00 00 fd 00 00    ....?.?????..?..
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 50 10 08 50 00 02 00 70 00 00 30 10 0b 02 1c 01    P??P.?.p..0?????
f0: 00 0b 07 00 94 11 7f 00 00 00 00 00 00 01 0e ff    .??.???......??.
root@ice-pinephone [ ~ ] # i2cdump 0 0x2c
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x2c, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 29 1f 88 76 00 ac 11 00 11 20 10 10 00 00 00 00    )??v.??.? ??....
10: 03 00 ff 8f ff 7f 00 00 00 00 05 00 10 0a 0c 00    ?..?.?....?.???.
20: 00 00 00 00 99 06 c0 00 00 00 00 00 00 00 02 00    ....???.......?.
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: b8 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?...............
80: 01 25 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ?%..............
90: 0f 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ??..............
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

> 
> Thanks,
>  Enric
> 
> 
> > regards,
> > 	o.
> > 
> > > > Thanks in advance,
> > > >  Enric
> > > > 
> > > > [snip]

