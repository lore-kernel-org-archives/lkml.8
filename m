Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD7CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2304F2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCEJky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:40:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:13116 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCEJky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:40:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 01:40:53 -0800
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="234361803"
Received: from bennur-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.38.13])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 01:40:44 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Rajat Jain <rajatja@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Imre Deak <imre.deak@intel.com>,
        =?utf-8?Q?Jo?= =?utf-8?Q?s=C3=A9?= Roberto de Souza 
        <jose.souza@intel.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        gregkh@linuxfoundation.org, mathewk@google.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@denx.de>,
        seanpaul@google.com, Duncan Laurie <dlaurie@google.com>,
        jsbarnes@google.com, Thierry Reding <thierry.reding@gmail.com>,
        mpearson@lenovo.com, Nitin Joshi1 <njoshi1@lenovo.com>,
        Sugumaran Lacshiminarayanan <slacshiminar@lenovo.com>,
        Tomoki Maruichi <maruichit@lenovo.com>
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Subject: Re: [PATCH v6 2/3] drm/i915: Lookup and attach ACPI device node for connectors
In-Reply-To: <20200305012338.219746-3-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200305012338.219746-1-rajatja@google.com> <20200305012338.219746-3-rajatja@google.com>
Date:   Thu, 05 Mar 2020 11:40:45 +0200
Message-ID: <87o8tbnnqa.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Mar 2020, Rajat Jain <rajatja@google.com> wrote:
> Lookup and attach ACPI nodes for intel connectors. The lookup is done
> in compliance with ACPI Spec 6.3
> https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> (Ref: Pages 1119 - 1123).
>
> This can be useful for any connector specific platform properties. (This
> will be used for privacy screen in next patch).
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v6: Addressed minor comments from Jani at
>     https://lkml.org/lkml/2020/1/24/1143
>      - local variable renamed.
>      - used drm_dbg_kms()
>      - used acpi_device_handle()
>      - Used opaque type acpi_handle instead of void*
> v5: same as v4
> v4: Same as v3
> v3: fold the code into existing acpi_device_id_update() function
> v2: formed by splitting the original patch into ACPI lookup, and privacy
>     screen property. Also move it into i915 now that I found existing code
>     in i915 that can be re-used.
>
>  drivers/gpu/drm/i915/display/intel_acpi.c     | 24 +++++++++++++++++++
>  .../drm/i915/display/intel_display_types.h    |  5 ++++
>  drivers/gpu/drm/i915/display/intel_dp.c       |  3 +++
>  3 files changed, 32 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> index 3e6831cca4ac1..870c1ad98df92 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> @@ -222,11 +222,22 @@ static u32 acpi_display_type(struct intel_connector *connector)
>  	return display_type;
>  }
>  
> +/*
> + * Ref: ACPI Spec 6.3
> + * https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> + * Pages 1119 - 1123 describe, what I believe, a standard way of
> + * identifying / addressing "display panels" in the ACPI. It provides
> + * a way for the ACPI to define devices for the display panels attached
> + * to the system. It thus provides a way for the BIOS to export any panel
> + * specific properties to the system via ACPI (like device trees).
> + */
>  void intel_acpi_device_id_update(struct drm_i915_private *dev_priv)
>  {
>  	struct drm_device *dev = &dev_priv->drm;
>  	struct intel_connector *connector;
>  	struct drm_connector_list_iter conn_iter;
> +	struct acpi_device *conn_dev;
> +	u64 conn_addr;
>  	u8 display_index[16] = {};
>  
>  	/* Populate the ACPI IDs for all connectors for a given drm_device */
> @@ -242,6 +253,19 @@ void intel_acpi_device_id_update(struct drm_i915_private *dev_priv)
>  		device_id |= display_index[type]++ << ACPI_DISPLAY_INDEX_SHIFT;
>  
>  		connector->acpi_device_id = device_id;
> +
> +		/* Build the _ADR to look for */
> +		conn_addr = device_id | ACPI_DEVICE_ID_SCHEME |
> +				ACPI_BIOS_CAN_DETECT;
> +
> +		drm_dbg_kms(dev, "Checking connector ACPI node at _ADR=%llX\n",
> +			    conn_addr);
> +
> +		/* Look up the connector device, under the PCI device */
> +		conn_dev = acpi_find_child_device(
> +					ACPI_COMPANION(&dev->pdev->dev),
> +					conn_addr, false);
> +		connector->acpi_handle = acpi_device_handle(conn_dev);
>  	}
>  	drm_connector_list_iter_end(&conn_iter);
>  }
> diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
> index 5e00e611f077f..d70612cc1ba2a 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_types.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_types.h
> @@ -411,9 +411,14 @@ struct intel_connector {
>  	 */
>  	struct intel_encoder *encoder;
>  
> +#ifdef CONFIG_ACPI
>  	/* ACPI device id for ACPI and driver cooperation */
>  	u32 acpi_device_id;
>  
> +	/* ACPI handle corresponding to this connector display, if found */
> +	acpi_handle acpi_handle;
> +#endif
> +
>  	/* Reads out the current hw, returning true if the connector is enabled
>  	 * and active (i.e. dpms ON state). */
>  	bool (*get_hw_state)(struct intel_connector *);
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 0a417cd2af2bc..171821113d362 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -44,6 +44,7 @@
>  #include "i915_debugfs.h"
>  #include "i915_drv.h"
>  #include "i915_trace.h"
> +#include "intel_acpi.h"
>  #include "intel_atomic.h"
>  #include "intel_audio.h"
>  #include "intel_connector.h"
> @@ -6868,6 +6869,8 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
>  
>  		connector->state->scaling_mode = DRM_MODE_SCALE_ASPECT;
>  
> +		/* Lookup the ACPI node corresponding to the connector */
> +		intel_acpi_device_id_update(dev_priv);

I find this part problematic.

Normally, we call the function at probe via i915_driver_register() ->
intel_opregion_register() -> intel_opregion_resume() ->
intel_didl_outputs() -> intel_acpi_device_id_update(). It gets called
*once* at probe, after we have all the outputs (and thus connectors)
figured out.

This in turn calls it for every DP connector, before we even have all
connectors registered. But it also re-iterates the previously handled
connectors again and again.

The problem, of course, is that you'll need connector->acpi_handle to
figure out whether the feature is present and whether the property is
needed. Figuring out acpi_handle also requires
connector->acpi_device_id.

It's a bit of a catch-22.

I think the options are:

1) See if we can postpone creating and attaching properties to connector
->late_register hook. (I didn't have the time to look into it yet, at
all.)

2) Provide a way to populate connector->acpi_device_id and
connector->acpi_handle on a per-connector basis. At least the device id
remains constant for the lifetime of the drm_device (why do we keep
updating it at every resume?!) but can we be sure ->acpi_handle does
too? (I don't really know my way around ACPI.)

BR,
Jani.


>  	}
>  }

-- 
Jani Nikula, Intel Open Source Graphics Center
