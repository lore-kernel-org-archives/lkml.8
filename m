Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7258AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A98206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589471779;
	bh=4+mrHHiujjKZeXa7UmvFygJXr2DL1VMGgBUeR3xOKSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KVS4wAlXGu6LTgKFhwZ7fQb9uWuUUW6EBuTXnuQ5fhtyos2RaIUa9Yd9yskpmT56B
	 0Jb2Ag5FeA5r/45dIdm38ZjzD4c5hDkY+xfRBAVcF555bQJStng7+JzMEmT29ASTSN
	 dzP/DBF2Cmm9YtbQTpHti3+44+JCI/8IRQ59rJ7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgENP4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgENP4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:56:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69E272065F;
        Thu, 14 May 2020 15:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589471777;
        bh=4+mrHHiujjKZeXa7UmvFygJXr2DL1VMGgBUeR3xOKSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pD8rtpMPzkydWUkxyDAKIK1Een7f0l8h7+ro2iDsHML/eygZ4f3RWZpjG2kWiWjeC
         sD+7H55XCR+c5Hay4xOuWtArlLcgAJhkvSvAG58lILDgQqCmn/Vb7ppIjSe5lVRg6l
         QQmSQG91xG5vRjP54vqbNkmEsY7AdsYz1YkYbLVI=
Date:   Thu, 14 May 2020 17:56:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     arnd@arndb.de, manivannan.sadhasivam@linaro.org,
        bjorn.andersson@linaro.org, wufan@codeaurora.org,
        pratanan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/8] qaic: Create char dev
Message-ID: <20200514155615.GA2963499@kroah.com>
References: <1589465266-20056-1-git-send-email-jhugo@codeaurora.org>
 <1589465266-20056-4-git-send-email-jhugo@codeaurora.org>
 <20200514141211.GA2643665@kroah.com>
 <0421a64a-10f3-08df-9ef1-14fdb570db0d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0421a64a-10f3-08df-9ef1-14fdb570db0d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 09:05:30AM -0600, Jeffrey Hugo wrote:
> Wow, thank you for the near immediate response.  I'm am quite impressed.
> 
> On 5/14/2020 8:12 AM, Greg KH wrote:
> > On Thu, May 14, 2020 at 08:07:41AM -0600, Jeffrey Hugo wrote:
> > >   /* Copyright (c) 2019-2020, The Linux Foundation. All rights reserved. */
> > > +#include <linux/cdev.h>
> > > +#include <linux/idr.h>
> > > +#include <linux/list.h>
> > > +#include <linux/kref.h>
> > > +#include <linux/mhi.h>
> > >   #include <linux/module.h>
> > >   #include <linux/msi.h>
> > > +#include <linux/mutex.h>
> > >   #include <linux/pci.h>
> > >   #include <linux/pci_ids.h>
> > > @@ -13,9 +19,242 @@
> > >   #define PCI_DEV_AIC100			0xa100
> > >   #define QAIC_NAME			"Qualcomm Cloud AI 100"
> > > +#define QAIC_MAX_MINORS			256
> > 
> > Why have a max?
> > 
> > Why not just use a misc device so you make the logic a lot simple, no
> > class or chardev logic to mess with at all.
> 
> It was our understanding that the preference is not to add new misc devices.

Huh, who said that?  Not the char/misc maintainer (i.e. me) :)

> As I go and try to find a supporting reference for that, I cannot find one,
> so I'm not entirely sure where that idea came from.
> 
> In addition, we see that the Habana Labs driver also uses chardev, and has
> chosen the same max.  We assumed that since their driver is already
> accepted, using the same mechanisms where applicable would be the preferred
> approach.

They had good reasons why not to use a chardev and convinced me of it.
If you can't come up with them, then stick with a misc for now please.

> Specific to the max, 256 was chosen as being a factor larger than the
> largest system we have, therefore we figured it wouldn't be hit for a long
> while even as we try to have a look at what might happen down the road.
> Looking at the Habana code, it looks like they have the same value for much
> of the same reasons, although their usecases may vary from ours somewhat.

Max numbers for no good reason are not a good thing to have.

> At this time, I don't think we have a strong requirement for a chardev, so
> we could investigate a switch over to a misc dev if you would prefer that
> over following the Habana Labs precedent.  All I ask is a confirmation that
> is the approach you would like to see going forward after reviewing the
> above.

Please use misc.

That is, if you even need a character device node :)

thanks,

greg k-h
