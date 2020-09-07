Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8DBC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3532E207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="baX7fTKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgIGQSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:18:20 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38690 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbgIGQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:17:57 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 216E53E;
        Mon,  7 Sep 2020 18:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1599495457;
        bh=oUXDtmb/aWHYuEDGLK0yDkObyVcA366/VIqlbIpXLAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baX7fTKt2b1L58jlqgWnPkjrSCV4QUur25+tDNBEhpeS/yHIOAtaoMaP5TYK3iPOn
         tlKrBYyt6uPAAc7XB2q22S/1zK4pdAvWU214gn4lydYNPzdXM98PmEKykc0sQe24I4
         04Q289KjDUzKdloEpOiGT2uAfSno8ceF8330AaN0=
Date:   Mon, 7 Sep 2020 19:17:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     marex@denx.de, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: mxsfb: check framebuffer pitch
Message-ID: <20200907161712.GF6047@pendragon.ideasonboard.com>
References: <20200907160343.124405-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907160343.124405-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thank you for the patch.

On Mon, Sep 07, 2020 at 06:03:43PM +0200, Stefan Agner wrote:
> The lcdif IP does not support a framebuffer pitch (stride) other than
> the CRTC width. Check for equality and reject the state otherwise.
> 
> This prevents a distorted picture when using 640x800 and running the
> Mesa graphics stack. Mesa tires to use a cache aligned stride, which

s/tires/tries/

> leads at that particular resolution to width != stride. Currently
> Mesa has no fallback behavior, but rejecting this configuration allows
> userspace to handle the issue correctly.

I'm increasingly impressed by how featureful this IP core is :-)

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> index b721b8b262ce..79aa14027f91 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -403,14 +403,28 @@ static int mxsfb_plane_atomic_check(struct drm_plane *plane,
>  {
>  	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
>  	struct drm_crtc_state *crtc_state;
> +	unsigned int pitch;
> +	int ret;
>  
>  	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
>  						   &mxsfb->crtc);
>  
> -	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> -						   DRM_PLANE_HELPER_NO_SCALING,
> -						   DRM_PLANE_HELPER_NO_SCALING,
> -						   false, true);
> +	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> +						  DRM_PLANE_HELPER_NO_SCALING,
> +						  DRM_PLANE_HELPER_NO_SCALING,
> +						  false, true);
> +	if (ret || !plane_state->visible)

Would it be more explict to check for !plane_state->fb ? Otherwise I'll
have to verify that !fb always implies !visible :-)

> +		return ret;
> +
> +	pitch = crtc_state->mode.hdisplay *
> +		plane_state->fb->format->cpp[0];

This holds on a single line.

> +	if (plane_state->fb->pitches[0] != pitch) {
> +		dev_err(plane->dev->dev,
> +			"Invalid pitch: fb and crtc widths must be the same");

I'd turn this into a dev_dbg(), printing error messages to the kernel
log in response to user-triggered conditions is a bit too verbose and
could flood the log.

Wouldn't it be best to catch this issue when creating the framebuffer ?

> +		return -EINVAL;
> +	}
> +
> +	return 0;
>  }
>  
>  static void mxsfb_plane_primary_atomic_update(struct drm_plane *plane,

-- 
Regards,

Laurent Pinchart
