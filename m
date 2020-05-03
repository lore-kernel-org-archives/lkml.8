Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2BEC47256
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 17:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F290206EB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 17:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgECRkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 13:40:45 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:33446 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgECRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 13:40:45 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id D54FB20026;
        Sun,  3 May 2020 19:40:41 +0200 (CEST)
Date:   Sun, 3 May 2020 19:40:40 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     b.zolnierkie@samsung.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video/fbdev/matroxfb: Remove dead code
Message-ID: <20200503174040.GA27362@ravnborg.org>
References: <1588370291-7746-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588370291-7746-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
        a=XgyGsw9y4zMyC8-ZD7IA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick

On Sat, May 02, 2020 at 03:28:11AM +0530, Souptick Joarder wrote:
> These are dead code since 3.15. If there is no plan to use it further
> it can be removed forever.
Could you explain why you conclude this is dead code sine 3.15 -
and maybe point to the commit that made it dead.
I failed to look it up.
And I would assume I did not have to look it up, but that you have
provided enough background to evaluate the patch.

Sometimes dead code are kept becasue it documents something etc.
So it is not always a simple removal.

	Sam

> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/video/fbdev/matrox/matroxfb_DAC1064.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
> index 765e805..9c2a2c0 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_DAC1064.c
> @@ -603,9 +603,6 @@ static void MGA1064_ramdac_init(struct matrox_fb_info *minfo)
>  /* BIOS environ */
>  static int x7AF4 = 0x10;	/* flags, maybe 0x10 = SDRAM, 0x00 = SGRAM??? */
>  				/* G100 wants 0x10, G200 SGRAM does not care... */
> -#if 0
> -static int def50 = 0;	/* reg50, & 0x0F, & 0x3000 (only 0x0000, 0x1000, 0x2000 (0x3000 disallowed and treated as 0) */
> -#endif
>  
>  static void MGAG100_progPixClock(const struct matrox_fb_info *minfo, int flags,
>  				 int m, int n, int p)
> @@ -843,9 +840,6 @@ static int MGAG100_preinit(struct matrox_fb_info *minfo)
>  	struct matrox_hw_state *hw = &minfo->hw;
>  
>          u_int32_t reg50;
> -#if 0
> -	u_int32_t q;
> -#endif
>  
>  	DBG(__func__)
>  
> @@ -927,11 +921,6 @@ static int MGAG100_preinit(struct matrox_fb_info *minfo)
>  		mga_writeb(minfo->video.vbase, 0x0000, 0xAA);
>  		mga_writeb(minfo->video.vbase, 0x0800, 0x55);
>  		mga_writeb(minfo->video.vbase, 0x4000, 0x55);
> -#if 0
> -		if (mga_readb(minfo->video.vbase, 0x0000) != 0xAA) {
> -			hw->MXoptionReg &= ~0x1000;
> -		}
> -#endif
>  		hw->MXoptionReg |= 0x00078020;
>  	} else if (minfo->devflags.accelerator == FB_ACCEL_MATROX_MGAG200) {
>  		pci_read_config_dword(minfo->pcidev, PCI_OPTION2_REG, &reg50);
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
