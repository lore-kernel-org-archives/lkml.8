Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B86C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 818D42078D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590180470;
	bh=ABXEd3vc08BMg4ogCVIQEmBIL34CZ7hlNe8SZ9PbUAg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=poYZdOjoCTOS4A0Px3TSIdcz4qdnxAiyT2KgOAE9DLJcUwl/VIlX8U7LoLGuIJHto
	 nJRVVpBexGKqGGQmxnTafe+nR1dgvKiQworXHI618ccoi2xoNhKTOLT6rok7qHpNrI
	 R2jMJKDCFOGBJjpIEAxaegOwGI2+hEdSqUOxO78w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgEVUrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730946AbgEVUrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:47:49 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A1C20723;
        Fri, 22 May 2020 20:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590180468;
        bh=ABXEd3vc08BMg4ogCVIQEmBIL34CZ7hlNe8SZ9PbUAg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=QBQVmp1VQZ2dAmCNmxEI92dXe8V0WuRDH3d/aYG8pRWxtwKEeupy1RLtLeK0fqVGJ
         yH0YKWXQ2E1JqwtNUKz1bfqrKnayppYXP5JBYeNJZVX+JM4GetGxI8H2+TPmrB1hHL
         Dext8r1i2WPfHkst+1gu6kSoUmo/96C3RHGFAxus=
Date:   Fri, 22 May 2020 13:47:47 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Julien Grall <julien@xen.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH 02/10] swiotlb-xen: remove start_dma_addr
In-Reply-To: <ab89bf08-a02f-85af-8f83-6a851d72ccf2@xen.org>
Message-ID: <alpine.DEB.2.21.2005221336530.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s> <20200520234520.22563-2-sstabellini@kernel.org> <6241b8f6-5c51-0486-55ae-d571b117a184@xen.org> <alpine.DEB.2.21.2005211243060.27502@sstabellini-ThinkPad-T480s>
 <ab89bf08-a02f-85af-8f83-6a851d72ccf2@xen.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020, Julien Grall wrote:
> On 22/05/2020 04:55, Stefano Stabellini wrote:
> > On Thu, 21 May 2020, Julien Grall wrote:
> > > Hi,
> > > 
> > > On 21/05/2020 00:45, Stefano Stabellini wrote:
> > > > From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > > > 
> > > > It is not strictly needed. Call virt_to_phys on xen_io_tlb_start
> > > > instead. It will be useful not to have a start_dma_addr around with the
> > > > next patches.
> > > > 
> > > > Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > > > ---
> > > >    drivers/xen/swiotlb-xen.c | 5 +----
> > > >    1 file changed, 1 insertion(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > > > index a42129cba36e..b5e0492b07b9 100644
> > > > --- a/drivers/xen/swiotlb-xen.c
> > > > +++ b/drivers/xen/swiotlb-xen.c
> > > > @@ -52,8 +52,6 @@ static unsigned long xen_io_tlb_nslabs;
> > > >     * Quick lookup value of the bus address of the IOTLB.
> > > >     */
> > > >    -static u64 start_dma_addr;
> > > > -
> > > >    /*
> > > >     * Both of these functions should avoid XEN_PFN_PHYS because
> > > > phys_addr_t
> > > >     * can be 32bit when dma_addr_t is 64bit leading to a loss in
> > > > @@ -241,7 +239,6 @@ int __ref xen_swiotlb_init(int verbose, bool early)
> > > >    		m_ret = XEN_SWIOTLB_EFIXUP;
> > > >    		goto error;
> > > >    	}
> > > > -	start_dma_addr = xen_virt_to_bus(xen_io_tlb_start);
> > > >    	if (early) {
> > > >    		if (swiotlb_init_with_tbl(xen_io_tlb_start,
> > > > xen_io_tlb_nslabs,
> > > >    			 verbose))
> > > > @@ -389,7 +386,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device
> > > > *dev, struct page *page,
> > > >    	 */
> > > >    	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
> > > >    -	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys,
> > > > +	map = swiotlb_tbl_map_single(dev, virt_to_phys(xen_io_tlb_start),
> > > > phys,
> > > 
> > > xen_virt_to_bus() is implemented as xen_phys_to_bus(virt_to_phys()). Can
> > > you
> > > explain how the two are equivalent?
> > 
> > They are not equivalent. Looking at what swiotlb_tbl_map_single expects,
> > and also the implementation of swiotlb_init_with_tbl, I think
> > virt_to_phys is actually the one we want.
> > 
> > swiotlb_tbl_map_single compares the argument with __pa(tlb) which is
> > __pa(xen_io_tlb_start) which is virt_to_phys(xen_io_tlb_start).
> 
> I can't find such check in master. What is your baseline? Could you point to
> the exact line of code?

My base is b85051e755b0e9d6dd8f17ef1da083851b83287d, which is master
from a couple of days back.


xen_swiotlb_init calls swiotlb_init_with_tbl which takes a virt address
as a parameter (xen_io_tlb_start), it gets converted to phys and stored
in io_tlb_start as a physical address.

Later, xen_swiotlb_map_page calls swiotlb_tbl_map_single passing a
dma addr as parameter (tbl_dma_addr). tbl_dma_addr is used to calculate
the right slot in the swiotlb buffer to use. (Strangely tbl_dma_addr is
a dma_addr_t and it is not converted to phys_addr_t before doing
operations... I think tbl_dma_addr should be a phys addr.)

The comparison with io_tlb_start is done here:

	do {
		while (iommu_is_span_boundary(index, nslots, offset_slots,
					      max_slots)) {
			index += stride;
			if (index >= io_tlb_nslabs)
				index = 0;
			if (index == wrap)
				goto not_found;
		}

index is io_tlb_start and offset_slots is derived by tbl_dma_addr.
