Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE19C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16122067C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgHZHFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:05:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:24662 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgHZHFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:05:12 -0400
IronPort-SDR: 8A/AJ86Qc2Da2ndvc/Zax5Jdfe6nI0ETIIOd7XZZGvcbG0v+rdxitl1g6+ItbqkK481LYjU27m
 LrgqdP2muogQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="174294095"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="174294095"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 00:05:11 -0700
IronPort-SDR: t9zAxUm+0FHTf119H7H8PV8/d7t15hFwVjWcUpPmVuSJw246+3dLtlSGJIJdZMZ+UVL+wne0mJ
 l9sOlDzxYKFg==
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="474661934"
Received: from jguenthe-mobl.ger.corp.intel.com (HELO localhost) ([10.252.32.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 00:05:04 -0700
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
Subject: Re: [RFC v4 16/20] drm/i915/dp: Extract drm_dp_get_sink_count()
In-Reply-To: <20200825195027.74681-17-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200825195027.74681-1-lyude@redhat.com> <20200825195027.74681-17-lyude@redhat.com>
Date:   Wed, 26 Aug 2020 10:05:01 +0300
Message-ID: <87o8mx6g6a.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020, Lyude Paul <lyude@redhat.com> wrote:
> And of course, we'll also need to read the sink count from other drivers
> as well if we're checking whether or not it's supported. So, let's
> extract the code for this into another helper.
>
> v2:
> * Fix drm_dp_dpcd_readb() ret check
> * Add back comment and move back sink_count assignment in intel_dp_get_dpcd()
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Sean Paul <sean@poorly.run>
> ---
>  drivers/gpu/drm/drm_dp_helper.c         | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_dp.c | 11 +++++------
>  include/drm/drm_dp_helper.h             |  1 +
>  3 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 863e0babc1903..67ad05eb05b7e 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -736,6 +736,28 @@ bool drm_dp_has_sink_count(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_dp_has_sink_count);
>  
> +/**
> + * drm_dp_get_sink_count() - Retrieve the sink count for a given sink

From the department of bikeshedding...

Should we have a naming scheme where it's obvious whether a function
will do DPCD access, or just shuffle existing data?

For example, drm_dp_read_foo() for anything with DPCD access
vs. drm_dp_get_foo() or even simpler for anything that only processes
pre-read data?

> + * @aux: The DP AUX channel to use
> + *
> + * Returns: The current sink count reported by @aux, or a negative error code
> + * otherwise.
> + */
> +int drm_dp_get_sink_count(struct drm_dp_aux *aux)
> +{
> +	u8 count;
> +	int ret;
> +
> +	ret = drm_dp_dpcd_readb(aux, DP_SINK_COUNT, &count);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 1)
> +		return -EIO;

Makes me wonder if that shouldn't be at drm_dp_dpcd_read() level, for
reads returning 0..len-1 bytes. Not necessarily part of this series, but
seems silly to set a precedent to start handling that return value all
over the place.

BR,
Jani.

> +
> +	return DP_GET_SINK_COUNT(count);
> +}
> +EXPORT_SYMBOL(drm_dp_get_sink_count);
> +
>  /*
>   * I2C-over-AUX implementation
>   */
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 35a4779a442e2..4337321a3be4f 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4648,6 +4648,8 @@ intel_dp_has_sink_count(struct intel_dp *intel_dp)
>  static bool
>  intel_dp_get_dpcd(struct intel_dp *intel_dp)
>  {
> +	int ret;
> +
>  	if (!intel_dp_read_dpcd(intel_dp))
>  		return false;
>  
> @@ -4664,11 +4666,8 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
>  	}
>  
>  	if (intel_dp_has_sink_count(intel_dp)) {
> -		u8 count;
> -		ssize_t r;
> -
> -		r = drm_dp_dpcd_readb(&intel_dp->aux, DP_SINK_COUNT, &count);
> -		if (r < 1)
> +		ret = drm_dp_get_sink_count(&intel_dp->aux);
> +		if (ret < 0)
>  			return false;
>  
>  		/*
> @@ -4676,7 +4675,7 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
>  		 * a member variable in intel_dp will track any changes
>  		 * between short pulse interrupts.
>  		 */
> -		intel_dp->sink_count = DP_GET_SINK_COUNT(count);
> +		intel_dp->sink_count = ret;
>  
>  		/*
>  		 * SINK_COUNT == 0 and DOWNSTREAM_PORT_PRESENT == 1 implies that
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index a1413a531eaf4..0c141fc81aaa8 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -1635,6 +1635,7 @@ struct drm_dp_desc;
>  bool drm_dp_has_sink_count(struct drm_connector *connector,
>  			   const u8 dpcd[DP_RECEIVER_CAP_SIZE],
>  			   const struct drm_dp_desc *desc);
> +int drm_dp_get_sink_count(struct drm_dp_aux *aux);
>  
>  void drm_dp_remote_aux_init(struct drm_dp_aux *aux);
>  void drm_dp_aux_init(struct drm_dp_aux *aux);

-- 
Jani Nikula, Intel Open Source Graphics Center
