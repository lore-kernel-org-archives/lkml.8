Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B4AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE15120637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgCWQCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:02:33 -0400
Received: from foss.arm.com ([217.140.110.172]:51454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbgCWQCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:02:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7921FEC;
        Mon, 23 Mar 2020 09:02:31 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29EFB3F802;
        Mon, 23 Mar 2020 09:02:31 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:02:28 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Oliver Neukum <oneukum@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Message-ID: <20200323160228.x3sqz64qdx6wenpo@e107158-lin.cambridge.arm.com>
References: <1584977769.27949.18.camel@suse.de>
 <Pine.LNX.4.44L0.2003231151390.24254-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2003231151390.24254-100000@netrider.rowland.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/20 11:54, Alan Stern wrote:
> On Mon, 23 Mar 2020, Oliver Neukum wrote:
> 
> > Am Montag, den 23.03.2020, 14:38 +0000 schrieb Qais Yousef:
> > > Hi
> > > 
> > > I've hit the following lockdep warning when I trigger hibernate on arm64
> > > platform (Juno-r2)
> > > 
> > > 
> > > 	echo suspend > /sys/power/disk
> > > 	echo disk > /sys/power/state
> > > 
> > > I only had a usb flash drive attached to it. Let me know if you need more info.
> > 
> > Hi,
> > 
> > that is not a lockdep issue, but the hub driver is not properly killing
> > its URB presumably. Yet, the driver looks correct to me. Please use
> > the additional patch and activate dynamic debugging for usbcore.
> 
> Was the USB flash drive being used as a swap device for holding the 
> hibernation image?  That's not likely to work very well.  At least, I 
> doubt that it has been tested very much.
> 
> This diagnostic was suggested by the runtime PM error that occurred 
> when the system was trying to store the hibernation image.  That's 
> probably when the hub driver's URB got restarted.

Yes, sadly it's the only source of storage I have on that device.

When I ran the test I had swapoff, as you can see in the snippet below. When
swap is on I do hibernate and wakeup successfully. At least that's what appears
to be happening to me.

I get a similar splat regardless of swap is on or off.


[  327.154849] usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active
[  327.290355] PM: Cannot find swap device, try swapon -a
[  327.295533] PM: Cannot get swap writer
[  327.480758] OOM killer enabled.
[  327.483939] Restarting tasks ...
[  327.484229] ------------[ cut here ]------------
[  327.484664] done.
[  327.487743] URB 000000000c121c1c submitted while active
[  327.499622] WARNING: CPU: 1 PID: 296 at drivers/usb/core/urb.c:363 usb_submit_urb+0x3f0/0x520

Thanks

--
Qais Yousef
