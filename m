Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3260BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A0820720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="VthOtP0D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qqytq1Yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgA2Qn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:43:26 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:40511 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbgA2Qn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:43:26 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E8A8073A;
        Wed, 29 Jan 2020 11:43:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 29 Jan 2020 11:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=wVzq7A1mRlnA44nVMIvtmOwiqIc
        +jpFRZC1MsfkyksU=; b=VthOtP0DvyThBwtvX6HaFcbEMTcSArV4Azqiv8KpPlD
        50QKi/8mlb2CCFnvsKBl1sLQYzejzFwOzg53M+fo3tndBhFTG58xStEyKTu5FCQH
        mrP+vFew0q+304HhwRf0hZaS9IXsnKVsMnEkg+eslmhGPeaVvL7wqq97VYtBHXmI
        KIfDEuglk2ZvNRcNnwynNy/NqfNgnheN5TnuZpOM87ZUvQqZo1irT+suVx/d+t0i
        N+FxgG7oOmHW4cwAFub2wg+GNxf/2gzKrOGPvcaLzT1X7Iq41LimQJeYz8m6ab2S
        iQBARgG9hJUbfIgdstm7Z06X+CxVGUbSafW4dHCgVdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wVzq7A
        1mRlnA44nVMIvtmOwiqIc+jpFRZC1MsfkyksU=; b=qqytq1Yf31pUWzGdkKoti4
        Ov3jOUxIbpFlDCoJapv/9+GsHth0RMKmc34TB1zE7RjKgDm/7LU4puM630p0rC+R
        fZqoXn+0hZvktfbhzDeYJUx3Pm4NdiBkXzQjI7UVQZEgzbytALwfyseOxZ4+zRkz
        5PwdhI56hqtwD/qh9kXtSCjJTc8vr9L1a3BEgKltoKa6THTNijP2kPDV9uMIe5NQ
        rJUt6RwxGeamRrJZaKDfPZDY8pwZ2S34YUoeGhLJgqddlcuAfhDUglC2CjMtymRZ
        WmQXUOjbUiSBtSBwcv+HqxyQ0KW9AYf/32c+fcCe4gv+286by/b9XkcmLzn6KXoQ
        ==
X-ME-Sender: <xms:K7YxXpQ7Fze2-w6LiBtLU5-rg0hFUh_yVGdqBeHSCuUHfvTHxe5ItQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfeeigdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:K7YxXu0G2pW7Q-Z_7L5EJQ3Q_0-F2HSRt6rp7LaCQhz4QDAXlnBWzw>
    <xmx:K7YxXqLW-PGmXsZzP9x85jXy1zifo0OFbY9yelJS6McPDnZfkm_B9g>
    <xmx:K7YxXv9LjfUa8O82HPWK5BxXQzDbVlBIdpO3RSUDz2xJ1mv6XzZyrQ>
    <xmx:LLYxXtRhIUP1D-BmKu7jflKrRsEL2xZ8SJ-oVgX_bjJt6KBChsgFJg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7C10B3060B27;
        Wed, 29 Jan 2020 11:43:23 -0500 (EST)
Date:   Wed, 29 Jan 2020 17:43:21 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 1/1] drm: sun4i: hdmi: Add support for sun4i HDMI
 encoder audio
Message-ID: <20200129164321.34mornbi3xvx5dys@gilmour.lan>
References: <20200128140642.8404-1-stefan@olimex.com>
 <20200128140642.8404-2-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128140642.8404-2-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 28, 2020 at 04:06:42PM +0200, Stefan Mavrodiev wrote:
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> index 68d4644ac2dc..4cd35c97c503 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -23,6 +23,8 @@
>  #include <drm/drm_print.h>
>  #include <drm/drm_probe_helper.h>
>
> +#include <sound/soc.h>
> +
>  #include "sun4i_backend.h"
>  #include "sun4i_crtc.h"
>  #include "sun4i_drv.h"
> @@ -87,6 +89,10 @@ static void sun4i_hdmi_disable(struct drm_encoder *encoder)
>
>  	DRM_DEBUG_DRIVER("Disabling the HDMI Output\n");
>
> +#ifdef CONFIG_DRM_SUN4I_HDMI_AUDIO
> +	sun4i_hdmi_audio_destroy(hdmi);
> +#endif
> +
>  	val = readl(hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
>  	val &= ~SUN4I_HDMI_VID_CTRL_ENABLE;
>  	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
> @@ -114,6 +120,11 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder)
>  		val |= SUN4I_HDMI_VID_CTRL_HDMI_MODE;
>
>  	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
> +
> +#ifdef CONFIG_DRM_SUN4I_HDMI_AUDIO
> +	if (hdmi->hdmi_audio && sun4i_hdmi_audio_create(hdmi))
> +		DRM_ERROR("Couldn't create the HDMI audio adapter\n");
> +#endif

I really don't think we should be creating / removing the audio card
at enable / disable time.

To fix the drvdata pointer, you just need to use the card pointer in
the unbind, and that's it.

Maxime
