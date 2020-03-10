Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042AAC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8CE24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCJODq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:03:46 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37870 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726539AbgCJODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:03:46 -0400
Received: (qmail 1809 invoked by uid 2102); 10 Mar 2020 10:03:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Mar 2020 10:03:45 -0400
Date:   Tue, 10 Mar 2020 10:03:45 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Lubomir Rintel <lkundrak@v3.sk>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] USB: EHCI: ehci-mv: switch the HSIC HCI to HSIC mode
In-Reply-To: <20200309130014.548168-1-lkundrak@v3.sk>
Message-ID: <Pine.LNX.4.44L0.2003101003280.1651-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Mar 2020, Lubomir Rintel wrote:

> Turns out the undocumented and reserved bits of port status/control
> register of the root port need to be set to use the HCI in HSIC mode.
> 
> Typically the firmware does this, but that is not always good enough,
> because the bits get lost if the HSIC clock is disabled (e.g. when
> ehci-mv is build as a module).
> 
> This supplements commit 7b104f890ade ("USB: EHCI: ehci-mv: add HSIC
> support").
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> ---
>  drivers/usb/host/ehci-mv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
> index bd4f6ef534d96..ddb668963955f 100644
> --- a/drivers/usb/host/ehci-mv.c
> +++ b/drivers/usb/host/ehci-mv.c
> @@ -110,6 +110,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
>  	struct resource *r;
>  	int retval = -ENODEV;
>  	u32 offset;
> +	u32 status;
>  
>  	if (usb_disabled())
>  		return -ENODEV;
> @@ -213,6 +214,14 @@ static int mv_ehci_probe(struct platform_device *pdev)
>  		device_wakeup_enable(hcd->self.controller);
>  	}
>  
> +	if (of_usb_get_phy_mode(pdev->dev.of_node) == USBPHY_INTERFACE_MODE_HSIC) {
> +		status = ehci_readl(ehci, &ehci->regs->port_status[0]);
> +		/* These "reserved" bits actually enable HSIC mode. */
> +		status |= BIT(25);
> +		status &= ~GENMASK(31, 30);
> +		ehci_writel(ehci, status, &ehci->regs->port_status[0]);
> +	}
> +
>  	dev_info(&pdev->dev,
>  		 "successful find EHCI device with regs 0x%p irq %d"
>  		 " working in %s mode\n", hcd->regs, hcd->irq,
> 

