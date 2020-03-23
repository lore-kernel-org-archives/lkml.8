Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90289C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7166420736
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgCWIvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:51:05 -0400
Received: from verein.lst.de ([213.95.11.211]:57618 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgCWIvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:51:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D778468BEB; Mon, 23 Mar 2020 09:50:59 +0100 (CET)
Date:   Mon, 23 Mar 2020 09:50:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200323085059.GA32528@lst.de>
References: <20200320141640.366360-1-hch@lst.de> <20200320141640.366360-2-hch@lst.de> <2f31d0dd-aa7e-8b76-c8a1-5759fda5afc9@ozlabs.ru> <20200323083705.GA31245@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323083705.GA31245@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 09:37:05AM +0100, Christoph Hellwig wrote:
> > > +	/*
> > > +	 * Allows IOMMU drivers to bypass dynamic translations if the DMA mask
> > > +	 * is large enough.
> > > +	 */
> > > +	if (dev->dma_ops_bypass) {
> > > +		if (min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit) >=
> > > +				dma_direct_get_required_mask(dev))
> > > +			return true;
> > > +	}
> > 
> > 
> > Why not do this in dma_map_direct() as well?
> 
> Mostly beacuse it is a relatively expensive operation, including a
> fls64.

Which I guess isn't too bad compared to a dynamic IOMMU mapping.  Can
you just send a draft patch for what you'd like to see for ppc?
