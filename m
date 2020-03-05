Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E507C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AD72072A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCETCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:02:18 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44424 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726173AbgCETCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:02:18 -0500
Received: (qmail 3927 invoked by uid 2102); 5 Mar 2020 14:02:16 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Mar 2020 14:02:16 -0500
Date:   Thu, 5 Mar 2020 14:02:16 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     gregkh@linuxfoundation.org, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: core: Set port link to RxDetect if port is not
 enabled after resume
In-Reply-To: <20200305072826.23231-1-kai.heng.feng@canonical.com>
Message-ID: <Pine.LNX.4.44L0.2003051357400.1298-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020, Kai-Heng Feng wrote:

> On Dell TB16, Realtek USB ethernet (r8152) connects to an SMSC hub which
> then connects to ASMedia xHCI's root hub:
> 
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
>             |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
> 
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp. USB5537B
> Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter
> 
> The port is disabled after resume:
> xhci_hcd 0000:3f:00.0: Get port status 4-1 read: 0x280, return 0x280
> 
> According to xHCI 4.19.1.2.1, we should set link to RxDetect to transit
> it from disabled state to disconnected state, which allows the port to
> be set to U0 and completes the resume process.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> 
> P.S. This is and differnt (and should be more correct) approach to solve
> https://lore.kernel.org/lkml/20191129174115.31683-1-kai.heng.feng@canonical.com/
> 
>  drivers/usb/core/hub.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 54cd8ef795ec..352e33c84d6a 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3537,12 +3537,24 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  
>  	/* Skip the initial Clear-Suspend step for a remote wakeup */
>  	status = hub_port_status(hub, port1, &portstatus, &portchange);
> -	if (status == 0 && !port_is_suspended(hub, portstatus)) {
> +	if (status == 0 && !port_is_suspended(hub, portstatus)
> +	    && (portstatus & USB_PORT_STAT_ENABLE)) {

This doesn't look right.  We want to skip the step the clears the
port's suspend feature whenever the feature is already clear,
regardless of whether the port is enabled.

Besides, isn't this new test racy?  Suppose the port was enabled when
we called hub_port_status above, but it got disabled in the nanoseconds
since then?

>  		if (portchange & USB_PORT_STAT_C_SUSPEND)
>  			pm_wakeup_event(&udev->dev, 0);
>  		goto SuspendCleared;
>  	}
>  
> +	/* xHCI 4.19.1.2.1 */
> +	if (hub_is_superspeed(hub->hdev)) {
> +		if (!(portstatus & USB_PORT_STAT_ENABLE))
> +			status = hub_set_port_link_state(hub, port1,
> +							 USB_SS_PORT_LS_RX_DETECT);
> +
> +		if (status)
> +			dev_dbg(&port_dev->dev,
> +				"can't set to RxDetect, status %d\n", status);
> +	}
> +

So maybe this part belongs later in the routine.  Or maybe it shouldn't
be in the hub driver at all -- since it is xHCI-specific, shouldn't it
go into the xhci-hcd driver?

Alan Stern

>  	/* see 7.1.7.7; affects power usage, but not budgeting */
>  	if (hub_is_superspeed(hub->hdev))
>  		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U0);

