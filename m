Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE18C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9054206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgIDPpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:45:25 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59155 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726047AbgIDPpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:45:18 -0400
Received: (qmail 694637 invoked by uid 1000); 4 Sep 2020 11:45:17 -0400
Date:   Fri, 4 Sep 2020 11:45:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: ohci: Add per-port overcurrent quirk
Message-ID: <20200904154517.GB694058@rowland.harvard.edu>
References: <20200904032247.11345-1-hamish.martin@alliedtelesis.co.nz>
 <20200904032247.11345-2-hamish.martin@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904032247.11345-2-hamish.martin@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 03:22:46PM +1200, Hamish Martin wrote:
> Some integrated OHCI controller hubs do not expose all ports of the hub
> to pins on the SoC. In some cases the unconnected ports generate
> spurious overcurrent events. For example the Broadcom 56060/Ranger 2 SoC
> contains a nominally 3 port hub but only the first port is wired.
> 
> Default behaviour for ohci-platform driver is to use "ganged"
> overcurrent protection mode. This leads to the spurious overcurrent
> events affecting all ports in the hub.
> 
> Allow this to be rectified by specifying per-port overcurrent protection
> mode via the device tree.
> 
> Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
> ---
>  drivers/usb/host/ohci-hcd.c      | 4 ++++
>  drivers/usb/host/ohci-platform.c | 3 +++
>  drivers/usb/host/ohci.h          | 1 +
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index dd37e77dae00..01e3d75e29d9 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -687,6 +687,10 @@ static int ohci_run (struct ohci_hcd *ohci)
>  		val |= RH_A_NPS;
>  		ohci_writel (ohci, val, &ohci->regs->roothub.a);
>  	}
> +	if (ohci->flags & OHCI_QUIRK_PER_PORT_OC) {
> +		val |= RH_A_OCPM;
> +		ohci_writel(ohci, val, &ohci->regs->roothub.a);
> +	}

I don't think this is right, for two reasons.  First, isn't per-port 
overcurrent protection the default?

Second, RH_A_OCPM doesn't do anything unless RH_A_NOCP is clear.

Alan Stern

>  	ohci_writel (ohci, RH_HS_LPSC, &ohci->regs->roothub.status);
>  	ohci_writel (ohci, (val & RH_A_NPS) ? 0 : RH_B_PPCM,
>  						&ohci->regs->roothub.b);
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 4a8456f12a73..45e69ce4ef86 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -137,6 +137,9 @@ static int ohci_platform_probe(struct platform_device *dev)
>  		if (of_property_read_bool(dev->dev.of_node, "no-big-frame-no"))
>  			ohci->flags |= OHCI_QUIRK_FRAME_NO;
>  
> +		if (of_property_read_bool(dev->dev.of_node, "per-port-overcurrent"))
> +			ohci->flags |= OHCI_QUIRK_PER_PORT_OC;
> +
>  		if (of_property_read_bool(dev->dev.of_node,
>  					  "remote-wakeup-connected"))
>  			ohci->hc_control = OHCI_CTRL_RWC;
> diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
> index aac6285b37f8..9c2bc816246c 100644
> --- a/drivers/usb/host/ohci.h
> +++ b/drivers/usb/host/ohci.h
> @@ -422,6 +422,7 @@ struct ohci_hcd {
>  #define	OHCI_QUIRK_AMD_PREFETCH	0x400			/* pre-fetch for ISO transfer */
>  #define	OHCI_QUIRK_GLOBAL_SUSPEND	0x800		/* must suspend ports */
>  #define	OHCI_QUIRK_QEMU		0x1000			/* relax timing expectations */
> +#define	OHCI_QUIRK_PER_PORT_OC	0x2000			/* per-port overcurrent protection */
>  
>  	// there are also chip quirks/bugs in init logic
>  
> -- 
> 2.28.0
> 
