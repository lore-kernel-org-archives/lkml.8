Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E98C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FE922BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgH0QjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:39:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:50528 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbgH0Qi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:38:56 -0400
IronPort-SDR: CxKpXJ8HWMe2EQ8GRMeBZeFfARBwmIMQXgGYzPXQWLe8Jsb7U7gtHvYoP984Sm5InJm+JfxTri
 B/MDC+yANALw==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="218073813"
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="218073813"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 09:38:56 -0700
IronPort-SDR: vts0Vlpjg+ajGomCStZRxxeP3u7ckxpaGtCW836r9BjS0dxN3YSHQJb6EVXC1Jv5a6OncUNQuA
 C40x1lJ5VhcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="299917319"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 27 Aug 2020 09:38:52 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 27 Aug 2020 19:38:51 +0300
Date:   Thu, 27 Aug 2020 19:38:51 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915/vlv_dsi_pll: fix spelling mistake
 "Cant" -> "Can't"
Message-ID: <20200827163851.GU6112@intel.com>
References: <20200810095952.60968-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200810095952.60968-1-colin.king@canonical.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:59:52AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a drm_err message. Fix it.

Thanks. Applied to dinq.

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/i915/display/vlv_dsi_pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/vlv_dsi_pll.c b/drivers/gpu/drm/i915/display/vlv_dsi_pll.c
> index d0a514301575..4070b00c3690 100644
> --- a/drivers/gpu/drm/i915/display/vlv_dsi_pll.c
> +++ b/drivers/gpu/drm/i915/display/vlv_dsi_pll.c
> @@ -483,7 +483,7 @@ int bxt_dsi_pll_compute(struct intel_encoder *encoder,
>  
>  	if (dsi_ratio < dsi_ratio_min || dsi_ratio > dsi_ratio_max) {
>  		drm_err(&dev_priv->drm,
> -			"Cant get a suitable ratio from DSI PLL ratios\n");
> +			"Can't get a suitable ratio from DSI PLL ratios\n");
>  		return -ECHRNG;
>  	} else
>  		drm_dbg_kms(&dev_priv->drm, "DSI PLL calculation is Done!!\n");
> -- 
> 2.27.0
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrjälä
Intel
