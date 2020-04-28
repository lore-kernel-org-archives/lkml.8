Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A0AC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACCD2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgD1IZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726660AbgD1IZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:25:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F4BC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:25:21 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jTLYD-0005oz-3B; Tue, 28 Apr 2020 10:25:09 +0200
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jTLYA-0003sR-0V; Tue, 28 Apr 2020 10:25:06 +0200
Date:   Tue, 28 Apr 2020 10:25:05 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 1/3] media: dt-bindings: ov8856: Document YAML bindings
Message-ID: <20200428082505.GA22489@pengutronix.de>
References: <20200408110816.2712841-1-robert.foss@linaro.org>
 <20200408110816.2712841-2-robert.foss@linaro.org>
 <20200415160729.GA4438@bogus>
 <20200415162110.bmorj4u4hkqohqjx@pengutronix.de>
 <CAG3jFysg34=HJ7xefuAKw4Uq6W0POm5TsJmzQku6WwkhH_j=-w@mail.gmail.com>
 <20200428075504.ovzugt2mbgan7z3k@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428075504.ovzugt2mbgan7z3k@gilmour.lan>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:23:30 up 66 days, 19:40, 148 users,  load average: 0.03, 0.16,
 0.38
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-28 09:55, Maxime Ripard wrote:
> On Mon, Apr 27, 2020 at 05:13:42PM +0200, Robert Foss wrote:
> > On Wed, 15 Apr 2020 at 18:21, Marco Felsch <m.felsch@pengutronix.de> wrote:
> > >
> > > On 20-04-15 11:07, Rob Herring wrote:
> > > > On Wed, Apr 08, 2020 at 01:08:14PM +0200, Robert Foss wrote:
> > > > > From: Dongchun Zhu <dongchun.zhu@mediatek.com>

...

> > > > > +  clock-names:
> > > > > +    description:
> > > > > +      Input clock for the sensor.
> > > > > +    items:
> > > > > +      - const: xvclk
> > > > > +
> > > > > +  assigned-clocks:
> > > > > +    description:
> > > > > +      Input clock for the sensor.
> > > > > +
> > > > > +  assigned-clock-rates:
> > > > > +    description:
> > > > > +      Frequency of the xvclk clock in Hertz.
> > > >
> > > > These 2 should have a 'maxItems: 1'
> > >
> > > Don't know why those properties are needed here.. IMHO this shouldn't be
> > > part of the binding or at least it should be optional and not required.
> > > All we need is the clocks and the clock-names property.
> > 
> > Thanks Marco, I'll make it optional for the next revision.
> 
> Well, the whole discussion we had was about removing them entirely?

+1 from my side. It is part of the system integration and not part of
this device.

Regards,
  Marco

> Maxime
