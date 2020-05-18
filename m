Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838B6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F6C20671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgERRtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:49:01 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:40232 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbgERRs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:48:57 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 4F54380512;
        Mon, 18 May 2020 19:48:49 +0200 (CEST)
Date:   Mon, 18 May 2020 19:48:47 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 7/7] drm/mediatek: mtk_dsi: Create connector for
 bridges
Message-ID: <20200518174847.GA770263@ravnborg.org>
References: <20200501152335.1805790-1-enric.balletbo@collabora.com>
 <20200501152335.1805790-8-enric.balletbo@collabora.com>
 <CAFqH_53h=3OXzwLnw1XT3rHYkMPOPNFBdQdPeFmNubN9qq_Twg@mail.gmail.com>
 <CAAOTY_-pOUuM7LQ1jm6gqpg8acMqDWOHxGucY5XOjq0ctGUkzA@mail.gmail.com>
 <53683f2d-23c7-57ab-2056-520c50795ffe@collabora.com>
 <CAAOTY__b6V12fS2xTKGjB1fQTfRjX7AQyBqDPXzshfhkjjSkeQ@mail.gmail.com>
 <37191700-5832-2931-5764-7f7fddd023b9@collabora.com>
 <e1ac7d75-c46a-445a-5fcf-5253548f2707@collabora.com>
 <CAAOTY_-w0V0iQgjZ0n26KKs_MdB-im9+LC2EDTmGo0wMG9p_Vw@mail.gmail.com>
 <CAFqH_52YJEnuoXmJVq1TgH5Ay76p-feVQPZ6s4h-1TMBDQ8fDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqH_52YJEnuoXmJVq1TgH5Ay76p-feVQPZ6s4h-1TMBDQ8fDA@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=33rsfa9LKxz_d3rkTGwA:9 a=mxk1C73UtW0IAQGh:21
        a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric/Chun-Kuang.

> >
> > My point is: when do you attach panel to a connector?
> > In this patch,
> >
> > ret = drm_bridge_attach(&dsi->encoder, &dsi->bridge, NULL,
> >                                           DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> >
> > it would call into mtk_dsi_bridge_attach() with
> > DRM_BRIDGE_ATTACH_NO_CONNECTOR, and call into panel_bridge_attach()
> > with DRM_BRIDGE_ATTACH_NO_CONNECTOR.
> 
> My understanding is that the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is to
> ease transition between the old and the new model. The drivers that
> support the new model shall set that flag.
Yes, right now we have fous on migrating all bridge drivers to the new
model and next step is to make the transition for the display drivers
one by one.
Display drivers that uses the old model rely on the bridge driver to
create the connector, whereas display drivers using the new model will
create the connector themself.
Display drivers following the new model will pass DRM_BRIDGE_ATTACH_NO_CONNECTOR
to tell the bridge drive that no connector shall be created by the
bridge driver.

For this driver where only the new model is needed there is no
reason to try to support both models.
So the display driver shall always create the connector, and never
ask the bridge driver to do it (always pass
DRM_BRIDGE_ATTACH_NO_CONNECTOR).

I hope this confirm and clarifies it.

	Sam
