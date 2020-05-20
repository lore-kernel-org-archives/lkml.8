Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF7CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F6F207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 05:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589953433;
	bh=IEc+QC7akchK5eV7/ZYdgqsaG2z+ctbqijAK6mJ6Q98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t7pz6zeQFuYLk8f6rqMPnP5AT/N9V1R/jRyuHdSDaU9QaH84ZIKGgc+KVXmFWl1xo
	 Xl7pTcMlIUoUuJAmZ5KQ70P/D6Smcwnlu8Q5bLD0YIAz2y0aEeOhxS0QjZYuZ06654
	 7wL48yhhWyJSxi2bdDOT6C9t6PeUSEI1o7Oc+xas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgETFnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 01:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgETFnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 01:43:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B534C2075F;
        Wed, 20 May 2020 05:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589953432;
        bh=IEc+QC7akchK5eV7/ZYdgqsaG2z+ctbqijAK6mJ6Q98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MV9LOgk3OXP5XC66veg+cLqTxXmgekS2F0K2Lx1avu81cXlkxReu1me2r75MMQ2b+
         ZE/q6upLQs+FrqRHXAntfRYgsnkgOdGK7p4UiV+dhvyZ4PYwI5dyJMh3rzb1/w81wX
         vLFfMmab6HO3EzfJeRgK37kwsXkaZoBeGIY6dFJs=
Date:   Wed, 20 May 2020 07:43:49 +0200
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
Message-ID: <20200520054349.GB2180554@kroah.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-10-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519203419.12369-10-james.quinlan@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 04:34:07PM -0400, Jim Quinlan wrote:
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ac8e37cd716a..6cd916860b5f 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -493,6 +493,8 @@ struct dev_links_info {
>   * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
>   *		DMA limit than the device itself supports.
>   * @dma_pfn_offset: offset of DMA memory range relatively of RAM
> + * @dma_map:	Like dma_pfn_offset but used when there are multiple
> + *		pfn offsets for multiple dma-ranges.
>   * @dma_parms:	A low level driver may set these to teach IOMMU code about
>   * 		segment limitations.
>   * @dma_pools:	Dma pools (if dma'ble device).
> @@ -578,7 +580,12 @@ struct device {
>  					     allocations such descriptors. */
>  	u64		bus_dma_limit;	/* upstream dma constraint */
>  	unsigned long	dma_pfn_offset;
> -
> +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> +	const void *dma_offset_map;	/* Like dma_pfn_offset, but for
> +					 * the unlikely case of multiple
> +					 * offsets. If non-null, dma_pfn_offset
> +					 * will be 0. */
> +#endif
>  	struct device_dma_parameters *dma_parms;
>  
>  	struct list_head	dma_pools;	/* dma pools (if dma'ble) */

I'll defer to Christoph here, but I thought we were trying to get rid of
stuff like this from struct device, not add new things to it for dma
apis.  And why is it a void *?

thanks,

greg k-h
