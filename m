Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F441C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0979F2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgHZQZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:25:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:63758 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgHZQZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:25:19 -0400
IronPort-SDR: wYltJ6V+nAlxPHbY8ejAj7pP085E7QAv6hBVcvtLgK9kKbuJQrEfn/IoquZLpW6GVCqLmyby0I
 jntnbw7SmVFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="135876678"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="135876678"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 09:25:04 -0700
IronPort-SDR: 6lt9+j4eGT0v5tDACuVd3B8bxb9Q1oeuYvvvqx15jOzrfAwovc5udQTe/+x3iWHyqTR74WnxUj
 xV5hGEGnYrBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="336877690"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 26 Aug 2020 09:24:59 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 26 Aug 2020 19:24:58 +0300
Date:   Wed, 26 Aug 2020 19:24:58 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jani.nikula@linux.intel.com,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Uma Shankar <uma.shankar@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        intel-gfx@lists.freedesktop.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/lspcon: Limits to 8 bpc for RGB/YCbCr444
Message-ID: <20200826162458.GP6112@intel.com>
References: <20200826052143.17607-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200826052143.17607-1-kai.heng.feng@canonical.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 01:21:15PM +0800, Kai-Heng Feng wrote:
> LSPCON only supports 8 bpc for RGB/YCbCr444.
> 
> Set the correct bpp otherwise it renders blank screen.

Hmm. Does 
git://github.com/vsyrjala/linux.git dp_downstream_ports_5
work?

Actually better make that dp_downstream_ports_5^^^^^^^^^^^ aka.
54d846ce62a2 ("drm/i915: Do YCbCr 444->420 conversion via DP protocol
converters") to avoid the experiments and hacks I have sitting on top.

> 
> Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/2195
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/i915/display/intel_lspcon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_lspcon.c b/drivers/gpu/drm/i915/display/intel_lspcon.c
> index b781bf469644..c7a44fcaade8 100644
> --- a/drivers/gpu/drm/i915/display/intel_lspcon.c
> +++ b/drivers/gpu/drm/i915/display/intel_lspcon.c
> @@ -196,7 +196,8 @@ void lspcon_ycbcr420_config(struct drm_connector *connector,
>  		crtc_state->port_clock /= 2;
>  		crtc_state->output_format = INTEL_OUTPUT_FORMAT_YCBCR444;
>  		crtc_state->lspcon_downsampling = true;
> -	}
> +	} else
> +		crtc_state->pipe_bpp = 24;
>  }
>  
>  static bool lspcon_probe(struct intel_lspcon *lspcon)
> -- 
> 2.17.1

-- 
Ville Syrjälä
Intel
