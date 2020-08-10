Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AC6206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhHI6QrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgHJJld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgHJJlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:41:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B09C061756;
        Mon, 10 Aug 2020 02:41:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f5so541595plr.9;
        Mon, 10 Aug 2020 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z3ulW2VxpkqtQgW6r5h1dF3y8SsTkgQ0jTlNBIbDSYs=;
        b=BhHI6QrI59CCp9aOeqg0rtMs2ISonD+r8bVrNsB10xf3Chv8koFMrz9OE8b6a5acs8
         558t3l2AnmWvtVKfOJceNXRhuk53EWvBOUZT97b3bWvOPCPwbJKCiO01meo0M1gWnJqQ
         Cg9RhFCRr1SdRa3ZewFFTkx7Qq0s2NLpSBDxdyOr45J/Sgmf0764JOoJofb5Hy+wxhnP
         ivzrBRmxYCbcDZ4Qo0WI5YJuWvk+aycAdYyaIKXvUtF9Cawlix6ruh/5cnRZrRaIQTdB
         zgAFuCYU35QSQ/BD8/VzLKiHfOWznMZK31lEEKIW24+HyVTBtxyFaDxIwDY0SbSmSJDH
         dDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z3ulW2VxpkqtQgW6r5h1dF3y8SsTkgQ0jTlNBIbDSYs=;
        b=KNbVxzjELDlYh7ivumi17/XkSoJ+/gP8l2A6AHJtw1w9vSGTFVHg+JeiO8PIsx/wd+
         S8il2NUiYyIecSXxE6iJvGxYVkWYWOkk9AMoxHxQSEQNjxltO533zesFtaXq7CWQR8s3
         dsqcfIVbbkl4wZzO/KeQqipT06GwvztynWJivHGCWhspPC2ErLpH3L/H/EPZEJx6xWvI
         WJPyhzLvp7a6pjN+NcakwBpvQQAjXi3NV29Irv1vrrR4OunAwRKBizndIdFsju+jJ9I3
         uoZgcqgDI2ZF3Ma7fyLZhJcUQTDD042wRm1uR9uzY8a2HjBjlzfBLDKwju9kWPqQtyNO
         20ig==
X-Gm-Message-State: AOAM530YhPK6VmSgIc9LH684DQdambfGfAo2esSP+Nk6YEj+BSaKbC8D
        hVq9YgJD92e2BzvL9mrCNK0=
X-Google-Smtp-Source: ABdhPJxRp1VjaaWXXrOdi8Azm9qKK7cq1QmeZD/8Knibe1gjjmeI3cd+iMmFGz7lYAvYXmTHmMZ+9Q==
X-Received: by 2002:a17:90b:e83:: with SMTP id fv3mr25419713pjb.193.1597052491734;
        Mon, 10 Aug 2020 02:41:31 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id o4sm13500555pjs.51.2020.08.10.02.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 02:41:31 -0700 (PDT)
Date:   Mon, 10 Aug 2020 15:09:48 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Andres Salomon <dilinger@queued.net>,
        Antonino Daplas <adaplas@gmail.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-geode@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 01/12] fbdev: gxfb: use generic power management
Message-ID: <20200810093948.GB6615@gmail.com>
References: <20200805180722.244008-1-vaibhavgupta40@gmail.com>
 <20200805180722.244008-2-vaibhavgupta40@gmail.com>
 <20200808111746.GA24172@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200808111746.GA24172@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08, 2020 at 01:17:46PM +0200, Sam Ravnborg wrote:
> Hi Vaibhav
> 
> On Wed, Aug 05, 2020 at 11:37:11PM +0530, Vaibhav Gupta wrote:
> > Drivers using legacy power management .suspen()/.resume() callbacks
> > have to manage PCI states and device's PM states themselves. They also
> > need to take care of standard configuration registers.
> > 
> > Switch to generic power management framework using a single
> > "struct dev_pm_ops" variable
> 
> "to take the unnecessary load from the driver."
> - I do not parse the above - I cannot see what load is removed.
> But the code is simpler which is fine. The drawback is that we now
> always link in the suspend_gx functions but hopefultl the linker drops
> them later.
> 
> > This also avoids the need for the driver to directly call most of the PCI
> > helper functions and device power state control functions, as through
> > the generic framework PCI Core takes care of the necessary operations,
> > and drivers are required to do only device-specific jobs.
> Again, I do not see what calles are removed.
> A single check for the state is dropped - anything else?
>
Yeah, the commit messages are bit misleading, I have modified them. 
> > 
> > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> > ---
> >  drivers/video/fbdev/geode/gxfb.h       |  5 ----
> >  drivers/video/fbdev/geode/gxfb_core.c  | 36 ++++++++++++++------------
> >  drivers/video/fbdev/geode/suspend_gx.c |  4 ---
> >  3 files changed, 20 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/geode/gxfb.h b/drivers/video/fbdev/geode/gxfb.h
> > index d2e9c5c8e294..792c111c21e4 100644
> > --- a/drivers/video/fbdev/geode/gxfb.h
> > +++ b/drivers/video/fbdev/geode/gxfb.h
> > @@ -21,7 +21,6 @@ struct gxfb_par {
> >  	void __iomem *dc_regs;
> >  	void __iomem *vid_regs;
> >  	void __iomem *gp_regs;
> > -#ifdef CONFIG_PM
> >  	int powered_down;
> >  
> >  	/* register state, for power management functionality */
> > @@ -36,7 +35,6 @@ struct gxfb_par {
> >  	uint64_t fp[FP_REG_COUNT];
> >  
> >  	uint32_t pal[DC_PAL_COUNT];
> > -#endif
> >  };
> >  
> >  unsigned int gx_frame_buffer_size(void);
> > @@ -49,11 +47,8 @@ void gx_set_dclk_frequency(struct fb_info *info);
> >  void gx_configure_display(struct fb_info *info);
> >  int gx_blank_display(struct fb_info *info, int blank_mode);
> >  
> > -#ifdef CONFIG_PM
> >  int gx_powerdown(struct fb_info *info);
> >  int gx_powerup(struct fb_info *info);
> > -#endif
> > -
> >  
> >  /* Graphics Processor registers (table 6-23 from the data book) */
> >  enum gp_registers {
> > diff --git a/drivers/video/fbdev/geode/gxfb_core.c b/drivers/video/fbdev/geode/gxfb_core.c
> > index d38a148d4746..44089b331f91 100644
> > --- a/drivers/video/fbdev/geode/gxfb_core.c
> > +++ b/drivers/video/fbdev/geode/gxfb_core.c
> > @@ -322,17 +322,14 @@ static struct fb_info *gxfb_init_fbinfo(struct device *dev)
> >  	return info;
> >  }
> >  
> > -#ifdef CONFIG_PM
> > -static int gxfb_suspend(struct pci_dev *pdev, pm_message_t state)
> > +static int __maybe_unused gxfb_suspend(struct device *dev)
> >  {
> > -	struct fb_info *info = pci_get_drvdata(pdev);
> > +	struct fb_info *info = dev_get_drvdata(dev);
> I do not see any dev_set_drvdata() so I guess we get a NULL pointer
> here which is not intended.
> Adding a dev_set_data() to gxfb_probe() would do the trick.
> 
gxfb_probe() invokes pci_set_drvdata(pdev, info) which in turn calls
dev_set_drvdata(&pdev->dev, data). Adding dev_get_drvdata() will be redundant.

> >  
> > -	if (state.event == PM_EVENT_SUSPEND) {
> > -		console_lock();
> > -		gx_powerdown(info);
> > -		fb_set_suspend(info, 1);
> > -		console_unlock();
> > -	}
> > +	console_lock();
> > +	gx_powerdown(info);
> > +	fb_set_suspend(info, 1);
> > +	console_unlock();
> >  
> >  	/* there's no point in setting PCI states; we emulate PCI, so
> >  	 * we don't end up getting power savings anyways */
> > @@ -340,9 +337,9 @@ static int gxfb_suspend(struct pci_dev *pdev, pm_message_t state)
> >  	return 0;
> >  }
> >  
> > -static int gxfb_resume(struct pci_dev *pdev)
> > +static int __maybe_unused gxfb_resume(struct device *dev)
> >  {
> > -	struct fb_info *info = pci_get_drvdata(pdev);
> > +	struct fb_info *info = dev_get_drvdata(dev);
> >  	int ret;
> >  
> >  	console_lock();
> > @@ -356,7 +353,6 @@ static int gxfb_resume(struct pci_dev *pdev)
> >  	console_unlock();
> >  	return 0;
> >  }
> > -#endif
> >  
> >  static int gxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> > @@ -467,15 +463,23 @@ static const struct pci_device_id gxfb_id_table[] = {
> >  
> >  MODULE_DEVICE_TABLE(pci, gxfb_id_table);
> >  
> > +static const struct dev_pm_ops gxfb_pm_ops = {
> > +#ifdef CONFIG_PM_SLEEP
> > +	.suspend	= gxfb_suspend,
> > +	.resume		= gxfb_resume,
> > +	.freeze		= NULL,
> > +	.thaw		= gxfb_resume,
> > +	.poweroff	= NULL,
> > +	.restore	= gxfb_resume,
> > +#endif
> > +};
> Can we use SET_SYSTEM_SLEEP_PM_OPS here?
> .freeze will be assigned gxfb_suspend, but gxfb_suspend will anyway be
> called as far as I read the code.
> Likewise for poweroff.
> 
Earlier, gxfb_suspend() performed each operation just for suspend event.
And as it was legacy code, it was invoked by pci_legacy_suspend() for
pci_pm_suspend(), pci_pm_freeze() and pci_pm_poweroff().
Thus, the code was wrapped inside "if" container:
	if (state.event == PM_EVENT_SUSPEND) { }

After binding it with dev_pm_ops variable, pm->suspend() is invoked by just
pci_pm_suspend() which is required.

So I removed the "if" container and bind the callback with pm->suspend pointer
only.

Using SET_SYSTEM_PM_OPS will bring back the extra step of invoking gxfb_suspend()
for freeze and poweroff, even though the function will do nothing in that case.

Vaibhav Gupta
> 	Sam
> 
> > +
> >  static struct pci_driver gxfb_driver = {
> >  	.name		= "gxfb",
> >  	.id_table	= gxfb_id_table,
> >  	.probe		= gxfb_probe,
> >  	.remove		= gxfb_remove,
> > -#ifdef CONFIG_PM
> > -	.suspend	= gxfb_suspend,
> > -	.resume		= gxfb_resume,
> > -#endif
> > +	.driver.pm	= &gxfb_pm_ops,
> >  };
> >  
> >  #ifndef MODULE
> > diff --git a/drivers/video/fbdev/geode/suspend_gx.c b/drivers/video/fbdev/geode/suspend_gx.c
> > index 1110a527c35c..8c49d4e98772 100644
> > --- a/drivers/video/fbdev/geode/suspend_gx.c
> > +++ b/drivers/video/fbdev/geode/suspend_gx.c
> > @@ -11,8 +11,6 @@
> >  
> >  #include "gxfb.h"
> >  
> > -#ifdef CONFIG_PM
> > -
> >  static void gx_save_regs(struct gxfb_par *par)
> >  {
> >  	int i;
> > @@ -259,5 +257,3 @@ int gx_powerup(struct fb_info *info)
> >  	par->powered_down  = 0;
> >  	return 0;
> >  }
> > -
> > -#endif
> > -- 
> > 2.27.0
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
