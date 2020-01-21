Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CCEC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E28B21569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579626951;
	bh=qVCil94wgEQJMgnsjwFbC4DcciytL5tgZdZLpbVcBIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kWzbugnkmN5+l8qQ524zkpg/Od8xYEFoHfgZdKbBbnStVvHBFNODJy3JLwPt0h7UO
	 5MhX2nPEBpHrm6E69waERkTluzzbCWlpHC14ZxsnIelLYejBfuatKgS8t+DpWgxpCS
	 5Nr/uNNARRtGbSlFDWcjGmSCjDMWwTvRLU6yQa7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAURPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:15:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbgAURPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:15:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD4CA20882;
        Tue, 21 Jan 2020 17:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579626949;
        bh=qVCil94wgEQJMgnsjwFbC4DcciytL5tgZdZLpbVcBIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xN+47/rvM7NIeyfvkGJ7bHtr2GVMOcFPD1xvxsbEgp4PiNvshojcXYnvsMA8VgG/C
         DAgNtQPOlyYlVDqFPtyIGtY/z1ihJKXVQOH2uzbTdFgWhmbMF/5H3HMYT98I+dySJ3
         FRmtz7sJSDj4cfuBnsHJpO0DrsPKLOQtVCYX38U0=
Date:   Tue, 21 Jan 2020 18:15:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v4 2/2] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200121171547.GA632898@kroah.com>
References: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
 <20200117133759.5729-3-roman.sudarikov@linux.intel.com>
 <20200117141944.GC1856891@kroah.com>
 <20200117162357.GK302770@tassilo.jf.intel.com>
 <20200117165406.GA1937954@kroah.com>
 <f62a14a4-4fea-84f7-4cab-8bef74cf9e8a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f62a14a4-4fea-84f7-4cab-8bef74cf9e8a@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 07:15:56PM +0300, Sudarikov, Roman wrote:
> On 17.01.2020 19:54, Greg KH wrote:
> > On Fri, Jan 17, 2020 at 08:23:57AM -0800, Andi Kleen wrote:
> > > > I thought I was nice and gentle last time and said that this was a
> > > > really bad idea and you would fix it up.  That didn't happen, so I am
> > > > being explicit here, THIS IS NOT AN ACCEPTABLE FILE OUTPUT FOR A SYSFS
> > > > FILE.
> > > Could you suggest how such a 1:N mapping should be expressed instead in
> > > sysfs?
> > I have yet to figure out what it is you all are trying to express here
> > given a lack of Documentation/ABI/ file :)
> > 
> > But again, sysfs is ONE VALUE PER FILE.  You have a list of items here,
> > that is bounded only by the number of devices in the system at the
> > moment.  That number will go up in time, as we all know.  So this is
> > just not going to work at all as-is.
> > 
> > greg k-h
> 
> Hi Greg,
> 
> Technically, the motivation behind this patch is to enable Linux perf tool
> to attribute IO traffic to IO device.
> 
> Currently, perf tool provides interface to configure IO PMUs only without
> any
> context.
> 
> Understanding IIO stack concept to find which IIO stack that particular
> IO device is connected to, or to identify an IIO PMON block to program
> for monitoring specific IIO stack assumes a lot of implicit knowledge
> about given Intel server platform architecture.

Is "IIO" being used here the same way that drivers/iio/ is in the
kernel, or is this some other term?  If it is the same, why isn't the
iio developers involved in this?  If it is some other term, please
always define it and perhaps pick a different name :)

> Please consider the following mapping schema:
> 
> 1. new "mapping" directory is to be added under each uncore_iio_N directory

What is uncore_iio_N?  A struct device?  Or something else?

> 2. that "mapping" directory is supposed to contain symlinks named "dieN"
> which are pointed to corresponding root bus.
> Below is how it looks like for 2S machine:
> 
> # ll uncore_iio_0/mapping/
> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die0 ->
> ../../pci0000:00/pci_bus/0000:00

Where did "pci_bus" come from in there?  I don't see under /sys/devices/
for my pci bridges.

> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die1 ->
> ../../pci0000:80/pci_bus/0000:80
> 
> # ll uncore_iio_1/mapping/
> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die0 ->
> ../../pci0000:17/pci_bus/0000:17
> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die1 ->
> ../../pci0000:85/pci_bus/0000:85
> 
> # ll uncore_iio_2/mapping/
> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die0 ->
> ../../pci0000:3a/pci_bus/0000:3a
> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die1 ->
> ../../pci0000:ae/pci_bus/0000:ae
> 
> # ll uncore_iio_3/mapping/
> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die0 ->
> ../../pci0000:5d/pci_bus/0000:5d
> lrwxrwxrwx 1 root root 0 Jan 20 23:55 die1 ->
> ../../pci0000:d7/pci_bus/0000:d7

Why have a subdir here?

Anyway, yes, that would make sense, if userspace can actually do
something with that, can it?

Also, what tears those symlinks down when you remove those pci devices
from the system?  Shouldn't you have an entry in the pci device itself
for this type of thing?  And if so, isn't this really just a "normal"
class type driver you are writing?  That should handle all of the
symlinks and stuff for you automatically, right?

thanks,

greg k-h
