Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26680C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46BA20775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgICPrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:47:19 -0400
Received: from netrider.rowland.org ([192.131.102.5]:51221 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727786AbgICPrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:47:18 -0400
Received: (qmail 663890 invoked by uid 1000); 3 Sep 2020 11:47:17 -0400
Date:   Thu, 3 Sep 2020 11:47:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/20] usb/host: ehci-platform: Use pm_ptr() macro
Message-ID: <20200903154717.GB663761@rowland.harvard.edu>
References: <20200903112554.34263-1-paul@crapouillou.net>
 <20200903112554.34263-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903112554.34263-5-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 01:25:38PM +0200, Paul Cercueil wrote:
> Use the newly introduced pm_ptr() macro, and mark the suspend/resume
> functions __maybe_unused. These functions can then be moved outside the
> CONFIG_PM_SUSPEND block, and the compiler can then process them and
> detect build failures independently of the config. If unused, they will
> simply be discarded by the compiler.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/usb/host/ehci-platform.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 006c4f6188a5..4585a3a24678 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -410,8 +410,7 @@ static int ehci_platform_remove(struct platform_device *dev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int ehci_platform_suspend(struct device *dev)
> +static int __maybe_unused ehci_platform_suspend(struct device *dev)
>  {
>  	struct usb_hcd *hcd = dev_get_drvdata(dev);
>  	struct usb_ehci_pdata *pdata = dev_get_platdata(dev);
> @@ -433,7 +432,7 @@ static int ehci_platform_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int ehci_platform_resume(struct device *dev)
> +static int __maybe_unused ehci_platform_resume(struct device *dev)
>  {
>  	struct usb_hcd *hcd = dev_get_drvdata(dev);
>  	struct usb_ehci_pdata *pdata = dev_get_platdata(dev);
> @@ -464,7 +463,6 @@ static int ehci_platform_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_PM_SLEEP */
>  
>  static const struct of_device_id vt8500_ehci_ids[] = {
>  	{ .compatible = "via,vt8500-ehci", },
> @@ -499,7 +497,7 @@ static struct platform_driver ehci_platform_driver = {
>  	.shutdown	= usb_hcd_platform_shutdown,
>  	.driver		= {
>  		.name	= "ehci-platform",
> -		.pm	= &ehci_platform_pm_ops,
> +		.pm	= pm_ptr(&ehci_platform_pm_ops),
>  		.of_match_table = vt8500_ehci_ids,
>  		.acpi_match_table = ACPI_PTR(ehci_acpi_match),
>  	}
> -- 
> 2.28.0

For patches 2 - 4:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
