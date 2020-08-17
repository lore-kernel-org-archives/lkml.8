Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E741C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30FE204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391643AbgHQSr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:47:57 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54675 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2391397AbgHQSrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:47:55 -0400
Received: (qmail 120920 invoked by uid 1000); 17 Aug 2020 14:47:53 -0400
Date:   Mon, 17 Aug 2020 14:47:53 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jim Baxter <jim_baxter@mentor.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        "Resch Carsten \(CM/ESO6\)" <Carsten.Resch@de.bosch.com>,
        "Rosca, Eugeniu \(ADITG/ESB\)" <erosca@de.adit-jv.com>
Subject: Re: PROBLEM: Long Workqueue delays.
Message-ID: <20200817184753.GA120209@rowland.harvard.edu>
References: <71aafe68-7fe0-6b77-ea8e-83edd3f16c8d@mentor.com>
 <20200817115744.GA3985908@kroah.com>
 <57a7841d-86e3-b6df-1488-a252a68a9ee0@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a7841d-86e3-b6df-1488-a252a68a9ee0@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 07:24:01PM +0100, Jim Baxter wrote:
> On 17/08/2020 12:57, Greg KH wrote:
> > On Mon, Aug 17, 2020 at 12:40:03PM +0100, Jim Baxter wrote:
> >> We have issues with the workqueue of the kernel overloading the CPU 0 
> >> when we we disconnect a USB stick.
> >>
> >> This results in other items on the shared workqueue being delayed by
> >> around 6.5 seconds with a default kernel configuration and 2.3 seconds
> >> on a config tailored for our RCar embedded platform.
> >>
> > 
> > Is this data really flushed out to the device?

In the example, data was copied _from_ the device, not to it.

> I am unsure if the delay is due to a single system or a combination of memory,
> usb or filesystem operations, the delay also occurs if the device is mounted
> as ro and using the sync option.
> 
> Using umount stops the issue occurring but is unfortunately not guaranteed in
> our particular system.

Unplugging a R/W USB drive without unmounting it first is a great way to 
corrupt the data.

> >> - Disconnect the USB stick:
> >> [ 1551.796792] usb 2-1: USB disconnect, device number 2
> >> [ 1558.625517] DELAY: 6782
> >>
> >>
> >> The Delay output 6782 is in milliseconds.
> > 
> > What USB workqueue is taking so long?> 
> > The one trying to deal with the filesystem flushing out the data that it
> > can't do now that the device is removed?  :)
> > 
> From my analysis it is the hub_event workqueue shown to be using most of the CPU,
> the kworker/0:1+usb thread uses around 98% of the CPU.
> 
> I have traced the workqueue:workqueue_queue_work function while unplugging the USB
> but not found a particular workqueue function being called a lot.
> 
> Using perf Iidentified the hub_events workqueue was spending a lot of time in
> invalidate_partition(), I have included a cut down the captured data from perf in
> [2] which shows the additional functions where the kworker spends most of its time.

invalidate_partition() is part of the block layer, not part of USB.  It 
gets called whenever a drive is removed from the system, no matter what 
type of drive it is.  You should ask the people involved in that 
subsystem why it takes so long.

> I realise that not unmounting the USB stick is not ideal, though I wonder what 
> additional work is done when unplugging the USB stick compared to unmounting it.

Unmounting a drive flushes all the dirty buffers from memory back to the 
drive.  Obviously that can't be done if the drive is unplugged first.

As far as the USB subsystem is concerned, exactly the same amount of 
work is done during disconnect regardless of whether or not the drive is 
mounted.  (In fact, the USB subsystem doesn't even know whether a drive 
is mounted; that concept is part of the block and filesystem layers.)

> I guess it may be waiting for a time-out during the operation without the unmount.

That seems very unlikely.  When a USB device gets unplugged the system 
realizes it.  Any I/O meant for that device is immediately cancelled; 
there are no timeouts.

(Okay, not strictly true; there is a fraction-of-a-second timeout during 
which the system waits to see whether the disconnect was permanent or 
just a temporary glitch.  But you're talking about 6-second long 
delays.)

Alan Stern
