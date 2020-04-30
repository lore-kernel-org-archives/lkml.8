Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B464C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D336B20661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgD3Pl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:41:59 -0400
Received: from netrider.rowland.org ([192.131.102.5]:39373 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726745AbgD3Pl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:41:58 -0400
Received: (qmail 4742 invoked by uid 500); 30 Apr 2020 11:41:57 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Apr 2020 11:41:57 -0400
Date:   Thu, 30 Apr 2020 11:41:57 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
cc:     gregkh@linuxfoundation.org, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mausb-host-devel@displaylink.com>
Subject: Re: [External] Re: [PATCH v5 5/8] usb: mausb_host: Introduce PAL
 processing
In-Reply-To: <32cc80c0-c2ff-440c-7505-e848aba782d8@displaylink.com>
Message-ID: <Pine.LNX.4.44L0.2004301139560.3855-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020, Vladimir Stankovic wrote:

> On 30.4.20. 17:18, Alan Stern wrote:
> > On Thu, 30 Apr 2020, Vladimir Stankovic wrote:
> > 
> >> On 26.4.20. 22:56, Alan Stern wrote:
> >>> On Sun, 26 Apr 2020, Vladimir Stankovic wrote:
> >>>
> >>>> On 26.4.20. 16:31, Alan Stern wrote:
> >>>>> On Sun, 26 Apr 2020, Vladimir Stankovic wrote:
> >>>>>
> >>>>>> On 26.4.20. 02:32, Alan Stern wrote:
> >>>>>>> On Sat, 25 Apr 2020 vladimir.stankovic@displaylink.com wrote:
> >>>>>>>
> >>>>>>>> Protocol adaptation layer (PAL) implementation has been added to
> >>>>>>>> introduce MA-USB structures and logic.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> >>>>>>>
> >>>>>>> ...
> >>>>>>>
> >>>>>>>> +	/*
> >>>>>>>> +	 * Masking URB_SHORT_NOT_OK flag as SCSI driver is adding it where it
> >>>>>>>> +	 * should not, so it is breaking the USB drive on the linux
> >>>>>>>> +	 */
> >>>>>>>> +	urb->transfer_flags &= ~URB_SHORT_NOT_OK;
> > 
> > ...

> > Also, what makes you think the driver is setting the SHORT_NOT_OK flag
> > at the wrong time?  In fact, how can there be a wrong time?  
> > SHORT_NOT_OK is a valid flag to use with any control or bulk URB.
> > 
> > Alan Stern
> > 
> The comment is clearly wrong - as mentioned earlier, this fix was added in early
> development phase and I guess that implementer was not clear on how the particular
> flag was added. Investigation is ongoing around proper fix for this.
> 
> Anyhow, it is a usb-storage driver related to this - here is usb-related log snippet:
> 
> usb 3-1.1.2: new high-speed USB device number 5 using mausb_host_hcd_dev
> usb 3-1.1.2: New USB device found, idVendor=0951, idProduct=1666
> usb 3-1.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 3-1.1.2: Product: DataTraveler 3.0
> usb 3-1.1.2: Manufacturer: Kingston
> usb 3-1.1.2: SerialNumber: 0C9D9210E304E311095E087A
> usb-storage 3-1.1.2:1.0: USB Mass Storage device detected
> scsi host3: usb-storage 3-1.1.2:1.0
> scsi 3:0:0:0: Direct-Access     Kingston DataTraveler 3.0 PMAP PQ: 0 ANSI: 6
> Attached scsi generic sg2 type 0
> [sdb] 30277632 512-byte logical blocks: (15.5 GB/14.4 GiB)
> 
> As can be seen, USB flash attached to remote device is properly enumerated via
> MA USB. Without the fix, usb driver is not able to read USB descriptors, ending
> up in USB storage not being accessible.

That's strange, considering that the SHORT_NOT_OK flag doesn't get set 
when the system is reading the device's USB descriptors.

Alan Stern

