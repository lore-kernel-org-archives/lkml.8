Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E668C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D312076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgHKTRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:17:11 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:39568 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:17:10 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A092620023;
        Tue, 11 Aug 2020 21:17:05 +0200 (CEST)
Date:   Tue, 11 Aug 2020 21:17:04 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinay Simha B N <simhavcs@gmail.com>
Cc:     Vinay Simha B N <simhavcs@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v8 2/2] display/drm/bridge: TC358775 DSI/LVDS driver
Message-ID: <20200811191704.GA524675@ravnborg.org>
References: <1594388491-15129-1-git-send-email-simhavcs@gmail.com>
 <1594388491-15129-2-git-send-email-simhavcs@gmail.com>
 <CAGWqDJ4P9dKzGngkiEtL_X1HRjjtU17WqNFM-qiv16tXwQNZTg@mail.gmail.com>
 <CAGWqDJ4s3x5M7dGMTxYMpDbM4NBS7kfTb6-+7Fdx8Pe=CE58fA@mail.gmail.com>
 <20200808213022.GW6186@pendragon.ideasonboard.com>
 <20200810175440.GC292825@ravnborg.org>
 <20200811101942.GB6054@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811101942.GB6054@pendragon.ideasonboard.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=WC5eoWgHUSoulA4aEAAA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinay.

> > 
> > If Laurent or others identify further things to improve we can take
> > it in-tree.
> 
> Just one thing, please see below.
> 
> > > > >> +       d2l_write(tc->i2c, VTIM1, vtime1);
> > > > >> +       d2l_write(tc->i2c, HTIM2, htime2);
> > > > >> +       d2l_write(tc->i2c, VTIM2, vtime2);
> > > > >> +
> > > > >> +       d2l_write(tc->i2c, VFUEN, VFUEN_EN);
> > > > >> +       d2l_write(tc->i2c, SYSRST, SYS_RST_LCD);
> > > > >> +       d2l_write(tc->i2c, LVPHY0, LV_PHY0_PRBS_ON(4) | LV_PHY0_ND(6));
> > > > >> +
> > > > >> +       dev_dbg(tc->dev, "bus_formats %04x bpc %d\n",
> > > > >> +               connector->display_info.bus_formats[0],
> > > > >> +               tc->bpc);
> > > > >> +       /*
> > > > >> +        * Default hardware register settings of tc358775 configured
> > > > >> +        * with MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA jeida-24 format
> > > > >> +        */
> > > > >> +       if (connector->display_info.bus_formats[0] ==
> > > > >> +               MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
> 
> This shouldn't come from the connector, but from the
> drm_bridge_state.output_bus_cfg.format. The drm_bridge_funcs
> .atomic_get_input_bus_fmts() operation likely needs to be implemented.

I trust you will look into this and submit a patch on top of
drm-misc-next.
Please add a proper "Fixes:" tag identifying the commit that introduced
this bug - in this case the commit introducing the driver.

Do not hesitate to reply to all if you have any questions.
We will help you if we can.

	Sam
