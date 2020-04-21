Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA53C55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35BF2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgDUIhs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:37:48 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46282 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUIhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:37:47 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jQoPZ-0001XI-1R; Tue, 21 Apr 2020 10:37:45 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: add bus-width properties to mmc nodes for rk3328.dtsi
Date:   Tue, 21 Apr 2020 10:37:44 +0200
Message-ID: <4769044.6T0MzsmYic@diego>
In-Reply-To: <CAGb2v67vV2Bxff5Gj1R8Qx3Cj+nzA5ine12hoXbhGP5Z+S7=UA@mail.gmail.com>
References: <20200416181944.5879-1-jbx6244@gmail.com> <2710874.PL6qFFFsBp@diego> <CAGb2v67vV2Bxff5Gj1R8Qx3Cj+nzA5ine12hoXbhGP5Z+S7=UA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 21. April 2020, 10:29:49 CEST schrieb Chen-Yu Tsai:
> On Tue, Apr 21, 2020 at 4:23 PM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Hi ChenYu,
> >
> > Am Dienstag, 21. April 2020, 05:48:52 CEST schrieb Chen-Yu Tsai:
> > > On Fri, Apr 17, 2020 at 2:19 AM Johan Jonker <jbx6244@gmail.com> wrote:
> > > >
> > > > 'bus-width' and pinctrl containing the bus-pins
> > > > should be in the same file, so add them to
> > > > all mmc nodes in 'rk3328.dtsi'.
> > >
> > > Nope. First of all, pinctrl usage is with pinctrl-N properties, not the
> > > pinctrl device, and there are no defaults set for any of the mmc nodes.
> > > Second, these are board design specific. For example, boards are free to
> > > use just 4 bits for the eMMC if they so desire. So this should be in each
> > > board dts file. If a board is missing this property, fix the board.
> >
> > you are correct that the pinctrl entries are missing from the patches,
> > bus-width and pinctrl should be defined in the same file each time,
> > but for the whole idea I tend to disagree.
> >
> > So far every board with a Rockchip socs follows Rockchip's reference design
> > for a lot of parts - for example I only see sdmmc nodes with bus-width=4
> > etc.
> >
> > So the basic idea is to have default pinctrl settings for the settings
> > everybody uses predefined ... if a board comes along that needs different
> > settings it is free to redefine that.
> 
> I think having a default is a great idea. :)

especially for controllers that only ever use the same settings anyway.



