Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86370C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4DF2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404240AbgE1PTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:19:11 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:43040 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404149AbgE1PTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:19:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 420DA80307C0;
        Thu, 28 May 2020 15:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r6jQPtQkf7QC; Thu, 28 May 2020 18:19:03 +0300 (MSK)
Date:   Thu, 28 May 2020 18:19:02 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/10] dmaengine: Introduce DMA-device device_caps
 callback
Message-ID: <20200528151902.vemr7aolvtean2f3@mobilestation>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-6-Sergey.Semin@baikalelectronics.ru>
 <20200528144257.GS1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200528144257.GS1634618@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 05:42:57PM +0300, Andy Shevchenko wrote:
> On Wed, May 27, 2020 at 01:50:16AM +0300, Serge Semin wrote:
> > There are DMA devices (like ours version of Synopsys DW DMAC) which have
> > DMA capabilities non-uniformly redistributed amongst the device channels.
> > In order to provide a way of exposing the channel-specific parameters to
> > the DMA engine consumers, we introduce a new DMA-device callback. In case
> > if provided it gets called from the dma_get_slave_caps() method and is
> > able to override the generic DMA-device capabilities.
> 
> > +	if (device->device_caps)
> > +		device->device_caps(chan, caps);
> > +
> >  	return 0;
> 
> I dunno why this returns int, but either we get rid of this returned value
> (perhaps in the future, b/c it's not directly related to this series), or
> something like
> 
> 	if (device->device_caps)
> 		return device->device_caps(chan, caps);

It returns int because dma_get_slave_caps() check parameters and some other
stuff.

Regarding device_caps() callback having a return value. IMO it's redundant.
The only thing what the callback should do is to update the caps and device
is supposed to know it' capabilities, otherwise who else should know? So I
don't see why device_caps would be needed.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
