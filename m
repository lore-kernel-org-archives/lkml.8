Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AAFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839FC2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgGPFb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:31:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:18735 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgGPFb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:31:26 -0400
IronPort-SDR: Ty9Khd8ifG/SJ3+FMlRD4Xjsud8fx/XLROV/pWKTtX6kzqgbbFsMrBnIDWLQ6oxKSonGWoiA9h
 rUujDGv3XI9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="148472164"
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="148472164"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 22:31:25 -0700
IronPort-SDR: xBfYb4LkrgVsVe56PJhYLinf7aT7ukc2PXrNBBAx0Xbb0mq6db78PPpIcnMy1hVKSa9XbdTlEG
 zf/kG9toU0gw==
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="325034032"
Received: from mdroper-desk1.fm.intel.com (HELO mdroper-desk1.amr.corp.intel.com) ([10.1.27.168])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 22:31:25 -0700
Date:   Wed, 15 Jul 2020 22:31:24 -0700
From:   Matt Roper <matthew.d.roper@intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] drm/i915/display: Ensure that ret is always initialized
 in icl_combo_phy_verify_state
Message-ID: <20200716053124.GE2588642@mdroper-desk1.amr.corp.intel.com>
References: <20200716042742.123169-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716042742.123169-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 09:27:42PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/gpu/drm/i915/display/intel_combo_phy.c:268:3: warning: variable
> 'ret' is uninitialized when used here [-Wuninitialized]
>                 ret &= check_phy_reg(dev_priv, phy, ICL_PORT_TX_DW8_LN0(phy),
>                 ^~~
> drivers/gpu/drm/i915/display/intel_combo_phy.c:261:10: note: initialize
> the variable 'ret' to silence this warning
>         bool ret;
>                 ^
>                  = 0
> 1 warning generated.
> 
> In practice, the bug this warning appears to be concerned with would not
> actually matter because ret gets initialized to the return value of
> cnl_verify_procmon_ref_values. However, that does appear to be a bug
> since it means the first hunk of the patch this fixes won't actually do
> anything (since the values of check_phy_reg won't factor into the final
> ret value). Initialize ret to true then make all of the assignments a
> bitwise AND with itself so that the function always does what it should
> do.
> 
> Fixes: 239bef676d8e ("drm/i915/display: Implement new combo phy initialization step")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1094
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_combo_phy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_combo_phy.c b/drivers/gpu/drm/i915/display/intel_combo_phy.c
> index eccaa79cb4a9..a4b8aa6d0a9e 100644
> --- a/drivers/gpu/drm/i915/display/intel_combo_phy.c
> +++ b/drivers/gpu/drm/i915/display/intel_combo_phy.c
> @@ -258,7 +258,7 @@ static bool phy_is_master(struct drm_i915_private *dev_priv, enum phy phy)
>  static bool icl_combo_phy_verify_state(struct drm_i915_private *dev_priv,
>  				       enum phy phy)
>  {
> -	bool ret;
> +	bool ret = true;
>  	u32 expected_val = 0;
>  
>  	if (!icl_combo_phy_enabled(dev_priv, phy))
> @@ -276,7 +276,7 @@ static bool icl_combo_phy_verify_state(struct drm_i915_private *dev_priv,
>  				     DCC_MODE_SELECT_CONTINUOSLY);
>  	}
>  
> -	ret = cnl_verify_procmon_ref_values(dev_priv, phy);
> +	ret &= cnl_verify_procmon_ref_values(dev_priv, phy);
>  
>  	if (phy_is_master(dev_priv, phy)) {
>  		ret &= check_phy_reg(dev_priv, phy, ICL_PORT_COMP_DW8(phy),
> 
> base-commit: ca0e494af5edb59002665bf12871e94b4163a257
> -- 
> 2.28.0.rc0
> 

-- 
Matt Roper
Graphics Software Engineer
VTT-OSGC Platform Enablement
Intel Corporation
(916) 356-2795
