Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA88C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAF420772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zbh2ZDpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgHQHsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgHQHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:48:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31138C061388;
        Mon, 17 Aug 2020 00:48:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x25so7835224pff.4;
        Mon, 17 Aug 2020 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wi7uOh+yRtLfdGHBZ3WK6CGtcfeUS/qkjXRc9sQSjvc=;
        b=Zbh2ZDpx5D7ecoMsmjdy0EZPc17mhOMQ+yg6h9NruYfGK34WnVFxgqtb3ALzVVwFjW
         +fQOuZxuwzoaBjKLFhJHTpRxl+41tCCCAvNdTjbUvmKX4DCUH2imMS/IDINbDFEm8o14
         IZYTsGs25owiK+EZnJmh/I8SHam1odD/s+4vnAWqreIEGAWJQYqNVrpMo4xHS6l4q+Dt
         uZ717gj9zeYVjZcaRC2Cdkhkkdk5SMJX68fcUrPafwrcQkuF95Bs1DR5vrdxo8q60qwc
         NgaROWjOxuRyo4fNRoR4JEBt3XvWexmjtiTiObf7bEyOxfXMr5qzXXvuboSTaTps4Edz
         wp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wi7uOh+yRtLfdGHBZ3WK6CGtcfeUS/qkjXRc9sQSjvc=;
        b=DaSkS87yUvhWitojQczrVf78NYtbGsE23MEzvIHTqAou46Epx5aaErihpXMSsDTZfp
         JES6e9qI48yzTRh5cRUzxVgumz3u5yfsvV5OdJn5ersklVJD4KuytVbwoZd51W1CBTt8
         D98yp0r4wQsyKAmEvrvpXnst9hnzIMze9mjr1zS4UNmvsD3XwFWU3Ti310OZvHZXVhXg
         syGIK4qjE276TU+MKHtLiGtDvnrUbkW6ggk0uDlrQciQ3B1FjYmJjwdXyR5Ig0xHpyTO
         +Gv2jXsLX5Y7dfZfiArFjPNcmwJlBElbZNMVGexiKG6Wvcyzn/+UCYJ+T6QkXWKeXMuz
         zU2g==
X-Gm-Message-State: AOAM532+GCDzMHusen4nJztPvWRltmj62P3v2KhjhBZq2vNN5qrpB1D3
        7a117nefLtCZrSE2LeJkeGg=
X-Google-Smtp-Source: ABdhPJyH0PooAF7f8Gjqfs3WOBZbjkvwPWTfgVSpdwmSziet5j+X68Cf8uvMg8Xmk5uW4gSOtAOz0Q==
X-Received: by 2002:a63:794e:: with SMTP id u75mr8901794pgc.50.1597650493498;
        Mon, 17 Aug 2020 00:48:13 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id mh14sm17112858pjb.23.2020.08.17.00.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 00:48:13 -0700 (PDT)
Date:   Mon, 17 Aug 2020 13:16:34 +0530
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
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 09/12] fbdev: i740fb: use generic power management
Message-ID: <20200817074634.GD5869@gmail.com>
References: <20200810165458.GA292825@ravnborg.org>
 <20200810185723.15540-1-vaibhavgupta40@gmail.com>
 <20200810185723.15540-10-vaibhavgupta40@gmail.com>
 <20200816202442.GB1426650@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200816202442.GB1426650@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 10:24:42PM +0200, Sam Ravnborg wrote:
> Hi Vaibhav
> 
> On Tue, Aug 11, 2020 at 12:27:20AM +0530, Vaibhav Gupta wrote:
> > Drivers should do only device-specific jobs. But in general, drivers using
> > legacy PCI PM framework for .suspend()/.resume() have to manage many PCI
> > PM-related tasks themselves which can be done by PCI Core itself. This
> > brings extra load on the driver and it directly calls PCI helper functions
> > to handle them.
> > 
> > Switch to the new generic framework by updating function signatures and
> > define a "struct dev_pm_ops" variable to bind PM callbacks. Also, remove
> > unnecessary calls to the PCI Helper functions along with the legacy
> > .suspend & .resume bindings.
> > 
> > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> 
> I several of the drivers I briefly looked at a new set of helpers were
> introduced for the different types of pm actions.
> They then called a more generic function that uses the passes
> enumeration to decide what to do.
> 
> But in this driver the test "state.event == PM_EVENT_FREEZE" is dropped
> and there is no freeze operation.
> Please explain this change so the reader is not left wondering.
> 
> 	Sam
> 
Okay,

Thanks
Vaibhav Gupta
> > ---
> >  drivers/video/fbdev/i740fb.c | 40 +++++++++++++++---------------------
> >  1 file changed, 16 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
> > index c65ec7386e87..8d7f06fc8a5a 100644
> > --- a/drivers/video/fbdev/i740fb.c
> > +++ b/drivers/video/fbdev/i740fb.c
> > @@ -1175,16 +1175,11 @@ static void i740fb_remove(struct pci_dev *dev)
> >  	}
> >  }
> >  
> > -#ifdef CONFIG_PM
> > -static int i740fb_suspend(struct pci_dev *dev, pm_message_t state)
> > +static int __maybe_unused i740fb_suspend(struct device *dev)
> >  {
> > -	struct fb_info *info = pci_get_drvdata(dev);
> > +	struct fb_info *info = dev_get_drvdata(dev);
> >  	struct i740fb_par *par = info->par;
> >  
> > -	/* don't disable console during hibernation and wakeup from it */
> > -	if (state.event == PM_EVENT_FREEZE || state.event == PM_EVENT_PRETHAW)
> > -		return 0;
> > -
> >  	console_lock();
> >  	mutex_lock(&(par->open_lock));
> >  
> > @@ -1197,19 +1192,15 @@ static int i740fb_suspend(struct pci_dev *dev, pm_message_t state)
> >  
> >  	fb_set_suspend(info, 1);
> >  
> > -	pci_save_state(dev);
> > -	pci_disable_device(dev);
> > -	pci_set_power_state(dev, pci_choose_state(dev, state));
> > -
> >  	mutex_unlock(&(par->open_lock));
> >  	console_unlock();
> >  
> >  	return 0;
> >  }
> >  
> > -static int i740fb_resume(struct pci_dev *dev)
> > +static int __maybe_unused i740fb_resume(struct device *dev)
> >  {
> > -	struct fb_info *info = pci_get_drvdata(dev);
> > +	struct fb_info *info = dev_get_drvdata(dev);
> >  	struct i740fb_par *par = info->par;
> >  
> >  	console_lock();
> > @@ -1218,11 +1209,6 @@ static int i740fb_resume(struct pci_dev *dev)
> >  	if (par->ref_count == 0)
> >  		goto fail;
> >  
> > -	pci_set_power_state(dev, PCI_D0);
> > -	pci_restore_state(dev);
> > -	if (pci_enable_device(dev))
> > -		goto fail;
> > -
> >  	i740fb_set_par(info);
> >  	fb_set_suspend(info, 0);
> >  
> > @@ -1231,10 +1217,17 @@ static int i740fb_resume(struct pci_dev *dev)
> >  	console_unlock();
> >  	return 0;
> >  }
> > -#else
> > -#define i740fb_suspend NULL
> > -#define i740fb_resume NULL
> > -#endif /* CONFIG_PM */
> > +
> > +static const struct dev_pm_ops i740fb_pm_ops = {
> > +#ifdef CONFIG_PM_SLEEP
> > +	.suspend	= i740fb_suspend,
> > +	.resume		= i740fb_resume,
> > +	.freeze		= NULL,
> > +	.thaw		= i740fb_resume,
> > +	.poweroff	= i740fb_suspend,
> > +	.restore	= i740fb_resume,
> > +#endif /* CONFIG_PM_SLEEP */
> > +};
> >  
> >  #define I740_ID_PCI 0x00d1
> >  #define I740_ID_AGP 0x7800
> > @@ -1251,8 +1244,7 @@ static struct pci_driver i740fb_driver = {
> >  	.id_table	= i740fb_id_table,
> >  	.probe		= i740fb_probe,
> >  	.remove		= i740fb_remove,
> > -	.suspend	= i740fb_suspend,
> > -	.resume		= i740fb_resume,
> > +	.driver.pm	= &i740fb_pm_ops,
> >  };
> >  
> >  #ifndef MODULE
> > -- 
> > 2.27.0
