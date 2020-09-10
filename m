Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE305C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B387120732
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbgIJPaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 11:30:46 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34871 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731243AbgIJP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:28:06 -0400
Received: (qmail 851550 invoked by uid 1000); 10 Sep 2020 11:27:34 -0400
Date:   Thu, 10 Sep 2020 11:27:34 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux@prisktech.co.nz, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ehci-platform: Add workaround for
 brcm,xgs-iproc-ehci
Message-ID: <20200910152734.GB849569@rowland.harvard.edu>
References: <20200910025154.20848-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910025154.20848-1-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 02:51:53PM +1200, Chris Packham wrote:
> The ehci controller found in some Broadcom switches with integrated SoCs
> has an issue which causes a soft lockup with large transfers like you
> see when running ext4 on USB3 flash drive.
> 
> Port the fix from the Broadcom XLDK to increase the OUT_THRESHOLD to
> avoid the problem.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> I don't have much data on what this change does. I can say it is needed to
> avoid a soft lockup when using a USB3 Flash drive formatted has ext4 (USB2 +
> ext4 is OK, USB3 + fat is OK). I presume the affected combination ends up using
> larger transfers triggering the problem.
> 
> The equivalent change in the Broadcom XLDK is
> 
> 	if (IS_ENABLED(CONFIG_USB_EHCI_XGS_IPROC))
> 		ehci_writel(ehci, BCM_USB_FIFO_THRESHOLD,
> 				&ehci->regs->reserved4[6]);
> 
> This is problematic because it would unconditionally apply to all ehci
> controllers whenever CONFIG_USB_EHCI_XGS_IPROC is enabled (also reserved4 only
> goes to 6 so technically it's indexing off the end of the array).
> 
> I wasn't sure if I should add a new property or somehow detect the affected
> host controller. I settled on using of_device_is_compatible() as that seemed
> the simplest thing to do.

Reasonable.

>  drivers/usb/host/ehci-platform.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 006c4f6188a5..0d2de8faa3c1 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -53,6 +53,9 @@ struct ehci_platform_priv {
>  
>  static const char hcd_name[] = "ehci-platform";
>  
> +#define bcm_iproc_insnreg01	hostpc
> +#define BCM_USB_FIFO_THRESHOLD	0x00800040

Minor nit: Since hostpc is nominally an array, IMO it would be a little 
clearer to define bcm_iproc_insnreg01 as hostpc[0] and then do the 
ehci_writel to &ehci->regs->bcm_iproc_insnreg01.  That makes it look 
more like an ordinary structure member.

Also IMO, it's better to put the #define's before the structure 
definitions.

> +
>  static int ehci_platform_reset(struct usb_hcd *hcd)
>  {
>  	struct platform_device *pdev = to_platform_device(hcd->self.controller);
> @@ -358,6 +361,9 @@ static int ehci_platform_probe(struct platform_device *dev)
>  
>  	device_wakeup_enable(hcd->self.controller);
>  	device_enable_async_suspend(hcd->self.controller);
> +	if (of_device_is_compatible(dev->dev.of_node, "brcm,xgs-iproc-ehci"))
> +		ehci_writel(ehci, BCM_USB_FIFO_THRESHOLD,
> +			    ehci->regs->bcm_iproc_insnreg01);

In theory, this should go before the usb_add_hcd() call because 
afterward the controller is active.  But you can't put it before 
ehci->regs has been assigned, which happens in ehci_setup().  Probably 
the best place is at the end of ehci_platform_reset().

Alan Stern

>  	platform_set_drvdata(dev, hcd);
>  
>  	if (priv->quirk_poll)
> -- 
> 2.28.0
> 
