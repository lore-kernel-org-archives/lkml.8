Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5604C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C452C207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589983404;
	bh=QuXivJWfSCHoFejw2WGsuzr9GwmENzgWc4fknuN2hVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fwXcVbXEx3f5JieGlZh8DwsfzH1t2S21Aj0Qdw/VhtE6qU7hgJmUC/0g+5pGpY8fO
	 4qeBT4SJJnU3REO2iEu3Wui+ltHtxwByhPTFuKa1cu3dTV8/TiTZXmmKLaS+CmxY12
	 eXOOWKP++MgrbXNZgiSyXR4ayYDebyDKH6NvxZiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgETODY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgETODX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:03:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20D320756;
        Wed, 20 May 2020 14:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589983403;
        bh=QuXivJWfSCHoFejw2WGsuzr9GwmENzgWc4fknuN2hVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eiyArFOnyS9XWPVzx2pT9OR3PB51ouV4SYNXBJ/MysL4g4tA60zrn+LXVy2btR79O
         RI9k8qrNOLyJ2r26YpfZ9DWI8NVapbA8kStc2j9iMBOnMPrz+iik1p9pAf++tpwLEf
         mcWbA0DiSjTiLMPuGXhTXbwNZHh9ZjMLZ0mML4wI=
Date:   Wed, 20 May 2020 16:03:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 09/15] device core: Add ability to handle multiple dma
 offsets
Message-ID: <20200520140320.GA3624154@kroah.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-10-james.quinlan@broadcom.com>
 <20200520054349.GB2180554@kroah.com>
 <CA+-6iNyQFauYc0ZNbzRmao_oOZD8XM+1D0XE133HP_-zgMLzuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNyQFauYc0ZNbzRmao_oOZD8XM+1D0XE133HP_-zgMLzuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 09:50:36AM -0400, Jim Quinlan wrote:
> On Wed, May 20, 2020 at 1:43 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, May 19, 2020 at 04:34:07PM -0400, Jim Quinlan wrote:
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index ac8e37cd716a..6cd916860b5f 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -493,6 +493,8 @@ struct dev_links_info {
> > >   * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
> > >   *           DMA limit than the device itself supports.
> > >   * @dma_pfn_offset: offset of DMA memory range relatively of RAM
> > > + * @dma_map: Like dma_pfn_offset but used when there are multiple
> > > + *           pfn offsets for multiple dma-ranges.
> > >   * @dma_parms:       A low level driver may set these to teach IOMMU code about
> > >   *           segment limitations.
> > >   * @dma_pools:       Dma pools (if dma'ble device).
> > > @@ -578,7 +580,12 @@ struct device {
> > >                                            allocations such descriptors. */
> > >       u64             bus_dma_limit;  /* upstream dma constraint */
> > >       unsigned long   dma_pfn_offset;
> > > -
> > > +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> > > +     const void *dma_offset_map;     /* Like dma_pfn_offset, but for
> > > +                                      * the unlikely case of multiple
> > > +                                      * offsets. If non-null, dma_pfn_offset
> > > +                                      * will be 0. */
> > > +#endif
> > >       struct device_dma_parameters *dma_parms;
> > >
> > >       struct list_head        dma_pools;      /* dma pools (if dma'ble) */
> >
> > I'll defer to Christoph here, but I thought we were trying to get rid of
> > stuff like this from struct device, not add new things to it for dma
> Hi Greg,
> 
> I wasn't aware of this policy.  I put it in 'struct device' because
> just like the existing dma_pfn_offset; it seemed to be the only way to
> pull this off.  I'll certainly follow any ideas on alternative
> strategies from Christoph et al.
> 
> > apis.  And why is it a void *?
> Just wanted to minimize the number of lines I've added to device.h, no
> other reason.

How would using a real type make this more lines?  Never use a void *
unless you have to, we want the compiler to check our errors for us :)

thanks,

greg k-h
