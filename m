Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0043DC4BA1D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CE4206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgBZRTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:19:22 -0500
Received: from verein.lst.de ([213.95.11.211]:49925 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgBZRTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:19:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5BE5068CEE; Wed, 26 Feb 2020 18:19:18 +0100 (CET)
Date:   Wed, 26 Feb 2020 18:19:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Proper way to check for restricted DMA addressing from device
 driver
Message-ID: <20200226171918.GA22703@lst.de>
References: <2608dfa05478d995586c9e477917349dc18618ac.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2608dfa05478d995586c9e477917349dc18618ac.camel@pengutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What you really needs is something like the dma_alloc_pages interface
here:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma_alloc_pages

which has been preempted by a few other things, and the fact that
the AMD SEV encryption bit breaks various assumptions made in this
interface..

On Wed, Feb 26, 2020 at 04:44:14PM +0100, Lucas Stach wrote:
> Hi all,
> 
> I'm currently struggling with how to properly check for restricted DMA
> addressing from a device driver side. The basic issue I'm facing is
> that I have a embedded GPU, which isn't able to address all system
> memory due to interconnect being restricted to 32bit addressing. The
> limits are properly described in the system device-tree and thus
> SWIOTLB is working.
> 
> However graphics buffers are large and graphics drivers really like to
> keep the dma mapping alive for performance reasons, which means I'm
> running out of SWIOTLB space pretty easily, aside from the obvious
> performance implications of SWIOTLB.
> 
> As 3 out of the maximum 4GB system memory are located in the DMA32 zone
> and thus located in the GPU addressable space, I just want to avoid
> allocating graphics buffers outside of the DMA32 zone.
> 
> To add the DMA32 restriction to my drivers allocations, I need a
> reliable way from the device driver side to check if the GPU is in such
> a restricted system. What I'm currently doing in my WIP patch is this:
> 
>  /*
>   * If the GPU is part of a system with only 32bit bus addressing
>   * capabilities, request pages for our SHM backend buffers from the
>   * DMA32 zone to avoid performance killing SWIOTLB bounce buffering.
>   */
>  if (*gpu->dev->dma_mask < BIT_ULL(32) && !device_iommu_mapped(gpu->dev))
>          priv->shm_gfp_mask |= GFP_DMA32;
> 
> However I'm not sure if there are edge cases where this check would
> fool me. Is there any better way to check for DMA addressing
> restrictions from the device driver side?
> 
> Regards,
> Lucas
---end quoted text---
