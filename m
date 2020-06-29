Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B417BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D9D320672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ioALFefx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389640AbgF2UmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731660AbgF2TOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CE9C00874E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:34:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so15628852wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=m1iLBqzd5JET/4+7q0bkqySBB/VEXvt/QPf9pQZxD4I=;
        b=ioALFefxtWjpUGVv9aHBdWR6XYQ5mUGOiLyBKcCwX93YpoWp3xtVYvb6n6RB2S8Ckz
         u3QFELzJpaqBiFOqrnUVJ2Wq7mtXuxbjmoKGKF4tV6Wn0jSwpXHOXITn+H14U5jKSdGf
         DiIL0Vq9MDiO8em2RGk+86Hl1UFagXnZvgL9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=m1iLBqzd5JET/4+7q0bkqySBB/VEXvt/QPf9pQZxD4I=;
        b=aMYXUyvUP+z1unC4NK0jKsThqDOlGGWdH4hgVmyJ8fqrFlCjKmuqrlV9xpaH5J21W5
         AcEREgCASSe5qGOyHIwY1C4o7Y0GJh9nxspXw1U1mlHt19NjawtdMU3IEpeXaf4DwwYw
         LO/Rm//uQwYzuDAIKCqSSd2FU4h80SQyYa3Tr4EXC6CYBriQXaURNZ5yCrwnFMgx2QFG
         0o6ZA9bwl8RnoIarVoEpBDDpZq0SzDCrx/RsG1Gxk8ib+TTYXzazzY2KCCCz18pVkUfQ
         +T1V92KJndFy2ZAH7P5tZAUb8Pu6oS0kvgFjKjyW585zRZFId6kPllTnVNY6+P4+Wjx6
         S1WA==
X-Gm-Message-State: AOAM530qCCSZsZPVspvW16xqAsF9kXnZasj8Yl0sk9KCK9N7tP/KxsdE
        sTwA/f2g8I3FFHtvre8yqwDcEQ==
X-Google-Smtp-Source: ABdhPJxoly9GEBebPkgfgZdpyDBicJrcaP5lLqpFp2lEkUI/aykgWwPjNusQB+uOOnfme7Z0sEXChg==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr15246966wrp.234.1593419641020;
        Mon, 29 Jun 2020 01:34:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y20sm4657035wmi.8.2020.06.29.01.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:34:00 -0700 (PDT)
Date:   Mon, 29 Jun 2020 10:33:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Antonio Borneo <antonio.borneo@st.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] drm/connector: fix minor typos in comments
Message-ID: <20200629083358.GK3278063@phenom.ffwll.local>
Mail-Followup-To: Antonio Borneo <antonio.borneo@st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20200626204252.44565-1-antonio.borneo@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626204252.44565-1-antonio.borneo@st.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 10:42:52PM +0200, Antonio Borneo wrote:
> Some of these comments are part of the Linux GPU Driver Developer's
> Guide.
> Fix some minor typo in the comments and remove a repeated 'the'.
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@st.com>

Queued up for 5.9 in drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_connector.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index d877ddc6dc57..cb62fb8e594e 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -38,7 +38,7 @@
>   * DOC: overview
>   *
>   * In DRM connectors are the general abstraction for display sinks, and include
> - * als fixed panels or anything else that can display pixels in some form. As
> + * also fixed panels or anything else that can display pixels in some form. As
>   * opposed to all other KMS objects representing hardware (like CRTC, encoder or
>   * plane abstractions) connectors can be hotplugged and unplugged at runtime.
>   * Hence they are reference-counted using drm_connector_get() and
> @@ -129,7 +129,7 @@ EXPORT_SYMBOL(drm_get_connector_type_name);
>  
>  /**
>   * drm_connector_get_cmdline_mode - reads the user's cmdline mode
> - * @connector: connector to quwery
> + * @connector: connector to query
>   *
>   * The kernel supports per-connector configuration of its consoles through
>   * use of the video= parameter. This function parses that option and
> @@ -991,7 +991,7 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
>   * 	DP MST sinks), or high-res integrated panels (like dual-link DSI) which
>   * 	are not gen-locked. Note that for tiled panels which are genlocked, like
>   * 	dual-link LVDS or dual-link DSI, the driver should try to not expose the
> - * 	tiling and virtualize both &drm_crtc and &drm_plane if needed. Drivers
> + * 	tiling and virtualise both &drm_crtc and &drm_plane if needed. Drivers
>   * 	should update this value using drm_connector_set_tile_property().
>   * 	Userspace cannot change this property.
>   * link-status:
> @@ -1131,7 +1131,7 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
>   *
>   *	It will even need to do colorspace conversion and get all layers
>   *	to one common colorspace for blending. It can use either GL, Media
> - *	or display engine to get this done based on the capabilties of the
> + *	or display engine to get this done based on the capabilities of the
>   *	associated hardware.
>   *
>   *	Driver expects metadata to be put in &struct hdr_output_metadata
> @@ -1614,7 +1614,7 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_property);
>   * variable refresh rate capability for a connector.
>   *
>   * Returns:
> - * Zero on success, negative errono on failure.
> + * Zero on success, negative errno on failure.
>   */
>  int drm_connector_attach_vrr_capable_property(
>  	struct drm_connector *connector)
> @@ -1759,7 +1759,7 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
>   * HDMI connectors.
>   *
>   * Returns:
> - * Zero on success, negative errono on failure.
> + * Zero on success, negative errno on failure.
>   */
>  int drm_mode_create_hdmi_colorspace_property(struct drm_connector *connector)
>  {
> @@ -1788,7 +1788,7 @@ EXPORT_SYMBOL(drm_mode_create_hdmi_colorspace_property);
>   * DP connectors.
>   *
>   * Returns:
> - * Zero on success, negative errono on failure.
> + * Zero on success, negative errno on failure.
>   */
>  int drm_mode_create_dp_colorspace_property(struct drm_connector *connector)
>  {
> @@ -1840,7 +1840,7 @@ EXPORT_SYMBOL(drm_mode_create_content_type_property);
>   * drm_mode_create_suggested_offset_properties - create suggests offset properties
>   * @dev: DRM device
>   *
> - * Create the the suggested x/y offset property for connectors.
> + * Create the suggested x/y offset property for connectors.
>   */
>  int drm_mode_create_suggested_offset_properties(struct drm_device *dev)
>  {
> @@ -1963,7 +1963,7 @@ int drm_connector_update_edid_property(struct drm_connector *connector,
>  		size = EDID_LENGTH * (1 + edid->extensions);
>  
>  	/* Set the display info, using edid if available, otherwise
> -	 * reseting the values to defaults. This duplicates the work
> +	 * resetting the values to defaults. This duplicates the work
>  	 * done in drm_add_edid_modes, but that function is not
>  	 * consistently called before this one in all drivers and the
>  	 * computation is cheap enough that it seems better to
> @@ -2076,7 +2076,7 @@ void drm_connector_set_vrr_capable_property(
>  EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
>  
>  /**
> - * drm_connector_set_panel_orientation - sets the connecter's panel_orientation
> + * drm_connector_set_panel_orientation - sets the connector's panel_orientation
>   * @connector: connector for which to set the panel-orientation property.
>   * @panel_orientation: drm_panel_orientation value to set
>   *
> @@ -2131,7 +2131,7 @@ EXPORT_SYMBOL(drm_connector_set_panel_orientation);
>  
>  /**
>   * drm_connector_set_panel_orientation_with_quirk -
> - *	set the connecter's panel_orientation after checking for quirks
> + *	set the connector's panel_orientation after checking for quirks
>   * @connector: connector for which to init the panel-orientation property.
>   * @panel_orientation: drm_panel_orientation value to set
>   * @width: width in pixels of the panel, used for panel quirk detection
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
