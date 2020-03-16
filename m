Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED0AC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0513C205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgCPMsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:48:54 -0400
Received: from verein.lst.de ([213.95.11.211]:54177 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730979AbgCPMsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:48:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1452368CEC; Mon, 16 Mar 2020 13:48:50 +0100 (CET)
Date:   Mon, 16 Mar 2020 13:48:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [RFC][PATCH] dma-mapping: align default segment_boundary_mask
 with dma_mask
Message-ID: <20200316124850.GB17386@lst.de>
References: <20200314000007.13778-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314000007.13778-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 05:00:07PM -0700, Nicolin Chen wrote:
> @@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
>  {
>  	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
>  		return dev->dma_parms->segment_boundary_mask;
> -	return DMA_BIT_MASK(32);
> +	return (unsigned long)dma_get_mask(dev);

Just thinking out loud after my reply - shouldn't we just return ULONG_MAX
by default here to mark this as no limit?
