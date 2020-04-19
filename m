Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0841C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 08:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8373421744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 08:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgDSIBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 04:01:01 -0400
Received: from verein.lst.de ([213.95.11.211]:35682 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDSIBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 04:01:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7C63E68BEB; Sun, 19 Apr 2020 10:00:58 +0200 (CEST)
Date:   Sun, 19 Apr 2020 10:00:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200419080058.GB12222@lst.de>
References: <20200414122506.438134-1-hch@lst.de> <20200414122506.438134-4-hch@lst.de> <20200418124205.GD6113@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418124205.GD6113@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 02:42:05PM +0200, Joerg Roedel wrote:
> Hi Christoph,
> 
> On Tue, Apr 14, 2020 at 02:25:05PM +0200, Christoph Hellwig wrote:
> > +static inline bool dma_map_direct(struct device *dev,
> > +		const struct dma_map_ops *ops)
> > +{
> > +	if (likely(!ops))
> > +		return true;
> > +	if (!dev->dma_ops_bypass)
> > +		return false;
> > +
> > +	return min_not_zero(*dev->dma_mask, dev->bus_dma_limit) >=
> > +			    dma_direct_get_required_mask(dev);
> 
> Why is the dma-mask check done here? The dma-direct code handles memory
> outside of the devices dma-mask with swiotlb, no?
> 
> I also don't quite get what the difference between setting the
> dma_ops_bypass flag non-zero and setting ops to NULL is.

The difference is that NULL ops mean imply the direct mapping is always
used, dma_ops_bypass means a direct mapping is used if no bounce buffering
using swiotlb is needed, which should also answer your first question.
The idea is to consolidate code in the core to use an opportunistic
direct mapping instead of the dynamic iommu mapping.  I though the cover
letter and commit log explained this well enough, but maybe I need to
do a better job.
