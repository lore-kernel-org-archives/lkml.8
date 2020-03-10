Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF85C3F2D0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE4321D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCJQRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:17:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:35089 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgCJQRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:17:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 09:17:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="321851490"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga001.jf.intel.com with SMTP; 10 Mar 2020 09:17:24 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 10 Mar 2020 18:17:23 +0200
Date:   Tue, 10 Mar 2020 18:17:23 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc:     jani.nikula@linux.intel.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, mripard@kernel.org, mihail.atanassov@arm.com,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        linux-kernel@vger.kernel.org, ankit.k.nautiyal@intel.com
Subject: Re: [RFC][PATCH 5/5] drm/i915/display: Add Nearest-neighbor based
 integer scaling support
Message-ID: <20200310161723.GK13686@intel.com>
References: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com>
 <20200225070545.4482-6-pankaj.laxminarayan.bharadiya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200225070545.4482-6-pankaj.laxminarayan.bharadiya@intel.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 12:35:45PM +0530, Pankaj Bharadiya wrote:
> Integer scaling (IS) is a nearest-neighbor upscaling technique that
> simply scales up the existing pixels by an integer
> (i.e., whole number) multiplier.Nearest-neighbor (NN) interpolation
> works by filling in the missing color values in the upscaled image
> with that of the coordinate-mapped nearest source pixel value.
> 
> Both IS and NN preserve the clarity of the original image. Integer
> scaling is particularly useful for pixel art games that rely on
> sharp, blocky images to deliver their distinctive look.
> 
> Program the scaler filter coefficients to enable the NN filter if
> scaling filter property is set to DRM_SCALING_FILTER_NEAREST_NEIGHBOR
> and enable integer scaling.
> 
> Bspec: 49247
> 
> Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 83 +++++++++++++++++++-
>  drivers/gpu/drm/i915/display/intel_display.h |  2 +
>  drivers/gpu/drm/i915/display/intel_sprite.c  | 20 +++--
>  3 files changed, 97 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index b5903ef3c5a0..6d5f59203258 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -6237,6 +6237,73 @@ void skl_scaler_disable(const struct intel_crtc_state *old_crtc_state)
>  		skl_detach_scaler(crtc, i);
>  }
>  
> +/**
> + *  Theory behind setting nearest-neighbor integer scaling:
> + *
> + *  17 phase of 7 taps requires 119 coefficients in 60 dwords per set.
> + *  The letter represents the filter tap (D is the center tap) and the number
> + *  represents the coefficient set for a phase (0-16).
> + *
> + *         +------------+------------------------+------------------------+
> + *         |Index value | Data value coeffient 1 | Data value coeffient 2 |
> + *         +------------+------------------------+------------------------+
> + *         |   00h      |          B0            |          A0            |
> + *         +------------+------------------------+------------------------+
> + *         |   01h      |          D0            |          C0            |
> + *         +------------+------------------------+------------------------+
> + *         |   02h      |          F0            |          E0            |
> + *         +------------+------------------------+------------------------+
> + *         |   03h      |          A1            |          G0            |
> + *         +------------+------------------------+------------------------+
> + *         |   04h      |          C1            |          B1            |
> + *         +------------+------------------------+------------------------+
> + *         |   ...      |          ...           |          ...           |
> + *         +------------+------------------------+------------------------+
> + *         |   38h      |          B16           |          A16           |
> + *         +------------+------------------------+------------------------+
> + *         |   39h      |          D16           |          C16           |
> + *         +------------+------------------------+------------------------+
> + *         |   3Ah      |          F16           |          C16           |
> + *         +------------+------------------------+------------------------+
> + *         |   3Bh      |        Reserved        |          G16           |
> + *         +------------+------------------------+------------------------+
> + *
> + *  To enable nearest-neighbor scaling:  program scaler coefficents with
> + *  the center tap (Dxx) values set to 1 and all other values set to 0 as per
> + *  SCALER_COEFFICIENT_FORMAT
> + *
> + */
> +void skl_setup_nearest_neighbor_filter(struct drm_i915_private *dev_priv,
> +				  enum pipe pipe, int scaler_id)

skl_scaler_... 

> +{
> +
> +	int coeff = 0;
> +	int phase = 0;
> +	int tap;
> +	int val = 0;

Needlessly wide scope for most of these.

> +
> +	/*enable the index auto increment.*/
> +	intel_de_write_fw(dev_priv, SKL_PS_COEF_INDEX_SET0(pipe, scaler_id),
> +			  _PS_COEE_INDEX_AUTO_INC);
> +
> +	for (phase = 0; phase < 17; phase++) {
> +		for (tap = 0; tap < 7; tap++) {
> +			coeff++;

Can be part of the % check.

> +			if (tap == 3)
> +				val = (phase % 2) ? (0x800) : (0x800 << 16);

Parens overload.

> +
> +			if (coeff % 2 == 0) {
> +				intel_de_write_fw(dev_priv, SKL_PS_COEF_DATA_SET0(pipe, scaler_id), val);
> +				val = 0;

Can drop this val=0 if you move the variable into tight scope and
initialize there.

I was trying to think of a bit more generic way to do this, but couldn't
really think of anything apart from pre-filling the entire coefficient
set and the programming blindly. And that seems a bit wasteful if we only
care about nearest neighbour.

> +			}
> +
> +		}
> +
> +	}
> +
> +	intel_de_write_fw(dev_priv, SKL_PS_COEF_DATA_SET0(pipe, scaler_id), 0);
> +}
> +
>  static void skl_pfit_enable(const struct intel_crtc_state *crtc_state)
>  {
>  	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
> @@ -6260,9 +6327,23 @@ static void skl_pfit_enable(const struct intel_crtc_state *crtc_state)
>  		pfit_w = (crtc_state->pch_pfit.size >> 16) & 0xFFFF;
>  		pfit_h = crtc_state->pch_pfit.size & 0xFFFF;
>  
> +		id = scaler_state->scaler_id;
> +
>  		if (state->scaling_filter ==
>  		    DRM_SCALING_FILTER_NEAREST_NEIGHBOR) {
>  			scaling_filter = PS_FILTER_PROGRAMMED;
> +			skl_setup_nearest_neighbor_filter(dev_priv, pipe, id);

This should be sitting alongside the other register writes.

> +
> +			/* Make the scaling window size to integer multiple of
> +			 * source.
> +			 *
> +			 * TODO: Should userspace take desision to round
> +			 * scaling window to integer multiple?

To give userspace actual control of the pfit window size we need the border
props (or something along those lines). Step 1 is
https://patchwork.freedesktop.org/series/68409/. There are further steps
in my branch after that, but it's still missing the border props for
eDP/LVDS/DSI since I was too lazy to think how they should interact with
the existing scaling mode prop.

> +			 */
> +			pfit_w = rounddown(pfit_w,
> +					   (crtc_state->pipe_src_w << 16));
> +			pfit_h = rounddown(pfit_h,
> +					   (crtc_state->pipe_src_h << 16));
>  		}

This part should be dropped as Daniel mentioned.

>  
>  		hscale = (crtc_state->pipe_src_w << 16) / pfit_w;
> @@ -6271,8 +6352,6 @@ static void skl_pfit_enable(const struct intel_crtc_state *crtc_state)
>  		uv_rgb_hphase = skl_scaler_calc_phase(1, hscale, false);
>  		uv_rgb_vphase = skl_scaler_calc_phase(1, vscale, false);
>  
> -		id = scaler_state->scaler_id;
> -
>  		spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
>  
>  		intel_de_write_fw(dev_priv, SKL_PS_CTRL(pipe, id),

I think we should also explicitly indicate here which cofficient set(s)
we're going to use, even if using set0 does mean those bits will be 0.

> diff --git a/drivers/gpu/drm/i915/display/intel_display.h b/drivers/gpu/drm/i915/display/intel_display.h
> index f92efbbec838..49f58d3c98fe 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.h
> +++ b/drivers/gpu/drm/i915/display/intel_display.h
> @@ -586,6 +586,8 @@ void intel_crtc_arm_fifo_underrun(struct intel_crtc *crtc,
>  u16 skl_scaler_calc_phase(int sub, int scale, bool chroma_center);
>  int skl_update_scaler_crtc(struct intel_crtc_state *crtc_state);
>  void skl_scaler_disable(const struct intel_crtc_state *old_crtc_state);
> +void skl_setup_nearest_neighbor_filter(struct drm_i915_private *dev_priv,
> +				  enum pipe pipe, int scaler_id);
>  void ilk_pfit_disable(const struct intel_crtc_state *old_crtc_state);
>  u32 glk_plane_color_ctl(const struct intel_crtc_state *crtc_state,
>  			const struct intel_plane_state *plane_state);
> diff --git a/drivers/gpu/drm/i915/display/intel_sprite.c b/drivers/gpu/drm/i915/display/intel_sprite.c
> index fd7b31a21723..5bef5c031374 100644
> --- a/drivers/gpu/drm/i915/display/intel_sprite.c
> +++ b/drivers/gpu/drm/i915/display/intel_sprite.c
> @@ -415,18 +415,26 @@ skl_program_scaler(struct intel_plane *plane,
>  	u16 y_vphase, uv_rgb_vphase;
>  	int hscale, vscale;
>  	const struct drm_plane_state *state = &plane_state->uapi;
> +	u32 src_w = drm_rect_width(&plane_state->uapi.src) >> 16;
> +	u32 src_h = drm_rect_height(&plane_state->uapi.src) >> 16;
>  	u32 scaling_filter = PS_FILTER_MEDIUM;
> +	struct drm_rect dst;
>  
>  	if (state->scaling_filter == DRM_SCALING_FILTER_NEAREST_NEIGHBOR) {
>  		scaling_filter = PS_FILTER_PROGRAMMED;
> +		skl_setup_nearest_neighbor_filter(dev_priv, pipe, scaler_id);
> +
> +		/* Make the scaling window size to integer multiple of source
> +		 * TODO: Should userspace take desision to round scaling window
> +		 * to integer multiple?
> +		 */
> +		crtc_w = rounddown(crtc_w, src_w);
> +		crtc_h = rounddown(crtc_h, src_h);
>  	}
>  
> -	hscale = drm_rect_calc_hscale(&plane_state->uapi.src,
> -				      &plane_state->uapi.dst,
> -				      0, INT_MAX);
> -	vscale = drm_rect_calc_vscale(&plane_state->uapi.src,
> -				      &plane_state->uapi.dst,
> -				      0, INT_MAX);
> +	drm_rect_init(&dst, crtc_x, crtc_y, crtc_w, crtc_h);

Drop as well.

> +	hscale = drm_rect_calc_hscale(&plane_state->uapi.src, &dst, 0, INT_MAX);
> +	vscale = drm_rect_calc_vscale(&plane_state->uapi.src, &dst, 0, INT_MAX);
>  
>  	/* TODO: handle sub-pixel coordinates */
>  	if (intel_format_info_is_yuv_semiplanar(fb->format, fb->modifier) &&
> -- 
> 2.23.0

-- 
Ville Syrjälä
Intel
