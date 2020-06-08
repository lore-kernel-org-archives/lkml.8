Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83425C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FF220760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664657;
	bh=9kgiWfc80bQ1pFTP10CoDvlD9i3E2sMoZB2p3Vvgd/g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=FS3Syt7cJwKC8epssZYoP6uPASAo4mBQstpTiEDKWDSXPUX0N73q6IjK2AH1NP55S
	 6z1APcjjYxkV7FBSJHaPmCx6/mwuIouPCs0tH6G+fHDNZiAUbnoIYOMCOBr9BQq8aI
	 nUli0shjgsIs6ZFDsKgUZk4WbpWB8hnm4NHsWkSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgFHXH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgFHXG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:59 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C48520820;
        Mon,  8 Jun 2020 23:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657618;
        bh=9kgiWfc80bQ1pFTP10CoDvlD9i3E2sMoZB2p3Vvgd/g=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=IAKP9+uyhx+Mw+/ttmtWvmUV5DWr7Hx4rynsr/VlhWY7naVEcoN2oD/N3/5SjrSVB
         EmHPS5CiBaqDmNLIqVqDyRmUgYL0/hy7nAFMhxlSh1iB+5l18sVCmDe/ECVJA17l06
         HJUi2skFlwTFsob6tOCCspquwIIueUlnqfhHl8Bo=
Date:   Mon, 8 Jun 2020 16:06:57 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@infradead.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        tamas@tklengyel.com, roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 08/11] swiotlb-xen: introduce phys_to_dma/dma_to_phys
 translations
In-Reply-To: <20200608070850.GD15742@infradead.org>
Message-ID: <alpine.DEB.2.21.2006081558400.2815@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s> <20200603222247.11681-8-sstabellini@kernel.org> <20200608070850.GD15742@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020, Christoph Hellwig wrote:
> On Wed, Jun 03, 2020 at 03:22:44PM -0700, Stefano Stabellini wrote:
> > From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > 
> > With some devices physical addresses are different than dma addresses.
> > To be able to deal with these cases, we need to call phys_to_dma on
> > physical addresses (including machine addresses in Xen terminology)
> > before returning them from xen_swiotlb_alloc_coherent and
> > xen_swiotlb_map_page.
> > 
> > We also need to convert dma addresses back to physical addresses using
> > dma_to_phys in xen_swiotlb_free_coherent and xen_swiotlb_unmap_page if
> > we want to do any operations on them.
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
> > Tested-by: Corey Minyard <cminyard@mvista.com>
> > Tested-by: Roman Shaposhnik <roman@zededa.com>
> > ---
> > Changes in v2:
> > - improve commit message
> > ---
> >  drivers/xen/swiotlb-xen.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index 0a6cb67f0fc4..60ef07440905 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -64,16 +64,16 @@ static inline dma_addr_t xen_phys_to_bus(struct device *dev, phys_addr_t paddr)
> >  
> >  	dma |= paddr & ~XEN_PAGE_MASK;
> >  
> > -	return dma;
> > +	return phys_to_dma(dev, dma);
> 
> So looking at this function:
> 
> The dma name for something passed to phys_to_dma is really
> weird.

Yeah, that is true, I am not sure why I chose that confusing name. I'll
rename it.


> The fact that the comments says don't use XEN_PFN_PHYS
> beause of the type mismatch while nothing but swiotlb-xen is the only
> user of XEN_PFN_PHYS is also weird.  I think XEN_PFN_PHYS needs to move
> to swiotlb-xen first, then use a hardcoded u64 for the size, and the
> split the function into a phys_to_xen_phys (or so) function where
> the result gets passed to phys_to_dma.

I understand what you are suggesting about having something like:

    xen_phys_to_dma(...)
    {
        phys_addr_t phys = xen_phys_to_bus(dev, paddr)
        return phys_to_dma(phys);
    }

I thought about it myself. I'll do it.

But I don't think I understood the comment about XEN_PFN_PHYS.


> Similar for the reverse direction.

OK
