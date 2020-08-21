Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41F0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901AE2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598009143;
	bh=wIHnziovTq/GuaiND/z2I5281pOd4DVCK+dCOSRCHIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UXWTHF5e4qQQ2NTbCJRpnZTnU+UVu1KdGMk7rUh/7PBb/M86C0zqyQevQ8m8wjrrx
	 nQHNBK0M0nBUn7uaXcOKHKTwS5P1SHxpvUFYgPsGLx9V4yaq4IS+vK9rviPSSv8GlQ
	 cEHOVRwYLm1E7cJbu1bv8zqGsz46RTItrq6qpJdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgHULZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgHULVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:21:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 378C82054F;
        Fri, 21 Aug 2020 11:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598008870;
        bh=wIHnziovTq/GuaiND/z2I5281pOd4DVCK+dCOSRCHIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PcSliOZS3tcBKMbeSR3XaPv/ZGWUPKX9YSogRdLwuTDjMmwiNY1SM9y9mjy2LbVWM
         wKT4WDDJ2FNx3Q+MP+JARGf1KkeqXgSrn7eg/Jy+KF+jND2xTGLw8aIgdeT9yMGj1J
         bYzBg/iQgpr4e5t9XIW2GjR+m2AG0ELB7MEXiOvM=
Date:   Fri, 21 Aug 2020 13:21:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pavel Machek <pavel@denx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 83/92] mfd: dln2: Run event handler loop under
 spinlock
Message-ID: <20200821112129.GA2284907@kroah.com>
References: <20200820091537.490965042@linuxfoundation.org>
 <20200820091541.964627271@linuxfoundation.org>
 <20200821072123.GC23823@amd>
 <CAHp75Vcbmc-PV-gQxuj9i8sAcFCzhJKe_qzEfrkUTZbnf3Vupg@mail.gmail.com>
 <20200821091416.GA1894114@kroah.com>
 <20200821091510.GA1894407@kroah.com>
 <20200821105449.GN1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821105449.GN1891694@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 01:54:49PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 21, 2020 at 11:15:10AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Aug 21, 2020 at 11:14:16AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Aug 21, 2020 at 12:06:45PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Aug 21, 2020 at 10:26 AM Pavel Machek <pavel@denx.de> wrote:
> > > > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > >
> > > > > > [ Upstream commit 3d858942250820b9adc35f963a257481d6d4c81d ]
> > > > > >
> > > > > > The event handler loop must be run with interrupts disabled.
> > > > > > Otherwise we will have a warning:
> > > > > ...
> > > > > > Recently xHCI driver switched to tasklets in the commit 36dc01657b49
> > > > > > ("usb: host: xhci: Support running urb giveback in tasklet
> > > > > > context").
> > > > >
> > > > > AFAICT, 36dc01657b49 is not included in 4.19.141, so this commit
> > > > > should not be needed, either.
> > > > 
> > > > I'm wondering if there are any other USB host controller drivers that
> > > > use URB giveback in interrupt enabled context.
> > > 
> > > Almost all do.
> > 
> > Sorry, read that the wrong way, most have interrupts disabled, so this
> > change should be fine.
> 
> The change is harmless in these cases. I was wondering if it actually *helps*
> in some cases besides xHCI.

It might, I forgot about usbip, which probably runs in this mode.

thanks,

greg k-h
