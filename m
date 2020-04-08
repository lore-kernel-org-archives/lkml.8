Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5B0C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D531420771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgDHRXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:23:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:34363 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbgDHRXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:23:47 -0400
IronPort-SDR: 8NsB3U7dQQ260ehjXjx3PmJvpEfhqCQqhb5Wdby0M6aQUUzK0XI/k/cu9rituPfm/UBSkGNwFo
 Z5tk3nGh4xIQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 10:20:18 -0700
IronPort-SDR: alANrSFQ+jAPj75SvasTFxKWiusMNUm7sDiMVunglpcRpH3YPg0qXdJUn1i88hu299MGPKZ9nm
 1wY0wwYKR0mQ==
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="425211159"
Received: from slinke-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.237])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 10:20:15 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Enrico Weigelt <info@metux.net>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: mx3fb: avoid warning about psABI change
In-Reply-To: <20200408162551.3928330-1-arnd@arndb.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200408162551.3928330-1-arnd@arndb.de>
Date:   Wed, 08 Apr 2020 20:20:11 +0300
Message-ID: <87pnchhp2s.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Apr 2020, Arnd Bergmann <arnd@arndb.de> wrote:
> The arm64 gcc-9 release warns about a change in the calling
> conventions:
>
> drivers/video/fbdev/mx3fb.c: In function 'sdc_init_panel':
> drivers/video/fbdev/mx3fb.c:506:12: note: parameter passing for argument of type 'struct ipu_di_signal_cfg' changed in GCC 9.1
>   506 | static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
>       |            ^~~~~~~~~~~~~~
> drivers/video/fbdev/mx3fb.c: In function '__set_par':
> drivers/video/fbdev/mx3fb.c:848:7: note: parameter passing for argument of type 'struct ipu_di_signal_cfg' changed in GCC 9.1
>
> Change the file to just pass the struct by reference, which is
> unambiguous and avoids the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/fbdev/mx3fb.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
> index 4af28e4421e5..e13fea3a292f 100644
> --- a/drivers/video/fbdev/mx3fb.c
> +++ b/drivers/video/fbdev/mx3fb.c
> @@ -509,7 +509,7 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
>  			  uint16_t h_start_width, uint16_t h_sync_width,
>  			  uint16_t h_end_width, uint16_t v_start_width,
>  			  uint16_t v_sync_width, uint16_t v_end_width,
> -			  struct ipu_di_signal_cfg sig)
> +			  struct ipu_di_signal_cfg *sig)

I have no idea why get_maintainer.pl (I presume) is Cc'ing me... but
since it is, I'll note that the pointer could be const, while the patch
is

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

either way.

>  {
>  	unsigned long lock_flags;
>  	uint32_t reg;
> @@ -591,17 +591,17 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
>  
>  	/* DI settings */
>  	old_conf = mx3fb_read_reg(mx3fb, DI_DISP_IF_CONF) & 0x78FFFFFF;
> -	old_conf |= sig.datamask_en << DI_D3_DATAMSK_SHIFT |
> -		sig.clksel_en << DI_D3_CLK_SEL_SHIFT |
> -		sig.clkidle_en << DI_D3_CLK_IDLE_SHIFT;
> +	old_conf |= sig->datamask_en << DI_D3_DATAMSK_SHIFT |
> +		sig->clksel_en << DI_D3_CLK_SEL_SHIFT |
> +		sig->clkidle_en << DI_D3_CLK_IDLE_SHIFT;
>  	mx3fb_write_reg(mx3fb, old_conf, DI_DISP_IF_CONF);
>  
>  	old_conf = mx3fb_read_reg(mx3fb, DI_DISP_SIG_POL) & 0xE0FFFFFF;
> -	old_conf |= sig.data_pol << DI_D3_DATA_POL_SHIFT |
> -		sig.clk_pol << DI_D3_CLK_POL_SHIFT |
> -		sig.enable_pol << DI_D3_DRDY_SHARP_POL_SHIFT |
> -		sig.Hsync_pol << DI_D3_HSYNC_POL_SHIFT |
> -		sig.Vsync_pol << DI_D3_VSYNC_POL_SHIFT;
> +	old_conf |= sig->data_pol << DI_D3_DATA_POL_SHIFT |
> +		sig->clk_pol << DI_D3_CLK_POL_SHIFT |
> +		sig->enable_pol << DI_D3_DRDY_SHARP_POL_SHIFT |
> +		sig->Hsync_pol << DI_D3_HSYNC_POL_SHIFT |
> +		sig->Vsync_pol << DI_D3_VSYNC_POL_SHIFT;
>  	mx3fb_write_reg(mx3fb, old_conf, DI_DISP_SIG_POL);
>  
>  	map = &di_mappings[mx3fb->disp_data_fmt];
> @@ -855,7 +855,7 @@ static int __set_par(struct fb_info *fbi, bool lock)
>  				   fbi->var.upper_margin,
>  				   fbi->var.vsync_len,
>  				   fbi->var.lower_margin +
> -				   fbi->var.vsync_len, sig_cfg) != 0) {
> +				   fbi->var.vsync_len, &sig_cfg) != 0) {
>  			dev_err(fbi->device,
>  				"mx3fb: Error initializing panel.\n");
>  			return -EINVAL;

-- 
Jani Nikula, Intel Open Source Graphics Center
