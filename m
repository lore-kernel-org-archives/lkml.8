Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D814DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3DB206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgGHPgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:36:39 -0400
Received: from verein.lst.de ([213.95.11.211]:35930 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgGHPgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:36:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6727E68B05; Wed,  8 Jul 2020 17:36:36 +0200 (CEST)
Date:   Wed, 8 Jul 2020 17:36:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
Message-ID: <20200708153635.GB26743@lst.de>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de> <e6504dc5-4169-edf9-d08e-17a378a1ef7a@arm.com> <21a7276e98ae245404d82537ac1ee597a92f9150.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a7276e98ae245404d82537ac1ee597a92f9150.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 12:35:34PM +0200, Nicolas Saenz Julienne wrote:
> > Which allows me to switch between ACPI/DT on the machine. In DT mode it 
> > works fine now, 
> 
> Nice, would that count as a Tested-by from you?
> 
> > but with ACPI I continue to have failures unless I 
> > disable CMA via cma=0 on the kernel command line. 
> 
> Yes, I see why, in atomic_pool_expand() memory is allocated from CMA without
> checking its correctness. That calls for a separate fix. I'll try to think of
> something.

I think we need a dma_coherent_ok for the allocations from the
pool and then fall back to the next better one to get started.  And
yes, CMA is a bit of a mess, that generally needs better checks.
