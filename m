Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBCDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5383020639
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgIIQEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:04:06 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57829 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730716AbgIIQDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:03:25 -0400
Received: (qmail 818232 invoked by uid 1000); 9 Sep 2020 10:05:47 -0400
Date:   Wed, 9 Sep 2020 10:05:47 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: ohci: Default to per-port over-current protection
Message-ID: <20200909140547.GB817244@rowland.harvard.edu>
References: <20200909035734.22463-1-hamish.martin@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909035734.22463-1-hamish.martin@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 03:57:34PM +1200, Hamish Martin wrote:
> Some integrated OHCI controller hubs do not expose all ports of the hub
> to pins on the SoC. In some cases the unconnected ports generate
> spurious over-current events. For example the Broadcom 56060/Ranger 2 SoC
> contains a nominally 3 port hub but only the first port is wired.
> 
> Default behaviour for ohci-platform driver is to use global over-current
> protection mode (AKA "ganged"). This leads to the spurious over-current
> events affecting all ports in the hub.
> 
> We now alter the default to use per-port over-current protection.
> 
> This patch results in the following configuration changes depending
> on quirks:
> - For quirk OHCI_QUIRK_SUPERIO no changes. These systems remain set up
>   for ganged power switching and no over-current protection.

How about changing the quirk name to something more meaningful, such as 
OHCI_QUIRK_GANGED_POWER_NO_OVERCURRENT?

> - For quirk OHCI_QUIRK_AMD756 or OHCI_QUIRK_HUB_POWER power switching
>   remains at none, while over-current protection is now guaranteed to be
>   set to per-port rather than the previous behaviour where it was either
>   none or global over-current protection depending on the value at
>   function entry.

Also consider renaming OHCI_QUIRK_HUB_POWER to something like 
OHCI_QUIRK_PORT_POWER_ALWAYS_ON.

> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
> ---
>  drivers/usb/host/ohci-hcd.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index dd37e77dae00..8ab81f6ab150 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -673,20 +673,25 @@ static int ohci_run (struct ohci_hcd *ohci)
>  
>  	/* handle root hub init quirks ... */
>  	val = roothub_a (ohci);
> -	val &= ~(RH_A_PSM | RH_A_OCPM);
> +	/* Configure for per-port over-current protection by default */
> +	val &= ~RH_A_NOCP;
> +	val |= RH_A_OCPM;
>  	if (ohci->flags & OHCI_QUIRK_SUPERIO) {
> -		/* NSC 87560 and maybe others */
> +		/* NSC 87560 and maybe others.
> +		 * Ganged power switching, no over-current protection.
> +		 */
>  		val |= RH_A_NOCP;
> -		val &= ~(RH_A_POTPGT | RH_A_NPS);
> -		ohci_writel (ohci, val, &ohci->regs->roothub.a);
> +		val &= ~(RH_A_POTPGT | RH_A_NPS | RH_A_PSM | RH_A_OCPM);
>  	} else if ((ohci->flags & OHCI_QUIRK_AMD756) ||
>  			(ohci->flags & OHCI_QUIRK_HUB_POWER)) {
>  		/* hub power always on; required for AMD-756 and some
> -		 * Mac platforms.  ganged overcurrent reporting, if any.
> +		 * Mac platforms.
>  		 */
> +		val &= ~RH_A_PSM;
>  		val |= RH_A_NPS;

PSM is ignored when NPS is on.  You needn't bother to set it.

> -		ohci_writel (ohci, val, &ohci->regs->roothub.a);
>  	}
> +	ohci_writel(ohci, val, &ohci->regs->roothub.a);
> +
>  	ohci_writel (ohci, RH_HS_LPSC, &ohci->regs->roothub.status);
>  	ohci_writel (ohci, (val & RH_A_NPS) ? 0 : RH_B_PPCM,
>  						&ohci->regs->roothub.b);

You didn't actually change the default: distrust_firmware is still 
initialized to true.

Alan Stern
