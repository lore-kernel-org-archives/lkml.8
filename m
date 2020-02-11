Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD18EC3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5321206ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgBKODj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:03:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:6535 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbgBKODj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:03:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 06:03:37 -0800
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="226511538"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 06:03:34 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     sean@poorly.run, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] drm/i915/dp: convert to struct drm_device based logging macros.
In-Reply-To: <20200206080014.13759-2-wambui.karugax@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200206080014.13759-1-wambui.karugax@gmail.com> <20200206080014.13759-2-wambui.karugax@gmail.com>
Date:   Tue, 11 Feb 2020 16:03:31 +0200
Message-ID: <87o8u5z0ek.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Feb 2020, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> @@ -5990,11 +6040,13 @@ int intel_dp_hdcp_write_an_aksv(struct intel_digital_port *intel_dig_port,
>  static int intel_dp_hdcp_read_bksv(struct intel_digital_port *intel_dig_port,
>  				   u8 *bksv)
>  {
> +	struct intel_dp *intel_dp = &intel_dig_port->dp;
>  	ssize_t ret;
>  	ret = drm_dp_dpcd_read(&intel_dig_port->dp.aux, DP_AUX_HDCP_BKSV, bksv,
>  			       DRM_HDCP_KSV_LEN);
>  	if (ret != DRM_HDCP_KSV_LEN) {
> -		DRM_DEBUG_KMS("Read Bksv from DP/AUX failed (%zd)\n", ret);
> +		drm_dbg_kms(&dp_to_i915(intel_dp)->drm,
> +			    "Read Bksv from DP/AUX failed (%zd)\n", ret);
>  		return ret >= 0 ? -EIO : ret;
>  	}

If you're introducing local variables just for logging, I would prefer
it to be i915.

	struct drm_i915_private *i915 = to_i915(intel_dig_port->base.base.dev);

	...

	drm_dbg_kms(&i915->drm, ...);

If you look at dp_to_i915() it actually converts intel_dp back to
intel_digital_port, and then does the above to it, to get at i915. This
is an unnecessary dance.

It's fine to use &dp_to_i915(intel_dp)->drm when there are only a couple
of logging calls in a function, and intel_dp is already there. But any
more than that, and I'd add the i915 local variable. For example, but
not limited to, intel_dp_handle_test_request() would benefit from i915
local var.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
