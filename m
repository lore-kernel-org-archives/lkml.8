Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F088AC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84242080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgBJO3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:29:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:53053 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbgBJO3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:29:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 06:29:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="405600044"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2020 06:28:59 -0800
Subject: Re: [RESEND] [PATCH v2 2/3] xhci: Wait until link state trainsits to
 U0 after setting USB_SS_PORT_LS_U0
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     acelan.kao@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200205112633.25995-1-kai.heng.feng@canonical.com>
 <20200205112633.25995-2-kai.heng.feng@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <d65a1730-e725-ba1b-9272-0021346697e8@linux.intel.com>
Date:   Mon, 10 Feb 2020 16:31:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200205112633.25995-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.2.2020 13.26, Kai-Heng Feng wrote:
> Like U3 case, xHCI spec doesn't specify the upper bound of U0 transition
> time. The 20ms is not enough for some devices.
> 
> Intead of polling PLS or PLC, we can facilitate the port change event to
> know that the link transits to U0 is completed.
> 
> While at it, also separate U0 and U3 case to make the code cleaner.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Seperate U0 and U3 case.
>  - Prevent setting U0 from non-U state.
>  - Move the completion from per port to bus_state.
> 
>  drivers/usb/host/xhci-hub.c  | 43 +++++++++++++++++++++++++-----------
>  drivers/usb/host/xhci-mem.c  |  2 ++
>  drivers/usb/host/xhci-ring.c |  1 +
>  drivers/usb/host/xhci.h      |  1 +
>  4 files changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index d3c5bcf76755..0a5d8b28b99f 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -1297,7 +1297,32 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  					 wIndex, link_state);
>  				goto error;
>  			}
> +
> +			if (link_state == USB_SS_PORT_LS_U0) {
> +				if ((temp & PORT_PLS_MASK) == XDEV_U0)
> +					break;
> +
> +				if (!((temp & PORT_PLS_MASK) == XDEV_U1 ||
> +				    (temp & PORT_PLS_MASK) == XDEV_U2 ||
> +				    (temp & PORT_PLS_MASK) == XDEV_U3)) {
> +					xhci_warn(xhci, "Can only set port %d to U0 from U state\n",
> +							wIndex);

Port link state could be XDEV_RESUME or maybe even XDEV_RECOVERY if we race with a device
initiated resume.
I'll need to check how we should handle those. 

> +					goto error;
> +				}
> +				reinit_completion(&bus_state->link_change_done[wIndex]);
> +				xhci_set_link_state(xhci, ports[wIndex], USB_SS_PORT_LS_U0);
> +				spin_unlock_irqrestore(&xhci->lock, flags);
> +				if (!wait_for_completion_timeout(&bus_state->link_change_done[wIndex],
> +								 msecs_to_jiffies(100)))

Minor nit: rename link_change_done[] to u3exit_done[] 
see xhci 4.19.1.2.13.2 "U3", and the Host Initiated resume substate transition

> +					xhci_dbg(xhci, "missing U0 port change event for port %d\n",
> +						 wIndex);
> +				spin_lock_irqsave(&xhci->lock, flags);
> +				temp = readl(ports[wIndex]->addr);
> +				break;
> +			}
> +
>  			if (link_state == USB_SS_PORT_LS_U3) {
> +				int retries = 10;
>  				slot_id = xhci_find_slot_id_by_port(hcd, xhci,
>  						wIndex + 1);
>  				if (slot_id) {
> @@ -1308,26 +1333,18 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  					xhci_stop_device(xhci, slot_id, 1);
>  					spin_lock_irqsave(&xhci->lock, flags);
>  				}
> -			}
> -
> -			xhci_set_link_state(xhci, ports[wIndex], link_state);
> -
> -			spin_unlock_irqrestore(&xhci->lock, flags);
> -			if (link_state == USB_SS_PORT_LS_U3) {
> -				int retries = 10;
> -
> +				xhci_set_link_state(xhci, ports[wIndex], USB_SS_PORT_LS_U3);
> +				spin_unlock_irqrestore(&xhci->lock, flags);
>  				while (retries--) {
>  					msleep(10); /* wait device to enter */
>  					temp = readl(ports[wIndex]->addr);
>  					if ((temp & PORT_PLS_MASK) == XDEV_U3)
>  						break;
>  				}
> -			}
> -			spin_lock_irqsave(&xhci->lock, flags);
> -
> -			temp = readl(ports[wIndex]->addr);
> -			if (link_state == USB_SS_PORT_LS_U3)
> +				spin_lock_irqsave(&xhci->lock, flags);
> +				temp = readl(ports[wIndex]->addr);
>  				bus_state->suspended_ports |= 1 << wIndex;
> +			}
>  			break;
>  		case USB_PORT_FEAT_POWER:
>  			/*
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 3b1388fa2f36..aceb8c1af775 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -2531,6 +2531,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
>  		xhci->usb3_rhub.bus_state.resume_done[i] = 0;
>  		/* Only the USB 2.0 completions will ever be used. */
>  		init_completion(&xhci->usb2_rhub.bus_state.rexit_done[i]);
> +		init_completion(&xhci->usb2_rhub.bus_state.link_change_done[i]);

Not needed for usb2, it doesn't support Set Port Feature PORT_LINK_STATE requests

> +		init_completion(&xhci->usb3_rhub.bus_state.link_change_done[i]);

rename to u3exit_done

>  	}
>  
>  	if (scratchpad_alloc(xhci, flags))
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index d23f7408c81f..4d0f8dab069a 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1677,6 +1677,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
>  	     (portsc & PORT_PLS_MASK) == XDEV_U1 ||
>  	     (portsc & PORT_PLS_MASK) == XDEV_U2)) {
>  		xhci_dbg(xhci, "resume SS port %d finished\n", port_id);
> +		complete(&bus_state->link_change_done[hcd_portnum]);
>  		/* We've just brought the device into U0/1/2 through either the
>  		 * Resume state after a device remote wakeup, or through the
>  		 * U3Exit state after a host-initiated resume.  If it's a device
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 13d8838cd552..b5d443ce0750 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1694,6 +1694,7 @@ struct xhci_bus_state {
>  	/* Which ports are waiting on RExit to U0 transition. */
>  	unsigned long		rexit_ports;
>  	struct completion	rexit_done[USB_MAXCHILDREN];
> +	struct completion	link_change_done[USB_MAXCHILDREN];
>  };
>  
>  

I can do these minor changes and try out these first two patches.
No need to resend.

The last 3/3 patch isn't really tied to the first two, or even xhci, 
and should probably go as a separate patch.

-Mathias
