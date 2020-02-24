Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ECDC38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C312080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgBXTpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:45:35 -0500
Received: from verein.lst.de ([213.95.11.211]:40011 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgBXTpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 14:45:35 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E85268B05; Mon, 24 Feb 2020 20:45:29 +0100 (CET)
Date:   Mon, 24 Feb 2020 20:45:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] openrisc: use the generic in-place uncached DMA
 allocator
Message-ID: <20200224194528.GA10155@lst.de>
References: <20200220170139.387354-1-hch@lst.de> <20200220170139.387354-3-hch@lst.de> <20200221221447.GA7926@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221221447.GA7926@lianli.shorne-pla.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 07:14:47AM +0900, Stafford Horne wrote:
> On Thu, Feb 20, 2020 at 09:01:39AM -0800, Christoph Hellwig wrote:
> > Switch openrisc to use the dma-direct allocator and just provide the
> > hooks for setting memory uncached or cached.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: Stafford Horne <shorne@gmail.com>
> 
> Also, I test booted openrisc with linux 5.5 + these patches.  Thanks for
> continuing to shrink my code base.

I just resent a new version that changes how the hooks work based on
feedback from Robin.  Everything should work as-is, but if you have
some time to retest that would be great.
