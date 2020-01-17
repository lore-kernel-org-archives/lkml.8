Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04235C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D348A2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgAQLuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:50:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:35138 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgAQLug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:50:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 03:48:01 -0800
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="218886700"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 03:47:56 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, Perry Yuan <pyuan@redhat.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] drm/i915: Don't use VBT for detecting DPCD backlight controls
In-Reply-To: <87zhemgvrn.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200116211623.53799-1-lyude@redhat.com> <20200116211623.53799-5-lyude@redhat.com> <87zhemgvrn.fsf@intel.com>
Date:   Fri, 17 Jan 2020 13:47:53 +0200
Message-ID: <87wo9qgv86.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020, Jani Nikula <jani.nikula@intel.com> wrote:
> On Thu, 16 Jan 2020, Lyude Paul <lyude@redhat.com> wrote:
>> Despite the fact that the VBT appears to have a field for specifying
>> that a system is equipped with a panel that supports standard VESA
>> backlight controls over the DP AUX channel, so far every system we've
>> spotted DPCD backlight control support on doesn't actually set this
>> field correctly and all have it set to INTEL_BACKLIGHT_DISPLAY_DDI.
>>
>> While we don't know the exact reason for this VBT misuse, talking with
>> some vendors indicated that there's a good number of laptop panels out
>> there that supposedly support both PWM backlight controls and DPCD
>> backlight controls as a workaround until Intel supports DPCD backlight
>> controls across platforms universally. This being said, the X1 Extreme
>> 2nd Gen that I have here (note that Lenovo is not the hardware vendor
>> that informed us of this) PWM backlight controls are advertised, but
>> only DPCD controls actually function. I'm going to make an educated
>> guess here and say that on systems like this one, it's likely that PWM
>> backlight controls might have been intended to work but were never
>> really tested by QA.
>>
>> Since we really need backlights to work without any extra module
>> parameters, let's take the risk here and rely on the standard DPCD caps
>> to tell us whether AUX backlight controls are supported or not. We still
>> check the VBT, but only to make sure that we don't enable DPCD backlight
>> controls on a panel that uses something other then the standard VESA
>> interfaces over AUX. Since panels using such non-standard interfaces
>> should probably have support added to i915, we'll print a warning when
>> seeing this in the VBT. We can remove this warning later if we end up
>> adding support for any custom backlight interfaces.
>>
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=112376
>> Cc: Jani Nikula <jani.nikula@intel.com>
>> Cc: Perry Yuan <pyuan@redhat.com>
>> Cc: AceLan Kao <acelan.kao@canonical.com>
>> ---
>>  .../drm/i915/display/intel_dp_aux_backlight.c    | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> index 77a759361c5c..3002b600635f 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
>> @@ -330,13 +330,17 @@ int intel_dp_aux_init_backlight_funcs(struct intel_connector *intel_connector)
>>  	struct intel_panel *panel = &intel_connector->panel;
>>  	struct drm_i915_private *dev_priv = to_i915(intel_connector->base.dev);
>>  
>> -	if (i915_modparams.enable_dpcd_backlight == 0 ||
>> -	    (i915_modparams.enable_dpcd_backlight == -1 &&
>> -	    dev_priv->vbt.backlight.type != INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE))
>> -		return -ENODEV;
>> -
>> -	if (!intel_dp_aux_display_control_capable(intel_connector))
>> +	if (i915_modparams.enable_dpcd_backlight == 0)
>>  		return -ENODEV;
>> +	if (i915_modparams.enable_dpcd_backlight == -1) {
>> +		if (dev_priv->vbt.backlight.type
>> +		    == INTEL_BACKLIGHT_PANEL_DRIVER_INTERFACE) {
>> +			DRM_WARN("VBT says panel uses custom panel driver interface, not using DPCD backlight controls\n");
>> +			return -ENODEV;
>> +		}
>> +		if (!intel_dp_aux_display_control_capable(intel_connector))
>> +			return -ENODEV;
>
> Functionally, I'm fine with trying this. But perhaps we should check aux
> and early return first, and then check what vbt says, to reduce the
> dmesg noise.
>
> I'll probably want to see a debug message if we're enabling aux
> backlight even if dev_priv->vbt.backlight.type !=
> INTEL_BACKLIGHT_VESA_EDP_AUX_INTERFACE. It's the kind of debug trace
> you'll really want to get first.

So I've gone ahead and pushed patches 1-3 and 5 in this series, as they
were tested as part of the series I posted.

BR,
Jani.


>
> BR,
> Jani.
>
>
>
>> +	}
>>  
>>  	panel->backlight.setup = intel_dp_aux_setup_backlight;
>>  	panel->backlight.enable = intel_dp_aux_enable_backlight;

-- 
Jani Nikula, Intel Open Source Graphics Center
