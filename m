Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B3BC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBF72468D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgBZPoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:44:17 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46855 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgBZPoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:44:17 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1j6yr8-0008Ty-T1; Wed, 26 Feb 2020 16:44:14 +0100
Message-ID: <2608dfa05478d995586c9e477917349dc18618ac.camel@pengutronix.de>
Subject: Proper way to check for restricted DMA addressing from device driver
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 26 Feb 2020 16:44:14 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm currently struggling with how to properly check for restricted DMA
addressing from a device driver side. The basic issue I'm facing is
that I have a embedded GPU, which isn't able to address all system
memory due to interconnect being restricted to 32bit addressing. The
limits are properly described in the system device-tree and thus
SWIOTLB is working.

However graphics buffers are large and graphics drivers really like to
keep the dma mapping alive for performance reasons, which means I'm
running out of SWIOTLB space pretty easily, aside from the obvious
performance implications of SWIOTLB.

As 3 out of the maximum 4GB system memory are located in the DMA32 zone
and thus located in the GPU addressable space, I just want to avoid
allocating graphics buffers outside of the DMA32 zone.

To add the DMA32 restriction to my drivers allocations, I need a
reliable way from the device driver side to check if the GPU is in such
a restricted system. What I'm currently doing in my WIP patch is this:

 /*
  * If the GPU is part of a system with only 32bit bus addressing
  * capabilities, request pages for our SHM backend buffers from the
  * DMA32 zone to avoid performance killing SWIOTLB bounce buffering.
  */
 if (*gpu->dev->dma_mask < BIT_ULL(32) && !device_iommu_mapped(gpu->dev))
         priv->shm_gfp_mask |= GFP_DMA32;

However I'm not sure if there are edge cases where this check would
fool me. Is there any better way to check for DMA addressing
restrictions from the device driver side?

Regards,
Lucas

