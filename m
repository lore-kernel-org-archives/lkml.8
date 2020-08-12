Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A1CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1281206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FhhRn0pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgHLJ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:27:01 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:48260 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHLJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:27:00 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AF121595;
        Wed, 12 Aug 2020 11:26:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597224417;
        bh=nd5A/NqoRz9D4axjoXf+5BPmPqiCH64mLqHlBQHchh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhhRn0pDKz3bSWG2BnT8nNTJnN+GudPkL7FMrhlnR6+lR63Dis82E2gYeSOFBNUIO
         Wxb4wC+1NR7QG6lCsUVzRz7kVl8kvMHk+oCoqfzlexvQ6UKnHirkHkmn201FKqpYp8
         86TdYdvoLd08QDp1h4AndE5aCwImLoUEcQlke33I=
Date:   Wed, 12 Aug 2020 12:26:44 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Algea Cao <algea.cao@rock-chips.com>
Cc:     a.hajda@samsung.com, kuankuan.y@gmail.com, hjc@rock-chips.com,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        sam@ravnborg.org, airlied@linux.ie, heiko@sntech.de,
        jernej.skrabec@siol.net, laurent.pinchart+renesas@ideasonboard.com,
        jonas@kwiboo.se, mripard@kernel.org, darekm@google.com,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, cychiang@chromium.org,
        linux-kernel@vger.kernel.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com, maarten.lankhorst@linux.intel.com,
        daniel@ffwll.ch
Subject: Re: [PATCH 1/6] drm: Add connector atomic_begin/atomic_flush
Message-ID: <20200812092644.GD6057@pendragon.ideasonboard.com>
References: <20200812083120.743-1-algea.cao@rock-chips.com>
 <20200812083407.856-1-algea.cao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200812083407.856-1-algea.cao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Algea,

Thank you for the patch.

On Wed, Aug 12, 2020 at 04:34:07PM +0800, Algea Cao wrote:
> In some situations, connector should get some work done
> when plane is updating. Such as when change output color
> format, hdmi should send AVMUTE to make screen black before
> crtc updating color format, or screen may flash. After color
> updating, hdmi should clear AVMUTE bring screen back to normal.
> 
> The process is as follows:
> AVMUTE -> Update CRTC -> Update HDMI -> Clear AVMUTE
> 
> So we introduce connector atomic_begin/atomic_flush.

Implementing this through .atomic_begin() and .atomic_flush() seems like
a pretty big hack to me. Furthermore, I think this should be implemented
as bridge operations, not at the connector level, as the HDMI encoder
may not be the component that implements the drm_connector.

> Signed-off-by: Algea Cao <algea.cao@rock-chips.com>
> 
> ---
> 
>  drivers/gpu/drm/drm_atomic_helper.c      | 46 ++++++++++++++++++++++++
>  include/drm/drm_modeset_helper_vtables.h | 19 ++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index f68c69a45752..f4abd700d2c4 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -2471,6 +2471,8 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
>  				     struct drm_atomic_state *old_state,
>  				     uint32_t flags)
>  {
> +	struct drm_connector *connector;
> +	struct drm_connector_state *old_connector_state, *new_connector_state;
>  	struct drm_crtc *crtc;
>  	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>  	struct drm_plane *plane;
> @@ -2479,6 +2481,28 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
>  	bool active_only = flags & DRM_PLANE_COMMIT_ACTIVE_ONLY;
>  	bool no_disable = flags & DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET;
>  
> +	for_each_oldnew_connector_in_state(old_state, connector,
> +					   old_connector_state,
> +					   new_connector_state, i) {
> +		const struct drm_connector_helper_funcs *funcs;
> +
> +		if (!connector->state->crtc)
> +			continue;
> +
> +		if (!connector->state->crtc->state->active)
> +			continue;
> +
> +		funcs = connector->helper_private;
> +
> +		if (!funcs || !funcs->atomic_begin)
> +			continue;
> +
> +		DRM_DEBUG_ATOMIC("flush beginning [CONNECTOR:%d:%s]\n",
> +				 connector->base.id, connector->name);
> +
> +		funcs->atomic_begin(connector, old_connector_state);
> +	}
> +
>  	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
>  		const struct drm_crtc_helper_funcs *funcs;
>  
> @@ -2550,6 +2574,28 @@ void drm_atomic_helper_commit_planes(struct drm_device *dev,
>  
>  		funcs->atomic_flush(crtc, old_crtc_state);
>  	}
> +
> +	for_each_oldnew_connector_in_state(old_state, connector,
> +					   old_connector_state,
> +					   new_connector_state, i) {
> +		const struct drm_connector_helper_funcs *funcs;
> +
> +		if (!connector->state->crtc)
> +			continue;
> +
> +		if (!connector->state->crtc->state->active)
> +			continue;
> +
> +		funcs = connector->helper_private;
> +
> +		if (!funcs || !funcs->atomic_flush)
> +			continue;
> +
> +		DRM_DEBUG_ATOMIC("flushing [CONNECTOR:%d:%s]\n",
> +				 connector->base.id, connector->name);
> +
> +		funcs->atomic_flush(connector, old_connector_state);
> +	}
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_commit_planes);
>  
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index 421a30f08463..10f3f2e2fe28 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -1075,6 +1075,25 @@ struct drm_connector_helper_funcs {
>  	void (*atomic_commit)(struct drm_connector *connector,
>  			      struct drm_connector_state *state);
>  
> +	/**
> +	 * @atomic_begin:
> +	 *
> +	 * flush atomic update
> +	 *
> +	 * This callback is used by the atomic modeset helpers but it is optional.
> +	 */
> +	void (*atomic_begin)(struct drm_connector *connector,
> +			     struct drm_connector_state *state);
> +
> +	/**
> +	 * @atomic_begin:
> +	 *
> +	 * begin atomic update
> +	 *
> +	 * This callback is used by the atomic modeset helpers but it is optional.
> +	 */
> +	void (*atomic_flush)(struct drm_connector *connector,
> +			     struct drm_connector_state *state);
>  	/**
>  	 * @prepare_writeback_job:
>  	 *

-- 
Regards,

Laurent Pinchart
