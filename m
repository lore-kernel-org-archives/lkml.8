Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8A7C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413D82072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgAJP1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:27:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:15565 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbgAJP1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:27:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 07:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; 
   d="scan'208";a="304201494"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2020 07:27:19 -0800
Subject: Re: [PATCH 2/3] xhci: Wait until link state trainsits to U0 after
 setting USB_SS_PORT_LS_U0
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     acelan.kao@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200103084008.3579-1-kai.heng.feng@canonical.com>
 <20200103084008.3579-2-kai.heng.feng@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <17701887-a249-eade-eecb-541df6c2c704@linux.intel.com>
Date:   Fri, 10 Jan 2020 17:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200103084008.3579-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.1.2020 10.40, Kai-Heng Feng wrote:
> Like U3 case, xHCI spec doesn't specify the upper bound of U0 transition
> time. The 20ms is not enough for some devices.
> 
> Intead of polling PLS or PLC, we can facilitate the port change event to
> know that the link transits to U0 is completed.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/usb/host/xhci-hub.c  | 8 +++++++-
>   drivers/usb/host/xhci-mem.c  | 1 +
>   drivers/usb/host/xhci-ring.c | 1 +
>   drivers/usb/host/xhci.h      | 1 +
>   4 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 2b2e9d004dbf..07886a1bce62 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -1310,11 +1310,17 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>   					spin_lock_irqsave(&xhci->lock, flags);
>   				}
>   			}
> +			if (link_state == USB_SS_PORT_LS_U0)
> +				reinit_completion(&ports[wIndex]->link_state_changed);

All the other suspend and resume related port flags/completions are
in struct xhci_bus_state. See for example rexit_done[].
Not sure that is a better place but at least it would be consistent.

Could actually make sense to move more of them to the xhci_port structure,
but perhaps in some later suspend/resume rework patch.
>   
>   			xhci_set_link_state(xhci, ports[wIndex], link_state);
>   
>   			spin_unlock_irqrestore(&xhci->lock, flags);
> -			msleep(20); /* wait device to enter */
> +			if (link_state == USB_SS_PORT_LS_U0) {
> +				if (!wait_for_completion_timeout(&ports[wIndex]->link_state_changed, msecs_to_jiffies(100)))
> +					xhci_dbg(xhci, "missing U0 port change event for port %d-%d\n", hcd->self.busnum, wIndex + 1);

We might be waiting for completion here in unnecessary.
No completion is called if port is already in U0, either set by
xhci_bus_resume(), or we race with a device initiated resume.

Maybe read the current port link state first, and don't do anything if it's
already in U0, or fail if it's in a state where we can't resume to U0.

> +			} else
> +				msleep(20); /* wait device to enter */
>   			spin_lock_irqsave(&xhci->lock, flags);

Code might also be cleaner if we have separate if() statements for U0 and U3 link
states, and skip the generic xhci_set_link_state()

USB 3.2 specs only support PORT_LINK_STATE request feature selectors for
U0, U1, U2, U3, SS.Disabled, Rx.Detect and Compliance mode.
Out of these xhci driver already handles the SS.Disabled, Rx.detect and Compliance in
separate if statements, and xHC hardware can't force a U1 or U2 state by writing
the PLS field of the PORTSC register, so the xhci_set_link_state() here
is only useful for U0 and U3.

So maybe something like this:

if (link_state == U0)
   if (active_link_state == U0)
     break
   else if (active_link_state != a proper link state)
     return error	
   xhci_set_link_state(U0)
   wait_for_completion_timeout()
   break;

if (link_state == U3)
   xhci_stop_device(slot_id)
   xhci_set_link_state(U3)
   for (max 10 tries) {
     msleep_range(~10ms)
     if (readl(PORTSC(PLS) == U3)
       break
   }
   break
>   
>   			if (link_state == USB_SS_PORT_LS_U3) {
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 3b1388fa2f36..c760a28e3556 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -2268,6 +2268,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
>   		xhci->hw_ports[i].addr = &xhci->op_regs->port_status_base +
>   			NUM_PORT_REGS * i;
>   		xhci->hw_ports[i].hw_portnum = i;
> +		init_completion(&xhci->hw_ports[i].link_state_changed);
>   	}
>   
>   	xhci->rh_bw = kcalloc_node(num_ports, sizeof(*xhci->rh_bw), flags,
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index d23f7408c81f..44d91a53bf07 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1677,6 +1677,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
>   	     (portsc & PORT_PLS_MASK) == XDEV_U1 ||
>   	     (portsc & PORT_PLS_MASK) == XDEV_U2)) {
>   		xhci_dbg(xhci, "resume SS port %d finished\n", port_id);
> +		complete(&port->link_state_changed);

Completion will only be called if there was a port link change (PLC bit set)
and link is in U0/U1/U2. Completion will also be called for device
initiated resume even when no one is waiting for it. (probably harmless)

-Mathias
