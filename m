Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67859C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436DA215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgCJTGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:06:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:20000 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgCJTGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:06:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 12:06:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="289126101"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 10 Mar 2020 12:06:05 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 10 Mar 2020 21:06:04 +0200
Date:   Tue, 10 Mar 2020 21:06:04 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Manasi Navare <manasi.d.navare@intel.com>,
        "Lee, Shawn C" <shawn.c.lee@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/mst: Hookup DRM DP MST
 late_register/early_unregister callbacks
Message-ID: <20200310190604.GP13686@intel.com>
References: <20200310185417.1588984-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200310185417.1588984-1-lyude@redhat.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 02:54:16PM -0400, Lyude Paul wrote:
> i915 can enable aux device nodes for DP MST by calling
> drm_dp_mst_connector_late_register()/drm_dp_mst_connector_early_unregister(),
> so let's hook that up.
> 
> Changes since v1:
> * Call intel_connector_register/unregister() from
>   intel_dp_mst_connector_late_register/unregister() so we don't lose
>   error injection - Ville Syrjälä
> 
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Manasi Navare <manasi.d.navare@intel.com>
> Cc: "Lee, Shawn C" <shawn.c.lee@intel.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_mst.c | 28 +++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index d53978ed3c12..9311c10f5b1b 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -548,12 +548,36 @@ static int intel_dp_mst_get_ddc_modes(struct drm_connector *connector)
>  	return ret;
>  }
>  
> +static int
> +intel_dp_mst_connector_late_register(struct drm_connector *connector)
> +{
> +	struct intel_connector *intel_connector = to_intel_connector(connector);
> +	int ret;
> +
> +	ret = drm_dp_mst_connector_late_register(connector,
> +						 intel_connector->port);
> +	if (ret < 0)
> +		return ret;
> +
> +	return intel_connector_register(connector);

Don't we have to undo the damage if this fails?

> +}
> +
> +static void
> +intel_dp_mst_connector_early_unregister(struct drm_connector *connector)
> +{
> +	struct intel_connector *intel_connector = to_intel_connector(connector);
> +
> +	intel_connector_unregister(connector);
> +	drm_dp_mst_connector_early_unregister(connector,
> +					      intel_connector->port);
> +}
> +
>  static const struct drm_connector_funcs intel_dp_mst_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.atomic_get_property = intel_digital_connector_atomic_get_property,
>  	.atomic_set_property = intel_digital_connector_atomic_set_property,
> -	.late_register = intel_connector_register,
> -	.early_unregister = intel_connector_unregister,
> +	.late_register = intel_dp_mst_connector_late_register,
> +	.early_unregister = intel_dp_mst_connector_early_unregister,
>  	.destroy = intel_connector_destroy,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  	.atomic_duplicate_state = intel_digital_connector_duplicate_state,
> -- 
> 2.24.1

-- 
Ville Syrjälä
Intel
