Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16D2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C670820786
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGGOv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:51:59 -0400
Received: from verein.lst.de ([213.95.11.211]:59166 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGOv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:51:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96D6068AFE; Tue,  7 Jul 2020 16:51:56 +0200 (CEST)
Date:   Tue, 7 Jul 2020 16:51:56 +0200
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
Message-ID: <20200707145156.GA22235@lst.de>
References: <20200414122506.438134-1-hch@lst.de> <20200414122506.438134-2-hch@lst.de> <c2572d30-f03c-450d-e257-3a8673b42d44@ozlabs.ru> <20200415061859.GA32392@lst.de> <5139e8e1-6389-3387-dc39-6983b08ff28d@ozlabs.ru> <20200417075852.GA20049@lst.de> <70296d53-3504-2645-4b16-0eb73b0cd0d9@ozlabs.ru> <20200509081946.GA21834@lst.de> <95c46afb-bb40-3cb3-bf32-3e510fcd474d@ozlabs.ru> <fa6c3d55-1054-b87f-9832-3418323151cd@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6c3d55-1054-b87f-9832-3418323151cd@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:43:10AM +1000, Alexey Kardashevskiy wrote:
> Any luck there? I'd really like to cross this off my todo list :) Thanks,

We had another incident with new net code poking into dma internals
blocking this series.  That is now sorted out, so the series is back
on track.
