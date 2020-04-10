Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40EDC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFF420787
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDJKsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:48:40 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:43968 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgDJKsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:48:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 85414FB03;
        Fri, 10 Apr 2020 12:48:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bW2A5ldcPbjn; Fri, 10 Apr 2020 12:48:36 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id ECBD840601; Fri, 10 Apr 2020 12:48:35 +0200 (CEST)
Date:   Fri, 10 Apr 2020 12:48:35 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 0/2] drm: bridge: Add NWL MIPI DSI host controller
 support
Message-ID: <20200410104835.GA22010@bogon.m.sigxcpu.org>
References: <cover.1586427783.git.agx@sigxcpu.org>
 <20200409140130.GA11188@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409140130.GA11188@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Apr 09, 2020 at 04:01:30PM +0200, Sam Ravnborg wrote:
> Hi Guido.
> 
> On Thu, Apr 09, 2020 at 12:42:00PM +0200, Guido Günther wrote:
> > This adds initial support for the NWL MIPI DSI Host controller found on i.MX8
> > SoCs.
> > 
> > It adds support for the i.MX8MQ but the same IP core can also be found on e.g.
> > i.MX8QXP. I added the necessary hooks to support other imx8 variants but since
> > I only have imx8mq boards to test I omitted the platform data for other SoCs.
> > 
> > The code is based on NXPs BSP so I added Robert Chiras as Co-authored-by.
> > 
> > The most notable changes over the BSP driver are
> >  - Calculate HS mode timing from phy_configure_opts_mipi_dphy
> >  - Perform all clock setup via DT
> >  - Merge nwl-imx and nwl drivers
> >  - Add B0 silion revision quirk
> >  - become a bridge driver to hook into mxsfb / dcss
> >    imx-display-subsystem so it makes sense to make it drive a bridge for dsi as
> >    well).
> >  - Use panel_bridge to attach the panel
> >  - Use multiplex framework instead of accessing syscon directly
> > 
> > This has been tested on a Librem 5 devkit using mxsfb with Robert's patches[1]
> > and the mainline rocktech-jh057n00900 DSI panel driver on next-20200317 and on
> > the Librem5 with the a Mantix MLAF057WE51-X DSI panel driver (not yet mainline)
> > The DCSS (submitted for mainline inclusion now too) can also act as input
> > source.
> 
> Thanks for your persistence with this driver.
> I got ack from Laurent on IRC to apply it (not for the driver as he had
> no time to review it).
> So applied to drm-misc-next now.
> 
> I look forward for the update to support DRM_BRIDGE_ATTACH_NO_CONNECTOR
> in this driver and the corresponding display driver.

Thanks. I'll have a look at that (currently checking where the larger
mxsfb rework of Laurent is going so i can use that as a base
eventually).
Cheers,
 -- Guido
