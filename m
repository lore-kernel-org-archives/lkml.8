Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B027C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D506220723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590168855;
	bh=bkgshU6AbS0fJo/CTj2DzVqhKPnZ0Xphtqqjh9kikv0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=d6bjKVB49TPIMbTSr5sfi6ELi9laicDbsT5nz4VrnXR0siVvFvP0tcwOxZM3N/C1v
	 ynsXLAMu/DteWmjXVqCI/slth5bOLfxn8ULEZKTUsBXIqD3PzFEGfGIivJ+KOpUeeS
	 ZFOHBdktgMLwtdeswQDQouPdJavuWbYNAvN6Nj9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgEVReP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730701AbgEVReO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:34:14 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC899206C3;
        Fri, 22 May 2020 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590168854;
        bh=bkgshU6AbS0fJo/CTj2DzVqhKPnZ0Xphtqqjh9kikv0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=eSi4IF3LWHeaVP4rszG5wzmIBjjqjNqDcvCQBTU8KUyFwkM0Oh+Ow6iUg1jw3OAk0
         0w/3No0va/aFOz3I71+LNi36xW+LCxxNTBq257tnueccNsalMDzxVLsdBZpkO0j5lq
         5Iu6CCt39GlOmDVt5KSccs6JAEBpwqcDoIzXEL/4=
Date:   Fri, 22 May 2020 10:34:13 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        konrad.wilk@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH 08/10] swiotlb-xen: introduce phys_to_dma/dma_to_phys
 translations
In-Reply-To: <7aab1c00-c115-b989-61e5-fd7d28fa0d07@oracle.com>
Message-ID: <alpine.DEB.2.21.2005221033180.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s> <20200520234520.22563-8-sstabellini@kernel.org> <7aab1c00-c115-b989-61e5-fd7d28fa0d07@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020, Boris Ostrovsky wrote:
> On 5/20/20 7:45 PM, Stefano Stabellini wrote:
> > From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> >
> > Call dma_to_phys in is_xen_swiotlb_buffer.
> > Call phys_to_dma in xen_phys_to_bus.
> > Call dma_to_phys in xen_bus_to_phys.
> >
> > Everything is taken care of by these changes except for
> > xen_swiotlb_alloc_coherent and xen_swiotlb_free_coherent, which need a
> > few explicit phys_to_dma/dma_to_phys calls.
> >
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > ---
> >  drivers/xen/swiotlb-xen.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index c50448fd9b75..d011c4c7aa72 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -64,14 +64,16 @@ static inline dma_addr_t xen_phys_to_bus(struct device *dev, phys_addr_t paddr)
> >  
> >  	dma |= paddr & ~XEN_PAGE_MASK;
> >  
> > -	return dma;
> > +	return phys_to_dma(dev, dma);
> >  }
> >  
> > -static inline phys_addr_t xen_bus_to_phys(struct device *dev, dma_addr_t baddr)
> > +static inline phys_addr_t xen_bus_to_phys(struct device *dev,
> > +					  dma_addr_t dma_addr)
> 
> 
> Since now dma address != bus address this is no longer
> xen_bus_to_phys(). (And I guess the same is rue for xen_phys_to_bus()).

Should I rename them to xen_dma_to_phys and xen_phys_to_dma?

 
> >  {
> > +	phys_addr_t baddr = dma_to_phys(dev, dma_addr);
> >  	unsigned long xen_pfn = bfn_to_pfn(XEN_PFN_DOWN(baddr));
> > -	dma_addr_t dma = (dma_addr_t)xen_pfn << XEN_PAGE_SHIFT;
> > -	phys_addr_t paddr = dma;
> > +	phys_addr_t paddr = (xen_pfn << XEN_PAGE_SHIFT) |
> > +			    (baddr & ~XEN_PAGE_MASK);
> >  
> >  	paddr |= baddr & ~XEN_PAGE_MASK;
> 
> 
> This line needs to go, no?

Yes, good point
