Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40649C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 07:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178C420702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 07:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgA3Hxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 02:53:36 -0500
Received: from verein.lst.de ([213.95.11.211]:39306 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgA3Hxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 02:53:35 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 57B3C68B05; Thu, 30 Jan 2020 08:53:32 +0100 (CET)
Date:   Thu, 30 Jan 2020 08:53:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, hch@lst.de, vigneshr@ti.com,
        konrad.wilk@oracle.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, rogerq@ti.com,
        robh@kernel.org
Subject: Re: [PoC] arm: dma-mapping: direct: Apply dma_pfn_offset only when
 it is valid
Message-ID: <20200130075332.GA30735@lst.de>
References: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com> <20200114164332.3164-1-peter.ujfalusi@ti.com> <f8121747-8840-e279-8c7c-75a9d4becce8@arm.com> <28ee3395-baed-8d59-8546-ab7765829cc8@ti.com> <4f0e307f-29a9-44cd-eeaa-3b999e03871c@arm.com> <75843c71-1718-8d61-5e3d-edba6e1b10bd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75843c71-1718-8d61-5e3d-edba6e1b10bd@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[skipping the DT bits, as I'm everything but an expert on that..]

On Mon, Jan 27, 2020 at 04:00:30PM +0200, Peter Ujfalusi wrote:
> I agree on the phys_to_dma(). It should fail for addresses which does
> not fall into any of the ranges.
> It is just a that we in Linux don't have the concept atm for ranges, we
> have only _one_ range which applies to every memory address.

what does atm here mean?

We have needed multi-range support for quite a while, as common broadcom
SOCs do need it.  So patches for that are welcome at least from the
DMA layer perspective (kinda similar to your pseudo code earlier)

> > Nobody's disputing that the current dma_direct_supported()
> > implementation is broken for the case where ZONE_DMA itself is offset
> > from PA 0; the more pressing question is why Christoph's diff, which was
> > trying to take that into account, still didn't work.
> 
> I understand that this is a bit more complex than I interpret it, but
> the k2g is broken and currently the simplest way to make it work is to
> use the arm dma_ops in case the pfn_offset is not 0.
> It will be easy to test dma-direct changes trying to address the issue
> in hand, but will allow k2g to be usable at the same time.

Well, using the legacy arm dma ops means we can't use swiotlb if there
is an offset, which is also wrong for lots of common cases, including
the Rpi 4.  I'm still curious why my patch didn't work, as I thought
it should.  We'll need to find the minimum change to make it work
for now without switching ops, even if it isn't the correct one, and
then work from there.
