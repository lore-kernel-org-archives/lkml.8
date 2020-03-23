Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE835C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2952072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgCWRUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:20:21 -0400
Received: from verein.lst.de ([213.95.11.211]:59637 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728088AbgCWRUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:20:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C11FA68BEB; Mon, 23 Mar 2020 18:20:14 +0100 (CET)
Date:   Mon, 23 Mar 2020 18:20:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200323172014.GA31269@lst.de>
References: <20200320141640.366360-1-hch@lst.de> <20200320141640.366360-2-hch@lst.de> <2f31d0dd-aa7e-8b76-c8a1-5759fda5afc9@ozlabs.ru> <20200323083705.GA31245@lst.de> <37ce1b7e-264d-292d-32b1-093b24b3525c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ce1b7e-264d-292d-32b1-093b24b3525c@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 07:58:01PM +1100, Alexey Kardashevskiy wrote:
> >> 0x100.0000.0000 .. 0x101.0000.0000
> >>
> >> 2x4G, each is 1TB aligned. And we can map directly only the first 4GB
> >> (because of the maximum IOMMU table size) but not the other. And 1:1 on
> >> that "pseries" is done with offset=0x0800.0000.0000.0000.
> >>
> >> So we want to check every bus address against dev->bus_dma_limit, not
> >> dev->coherent_dma_mask. In the example above I'd set bus_dma_limit to
> >> 0x0800.0001.0000.0000 and 1:1 mapping for the second 4GB would not be
> >> tried. Does this sound reasonable? Thanks,
> > 
> > bus_dma_limit is just another limiting factor applied on top of
> > coherent_dma_mask or dma_mask respectively.
> 
> This is not enough for the task: in my example, I'd set bus limit to
> 0x0800.0001.0000.0000 but this would disable bypass for all RAM
> addresses - the first and the second 4GB blocks.

So what about something like the version here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-bypass.3
