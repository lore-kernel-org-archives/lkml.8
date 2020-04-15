Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E980C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0828A206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634777AbgDOGTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:19:09 -0400
Received: from verein.lst.de ([213.95.11.211]:43521 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393532AbgDOGTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:19:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C3C0368C65; Wed, 15 Apr 2020 08:18:59 +0200 (CEST)
Date:   Wed, 15 Apr 2020 08:18:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/4] dma-mapping: move the remaining DMA API calls out
 of line
Message-ID: <20200415061859.GA32392@lst.de>
References: <20200414122506.438134-1-hch@lst.de> <20200414122506.438134-2-hch@lst.de> <c2572d30-f03c-450d-e257-3a8673b42d44@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2572d30-f03c-450d-e257-3a8673b42d44@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:26:04PM +1000, Alexey Kardashevskiy wrote:
> May be this is correct and allowed (no idea) but removing exported
> symbols at least deserves a mention in the commit log, does not it?
> 
> The rest of the series is fine and works. Thanks,

Maybe I can throw in a line, but the point is that dma_direct_*
was exported as dma_* called them inline.  Now dma_* is out of line
and exported instead, which always was the actual API.
