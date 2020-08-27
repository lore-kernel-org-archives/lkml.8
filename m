Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FEEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 639FC22B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgH0OIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:08:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:13418 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728016AbgH0OBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:01:53 -0400
IronPort-SDR: 04S46TZN9v2b7ldtXn7FJj3kvBLdDT1upYMXoofUJ1hjqMnuBJdeHjWkkchQ93V1+/uX7AuBac
 acIkdLqkvteQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="174529459"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="174529459"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 06:50:55 -0700
IronPort-SDR: ROk2sEy5DjeF13nIMr60DR/K8Q6X9Mh1wvDhBaEzk8LFWPUA0odTbyC00j591GLrPHPcRFt1xE
 mH9ogS5hdkAg==
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="475221159"
Received: from jhaapako-mobl4.ger.corp.intel.com (HELO localhost) ([10.249.33.115])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 06:50:48 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        =?utf-8?Q?Jos=C3=A9?= Roberto de Souza <jose.souza@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 09/20] drm/i915/dp: Extract drm_dp_read_mst_cap()
In-Reply-To: <20200826182456.322681-10-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200826182456.322681-1-lyude@redhat.com> <20200826182456.322681-10-lyude@redhat.com>
Date:   Thu, 27 Aug 2020 16:50:46 +0300
Message-ID: <87d03c5hah.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020, Lyude Paul <lyude@redhat.com> wrote:
> Just a tiny drive-by cleanup, we can consolidate i915's code for
> checking for MST support into a helper to be shared across drivers.
>
> v5:
> * Drop !!()
> * Move drm_dp_has_mst() out of header
> * Change name from drm_dp_has_mst() to drm_dp_read_mst_cap()
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Sean Paul <sean@poorly.run>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c   | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_dp.c | 18 ++----------------
>  include/drm/drm_dp_mst_helper.h         |  3 +--
>  3 files changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 67dd72ea200e0..17dbed0a9800d 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3486,6 +3486,28 @@ static int drm_dp_get_vc_payload_bw(u8 dp_link_bw, u8  dp_link_count)
>  	return dp_link_bw * dp_link_count / 2;
>  }
>  
> +/**
> + * drm_dp_read_mst_cap() - check whether or not a sink supports MST
> + * @aux: The DP AUX channel to use
> + * @dpcd: A cached copy of the DPCD capabilities for this sink
> + *
> + * Returns: %True if the sink supports MST, %false otherwise
> + */
> +bool drm_dp_read_mst_cap(struct drm_dp_aux *aux,
> +			 const u8 dpcd[DP_RECEIVER_CAP_SIZE])
> +{
> +	u8 mstm_cap;
> +
> +	if (dpcd[DP_DPCD_REV] < DP_DPCD_REV_12)
> +		return false;
> +
> +	if (drm_dp_dpcd_readb(aux, DP_MSTM_CAP, &mstm_cap) != 1)
> +		return false;
> +
> +	return mstm_cap & DP_MST_CAP;
> +}
> +EXPORT_SYMBOL(drm_dp_read_mst_cap);
> +
>  /**
>   * drm_dp_mst_topology_mgr_set_mst() - Set the MST state for a topology manager
>   * @mgr: manager to set state for
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 79c27f91f42c0..4c7314b7a84e4 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4699,20 +4699,6 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
>  	return true;
>  }
>  
> -static bool
> -intel_dp_sink_can_mst(struct intel_dp *intel_dp)
> -{
> -	u8 mstm_cap;
> -
> -	if (intel_dp->dpcd[DP_DPCD_REV] < 0x12)
> -		return false;
> -
> -	if (drm_dp_dpcd_readb(&intel_dp->aux, DP_MSTM_CAP, &mstm_cap) != 1)
> -		return false;
> -
> -	return mstm_cap & DP_MST_CAP;
> -}
> -
>  static bool
>  intel_dp_can_mst(struct intel_dp *intel_dp)
>  {
> @@ -4720,7 +4706,7 @@ intel_dp_can_mst(struct intel_dp *intel_dp)
>  
>  	return i915->params.enable_dp_mst &&
>  		intel_dp->can_mst &&
> -		intel_dp_sink_can_mst(intel_dp);
> +		drm_dp_read_mst_cap(&intel_dp->aux, intel_dp->dpcd);
>  }
>  
>  static void
> @@ -4729,7 +4715,7 @@ intel_dp_configure_mst(struct intel_dp *intel_dp)
>  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
>  	struct intel_encoder *encoder =
>  		&dp_to_dig_port(intel_dp)->base;
> -	bool sink_can_mst = intel_dp_sink_can_mst(intel_dp);
> +	bool sink_can_mst = drm_dp_read_mst_cap(&intel_dp->aux, intel_dp->dpcd);
>  
>  	drm_dbg_kms(&i915->drm,
>  		    "[ENCODER:%d:%s] MST support: port: %s, sink: %s, modparam: %s\n",
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 8b9eb4db3381c..6ae5860d8644e 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -728,10 +728,9 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
>  
>  void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr);
>  
> -
> +bool drm_dp_read_mst_cap(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
>  int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool mst_state);
>  
> -
>  int drm_dp_mst_hpd_irq(struct drm_dp_mst_topology_mgr *mgr, u8 *esi, bool *handled);

-- 
Jani Nikula, Intel Open Source Graphics Center
