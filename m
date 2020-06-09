Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7237FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579F020774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgFIO6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:58:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:54057 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgFIO6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:58:20 -0400
IronPort-SDR: G63DDs6OgpbkV7WJuUu7Z1+a274vXCw76G8h2uI3Qf/XUZMJ3TvcEFT7lMsv5ZfAl9HsdDZBUt
 C8eDWEsePDnw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 07:58:09 -0700
IronPort-SDR: tMSN7Nuone8GvvVNmU8W6rqQ5cg9e7QBFaHz1xtf3c0cIhx/GpbXcOVAif3LeSrMB9PI4/7t/W
 dIIUVVJDTIrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400"; 
   d="scan'208";a="314219612"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 09 Jun 2020 07:58:06 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 09 Jun 2020 17:57:45 +0300
Date:   Tue, 9 Jun 2020 17:57:45 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Cyrus Lien <cyrus.lien@canonical.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: add support for min horizontal rate equal to
 max horizontal rate
Message-ID: <20200609145745.GO6112@intel.com>
References: <20200608195704.29841-1-cyrus.lien@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200608195704.29841-1-cyrus.lien@canonical.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 03:57:04AM +0800, Cyrus Lien wrote:
> According to EDID spec, table 3.26, byte #6 and #8, which said "Minimum
> rate value shall be less than or equal to maximum rate value". The minimum
> horizontal/vertical rate value is able to be equal to maximum horizontal/
> veritcal rate value.

How does that justifiy ignoring the min value?

> 
> This change check if h/v-sync excess maximum horizontal/vertical rate if
> hmin equal to hmax or vmin equal to vmax.
> 
> Signed-off-by: Cyrus Lien <cyrus.lien@canonical.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index fed653f13c26..23878320eabd 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2674,6 +2674,9 @@ mode_in_hsync_range(const struct drm_display_mode *mode,
>  	    hmax += ((t[4] & 0x08) ? 255 : 0);
>  	hsync = drm_mode_hsync(mode);
>  
> +	if (hmax == hmin)
> +		return (hsync <= hmax);
> +
>  	return (hsync <= hmax && hsync >= hmin);
>  }
>  
> @@ -2691,6 +2694,9 @@ mode_in_vsync_range(const struct drm_display_mode *mode,
>  	    vmax += ((t[4] & 0x02) ? 255 : 0);
>  	vsync = drm_mode_vrefresh(mode);
>  
> +	if (vmax == vmin)
> +		return (vsync <= vmax);
> +
>  	return (vsync <= vmax && vsync >= vmin);
>  }
>  
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
