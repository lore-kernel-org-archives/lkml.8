Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35C8C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A0B20769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tOm63dXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgDHRQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:16:31 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33552 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgDHRQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:16:31 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 71593522;
        Wed,  8 Apr 2020 19:16:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586366188;
        bh=9a89VhfQ+zxzqddEwHku2aXm8nngszld3qBqTJA/+iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOm63dXxNpKCIPk7dyAxYsjhfQ02dpkLbDtpcn2t2sY5CYcsNAQMZdzScCVXnSNe1
         I7hslD0nYn2m1Tq9FiHG9rIMNbAmokfgh6Xicis9C3h5TicZEsqQDDaIzJbU8bx339
         ORQHmva9tuPEHqjnEIr7yCqmyD6KO3ZnXKWPPFTc=
Date:   Wed, 8 Apr 2020 20:16:18 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Enrico Weigelt <info@metux.net>
Subject: Re: [PATCH] fbdev: mx3fb: avoid warning about psABI change
Message-ID: <20200408171618.GK4881@pendragon.ideasonboard.com>
References: <20200408162551.3928330-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408162551.3928330-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the patch.

On Wed, Apr 08, 2020 at 06:25:38PM +0200, Arnd Bergmann wrote:
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

How about making it a const pointer ? The current code doesn't change
the contents of the caller's structure as it passes it by value, let's
ensure that stays the same. With this fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

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
Regards,

Laurent Pinchart
