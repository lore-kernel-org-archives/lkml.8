Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37EEC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E62206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgDFLuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:50:22 -0400
Received: from verein.lst.de ([213.95.11.211]:33172 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbgDFLuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:50:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 35D0268C4E; Mon,  6 Apr 2020 13:50:17 +0200 (CEST)
Date:   Mon, 6 Apr 2020 13:50:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200406115016.GA10941@lst.de>
References: <20200323083705.GA31245@lst.de> <20200323085059.GA32528@lst.de> <87sghz2ibh.fsf@linux.ibm.com> <20200323172256.GB31269@lst.de> <ffce1af6-a215-dee8-7b5c-2111f43accfd@ozlabs.ru> <20200324075402.GJ23447@lst.de> <41975da3-3a4a-fc3c-2b90-8d607cf220e6@ozlabs.ru> <20200325083740.GC21605@lst.de> <a705afc5-779d-baf4-e5d2-e2da04c82743@ozlabs.ru> <213b0c7d-f908-b4f4-466d-6240c3622cd6@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213b0c7d-f908-b4f4-466d-6240c3622cd6@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 07:38:11PM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 26/03/2020 12:26, Alexey Kardashevskiy wrote:
> > 
> > 
> > On 25/03/2020 19:37, Christoph Hellwig wrote:
> >> On Wed, Mar 25, 2020 at 03:51:36PM +1100, Alexey Kardashevskiy wrote:
> >>>>> This is for persistent memory which you can DMA to/from but yet it does
> >>>>> not appear in the system as a normal memory and therefore requires
> >>>>> special handling anyway (O_DIRECT or DAX, I do not know the exact
> >>>>> mechanics). All other devices in the system should just run as usual,
> >>>>> i.e. use 1:1 mapping if possible.
> >>>>
> >>>> On other systems (x86 and arm) pmem as long as it is page backed does
> >>>> not require any special handling.  This must be some weird way powerpc
> >>>> fucked up again, and I suspect you'll have to suffer from it.
> >>>
> >>>
> >>> It does not matter if it is backed by pages or not, the problem may also
> >>> appear if we wanted for example p2p PCI via IOMMU (between PHBs) and
> >>> MMIO might be mapped way too high in the system address space and make
> >>> 1:1 impossible.
> >>
> >> How can it be mapped too high for a direct mapping with a 64-bit DMA
> >> mask?
> > 
> > The window size is limited and often it is not even sparse. It requires
> > an 8 byte entry per an IOMMU page (which is most commonly is 64k max) so
> > 1TB limit (a guest RAM size) is a quite real thing. MMIO is mapped to
> > guest physical address space outside of this 1TB (on PPC).
> > 
> > 
> 
> I am trying now this approach on top of yours "dma-bypass.3" (it is
> "wip", needs an upper boundary check):
> 
> https://github.com/aik/linux/commit/49d73c7771e3f6054804f6cfa80b4e320111662d
> 
> Do you see any serious problem with this approach? Thanks!

Do you have a link to the whole branch?  The github UI is unfortunately
unusable for that (or I'm missing something).
