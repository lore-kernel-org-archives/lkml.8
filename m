Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ED6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B274207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgFOQ6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:58:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:51516 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbgFOQ6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:58:35 -0400
IronPort-SDR: /YfPx/yEKW2V5MUJcTC12yaqNgvMjrOEUSsNs1Lk1Q4iCtk+UAFg9hS9poJ923XSB4He5GDMB5
 1/0laOtJKqSA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 09:58:34 -0700
IronPort-SDR: 7MvvpkDXECoxDtSIqCCutobgh7uUPicxbLQD5/1qPBGdypi6duM5fpiWJmcvbiYitVGVb3e/Mh
 qm4yhvUp+A5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="261155586"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 15 Jun 2020 09:58:28 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 15 Jun 2020 19:57:58 +0300
Date:   Mon, 15 Jun 2020 19:57:58 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 5/5] =?iso-8859-1?Q?drm=2Fte?=
 =?iso-8859-1?Q?gra=3A_plane=3A_Support_180=B0?= rotation
Message-ID: <20200615165758.GR6112@intel.com>
References: <20200614200121.14147-1-digetx@gmail.com>
 <20200614200121.14147-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200614200121.14147-6-digetx@gmail.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 11:01:21PM +0300, Dmitry Osipenko wrote:
> Combining horizontal and vertical reflections gives us 180 degrees of
> rotation.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index f31bca27cde4..ddd9b88f8fce 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -608,6 +608,7 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
>  {
>  	struct tegra_plane_state *plane_state = to_tegra_plane_state(state);
>  	unsigned int rotation = DRM_MODE_ROTATE_0 |
> +				DRM_MODE_ROTATE_180 |

Leave this out ...

>  				DRM_MODE_REFLECT_X |
>  				DRM_MODE_REFLECT_Y;
>  	struct tegra_bo_tiling *tiling = &plane_state->tiling;
> @@ -659,6 +660,14 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
>  	else
>  		plane_state->reflect_y = false;
>  
> +	if (tegra_fb_is_bottom_up(state->fb))
> +		plane_state->reflect_y = true;
> +
> +	if (rotation & DRM_MODE_ROTATE_180) {
> +		plane_state->reflect_x = !plane_state->reflect_x;
> +		plane_state->reflect_y = !plane_state->reflect_y;
> +	}

... and drm_rotation_simplify() will do this for you.

Though the bottim_up() thing will need a slightly different tweak I
guess.

I'd write this as somehting like:
rotation = state->rotation;
if (bottom_up())
	rotation ^= DRM_MODE_REFLECT_Y;
rotation = drm_rotation_simplify(rotation,
				 DRM_MODE_ROTATE_0 |
				 DRM_MODE_REFLECT_X |
				 DRM_MODE_REFLECT_Y;

Also note my use of XOR for the bottom_up() handling. I suspect
the current code is already broken if you combine bottom_up()
and REFLECT_Y since it just uses an OR instead of an XOR. That's
assuming my hucnh what bottom_up() is supposed to do is correct.


> +
>  	/*
>  	 * Tegra doesn't support different strides for U and V planes so we
>  	 * error out if the user tries to display a framebuffer with such a
> @@ -720,7 +729,7 @@ static void tegra_plane_atomic_update(struct drm_plane *plane,
>  	window.dst.h = drm_rect_height(&plane->state->dst);
>  	window.bits_per_pixel = fb->format->cpp[0] * 8;
>  	window.reflect_x = state->reflect_x;
> -	window.reflect_y = tegra_fb_is_bottom_up(fb) || state->reflect_y;
> +	window.reflect_y = state->reflect_y;
>  
>  	/* copy from state */
>  	window.zpos = plane->state->normalized_zpos;
> @@ -806,6 +815,7 @@ static struct drm_plane *tegra_primary_plane_create(struct drm_device *drm,
>  	err = drm_plane_create_rotation_property(&plane->base,
>  						 DRM_MODE_ROTATE_0,
>  						 DRM_MODE_ROTATE_0 |
> +						 DRM_MODE_ROTATE_180 |
>  						 DRM_MODE_REFLECT_X |
>  						 DRM_MODE_REFLECT_Y);
>  	if (err < 0)
> @@ -1094,6 +1104,7 @@ static struct drm_plane *tegra_dc_overlay_plane_create(struct drm_device *drm,
>  	err = drm_plane_create_rotation_property(&plane->base,
>  						 DRM_MODE_ROTATE_0,
>  						 DRM_MODE_ROTATE_0 |
> +						 DRM_MODE_ROTATE_180 |
>  						 DRM_MODE_REFLECT_X |
>  						 DRM_MODE_REFLECT_Y);
>  	if (err < 0)
> -- 
> 2.26.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
