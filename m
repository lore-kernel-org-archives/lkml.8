Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C23C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C3320663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCJQBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:01:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:55538 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgCJQBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:01:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 09:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="289076283"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 10 Mar 2020 09:01:07 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 10 Mar 2020 18:01:06 +0200
Date:   Tue, 10 Mar 2020 18:01:06 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc:     jani.nikula@linux.intel.com, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, mripard@kernel.org, mihail.atanassov@arm.com,
        linux-kernel@vger.kernel.org, ankit.k.nautiyal@intel.com
Subject: Re: [RFC][PATCH 1/5] drm: Introduce scaling filter property
Message-ID: <20200310160106.GH13686@intel.com>
References: <20200225070545.4482-1-pankaj.laxminarayan.bharadiya@intel.com>
 <20200225070545.4482-2-pankaj.laxminarayan.bharadiya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200225070545.4482-2-pankaj.laxminarayan.bharadiya@intel.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 12:35:41PM +0530, Pankaj Bharadiya wrote:
> Introduce new scaling filter property to allow userspace to select
> the driver's default scaling filter or Nearest-neighbor(NN) filter
> for upscaling operations on crtc/plane.
> 
> Drivers can set up this property for a plane by calling
> drm_plane_enable_scaling_filter() and for a CRTC by calling
> drm_crtc_enable_scaling_filter().
> 
> NN filter works by filling in the missing color values in the upscaled
> image with that of the coordinate-mapped nearest source pixel value.
> 
> NN filter for integer multiple scaling can be particularly useful for
> for pixel art games that rely on sharp, blocky images to deliver their
> distinctive look.
> 
> Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@intel.com>
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c |  8 +++++++
>  drivers/gpu/drm/drm_crtc.c        | 16 ++++++++++++++
>  drivers/gpu/drm/drm_mode_config.c | 13 ++++++++++++
>  drivers/gpu/drm/drm_plane.c       | 35 +++++++++++++++++++++++++++++++
>  include/drm/drm_crtc.h            | 10 +++++++++
>  include/drm/drm_mode_config.h     |  6 ++++++
>  include/drm/drm_plane.h           | 14 +++++++++++++
>  7 files changed, 102 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index a1e5e262bae2..4e3c1f3176e4 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -435,6 +435,8 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
>  		return ret;
>  	} else if (property == config->prop_vrr_enabled) {
>  		state->vrr_enabled = val;
> +	} else if (property == config->scaling_filter_property) {
> +		state->scaling_filter = val;

I think we want a per-plane/per-crtc prop for this. If we start adding
more filters we are surely going to need different sets for different hw
blocks.

>  	} else if (property == config->degamma_lut_property) {
>  		ret = drm_atomic_replace_property_blob_from_id(dev,
>  					&state->degamma_lut,
> @@ -503,6 +505,8 @@ drm_atomic_crtc_get_property(struct drm_crtc *crtc,
>  		*val = (state->gamma_lut) ? state->gamma_lut->base.id : 0;
>  	else if (property == config->prop_out_fence_ptr)
>  		*val = 0;
> +	else if (property == config->scaling_filter_property)
> +		*val = state->scaling_filter;
>  	else if (crtc->funcs->atomic_get_property)
>  		return crtc->funcs->atomic_get_property(crtc, state, property, val);
>  	else
> @@ -583,6 +587,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>  					sizeof(struct drm_rect),
>  					&replaced);
>  		return ret;
> +	} else if (property == config->scaling_filter_property) {
> +		state->scaling_filter = val;
>  	} else if (plane->funcs->atomic_set_property) {
>  		return plane->funcs->atomic_set_property(plane, state,
>  				property, val);
> @@ -641,6 +647,8 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
>  	} else if (property == config->prop_fb_damage_clips) {
>  		*val = (state->fb_damage_clips) ?
>  			state->fb_damage_clips->base.id : 0;
> +	} else if (property == config->scaling_filter_property) {
> +		*val = state->scaling_filter;
>  	} else if (plane->funcs->atomic_get_property) {
>  		return plane->funcs->atomic_get_property(plane, state, property, val);
>  	} else {
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 4936e1080e41..1ce7b2ac9eb5 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -748,3 +748,19 @@ int drm_mode_crtc_set_obj_prop(struct drm_mode_object *obj,
>  
>  	return ret;
>  }
> +
> +/**
> + * drm_crtc_enable_scaling_filter - Enables crtc scaling filter property.
> + * @crtc: CRTC on which to enable scaling filter property.
> + *
> + * This function lets driver to enable the scaling filter property on a crtc.
> + */
> +void drm_crtc_enable_scaling_filter(struct drm_crtc *crtc)
> +{
> +	struct drm_device *dev = crtc->dev;
> +
> +	drm_object_attach_property(&crtc->base,
> +				   dev->mode_config.scaling_filter_property,
> +				   0);
> +}
> +EXPORT_SYMBOL(drm_crtc_enable_scaling_filter);
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 08e6eff6a179..1024a8d1cd5d 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -214,6 +214,11 @@ static const struct drm_prop_enum_list drm_plane_type_enum_list[] = {
>  	{ DRM_PLANE_TYPE_CURSOR, "Cursor" },
>  };
>  
> +static const struct drm_prop_enum_list drm_scaling_filter_enum_list[] = {
> +	{ DRM_SCALING_FILTER_DEFAULT, "Default" },
> +	{ DRM_SCALING_FILTER_NEAREST_NEIGHBOR, "Nearest Neighbor" },
> +};
> +
>  static int drm_mode_create_standard_properties(struct drm_device *dev)
>  {
>  	struct drm_property *prop;
> @@ -370,6 +375,14 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
>  		return -ENOMEM;
>  	dev->mode_config.modifiers_property = prop;
>  
> +	prop = drm_property_create_enum(dev, 0,
> +				"SCALING_FILTER",
> +				drm_scaling_filter_enum_list,
> +				ARRAY_SIZE(drm_scaling_filter_enum_list));
> +	if (!prop)
> +		return -ENOMEM;
> +	dev->mode_config.scaling_filter_property = prop;
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index d6ad60ab0d38..ace7ee2775c8 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -1221,3 +1221,38 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
>  
>  	return ret;
>  }
> +
> +/**
> + * DOC: Scaling filter property
> + *
> + *
> + * SCALING_FILTER:
> + *
> + *	Indicates scaling filter to be used for CRTC/plane scaler
> + *
> + *	The value of this property can be one of the following:
> + *	Default:
> + *		Driver's default scaling filter
> + *	Nearest Neighbor:
> + *		Nearest Neighbor scaling filter
> + *
> + * Drivers can set up this property for a plane by calling
> + * drm_plane_enable_scaling_filter() and for a CRTC by calling
> + * drm_crtc_enable_scaling_filter()
> + */
> +
> +/**
> + * drm_plane_enable_scaling_filter - Enables plane scaling filter property.
> + * @plane: Plane on which to enable scaling filter property.
> + *
> + * This function lets driver to enable the scaling filter property on a plane.
> + */
> +void drm_plane_enable_scaling_filter(struct drm_plane *plane)
> +{
> +	struct drm_device *dev = plane->dev;
> +
> +	drm_object_attach_property(&plane->base,
> +				   dev->mode_config.scaling_filter_property,
> +				   0);
> +}
> +EXPORT_SYMBOL(drm_plane_enable_scaling_filter);
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 59b51a09cae6..770f9328a5ba 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -58,6 +58,7 @@ struct device_node;
>  struct dma_fence;
>  struct edid;
>  
> +
>  static inline int64_t U642I64(uint64_t val)
>  {
>  	return (int64_t)*((int64_t *)&val);
> @@ -296,6 +297,13 @@ struct drm_crtc_state {
>  	 */
>  	u32 target_vblank;
>  
> +	/**
> +	 * @scaling_filter:
> +	 *
> +	 * Scaling filter mode to be applied
> +	 */
> +	enum drm_scaling_filter scaling_filter;
> +
>  	/**
>  	 * @async_flip:
>  	 *
> @@ -1266,4 +1274,6 @@ static inline struct drm_crtc *drm_crtc_find(struct drm_device *dev,
>  #define drm_for_each_crtc(crtc, dev) \
>  	list_for_each_entry(crtc, &(dev)->mode_config.crtc_list, head)
>  
> +void drm_crtc_enable_scaling_filter(struct drm_crtc *crtc);
> +
>  #endif /* __DRM_CRTC_H__ */
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 3bcbe30339f0..8c308ae1056d 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -914,6 +914,12 @@ struct drm_mode_config {
>  	 */
>  	struct drm_property *modifiers_property;
>  
> +	/**
> +	 * @scaling_filter_property: CRTC/plane property to apply a particular
> +	 * filter while scaling.
> +	 */
> +	struct drm_property *scaling_filter_property;
> +
>  	/* cursor size */
>  	uint32_t cursor_width, cursor_height;
>  
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 3f396d94afe4..2bc665cc6071 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -35,6 +35,11 @@ struct drm_crtc;
>  struct drm_printer;
>  struct drm_modeset_acquire_ctx;
>  
> +
> +enum drm_scaling_filter {
> +	DRM_SCALING_FILTER_DEFAULT,
> +	DRM_SCALING_FILTER_NEAREST_NEIGHBOR,
> +};
>  /**
>   * struct drm_plane_state - mutable plane state
>   *
> @@ -214,6 +219,13 @@ struct drm_plane_state {
>  	 */
>  	bool visible;
>  
> +	/**
> +	 * @scaling_filter:
> +	 *
> +	 * Scaling filter mode to be applied
> +	 */
> +	enum drm_scaling_filter scaling_filter;
> +
>  	/**
>  	 * @commit: Tracks the pending commit to prevent use-after-free conditions,
>  	 * and for async plane updates.
> @@ -862,4 +874,6 @@ drm_plane_get_damage_clips(const struct drm_plane_state *state)
>  					state->fb_damage_clips->data : NULL);
>  }
>  
> +void drm_plane_enable_scaling_filter(struct drm_plane *plane);
> +
>  #endif
> -- 
> 2.23.0

-- 
Ville Syrjälä
Intel
