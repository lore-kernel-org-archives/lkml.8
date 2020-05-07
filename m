Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CCBC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F312080D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588839712;
	bh=vMCMu1ZCij3S9DyMwgnao9k5Ht7YBq0MBKru0DL71EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NPOpbBszd5FrpO/FBxac6d4TucLG8XR/SRdZU6KZFdBfLgcw/MKKfxAmjoklZAwCR
	 A8lO5q6K5YVfg9ZAJVQ8uY8OFitYXUss5/RbhLpyNikZguPGhm+FKRrjc3/icnVd/z
	 tVeCFBFvaJo0azTqWsRE44b1oS9dDQxb+NozdoJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgEGIVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgEGIVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:21:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55EF20753;
        Thu,  7 May 2020 08:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588839711;
        bh=vMCMu1ZCij3S9DyMwgnao9k5Ht7YBq0MBKru0DL71EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQRc2oUZTxHgceObRHepfY7ZL1NkskHEgkxWT1JVIPYzz28iJkoGurZrGCCDSTSca
         6nQqtCQksniF8DruFX442Ytn8ByfwjFiOU0PSknuxvLNOqnu1emWrFoKejCI3JF/Dk
         pmjoSGJ1n9y6TrJeIIewyUTSUMCyFoMfCp8TN7BQ=
Date:   Thu, 7 May 2020 10:21:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mathias.nyman@intel.com,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xhci: Make debug message consistent with bus and port
 number
Message-ID: <20200507082149.GE1024567@kroah.com>
References: <20200507061755.13280-1-kai.heng.feng@canonical.com>
 <20200507064510.GA787064@kroah.com>
 <C4A734C8-D1C6-45BC-9C0A-92364EAEE3C0@canonical.com>
 <20200507073119.GA876666@kroah.com>
 <90D5B23E-B037-49D2-BD44-7F9B0B2FC155@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90D5B23E-B037-49D2-BD44-7F9B0B2FC155@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 03:58:36PM +0800, Kai-Heng Feng wrote:
> 
> 
> > On May 7, 2020, at 15:31, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Thu, May 07, 2020 at 03:15:01PM +0800, Kai-Heng Feng wrote:
> >> 
> >> 
> >>> On May 7, 2020, at 14:45, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >>> 
> >>> On Thu, May 07, 2020 at 02:17:55PM +0800, Kai-Heng Feng wrote:
> >>>> Current xhci debug message doesn't always output bus number, so it's
> >>>> hard to figure out it's from USB2 or USB3 root hub.
> >>>> 
> >>>> In addition to that, some port numbers are offset to 0 and others are
> >>>> offset to 1. Use the latter to match the USB core.
> >>>> 
> >>>> So use "bus number - port index + 1" to make debug message consistent.
> >>>> 
> >>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>> ---
> >>>> drivers/usb/host/xhci-hub.c | 41 +++++++++++++++++++++----------------
> >>>> 1 file changed, 23 insertions(+), 18 deletions(-)
> >>>> 
> >>>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> >>>> index f37316d2c8fa..83088c262cc4 100644
> >>>> --- a/drivers/usb/host/xhci-hub.c
> >>>> +++ b/drivers/usb/host/xhci-hub.c
> >>>> @@ -1241,7 +1241,8 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> >>>> 			temp = readl(ports[wIndex]->addr);
> >>>> 			/* Disable port */
> >>>> 			if (link_state == USB_SS_PORT_LS_SS_DISABLED) {
> >>>> -				xhci_dbg(xhci, "Disable port %d\n", wIndex);
> >>>> +				xhci_dbg(xhci, "Disable port %d-%d\n",
> >>>> +					 hcd->self.busnum, wIndex + 1);
> >>> 
> >>> Shouldn't xhci_dbg() show the bus number already?  
> >> 
> >> It's the PCI bus number, different to USB2/USB3 root hub bus number...
> > 
> > But if this is using dev_dbg(), and it is, then you know how to look
> > that up by seeing where that device is in sysfs at that point in time.
> > 
> > So why add this again?
> 
> xHCI has two HCD, one for USB2 and one for USB3.
> If both of their port with same number are in use, for instance, port 1, then they are port 1-1 and port 2-1.
> Right now the debug message only show "Port 1", we still can't find the corresponding port via sysfs with insufficient info.

Look at the full kernel log line, the xhci hcd device should be showing
you unique information.  If not, something else is wrong.

What does a full line look like today for you?

thanks,

greg k-h
