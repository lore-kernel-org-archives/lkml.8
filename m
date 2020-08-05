Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3280C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D0D422CAD
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596658746;
	bh=9ZU3tOBOV62KtGOwY6EQ1jVnbWgX/1syfR1TvQSTbzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Yv/x3Sl+WztvFwFjphW8ZEBRzeShveXuSZwTo78mmBF+90OHdi/OseayqfWnRzqli
	 bLmwVyYdqpSx04UBHlJHiT1+9ED/mh+0EpgjJuexzRL/dLzBZPY/+vLz8BST5WZw+2
	 i5MhL89xAKPeQRDLS5zDFzUR6A+e/QQaMHMCLAaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHEUTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgHEUTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:19:04 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C08722B42;
        Wed,  5 Aug 2020 20:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596658743;
        bh=9ZU3tOBOV62KtGOwY6EQ1jVnbWgX/1syfR1TvQSTbzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mkadEPoAkce2xQobRg1rFSLi4AAEXKYR2DudqHgQ1JhFZKOtr4vqzaFll2OQC8sHb
         G9y3s6sJGan+0CJs8oa12+px1hLZ5Bv8Fx2uMxi70kHezueiX/D3jkB3xjfM0g12br
         M6mYiu3hVkbTRpwyksloYu+UcjiRznWrIDgIibJ0=
Date:   Wed, 5 Aug 2020 15:19:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Andres Salomon <dilinger@queued.net>,
        Antonino Daplas <adaplas@gmail.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1 01/12] fbdev: gxfb: use generic power management
Message-ID: <20200805201901.GA529929@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805180722.244008-2-vaibhavgupta40@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 11:37:11PM +0530, Vaibhav Gupta wrote:
> Drivers using legacy power management .suspen()/.resume() callbacks
> have to manage PCI states and device's PM states themselves. They also
> need to take care of standard configuration registers.

s/using legacy/using legacy PCI/
s/.suspen/.suspend/ (in all these patches)

I wouldn't necessarily repost the whole series just for that (unless
the maintainer wants it), but maybe update your branch so if you have
occasion to repost for other reasons, this will be fixed.

This particular driver actually doesn't *do* any of the PCI state or
device PM state management you mention.  And I don't see the "single
'struct dev_pm_ops'" you mention below -- I thought that meant you
would have a single struct shared between drivers (I think you did
that for IDE?), but that's not what you're doing.  This driver has
gxfb_pm_ops, the next has lxfb_pm_ops, etc.

AFAICT the patches are fine, but the commit logs don't seem exactly
accurate.

> Switch to generic power management framework using a single
> "struct dev_pm_ops" variable to take the unnecessary load from the driver.
> This also avoids the need for the driver to directly call most of the PCI
> helper functions and device power state control functions, as through
> the generic framework PCI Core takes care of the necessary operations,
> and drivers are required to do only device-specific jobs.
>
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/video/fbdev/geode/gxfb.h       |  5 ----
>  drivers/video/fbdev/geode/gxfb_core.c  | 36 ++++++++++++++------------
>  drivers/video/fbdev/geode/suspend_gx.c |  4 ---
>  3 files changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/video/fbdev/geode/gxfb.h b/drivers/video/fbdev/geode/gxfb.h
> index d2e9c5c8e294..792c111c21e4 100644
> --- a/drivers/video/fbdev/geode/gxfb.h
> +++ b/drivers/video/fbdev/geode/gxfb.h
> @@ -21,7 +21,6 @@ struct gxfb_par {
>  	void __iomem *dc_regs;
>  	void __iomem *vid_regs;
>  	void __iomem *gp_regs;
> -#ifdef CONFIG_PM
>  	int powered_down;
>  
>  	/* register state, for power management functionality */
> @@ -36,7 +35,6 @@ struct gxfb_par {
>  	uint64_t fp[FP_REG_COUNT];
>  
>  	uint32_t pal[DC_PAL_COUNT];
> -#endif
>  };
>  
>  unsigned int gx_frame_buffer_size(void);
> @@ -49,11 +47,8 @@ void gx_set_dclk_frequency(struct fb_info *info);
>  void gx_configure_display(struct fb_info *info);
>  int gx_blank_display(struct fb_info *info, int blank_mode);
>  
> -#ifdef CONFIG_PM
>  int gx_powerdown(struct fb_info *info);
>  int gx_powerup(struct fb_info *info);
> -#endif
> -
>  
>  /* Graphics Processor registers (table 6-23 from the data book) */
>  enum gp_registers {
> diff --git a/drivers/video/fbdev/geode/gxfb_core.c b/drivers/video/fbdev/geode/gxfb_core.c
> index d38a148d4746..44089b331f91 100644
> --- a/drivers/video/fbdev/geode/gxfb_core.c
> +++ b/drivers/video/fbdev/geode/gxfb_core.c
> @@ -322,17 +322,14 @@ static struct fb_info *gxfb_init_fbinfo(struct device *dev)
>  	return info;
>  }
>  
> -#ifdef CONFIG_PM
> -static int gxfb_suspend(struct pci_dev *pdev, pm_message_t state)
> +static int __maybe_unused gxfb_suspend(struct device *dev)
>  {
> -	struct fb_info *info = pci_get_drvdata(pdev);
> +	struct fb_info *info = dev_get_drvdata(dev);
>  
> -	if (state.event == PM_EVENT_SUSPEND) {
> -		console_lock();
> -		gx_powerdown(info);
> -		fb_set_suspend(info, 1);
> -		console_unlock();
> -	}
> +	console_lock();
> +	gx_powerdown(info);
> +	fb_set_suspend(info, 1);
> +	console_unlock();
>  
>  	/* there's no point in setting PCI states; we emulate PCI, so
>  	 * we don't end up getting power savings anyways */
> @@ -340,9 +337,9 @@ static int gxfb_suspend(struct pci_dev *pdev, pm_message_t state)
>  	return 0;
>  }
>  
> -static int gxfb_resume(struct pci_dev *pdev)
> +static int __maybe_unused gxfb_resume(struct device *dev)
>  {
> -	struct fb_info *info = pci_get_drvdata(pdev);
> +	struct fb_info *info = dev_get_drvdata(dev);
>  	int ret;
>  
>  	console_lock();
> @@ -356,7 +353,6 @@ static int gxfb_resume(struct pci_dev *pdev)
>  	console_unlock();
>  	return 0;
>  }
> -#endif
>  
>  static int gxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> @@ -467,15 +463,23 @@ static const struct pci_device_id gxfb_id_table[] = {
>  
>  MODULE_DEVICE_TABLE(pci, gxfb_id_table);
>  
> +static const struct dev_pm_ops gxfb_pm_ops = {
> +#ifdef CONFIG_PM_SLEEP
> +	.suspend	= gxfb_suspend,
> +	.resume		= gxfb_resume,
> +	.freeze		= NULL,
> +	.thaw		= gxfb_resume,
> +	.poweroff	= NULL,
> +	.restore	= gxfb_resume,
> +#endif
> +};
> +
>  static struct pci_driver gxfb_driver = {
>  	.name		= "gxfb",
>  	.id_table	= gxfb_id_table,
>  	.probe		= gxfb_probe,
>  	.remove		= gxfb_remove,
> -#ifdef CONFIG_PM
> -	.suspend	= gxfb_suspend,
> -	.resume		= gxfb_resume,
> -#endif
> +	.driver.pm	= &gxfb_pm_ops,
>  };
>  
>  #ifndef MODULE
> diff --git a/drivers/video/fbdev/geode/suspend_gx.c b/drivers/video/fbdev/geode/suspend_gx.c
> index 1110a527c35c..8c49d4e98772 100644
> --- a/drivers/video/fbdev/geode/suspend_gx.c
> +++ b/drivers/video/fbdev/geode/suspend_gx.c
> @@ -11,8 +11,6 @@
>  
>  #include "gxfb.h"
>  
> -#ifdef CONFIG_PM
> -
>  static void gx_save_regs(struct gxfb_par *par)
>  {
>  	int i;
> @@ -259,5 +257,3 @@ int gx_powerup(struct fb_info *info)
>  	par->powered_down  = 0;
>  	return 0;
>  }
> -
> -#endif
> -- 
> 2.27.0
> 
