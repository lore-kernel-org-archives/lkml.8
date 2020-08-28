Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2B3C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D583D2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="BPsdoeAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgH1Mv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:51:29 -0400
Received: from vps.xff.cz ([195.181.215.36]:39480 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbgH1Mv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1598619084; bh=N9amwtbHh9BlB74+6QxsJWuhe5/JoCauR4xTJEk0UA0=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=BPsdoeADRZs+yB6e9Gp4IQIZOL9VVePGL0NPeK6769CkWS0kvp+/ee5CbcphvNK2k
         oCk0AfbKWRHIJn7mLBVUB/vEl1eMb0c49boJXaH3DSNIcfIHpC/gtUF9ZCrKrQ9P12
         R1neKfZhDV+wCqMqiFdQj+XZPu5aqlWd9UVjHhlQ=
Date:   Fri, 28 Aug 2020 14:51:24 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-sunxi@googlegroups.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-sunxi] [PATCH] drm/sun4i: Fix dsi dcs long write function
Message-ID: <20200828125124.mgqforbmrjjee7gj@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        linux-sunxi@googlegroups.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200828112444.916455-1-megous@megous.com>
 <1872601.C7yQfbK89F@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1872601.C7yQfbK89F@jernej-laptop>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 02:35:26PM +0200, Jernej Škrabec wrote:
> Dne petek, 28. avgust 2020 ob 13:24:44 CEST je Ondrej Jirman napisal(a):
> > It's writing too much data. regmap_bulk_write expects number of
> > register sized chunks to write, not a byte sized length of the
> > bounce buffer. Bounce buffer needs to be padded too, so that
> > regmap_bulk_write will not read past the end of the buffer.
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> Fixes: 133add5b5ad4 ("drm/sun4i: Add Allwinner A31 MIPI-DSI controller 
> support")

It doesn't really fix anything user visible though, and will not help
the stable branch in any way. It just makes the code more correct.

Though now that you came up with the tag, copypasting it is not that much
work. ;) So I added it.

> should be added. Fix will be then automatically picked into stable releases.
> 
> Small nit below.
> 
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c index 7f13f4d715bf..840fad1b68dd
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -889,7 +889,7 @@ static int sun6i_dsi_dcs_write_long(struct sun6i_dsi
> > *dsi, regmap_write(dsi->regs, SUN6I_DSI_CMD_TX_REG(0),
> >  		     sun6i_dsi_dcs_build_pkt_hdr(dsi, msg));
> > 
> > -	bounce = kzalloc(msg->tx_len + sizeof(crc), GFP_KERNEL);
> > +	bounce = kzalloc(msg->tx_len + sizeof(crc) + 3, GFP_KERNEL);
> 
> It would be nicer to use ALIGN() macro, but I'm fine either way.

Nice idea.

> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks. :)

regards,
	o.

> Best regards,
> Jernej
> 
> >  	if (!bounce)
> >  		return -ENOMEM;
> > 
> > @@ -900,7 +900,7 @@ static int sun6i_dsi_dcs_write_long(struct sun6i_dsi
> > *dsi, memcpy((u8 *)bounce + msg->tx_len, &crc, sizeof(crc));
> >  	len += sizeof(crc);
> > 
> > -	regmap_bulk_write(dsi->regs, SUN6I_DSI_CMD_TX_REG(1), bounce, 
> len);
> > +	regmap_bulk_write(dsi->regs, SUN6I_DSI_CMD_TX_REG(1), bounce,
> > DIV_ROUND_UP(len, 4)); regmap_write(dsi->regs, SUN6I_DSI_CMD_CTL_REG, len +
> > 4 - 1);
> >  	kfree(bounce);
> 
> 
> 
> 
