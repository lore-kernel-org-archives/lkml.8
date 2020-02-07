Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C4FC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCC720720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGLLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:11:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:41962 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgBGLLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:11:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 03:11:14 -0800
X-IronPort-AV: E=Sophos;i="5.70,413,1574150400"; 
   d="scan'208";a="236324213"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 03:11:10 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Revert "drm/i915: Don't use VBT for detecting DPCD backlight controls"
In-Reply-To: <20200204192823.111404-2-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200204192823.111404-1-lyude@redhat.com> <20200204192823.111404-2-lyude@redhat.com>
Date:   Fri, 07 Feb 2020 13:11:07 +0200
Message-ID: <87r1z61wl0.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Feb 2020, Lyude Paul <lyude@redhat.com> wrote:
> This reverts commit d2a4bb6f8bc8cf2d788adf7e59b5b52fe3a3333c.
>
> So, turns out that this ended up just breaking things. While many
> laptops incorrectly advertise themselves as supporting PWM backlight
> controls, they actually will only work with DPCD backlight controls.
> Unfortunately, it also seems there are a number of systems which
> advertise DPCD backlight controls in their eDP DPCD but don't actually
> support them. Talking with some laptop manufacturers has shown it might
> be possible to probe this support via the EDID (!?!?) but I haven't been
> able to confirm that this would work on any other manufacturer's
> systems.
>
> So in the mean time, we'll just revert this commit for now and go back
> to the old way of doing things.

The below sentence does not seem to match the patch:

> Additionally, let's print out an info
> message into the kernel log so that it's a little more obvious if a
> system needs DPCD backlight controls enabled through a quirk (which
> we'll introduce in the next commit).

I've pushed the revert to dinq, with the above removed, thanks for the
patch.

I'll try to look into the rest of the patches soon...

BR,
Jani.

>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index e86feebef299..48276237b362 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -328,16 +328,15 @@ intel_dp_aux_display_control_capable(struct intel_connector *connector)
>  int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_connector)
>  {
>  	struct intel_panel *panel = &intel_connector->panel;
> -	enum intel_backlight_type type =
> -		to_i915(intel_connector->base.dev)->vbt.backlight.type;
> +	struct drm_i915_private *dev_priv = to_i915(intel_connector->base.dev);
>  
>  	if (i915_modparams.enable_dpcd_backlight == 0 ||
>  	    (i915_modparams.enable_dpcd_backlight == -1 &&
> -	     !intel_dp_aux_display_control_capable(intel_connector)))
> +	    dev_priv->vbt.backlight.type != INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE))
>  		return -ENODEV;
>  
> -	if (type != INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE)
> -		DRM_DEBUG_DRIVER("Ignoring VBT backlight type\n");
> +	if (!intel_dp_aux_display_control_capable(intel_connector))
> +		return -ENODEV;
>  
>  	panel->backlight.setup = intel_dp_aux_setup_backlight;
>  	panel->backlight.enable = intel_dp_aux_enable_backlight;

-- 
Jani Nikula, Intel Open Source Graphics Center
