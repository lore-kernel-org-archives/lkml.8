Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967AFC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D407214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 12:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDSMZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 08:25:05 -0400
Received: from 8bytes.org ([81.169.241.247]:36440 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgDSMZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:25:05 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EB734342; Sun, 19 Apr 2020 14:25:03 +0200 (CEST)
Date:   Sun, 19 Apr 2020 14:25:02 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200419122502.GI21900@8bytes.org>
References: <20200414122506.438134-1-hch@lst.de>
 <20200414122506.438134-4-hch@lst.de>
 <20200418124205.GD6113@8bytes.org>
 <20200419080058.GB12222@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419080058.GB12222@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 10:00:58AM +0200, Christoph Hellwig wrote:
> The difference is that NULL ops mean imply the direct mapping is always
> used, dma_ops_bypass means a direct mapping is used if no bounce buffering
> using swiotlb is needed, which should also answer your first question.
> The idea is to consolidate code in the core to use an opportunistic
> direct mapping instead of the dynamic iommu mapping.  I though the cover
> letter and commit log explained this well enough, but maybe I need to
> do a better job.

Ah right, now I see it, when dma_ops_bypass is set it will only use
direct mapping when the available memory fits into the device's
dma_masks, and calls into dma_ops otherwise.

I wonder how that will interact with an IOMMU driver, which has to make
sure that the direct mapping is accessible for the device at all.  It
can either put the device into a passthrough domain for direct mapping
or into a re-mapped domain, but then all DMA-API calls need to use dma-ops.
When the dma_mask covers available memory but coherent_mask doesn't,
the streaming calls will use dma-direct and alloc_coherent() calls into
dma-ops. There is no way for the IOMMU driver to ensure both works.

So what are the conditions under which an IOMMU driver would set
dma_ops_bypass to 1 and get a different result as to when setting
dev->dma_ops to NULL?

Regards,

	Joerg
