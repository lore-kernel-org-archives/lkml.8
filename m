Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74E2C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A55E207DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHZGv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:51:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:65017 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgHZGv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:51:27 -0400
IronPort-SDR: ZxJigQyeanaz+vhSSoUbExx+1i+rlULLvEoddYx3yIm5wqCpYx1B441DKAdeX64yGnaPIpSdWU
 P7ovp2b79/mg==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="136307295"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="136307295"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 23:51:26 -0700
IronPort-SDR: 18Kq/bo3KG+2JklofckLvITM98eBKy6PzKdqzNhgUaZo6F7C1RgDNcRA+WafVqssMiI4sPbMmj
 JzDOdx2sfeiQ==
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="474658678"
Received: from jguenthe-mobl.ger.corp.intel.com (HELO localhost) ([10.252.32.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 23:51:19 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        =?utf-8?Q?Jos?= =?utf-8?Q?=C3=A9?= Roberto de Souza 
        <jose.souza@intel.com>, Manasi Navare <manasi.d.navare@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v4 09/20] drm/i915/dp: Extract drm_dp_has_mst()
In-Reply-To: <20200825195027.74681-10-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200825195027.74681-1-lyude@redhat.com> <20200825195027.74681-10-lyude@redhat.com>
Date:   Wed, 26 Aug 2020 09:51:16 +0300
Message-ID: <87r1rt6gt7.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020, Lyude Paul <lyude@redhat.com> wrote:
> Just a tiny drive-by cleanup, we can consolidate i915's code for
> checking for MST support into a helper to be shared across drivers.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Sean Paul <sean@poorly.run>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 18 ++----------------
>  include/drm/drm_dp_mst_helper.h         | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 79c27f91f42c0..1e29d3a012856 100644
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
> +		drm_dp_has_mst(&intel_dp->aux, intel_dp->dpcd);
>  }
>  
>  static void
> @@ -4729,7 +4715,7 @@ intel_dp_configure_mst(struct intel_dp *intel_dp)
>  	struct drm_i915_private *i915 = dp_to_i915(intel_dp);
>  	struct intel_encoder *encoder =
>  		&dp_to_dig_port(intel_dp)->base;
> -	bool sink_can_mst = intel_dp_sink_can_mst(intel_dp);
> +	bool sink_can_mst = drm_dp_has_mst(&intel_dp->aux, intel_dp->dpcd);
>  
>  	drm_dbg_kms(&i915->drm,
>  		    "[ENCODER:%d:%s] MST support: port: %s, sink: %s, modparam: %s\n",
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 8b9eb4db3381c..2d8983a713e8c 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -911,4 +911,26 @@ __drm_dp_mst_state_iter_get(struct drm_atomic_state *state,
>  	for ((__i) = 0; (__i) < (__state)->num_private_objs; (__i)++) \
>  		for_each_if(__drm_dp_mst_state_iter_get((__state), &(mgr), NULL, &(new_state), (__i)))
>  
> +/**
> + * drm_dp_has_mst() - check whether or not a sink supports MST
> + * @aux: The DP AUX channel to use
> + * @dpcd: A cached copy of the DPCD capabilities for this sink
> + *
> + * Returns: %True if the sink supports MST, %false otherwise
> + */
> +static inline bool

I've become more and more critical of accumulating a lot of inlines in
headers. Do we really want this in the header?

> +drm_dp_has_mst(struct drm_dp_aux *aux,
> +	       const u8 dpcd[DP_RECEIVER_CAP_SIZE])
> +{
> +	u8 mstm_cap;
> +
> +	if (dpcd[DP_DPCD_REV] < DP_DPCD_REV_12)
> +		return false;
> +
> +	if (drm_dp_dpcd_readb(aux, DP_MSTM_CAP, &mstm_cap) != 1)
> +		return false;
> +
> +	return !!(mstm_cap & DP_MST_CAP);

The !! is superfluous.

BR,
Jani.

> +}
> +
>  #endif

-- 
Jani Nikula, Intel Open Source Graphics Center
