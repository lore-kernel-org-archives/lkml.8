Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A758C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546BF20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbgGVSta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:49:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47398 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgGVSta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:49:30 -0400
Received: from x2f7fa19.dyn.telefonica.de ([2.247.250.25] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jyJny-0005KA-ST; Wed, 22 Jul 2020 20:49:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        William Wu <william.wu@rock-chips.com>
Subject: Re: [PATCH v3] ARM: dts: rockchip: Add usb host0 ohci node for rk3288
Date:   Wed, 22 Jul 2020 20:49:25 +0200
Message-ID: <2630968.GxkqStg1Zh@phil>
In-Reply-To: <CAMty3ZCxynb3_GTxhf=Nrf=F=SbijqEfDVysCzQ1KXsF_MCjxw@mail.gmail.com>
References: <20200720105846.367776-1-jagan@amarulasolutions.com> <8444056.acRTkLjuym@phil> <CAMty3ZCxynb3_GTxhf=Nrf=F=SbijqEfDVysCzQ1KXsF_MCjxw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 22. Juli 2020, 20:46:55 CEST schrieb Jagan Teki:
> Hi Heiko,
> 
> On Thu, Jul 23, 2020 at 12:04 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > Hi Jaganm
> >
> > Am Montag, 20. Juli 2020, 12:58:46 CEST schrieb Jagan Teki:
> > > rk3288 and rk3288w have a usb host0 ohci controller.
> > >
> > > Although rk3288 ohci doesn't actually work on hardware, but
> > > rk3288w ohci can work well.
> > >
> > > So add usb host0 ohci node in rk3288 dtsi and the quirk in
> > > ohci platform driver will disable ohci on rk3288.
> >
> > If I remember the discussion correctly, we expect the board dts
> > or the bootloader to enable the ohci, right?
> > So that block go away ... just making sure, I don't remember
> > untrue stuff ;-)
> 
> Our (with Robin) initial discussion [1] is to manage OHCI enablement
> in the bootloader but since it requires many checks at bootloader
> level we finally rely on board dts to enable it as normal.

ok, so I'll just drop this paragraph when applying.



> 
> [1] https://lkml.org/lkml/2020/7/3/424
> 
> Jagan.
> 




