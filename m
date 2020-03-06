Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40D9C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42B9208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCFKPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:15:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:50480 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgCFKPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:15:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 02:15:16 -0800
X-IronPort-AV: E=Sophos;i="5.70,521,1574150400"; 
   d="scan'208";a="234756101"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 02:15:07 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?utf-8?Q?Jo?= =?utf-8?Q?s=C3=A9?= Roberto de Souza 
        <jose.souza@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mat King <mathewk@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        Sean Paul <seanpaul@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>,
        Guenter Roeck <groeck@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH v6 3/3] drm/i915: Add support for integrated privacy screens
In-Reply-To: <CACK8Z6ERZpZaSXsxrk_yGrRAtrgwytb5TEpyt1sX+V40U7m0sQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200305012338.219746-1-rajatja@google.com> <20200305012338.219746-4-rajatja@google.com> <87k13znmrc.fsf@intel.com> <CACK8Z6ERZpZaSXsxrk_yGrRAtrgwytb5TEpyt1sX+V40U7m0sQ@mail.gmail.com>
Date:   Fri, 06 Mar 2020 12:15:04 +0200
Message-ID: <87pndpoklz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
> OK, will do. In order to do that I may need to introduce driver level
> hooks that i915 driver can populate and drm core can call (or may be
> some functions to add privacy screen property that drm core exports
> and i915 driver will call).

The latter. Look at drm_connector_attach_*() functions in
drm_connector.c. i915 (or any other driver) can create and attach the
property as needed. drm_atomic_connector_{get,set}_property in
drm_atomic_uapi.c need to handle the properties, but *only* to get/set
the value in drm_connector_state, nothing more. How that value is
actually used is up to the drivers, but the userspace interface will be
the same instead of being driver specific.

>> > @@ -93,15 +97,18 @@ int intel_digital_connector_atomic_set_property(struct drm_connector *connector,
>> >       struct drm_i915_private *dev_priv = to_i915(dev);
>> >       struct intel_digital_connector_state *intel_conn_state =
>> >               to_intel_digital_connector_state(state);
>> > +     struct intel_connector *intel_connector = to_intel_connector(connector);
>> >
>> >       if (property == dev_priv->force_audio_property) {
>> >               intel_conn_state->force_audio = val;
>> >               return 0;
>> > -     }
>> > -
>> > -     if (property == dev_priv->broadcast_rgb_property) {
>> > +     } else if (property == dev_priv->broadcast_rgb_property) {
>> >               intel_conn_state->broadcast_rgb = val;
>> >               return 0;
>> > +     } else if (property == intel_connector->privacy_screen_property) {
>> > +             intel_privacy_screen_set_val(intel_connector, val);
>>
>> I think this part should only change the connector state. The driver
>> would then do the magic at commit stage according to the property value.

Also, this would be the part that's done in drm core level.

> Can you please point me to some code reference as to where in code
> does the "commit stage" apply the changes?

Look at, say, drm_connector_attach_scaling_mode_property(). In the
getter/setter code it'll just read/change state->scaling_mode. You can
use the value in encoder ->enable, ->disable, and ->update_pipe
hooks. Enable should enable the privacy screen if desired, disable
should probably unconditionally disable the privacy screen while
disabling the display, and update should just change the state according
to the value. Update is called if there isn't a full modeset. (Scaling
mode is a bit more indirect than that, affecting other things in the
encoder ->compute_config hook, leading to similar effects.)

Ville, anything I missed?

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
