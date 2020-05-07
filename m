Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EFBC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15EFB2078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588836683;
	bh=Ibfrzr4aWOuipCvG0cP+Oq1YAQPydyzZWHO9VbwFXeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qly8dGwvclcRNymjzunVMGsl3I6CzpgwD/BSKLamhiV6ZiVcSujTaT0ZhNepJbdyM
	 0oBu5Yt/CKDCR82kIWmclylBuze7wuxustshf4BMu3wbodn+HZXs11AxUyF3YMX10A
	 ZsCQAufC+R7F7cNxntrqj2aBolKE4H+gWKuGHHWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgEGHbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgEGHbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:31:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31242078C;
        Thu,  7 May 2020 07:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588836681;
        bh=Ibfrzr4aWOuipCvG0cP+Oq1YAQPydyzZWHO9VbwFXeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vy9K39+1uKfjiD/hPeV64uMHUe7pj44TE6ZxNNIUaw3S1NuLoVZlUlW08H3lP9Lws
         ocUEtLJLEVHzZ08n4kCv8ih5TWvcp0SCDW1JdGG5aSYdOLs3C/wpoTB/vb6cRmpanX
         Q6hCvBmV7MLRpbG4d6ukGbxSIPsJ70P3qBTcyJXI=
Date:   Thu, 7 May 2020 09:31:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mathias.nyman@intel.com,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xhci: Make debug message consistent with bus and port
 number
Message-ID: <20200507073119.GA876666@kroah.com>
References: <20200507061755.13280-1-kai.heng.feng@canonical.com>
 <20200507064510.GA787064@kroah.com>
 <C4A734C8-D1C6-45BC-9C0A-92364EAEE3C0@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C4A734C8-D1C6-45BC-9C0A-92364EAEE3C0@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 03:15:01PM +0800, Kai-Heng Feng wrote:
> 
> 
> > On May 7, 2020, at 14:45, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Thu, May 07, 2020 at 02:17:55PM +0800, Kai-Heng Feng wrote:
> >> Current xhci debug message doesn't always output bus number, so it's
> >> hard to figure out it's from USB2 or USB3 root hub.
> >> 
> >> In addition to that, some port numbers are offset to 0 and others are
> >> offset to 1. Use the latter to match the USB core.
> >> 
> >> So use "bus number - port index + 1" to make debug message consistent.
> >> 
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/usb/host/xhci-hub.c | 41 +++++++++++++++++++++----------------
> >> 1 file changed, 23 insertions(+), 18 deletions(-)
> >> 
> >> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> >> index f37316d2c8fa..83088c262cc4 100644
> >> --- a/drivers/usb/host/xhci-hub.c
> >> +++ b/drivers/usb/host/xhci-hub.c
> >> @@ -1241,7 +1241,8 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> >> 			temp = readl(ports[wIndex]->addr);
> >> 			/* Disable port */
> >> 			if (link_state == USB_SS_PORT_LS_SS_DISABLED) {
> >> -				xhci_dbg(xhci, "Disable port %d\n", wIndex);
> >> +				xhci_dbg(xhci, "Disable port %d-%d\n",
> >> +					 hcd->self.busnum, wIndex + 1);
> > 
> > Shouldn't xhci_dbg() show the bus number already?  
> 
> It's the PCI bus number, different to USB2/USB3 root hub bus number...

But if this is using dev_dbg(), and it is, then you know how to look
that up by seeing where that device is in sysfs at that point in time.

So why add this again?

> > If not, please fix
> > that up there instead of having to add it to all messages "by hand".
> 
> Not all xhci debug messages need roothub number in it.

Why pick these random ones?  What makes these different?

Either all or none, be consistant please.

greg k-h
