Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAC9C433EC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16EB2224D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgHFFSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 01:18:18 -0400
Received: from verein.lst.de ([213.95.11.211]:48641 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgHFFSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:18:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB10868CFE; Thu,  6 Aug 2020 07:18:14 +0200 (CEST)
Date:   Thu, 6 Aug 2020 07:18:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, amit.pundir@linaro.org,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, rientjes@google.com,
        jeremy.linton@arm.com, linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
Message-ID: <20200806051814.GA10143@lst.de>
References: <20200803160956.19235-1-nsaenzjulienne@suse.de> <20200803160956.19235-3-nsaenzjulienne@suse.de> <20200804060633.GA7368@lst.de> <e0b2a00c8cf86cb1a91804942d35c9d4b98e9f9f.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b2a00c8cf86cb1a91804942d35c9d4b98e9f9f.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 11:43:15AM +0200, Nicolas Saenz Julienne wrote:
> > Second I don't see the need (and actually some harm) in preventing GFP_KERNEL
> > allocations from dipping into lower CMA areas - something that we did support
> > before 5.8 with the single pool.
> 
> My thinking is the least we pressure CMA the better, it's generally scarse, and
> it'll not grow as the atomic pools grow. As far as harm is concerned, we now
> check addresses for correctness, so we shouldn't run into problems.
> 
> There is a potential case for architectures defining a default CMA but not
> defining DMA zones where this could be problematic. But isn't that just plain
> abusing CMA? If you need low memory allocations, you should be defining DMA
> zones.

The latter is pretty much what I expect, as we only support the default and
per-device DMA CMAs.
