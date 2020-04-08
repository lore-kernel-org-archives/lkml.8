Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3581CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FC82075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgDHSCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:02:23 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:35770 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgDHSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:02:22 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id CA5AC80516;
        Wed,  8 Apr 2020 20:02:17 +0200 (CEST)
Date:   Wed, 8 Apr 2020 20:02:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Enrico Weigelt <info@metux.net>
Subject: Re: [PATCH] fbdev: mx3fb: avoid warning about psABI change
Message-ID: <20200408180216.GC24828@ravnborg.org>
References: <20200408162551.3928330-1-arnd@arndb.de>
 <87pnchhp2s.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnchhp2s.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=XpTUx2N9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
        a=e5mUnYsNAAAA:8 a=gf0cKYegyjFaCekMSkcA:9 a=CjuIK1q_8ugA:10
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani & Laurent.

On Wed, Apr 08, 2020 at 08:20:11PM +0300, Jani Nikula wrote:
> On Wed, 08 Apr 2020, Arnd Bergmann <arnd@arndb.de> wrote:
> > The arm64 gcc-9 release warns about a change in the calling
> > conventions:
> >
> > drivers/video/fbdev/mx3fb.c: In function 'sdc_init_panel':
> > drivers/video/fbdev/mx3fb.c:506:12: note: parameter passing for argument of type 'struct ipu_di_signal_cfg' changed in GCC 9.1
> >   506 | static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
> >       |            ^~~~~~~~~~~~~~
> > drivers/video/fbdev/mx3fb.c: In function '__set_par':
> > drivers/video/fbdev/mx3fb.c:848:7: note: parameter passing for argument of type 'struct ipu_di_signal_cfg' changed in GCC 9.1
> >
> > Change the file to just pass the struct by reference, which is
> > unambiguous and avoids the warning.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/video/fbdev/mx3fb.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
> > index 4af28e4421e5..e13fea3a292f 100644
> > --- a/drivers/video/fbdev/mx3fb.c
> > +++ b/drivers/video/fbdev/mx3fb.c
> > @@ -509,7 +509,7 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
> >  			  uint16_t h_start_width, uint16_t h_sync_width,
> >  			  uint16_t h_end_width, uint16_t v_start_width,
> >  			  uint16_t v_sync_width, uint16_t v_end_width,
> > -			  struct ipu_di_signal_cfg sig)
> > +			  struct ipu_di_signal_cfg *sig)
> 
> I have no idea why get_maintainer.pl (I presume) is Cc'ing me... but
> since it is, I'll note that the pointer could be const, while the patch
> is
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

I was too quick to apply this - sorry.
I will follow-up with a const fix.

	Sam

> 
> either way.
> 
> >  {
> >  	unsigned long lock_flags;
> >  	uint32_t reg;
> > @@ -591,17 +591,17 @@ static int sdc_init_panel(struct mx3fb_data *mx3fb, enum ipu_panel panel,
> >  
> >  	/* DI settings */
> >  	old_conf = mx3fb_read_reg(mx3fb, DI_DISP_IF_CONF) & 0x78FFFFFF;
> > -	old_conf |= sig.datamask_en << DI_D3_DATAMSK_SHIFT |
> > -		sig.clksel_en << DI_D3_CLK_SEL_SHIFT |
> > -		sig.clkidle_en << DI_D3_CLK_IDLE_SHIFT;
> > +	old_conf |= sig->datamask_en << DI_D3_DATAMSK_SHIFT |
> > +		sig->clksel_en << DI_D3_CLK_SEL_SHIFT |
> > +		sig->clkidle_en << DI_D3_CLK_IDLE_SHIFT;
> >  	mx3fb_write_reg(mx3fb, old_conf, DI_DISP_IF_CONF);
> >  
> >  	old_conf = mx3fb_read_reg(mx3fb, DI_DISP_SIG_POL) & 0xE0FFFFFF;
> > -	old_conf |= sig.data_pol << DI_D3_DATA_POL_SHIFT |
> > -		sig.clk_pol << DI_D3_CLK_POL_SHIFT |
> > -		sig.enable_pol << DI_D3_DRDY_SHARP_POL_SHIFT |
> > -		sig.Hsync_pol << DI_D3_HSYNC_POL_SHIFT |
> > -		sig.Vsync_pol << DI_D3_VSYNC_POL_SHIFT;
> > +	old_conf |= sig->data_pol << DI_D3_DATA_POL_SHIFT |
> > +		sig->clk_pol << DI_D3_CLK_POL_SHIFT |
> > +		sig->enable_pol << DI_D3_DRDY_SHARP_POL_SHIFT |
> > +		sig->Hsync_pol << DI_D3_HSYNC_POL_SHIFT |
> > +		sig->Vsync_pol << DI_D3_VSYNC_POL_SHIFT;
> >  	mx3fb_write_reg(mx3fb, old_conf, DI_DISP_SIG_POL);
> >  
> >  	map = &di_mappings[mx3fb->disp_data_fmt];
> > @@ -855,7 +855,7 @@ static int __set_par(struct fb_info *fbi, bool lock)
> >  				   fbi->var.upper_margin,
> >  				   fbi->var.vsync_len,
> >  				   fbi->var.lower_margin +
> > -				   fbi->var.vsync_len, sig_cfg) != 0) {
> > +				   fbi->var.vsync_len, &sig_cfg) != 0) {
> >  			dev_err(fbi->device,
> >  				"mx3fb: Error initializing panel.\n");
> >  			return -EINVAL;
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
