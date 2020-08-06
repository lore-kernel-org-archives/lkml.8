Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F25AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3249206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735126;
	bh=OEb91Ejr5JEtyZgzJD6o2mtTHegdt84CjOCxzu1PrwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Elxy9FsYdxS+mGm5h74y+MJT98ZEGvCDPzruO5ayW2DQe62UUbHrfr9+PtY8+qsWt
	 KB9UOMKyPSUZsACYoETuHv6OTXtQ9W0JPqazybL+/1UcDeHB4qlxDPY+3DjxSl2shb
	 wkGPnl8iyVlO642y75BoYJeCgmu5WL7B7bytJhXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgHFRbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729231AbgHFRa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:30:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7D822CBB;
        Thu,  6 Aug 2020 11:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596712238;
        bh=OEb91Ejr5JEtyZgzJD6o2mtTHegdt84CjOCxzu1PrwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LaSl7aFBP67JYQSOwJImoFOTnSp1zRtRAYwJJvljYR8MME7OgXk5s3c09bk1KyjCa
         GAkR2fOYdD6TtoV5ncAgF6tE1azaghriZ2BxUZTgrGc318xTzu5AxNbst81Vaw7QhG
         j1iARMnMtEHYkxWP59bd4fKSPN6tnCOYlb4jFdY0=
Date:   Thu, 6 Aug 2020 12:53:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "hongxu.zhao" <hongxu.zhao@mediatek.com>
Cc:     "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        wsd_upstream@mediatek.com, Weiqi Fu <weiqi.fu@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        Cunliang Du <cunliang.du@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhen jiang <zhen.jiang@mediatek.com>
Subject: Re: [PATCH] staging: Add Mediatek High Frequency Manager Framework
Message-ID: <20200806105351.GA2829418@kroah.com>
References: <20200804075339.9820-1-hongxu.zhao@mediatek.com>
 <20200804081126.GA1765831@kroah.com>
 <1596702748.6258.3.camel@mbjsdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596702748.6258.3.camel@mbjsdccf07>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 04:32:28PM +0800, hongxu.zhao wrote:
> On Tue, 2020-08-04 at 10:11 +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 04, 2020 at 03:52:49PM +0800, hongxu.zhao wrote:
> > > Add a new sensor framework into linux kernel which can support multi client request sensor data.
> > > There are the following features:
> > >     1.Ringbuffer between manager and client;
> > >     2.Kernel space user interface;
> > >     3.User space user interface with syscall;
> > >     4.Each client hang detect mechanism;
> > >     5.Polling timer management in framework no need driver concern;
> > >     6.Polling kthread work intergrated into a single kthread
> > >       worker to save system resources in framework no need driver concern;
> > >     7.Proc file system to show manager device and client details;
> > >     8.Compitable with android and widely used in many mediatek platform products;
> > > 
> > > Change-Id: I6361cdc2d51de50f66eede7df099c4575e7ec473
> > 
> > Did you not run checkpatch.pl on this?  :)
> > 
> > No need for change-id here.
> > 
> > But, most importantly, why is this in drivers/staging?  What keeps it
> > from being in the "real" part of the kernel?  I need a TODO file in the
> > directory of the driver listing what remains to be done and who is
> > responsible for doing this work and reviewing patches.
> > 
> > Can you resend this with that file added and the Change-id removed?
> > 
> > Also, why not just use the IIO interface, why are you creating
> > yet-another api for sensors?  We already have 2, making a third seems
> > like something that guarantees this will never be mergable to the
> > correct part of the kernel.
> > 
> > And finally, /proc/ is not for devices, that is what sysfs is for,
> > please use that.
> 
> I have modified checkpatch issue, but blocked by ARCH=alpha build error
> and I can't reproduce this build error in mediatek environment. I need
> spend some time setting up an environment to solve this problem and will
> send you the latest patch together after solving the problem of alpha
> build error.

If you can't easily fix the alpha issue, you can just mark the driver as
not able to be built there for now.

> Firstly I want keep it in the real part of kernel and I send mail to
> community to find the right maintainer, unfortunately, several emails
> were not answered.

Pointers to those emails on lore.kernel.org?

> Secondly I found iio upstream history it also started from staging at
> the beginning, maybe staging is the best start until it become mature we
> can move it to the real part of kernel.

iio started in staging, but now that the infrastructure is out of it,
there should not be any reason that new drivers be forced to go into
staging too.  You only want to do it this way if for some reason you can
not get the work done on your own.

> Actually, we have already assessed IIO subsystem, but the conclusion is
> that it doesn't meet our requirement:
> 1. iio doesn't have sensor manager in kernel space.

What exactly do you mean by this?  Who needs to be a "manager" here?

> 2. each driver under the iio subsystem needs to create workqueue or
> kthread by itself, waste system resources.

workqueues are very light, how many sensors and what type of resources
are you referring to here?  And adding a whole new user api is not
exactly "tiny" either :)

> 3. iio doesn't have hang detect mechanism to detect polling thread hang.

That's userspace's issue, right?

> We need a sensor manager architecture in kernel space to select the best
> delay and latency that multi-client(user space or kernel space user)
> requested at the same time, and finally dispatch data to each client.

Why does that have to be in the kernel?

> We need lower resource comsumption, each driver can poll data by kthread
> work which intergrated into a single kthread worker to save system
> resources in framework.

Again, how many resources are you really saving here with a whole new
framework?

> We need detect polling thread hang to decide whether to send data to
> him.

Data to where?

> About proc, proc is only for High Frequency Manager Framework to show
> manager details and client details, is not for device drivers.

Then it is not needed :)

> we recommend device driver(like test/test_app.c) use sysfs which under
> High Frequency Manager Framework.

Then you need to document it really well as to what you are doing here.

But again, please try working with the IIO framework as that is what we
have today.  Any improvements you make to it will help everyone out.

Adding a third way to handle sensor data to the kernel is probably not
going to work well for anyone...

thanks,

greg k-h
