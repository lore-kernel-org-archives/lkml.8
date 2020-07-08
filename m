Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8233BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49481206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eb7RvTho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgGHRZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:25:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36878 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726006AbgGHRZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594229125;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PCbbzVisIhr1KPzrpNlYgZylablGP1kms5umra293M=;
        b=Eb7RvTholNn3OfPWcjUlPEqf1fJx+/AZvjsQc8hcqhnieNWqB4amQVrM3yMXfZiUyx0gIc
        dLBtGi6A/v6FupnkLeby+c3l6MLSMuMVbgX1HRamlKOMAU/Mpyup4aATQ764T3ZkRZ9PPg
        HDDXlWTxVpbFdPgfq+Eg4cOfD9HMgSU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-RL0WXL7qNUOzyY9a8soCIQ-1; Wed, 08 Jul 2020 13:25:17 -0400
X-MC-Unique: RL0WXL7qNUOzyY9a8soCIQ-1
Received: by mail-qk1-f199.google.com with SMTP id q6so22843914qke.21
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 10:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=8PCbbzVisIhr1KPzrpNlYgZylablGP1kms5umra293M=;
        b=oGoynHmlsRIQftAlE5NskuypsU8J69hNIcdK+pS7YaYby26QIgWCE5ZR27BDSpgN1u
         wTif+8BzdPfJSPlq40lIJE8HyKeFyZBhGGXaYNCUbrDsCPAPRC2Lr8ark59ui3bFwWPq
         faVb8JKBXLa8EK1DiwYnlDR1J1KWhefsGyl+kDrJCIuUtO3e4ar/oRwiu3DSL1imdZHN
         2ahXdAhVBWi/de5tvu80485/SHykssgdtPxf0fH3NTNWyGNP5PmcaF4Dfx15yZODBrhV
         18cjG2ZVBOa1H6jQAQDoh7PQo5Wm2mXhuNuXDyAEJitnkedSYatNUG/GgJx89hX3hY3w
         rdeQ==
X-Gm-Message-State: AOAM533t0KrGQlTITxLUM6o19RWxBW0CWRHeeidOZmtiRxU5efd5wbLf
        YzagAoaxlHNDm2uDULohAjMnCwx+heiiH1k7EYctkqdnentZCu7XZ8LvjRVSuH0zj8XiTWfTqga
        Q4NS+6wLI5Yvu0YsKfL3CWAne
X-Received: by 2002:a37:9ed6:: with SMTP id h205mr56839329qke.384.1594229116327;
        Wed, 08 Jul 2020 10:25:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl/XksMb0RSfvYaf4zucZwc2ys1sjnbTDpimEgAnoPLgdZ+PPqNjSFY/L+rjmqiFP0gjQoJw==
X-Received: by 2002:a37:9ed6:: with SMTP id h205mr56839308qke.384.1594229115992;
        Wed, 08 Jul 2020 10:25:15 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id u27sm449611qkm.121.2020.07.08.10.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 10:25:15 -0700 (PDT)
Message-ID: <b8d176ed8838ea0d63b794f5fd5d54b71afc0d69.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/probe_helper: Add
 drm_connector_helper_funcs.mode_valid_ctx
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     imre.deak@intel.com
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Lee Shawn C <shawn.c.lee@intel.com>
Date:   Wed, 08 Jul 2020 13:25:14 -0400
In-Reply-To: <20200707224036.GA22747@ideak-desk.fi.intel.com>
References: <20200526182313.4005-1-lyude@redhat.com>
         <20200526182313.4005-2-lyude@redhat.com>
         <20200707224036.GA22747@ideak-desk.fi.intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


JFYI - found an issue with this patch that wouldn't have shown up on i915, info
down below: 

On Wed, 2020-07-08 at 01:40 +0300, Imre Deak wrote:
> Sorry for the delay, the review as I promised:
> 
> On Tue, May 26, 2020 at 02:23:09PM -0400, Lyude Paul wrote:
> > This is just an atomic version of mode_valid, which is intended to be
> > used for situations where a driver might need to check the atomic state
> > of objects other than the connector itself. One such example is with
> > MST, where the maximum possible bandwidth on a connector can change
> > dynamically irregardless of the display configuration.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > Cc: Lee Shawn C <shawn.c.lee@intel.com>
> > Tested-by: Lee Shawn C <shawn.c.lee@intel.com>
> > ---
> >  drivers/gpu/drm/drm_crtc_helper_internal.h |  6 +-
> >  drivers/gpu/drm/drm_probe_helper.c         | 65 ++++++++++++++--------
> >  include/drm/drm_modeset_helper_vtables.h   | 41 ++++++++++++++
> >  3 files changed, 88 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_crtc_helper_internal.h
> > b/drivers/gpu/drm/drm_crtc_helper_internal.h
> > index f0a66ef47e5ad..ca767cba6094d 100644
> > --- a/drivers/gpu/drm/drm_crtc_helper_internal.h
> > +++ b/drivers/gpu/drm/drm_crtc_helper_internal.h
> > @@ -73,8 +73,10 @@ enum drm_mode_status drm_crtc_mode_valid(struct drm_crtc
> > *crtc,
> >  					 const struct drm_display_mode *mode);
> >  enum drm_mode_status drm_encoder_mode_valid(struct drm_encoder *encoder,
> >  					    const struct drm_display_mode
> > *mode);
> > -enum drm_mode_status drm_connector_mode_valid(struct drm_connector
> > *connector,
> > -					      struct drm_display_mode *mode);
> > +enum drm_mode_status
> > +drm_connector_mode_valid(struct drm_connector *connector,
> > +			 struct drm_display_mode *mode,
> > +			 struct drm_modeset_acquire_ctx *ctx);
> >  
> >  struct drm_encoder *
> >  drm_connector_get_single_encoder(struct drm_connector *connector);
> > diff --git a/drivers/gpu/drm/drm_probe_helper.c
> > b/drivers/gpu/drm/drm_probe_helper.c
> > index 466dfbba82564..3132784736841 100644
> > --- a/drivers/gpu/drm/drm_probe_helper.c
> > +++ b/drivers/gpu/drm/drm_probe_helper.c
> > @@ -86,16 +86,17 @@ drm_mode_validate_flag(const struct drm_display_mode
> > *mode,
> >  	return MODE_OK;
> >  }
> >  
> > -static enum drm_mode_status
> > +static int
> >  drm_mode_validate_pipeline(struct drm_display_mode *mode,
> > -			    struct drm_connector *connector)
> > +			   struct drm_connector *connector,
> > +			   struct drm_modeset_acquire_ctx *ctx)
> >  {
> >  	struct drm_device *dev = connector->dev;
> > -	enum drm_mode_status ret = MODE_OK;
> >  	struct drm_encoder *encoder;
> > +	int ret = MODE_OK;
> >  
> >  	/* Step 1: Validate against connector */
> > -	ret = drm_connector_mode_valid(connector, mode);
> > +	ret = drm_connector_mode_valid(connector, mode, ctx);
> >  	if (ret != MODE_OK)
> >  		return ret;
> >  
> > @@ -196,16 +197,23 @@ enum drm_mode_status drm_encoder_mode_valid(struct
> > drm_encoder *encoder,
> >  	return encoder_funcs->mode_valid(encoder, mode);
> >  }
> >  
> > -enum drm_mode_status drm_connector_mode_valid(struct drm_connector
> > *connector,
> > -					      struct drm_display_mode *mode)
> > +int
> > +drm_connector_mode_valid(struct drm_connector *connector,
> > +			 struct drm_display_mode *mode,
> > +			 struct drm_modeset_acquire_ctx *ctx)
> >  {
> >  	const struct drm_connector_helper_funcs *connector_funcs =
> >  		connector->helper_private;
> >  
> > -	if (!connector_funcs || !connector_funcs->mode_valid)
> > +	if (!connector_funcs)
> >  		return MODE_OK;
> >  
> > -	return connector_funcs->mode_valid(connector, mode);
> > +	if (connector_funcs->mode_valid_ctx)
> > +		return connector_funcs->mode_valid_ctx(connector, mode, ctx);
> > +	else if (connector_funcs->mode_valid)
> > +		return connector_funcs->mode_valid(connector, mode);
> > +	else
> > +		return MODE_OK;
> >  }
> >  
> >  #define DRM_OUTPUT_POLL_PERIOD (10*HZ)
> > @@ -375,8 +383,9 @@ EXPORT_SYMBOL(drm_helper_probe_detect);
> >   *      (if specified)
> >   *    - drm_mode_validate_flag() checks the modes against basic connector
> >   *      capabilities (interlace_allowed,doublescan_allowed,stereo_allowed)
> > - *    - the optional &drm_connector_helper_funcs.mode_valid helper can
> > perform
> > - *      driver and/or sink specific checks
> > + *    - the optional &drm_connector_helper_funcs.mode_valid or
> > + *      &drm_connector_helper_funcs.mode_valid_ctx helpers can perform
> > driver
> > + *      and/or sink specific checks
> >   *    - the optional &drm_crtc_helper_funcs.mode_valid,
> >   *      &drm_bridge_funcs.mode_valid and
> > &drm_encoder_helper_funcs.mode_valid
> >   *      helpers can perform driver and/or source specific checks which are
> > also
> > @@ -507,22 +516,34 @@ int drm_helper_probe_single_connector_modes(struct
> > drm_connector *connector,
> >  		mode_flags |= DRM_MODE_FLAG_3D_MASK;
> >  
> >  	list_for_each_entry(mode, &connector->modes, head) {
> > -		if (mode->status == MODE_OK)
> > -			mode->status = drm_mode_validate_driver(dev, mode);
> > +		if (mode->status != MODE_OK)
> > +			continue;
> > +
> > +		mode->status = drm_mode_validate_driver(dev, mode);
> > +		if (mode->status != MODE_OK)
> > +			continue;
> >  
> > -		if (mode->status == MODE_OK)
> > -			mode->status = drm_mode_validate_size(mode, maxX, maxY);
> > +		mode->status = drm_mode_validate_size(mode, maxX, maxY);
> > +		if (mode->status != MODE_OK)
> > +			continue;
> >  
> > -		if (mode->status == MODE_OK)
> > -			mode->status = drm_mode_validate_flag(mode, mode_flags);
> > +		mode->status = drm_mode_validate_flag(mode, mode_flags);
> > +		if (mode->status != MODE_OK)
> > +			continue;
> >  
> > -		if (mode->status == MODE_OK)
> > -			mode->status = drm_mode_validate_pipeline(mode,
> > -								  connector);
> > +		ret = drm_mode_validate_pipeline(mode, connector, &ctx);
> > +		if (ret == -EDEADLK) {
> > +			drm_modeset_backoff(&ctx);
> > +			goto retry;
> > +		} else if (WARN_ON_ONCE(ret < 0)) {
> > +			mode->status = MODE_BAD;

This check is wrong actually. We define negative values for drm_mode_status
(MODE_BAD, MODE_ERROR, MODE_STALE) which, at least with how drivers currently
seem to use them, are something we want to treat as not-unexpected errors and
not WARN_ON.

This is a bit annoying because it does mean there's some overlap between
drm_mode_status and some legitimate errno values (EPERM, ENOENT, ESRCH). Luckily
I can't see any reason why drivers would want to return those, but I think we
should probably print a debugging message when we get any errno values just so
developers don't get confused (also going to add a IS_ERR() equivalent for
drm_mode_status, but with a different name)

> > +		} else {
> > +			mode->status = ret;
> > +		}
> >  
> > -		if (mode->status == MODE_OK)
> > -			mode->status = drm_mode_validate_ycbcr420(mode,
> > -								  connector);
> > +		if (mode->status != MODE_OK)
> > +			continue;
> > +		mode->status = drm_mode_validate_ycbcr420(mode, connector);
> >  	}
> >  
> >  prune:
> > diff --git a/include/drm/drm_modeset_helper_vtables.h
> > b/include/drm/drm_modeset_helper_vtables.h
> > index 421a30f084631..8f020c3424b2b 100644
> > --- a/include/drm/drm_modeset_helper_vtables.h
> > +++ b/include/drm/drm_modeset_helper_vtables.h
> > @@ -968,6 +968,47 @@ struct drm_connector_helper_funcs {
> >  	 */
> >  	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
> >  					   struct drm_display_mode *mode);
> > +
> > +	/**
> > +	 * @mode_valid_ctx:
> > +	 *
> > +	 * Callback to validate a mode for a connector, irrespective of the
> > +	 * specific display configuration.
> > +	 *
> > +	 * This callback is used by the probe helpers to filter the mode list
> > +	 * (which is usually derived from the EDID data block from the sink).
> > +	 * See e.g. drm_helper_probe_single_connector_modes().
> > +	 *
> > +	 * This function is optional, and is the atomic version of
> > +	 * &drm_connector_funcs.mode_valid.
> > +	 *
> > +	 * To allow for accessing the atomic state of modesetting objects, the
> > +	 * helper libraries always call this with ctx set to a valid context,
> > +	 * and &drm_mode_config.connection_mutex will always be locked with
> > +	 * the ctx parameter set to @ctx. This allows for taking additional
> > +	 * locks as required.
> > +	 *
> > +	 * Even though additional locks may be acquired, this callback is
> > +	 * still expected not to take any constraints into account which would
> > +	 * be influenced by the currently set display state - such constraints
> > +	 * should be handled in the driver's atomic check. For example, if a
> > +	 * connector shares display bandwidth with other connectors then it
> > +	 * would be ok to validate a mode uses against the maximum possible
>                                      ^mode against?
> 
> Reviewed-by: Imre Deak <imre.deak@intel.com>
> 
> > +	 * bandwidth of the connector. But it wouldn't be ok to take the
> > +	 * current bandwidth usage of other connectors into account, as this
> > +	 * would change depending on the display state.
> > +	 *
> > +	 * Returns:
> > +	 *
> > +	 * Either &drm_mode_status.MODE_OK, one of the failure reasons in
> > +	 * &enum drm_mode_status, or -EDEADLK if a deadlock would have
> > +	 * occurred and we need to backoff.
> > +	 *
> > +	 */
> > +	int (*mode_valid_ctx)(struct drm_connector *connector,
> > +			      struct drm_display_mode *mode,
> > +			      struct drm_modeset_acquire_ctx *ctx);
> > +
> >  	/**
> >  	 * @best_encoder:
> >  	 *
> > -- 
> > 2.26.2
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

