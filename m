Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C92C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F81F2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592468342;
	bh=JxwQFpjvKeAB4INFoYQbuc1w34IX9n5JGMVd/v76/Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gwP/f8v1fXSFF20EDEZN55fFOtjVGioU5TKCxPf0veK+Gkur0OqBlJpzPKTY7Ll+G
	 +LEDB/GtCduE2srWiuSePQghUKn+3yOGDtY1+DG5856g0NwUQnstDTCLYFk0w/gj8D
	 cc1O2Qb/MFU1Xl+lmB4CdTxd2VtP7HXAp+R+vIAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgFRITA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgFRIS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:18:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24FCE208C7;
        Thu, 18 Jun 2020 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592468337;
        bh=JxwQFpjvKeAB4INFoYQbuc1w34IX9n5JGMVd/v76/Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YnosXv6U7X9MzW/oq+YVV7eFgTlowI2xeJ1XkF+AP9TjdBhcNVzq3s85rPSyVmNmC
         m1ZmZ/w3H3lX6eQkbANLTaDoK0g/g1YitnjP36P98w+8MAx2EzTyVUj4TVi9ZbywRB
         lcwUqVQ7RuC52V+gTLNj37ZXJ50/QHX14kIk9Zyg=
Date:   Thu, 18 Jun 2020 10:18:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: Re: [External] Re: [PATCH v6 3/8] usb: mausb_host: HCD initialization
Message-ID: <20200618081850.GB1043700@kroah.com>
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-4-vladimir.stankovic@displaylink.com>
 <20200515130754.GD1937631@kroah.com>
 <bc1d3b5a-758a-2c7d-4b6b-952c674f14f9@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc1d3b5a-758a-2c7d-4b6b-952c674f14f9@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 08:18:34PM +0200, Vladimir Stankovic wrote:
> On 15.5.20. 15:07, Greg KH wrote:
> > On Fri, May 15, 2020 at 02:34:57PM +0200, Vladimir Stankovic wrote:
> >> --- /dev/null
> >> +++ b/drivers/usb/host/mausb/hcd.c
> >> @@ -0,0 +1,120 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> >> + */
> >> +#include "hcd.h"
> >> +
> >> +#include "utils.h"
> >> +
> >> +static int mausb_bus_match(struct device *dev, struct device_driver *drv);
> >> +
> >> +static const struct file_operations mausb_fops;
> >> +
> >> +static unsigned int major;
> >> +static unsigned int minor = 1;
> >> +static dev_t devt;
> >> +static struct device *device;
> >> +
> >> +struct mausb_hcd	*mhcd;
> >> +static struct class	*mausb_class;
> >> +static struct bus_type	mausb_bus_type = {
> >> +	.name	= DEVICE_NAME,
> >> +	.match	= mausb_bus_match,
> >> +};
> > 
> > A static bus type???  For a single driver?
> > 
> >> +
> >> +static struct device_driver mausb_driver = {
> >> +	.name	= DEVICE_NAME,
> >> +	.bus	= &mausb_bus_type,
> >> +	.owner	= THIS_MODULE,
> >> +};
> > 
> > Wait, what???  A static "raw" struct device_driver?  Why???
> This was our initial driver setup that was "inherited" from some
> in-tree drivers. We are currently revising driver setup. In general,
> device driver will not work properly w/o bus being setup and the
> only way to avoid explicit bus and simplify driver setup is to use
> platform driver; however, we are not aware of any explicit dependency
> on the platform, so not sure whether it's acceptable to switch to
> platform device driver setup.

platform devices/drivers are to be used ONLY if your really have a
platform device (i.e. something connected to the system only through
device-tree or hard-coded memory locations.)  Do not use this for
virtual devices or anything else that is on a "real" bus.

thanks,

greg k-h
