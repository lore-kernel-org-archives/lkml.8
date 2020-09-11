Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4E0C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D3C221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIKQc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:32:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:20408 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbgIKPTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:19:01 -0400
IronPort-SDR: aNyfM9wNeliUF6yCC63zXsKB4ICo5WwM0rq/A/1qklXb1ap2itW5qC67FsNrLDbfnA42weh77M
 bous9ExZjVxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="146487813"
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="146487813"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 06:56:39 -0700
IronPort-SDR: vmjohGXeCztnlk0HvpTJJd5IK/ylPkCfq+HKaYOu83Xe+UYZw4oOsfGeUHsoE/+XJ7K8FKmbE4
 ANMKFfA6LC5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="342306628"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 11 Sep 2020 06:56:34 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 11 Sep 2020 16:56:34 +0300
Date:   Fri, 11 Sep 2020 16:56:34 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/imx/dcss: fix 64-bit divisions
Message-ID: <20200911135634.GI6112@intel.com>
References: <20200911134827.32142-1-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200911134827.32142-1-laurentiu.palcu@oss.nxp.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 04:48:27PM +0300, Laurentiu Palcu wrote:
> Use div_s64() for the 64-bit divisions. This would allow the driver to compile
> on 32-bit architectures, if needed.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
>  drivers/gpu/drm/imx/dcss/dcss-scaler.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-scaler.c b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> index cd21905de580..7c1e0e461244 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> @@ -134,7 +134,7 @@ static int div_q(int A, int B)
>  	else
>  		temp -= B / 2;
>  
> -	result = (int)(temp / B);
> +	result = (int)(div_s64(temp, B));
>  	return result;
>  }
>  
> @@ -237,7 +237,7 @@ static void dcss_scaler_gaussian_filter(int fc_q, bool use_5_taps,
>  			ll_temp = coef[phase][i];
>  			ll_temp <<= PSC_COEFF_PRECISION;
>  			ll_temp += sum >> 1;
> -			ll_temp /= sum;

That looks like hand rolled DIV_ROUND_CLOSEST_ULL()

> +			ll_temp = div_s64(ll_temp, sum);
>  			coef[phase][i] = (int)ll_temp;
>  		}
>  	}
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
