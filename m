Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2057BC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0018724695
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCJMHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:07:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:59099 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgCJMHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:07:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 05:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,536,1574150400"; 
   d="scan'208";a="234330305"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 10 Mar 2020 05:07:38 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 10 Mar 2020 14:07:37 +0200
Date:   Tue, 10 Mar 2020 14:07:37 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] drm/panel-simple: Fix dotclock for Ortustech COM37H3M
Message-ID: <20200310120737.GC13686@intel.com>
References: <e63a0533ad5b5142373437ef758aedbdb716152d.1583826198.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e63a0533ad5b5142373437ef758aedbdb716152d.1583826198.git.hns@goldelico.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 08:43:19AM +0100, H. Nikolaus Schaller wrote:
> The currently listed dotclock disagrees with the currently
> listed vrefresh rate. Change the dotclock to match the vrefresh.
> 
> There are two variants of the COM37H3M panel.
> The older one's COM37H3M05DTC data sheet specifies:
> 
>                          MIN      TYP     MAX
> CLK frequency    fCLK     --       22.4    26.3 MHz (in VGA mode)
> VSYNC Frequency  fVSYNC   54       60      66   Hz
> VSYNC cycle time tv       --      650      --   H
> HSYNC frequency  fHSYNC   --       39.3    --   kHz
> HSYNC cycle time th       --      570      --   CLK
> 
> The newer one's COM37H3M99DTC data sheet says:
> 
>                          MIN      TYP     MAX
> CLK frequency    fCLK     18       19.8    27   MHz
> VSYNC Frequency  fVSYNC   54       60      66   Hz
> VSYNC cycle time tv      646      650     700   H
> HSYNC frequency  fHSYNC  --        39.0    50.0 kHz
> HSYNC cycle time th      504      508     630   CLK
> 
> So we choose a parameter set that lies within the specs
> of both variants. We start at .vrefresh = 60,
> choose .htotal = 570 and .vtotal = 650 and end up
> in a clock of 22.230 MHz.
> 
> Reported-by: Ville Syrjala <ville.syrjala@linux.intel.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index e14c14ac62b5..b4cb23d4898d 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2390,15 +2390,15 @@ static const struct panel_desc ontat_yx700wv03 = {
>  };
>  
>  static const struct drm_display_mode ortustech_com37h3m_mode  = {
> -	.clock = 22153,
> +	.clock = 22230,
>  	.hdisplay = 480,
> -	.hsync_start = 480 + 8,
> -	.hsync_end = 480 + 8 + 10,
> -	.htotal = 480 + 8 + 10 + 10,
> +	.hsync_start = 480 + 40,
> +	.hsync_end = 480 + 40 + 10,
> +	.htotal = 480 + 40 + 10 + 40,
>  	.vdisplay = 640,
>  	.vsync_start = 640 + 4,
> -	.vsync_end = 640 + 4 + 3,
> -	.vtotal = 640 + 4 + 3 + 4,
> +	.vsync_end = 640 + 4 + 2,
> +	.vtotal = 640 + 4 + 2 + 4,
>  	.vrefresh = 60,

Numbers look consistent.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

>  	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
>  };
> -- 
> 2.23.0

-- 
Ville Syrjälä
Intel
