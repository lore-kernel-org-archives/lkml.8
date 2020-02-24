Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4116CC38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC6620CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgBXV5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:57:01 -0500
Received: from verein.lst.de ([213.95.11.211]:40500 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbgBXV5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:57:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C9FFA68B05; Mon, 24 Feb 2020 22:56:57 +0100 (CET)
Date:   Mon, 24 Feb 2020 22:56:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dma-direct: provide a arch_dma_clear_uncached hook
Message-ID: <20200224215657.GA12618@lst.de>
References: <20200224194446.690816-1-hch@lst.de> <20200224194446.690816-5-hch@lst.de> <20200224215327.GB11565@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224215327.GB11565@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:53:28PM -0800, Ira Weiny wrote:
> > +	else if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
> > +		arch_dma_clear_uncached(cpu_addr, size);
> 
> Isn't using arch_dma_clear_uncached() before patch 5 going to break
> bisectability?

Only if ARCH_HAS_DMA_CLEAR_UNCACHED is selected by anything, which
only happens in patch 5.
