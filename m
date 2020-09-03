Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F5DC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B906206D4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgICPeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:34:11 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41009 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728320AbgICPeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:34:09 -0400
Received: (qmail 663113 invoked by uid 1000); 3 Sep 2020 11:34:08 -0400
Date:   Thu, 3 Sep 2020 11:34:08 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/20] usb/host: ohci-platform: Use pm_ptr() macro
Message-ID: <20200903153408.GB662845@rowland.harvard.edu>
References: <20200903112554.34263-1-paul@crapouillou.net>
 <20200903112554.34263-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903112554.34263-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 01:25:35PM +0200, Paul Cercueil wrote:
> Use the newly introduced pm_ptr() macro, and mark the suspend/resume
> functions __maybe_unused. These functions can then be moved outside the
> CONFIG_PM_SUSPEND block, and the compiler can then process them and
> detect build failures independently of the config. If unused, they will
> simply be discarded by the compiler.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/usb/host/ohci-platform.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 4a8456f12a73..21400d7d8b0a 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -176,22 +176,21 @@ static int ohci_platform_probe(struct platform_device *dev)
>  	if (pdata->num_ports)
>  		ohci->num_ports = pdata->num_ports;
>  
> -#ifndef CONFIG_USB_OHCI_BIG_ENDIAN_MMIO
> -	if (ohci->flags & OHCI_QUIRK_BE_MMIO) {
> +	if (!IS_ENABLED(CONFIG_USB_OHCI_BIG_ENDIAN_MMIO) &&
> +	    ohci->flags & OHCI_QUIRK_BE_MMIO) {
>  		dev_err(&dev->dev,
>  			"Error: CONFIG_USB_OHCI_BIG_ENDIAN_MMIO not set\n");
>  		err = -EINVAL;
>  		goto err_reset;
>  	}
> -#endif
> -#ifndef CONFIG_USB_OHCI_BIG_ENDIAN_DESC
> -	if (ohci->flags & OHCI_QUIRK_BE_DESC) {
> +
> +	if (!IS_ENABLED(CONFIG_USB_OHCI_BIG_ENDIAN_DESC) &&
> +	    ohci->flags & OHCI_QUIRK_BE_DESC) {
>  		dev_err(&dev->dev,
>  			"Error: CONFIG_USB_OHCI_BIG_ENDIAN_DESC not set\n");
>  		err = -EINVAL;
>  		goto err_reset;
>  	}
> -#endif
>  
>  	pm_runtime_set_active(&dev->dev);
>  	pm_runtime_enable(&dev->dev);

The changes above don't seem to have any connection with the patch 
description.  Please don't mix multiple changes in a single patch.

The rest of the patch is okay.

Alan Stern

> @@ -267,8 +266,7 @@ static int ohci_platform_remove(struct platform_device *dev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int ohci_platform_suspend(struct device *dev)
> +static int __maybe_unused ohci_platform_suspend(struct device *dev)
>  {
>  	struct usb_hcd *hcd = dev_get_drvdata(dev);
>  	struct usb_ohci_pdata *pdata = dev->platform_data;
> @@ -286,7 +284,7 @@ static int ohci_platform_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int ohci_platform_resume(struct device *dev)
> +static int __maybe_unused ohci_platform_resume(struct device *dev)
>  {
>  	struct usb_hcd *hcd = dev_get_drvdata(dev);
>  	struct usb_ohci_pdata *pdata = dev_get_platdata(dev);
> @@ -306,7 +304,6 @@ static int ohci_platform_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_PM_SLEEP */
>  
>  static const struct of_device_id ohci_platform_ids[] = {
>  	{ .compatible = "generic-ohci", },
> @@ -332,7 +329,7 @@ static struct platform_driver ohci_platform_driver = {
>  	.shutdown	= usb_hcd_platform_shutdown,
>  	.driver		= {
>  		.name	= "ohci-platform",
> -		.pm	= &ohci_platform_pm_ops,
> +		.pm	= pm_ptr(&ohci_platform_pm_ops),
>  		.of_match_table = ohci_platform_ids,
>  	}
>  };
> -- 
> 2.28.0
> 
