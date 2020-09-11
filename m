Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FB2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF33C21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgIKHJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:09:58 -0400
Received: from verein.lst.de ([213.95.11.211]:35756 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKHJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:09:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DFED868B02; Fri, 11 Sep 2020 09:09:50 +0200 (CEST)
Date:   Fri, 11 Sep 2020 09:09:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        iommu@lists.linux-foundation.org, Tomasz Figa <tfiga@chromium.org>,
        Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 04/12] dma-mapping: fix DMA_OPS dependencies
Message-ID: <20200911070950.GB22394@lst.de>
References: <20200908164758.3177341-1-hch@lst.de> <20200908164758.3177341-5-hch@lst.de> <1e3c7094-62da-6e8c-0a41-0bc63dd3db68@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e3c7094-62da-6e8c-0a41-0bc63dd3db68@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 01:55:37PM +0100, Robin Murphy wrote:
> AFAICS all three of these bus drivers are only proxying a struct 
> dma_map_ops * pointer around, so if they used the set_dma_ops() helper they 
> shouldn't even need these selects at all. Only INTEL_MIC_HOST appears to 
> have a logical dependency on DMA_OPS for actual functionality.
>
> However, I have a vague feeling you might not be fond of those dma_ops 
> helpers, and I have no great objection to this one-liner as-is, so (modulo 
> the couple of commit message typos),

The problem with these inherіtances is that they don't actually work
for the general case.  You'd also need to inherity things like the
dma ranges, the bus limits, etc, etc.  So we need to kill them instead.
That whole mic/vop case is even worse than that with it's weird set
of chained dma ops that seems to implement some kind of device side
iommu that isn't in scope for the DMA API at all.
