Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A61C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D335320721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 09:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgAJJc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 04:32:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:48527 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgAJJc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:32:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 01:32:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,415,1571727600"; 
   d="scan'208";a="304118739"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2020 01:32:55 -0800
Subject: Re: [PATCH 1/3] xhci: Ensure link state is U3 after setting
 USB_SS_PORT_LS_U3
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu
Cc:     acelan.kao@canonical.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200103084008.3579-1-kai.heng.feng@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <607e395f-21ce-3c9f-eff7-2fa6aaa74595@linux.intel.com>
Date:   Fri, 10 Jan 2020 11:34:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200103084008.3579-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.1.2020 10.40, Kai-Heng Feng wrote:
> The xHCI spec doesn't specify the upper bound of U3 transition time. For
> some devices 20ms is not enough, so we need to make sure the link state
> is in U3 before further actions.

Looking at the USB 3.2 spec (7.2.4.2 Link Power management and Flow) it seems
most timers related to U3 entry are a lot less than a millisecond (4-16us)
If port is in U1/U2,  Ux_EXIT_TIMER is 6ms which seems to be the longest timeout.

If we anyway are polling for the U3 state we could shorten the initial 20ms sleep
down to 10ms. I think many devices, especially if they are already in U0
could manage this.

are >
> I've tried to use U3 Entry Capability by setting U3 Entry Enable in
> config register, however the port change event for U3 transition
> interrupts the system suspend process.
> 
> For now let's use the less ideal method by polling PLS.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/usb/host/xhci-hub.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 7a3a29e5e9d2..2b2e9d004dbf 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -1228,6 +1228,7 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>   			break;
>   		case USB_PORT_FEAT_LINK_STATE:
>   			temp = readl(ports[wIndex]->addr);
> +			xhci_dbg(xhci, "before setting link state, actual port %d-%d status = 0x%0x\n", hcd->self.busnum, wIndex + 1, temp);

xhci_set_link_state() already shows similar debugging,

>   			/* Disable port */
>   			if (link_state == USB_SS_PORT_LS_SS_DISABLED) {
>   				xhci_dbg(xhci, "Disable port %d\n", wIndex);
> @@ -1316,9 +1317,17 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>   			msleep(20); /* wait device to enter */
>   			spin_lock_irqsave(&xhci->lock, flags);
>   
> -			temp = readl(ports[wIndex]->addr);
> -			if (link_state == USB_SS_PORT_LS_U3)
> +			if (link_state == USB_SS_PORT_LS_U3) {
> +				retval = xhci_handshake(ports[wIndex]->addr, PORT_PLS_MASK, XDEV_U3, 80 * 1000);
> +				if (retval)
> +					xhci_dbg(xhci, "polling XDEV_U3 on port %d-%d timeout\n", hcd->self.busnum, wIndex + 1);

In worst case we are busylooping for 80ms here, keeping the cpu busy.
It should be ok to sleep here, so how about just reading the register
every 10ms max 10 times, sleeping in between.

-Mathias
