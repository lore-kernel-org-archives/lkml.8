Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A06C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A922064A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgDQH64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:58:56 -0400
Received: from verein.lst.de ([213.95.11.211]:56280 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbgDQH64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:58:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B16DF68BEB; Fri, 17 Apr 2020 09:58:52 +0200 (CEST)
Date:   Fri, 17 Apr 2020 09:58:52 +0200
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
Message-ID: <20200417075852.GA20049@lst.de>
References: <20200414122506.438134-1-hch@lst.de> <20200414122506.438134-2-hch@lst.de> <c2572d30-f03c-450d-e257-3a8673b42d44@ozlabs.ru> <20200415061859.GA32392@lst.de> <5139e8e1-6389-3387-dc39-6983b08ff28d@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5139e8e1-6389-3387-dc39-6983b08ff28d@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 09:21:37PM +1000, Alexey Kardashevskiy wrote:
> And the fact they were exported leaves possibility that there is a
> driver somewhere relying on these symbols or distro kernel won't build
> because the symbol disappeared from exports (I do not know what KABI
> guarantees or if mainline kernel cares).

We absolutely do not care.  In fact for abuses of APIs that drivers
should not use we almost care to make them private and break people
abusing them.

> I do not care in particular but
> some might, a line separated with empty lines in the commit log would do.

I'll add a blurb for the next version.
