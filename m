Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96E8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775ED20825
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590119690;
	bh=IOb0RQXn20mPjLvcXrm5g1uV8k0WGkYBZ/xCUkJOpgs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=OP3I9ZxTbdkeoLzkFYm0FqMyPcNNZVX0uMJHLcmDWp3/tDe6d0kcdElgGJz5eyMbA
	 tC8N6KpwDU+buvTBNH+JFO2c4Aqd3ilVA6z3QEfdQtZiuzdR4RdCeauA+ybNptItrf
	 Ipww0eYA9B1pYXMdB2+2sHjINoeApUnWb+P9CSxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgEVDyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 23:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgEVDyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 23:54:49 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7733F20759;
        Fri, 22 May 2020 03:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590119688;
        bh=IOb0RQXn20mPjLvcXrm5g1uV8k0WGkYBZ/xCUkJOpgs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=aR+s4YbN4WY3+tkkj48KZxEgCx1VjrO1vm0r1wNMQmzemwTf89enT66INgI5pVVER
         PKJNzG8Jq6pwsmDp7EOMvvfRmjTrWjeT/QV0ZXVda0Uz4aJBL5l9u4Yl1wGvrTnwnx
         0IQQAfkPycuEiV4Dv9WiJbM49iZE8D+vPYKqCvhA=
Date:   Thu, 21 May 2020 20:54:47 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Julien Grall <julien@xen.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH 01/10] swiotlb-xen: use vmalloc_to_page on vmalloc virt
 addresses
In-Reply-To: <23e5b6d8-c5d9-b43f-41cd-9d02d8ec0a7f@xen.org>
Message-ID: <alpine.DEB.2.21.2005211235590.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s> <20200520234520.22563-1-sstabellini@kernel.org> <23e5b6d8-c5d9-b43f-41cd-9d02d8ec0a7f@xen.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020, Julien Grall wrote:
> Hi,
> 
> On 21/05/2020 00:45, Stefano Stabellini wrote:
> > From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > 
> > Don't just assume that virt_to_page works on all virtual addresses.
> > Instead add a is_vmalloc_addr check and use vmalloc_to_page on vmalloc
> > virt addresses.
> 
> Can you provide an example where swiotlb is used with vmalloc()?

The issue was reported here happening on the Rasperry Pi 4:
https://marc.info/?l=xen-devel&m=158862573216800

If you are asking where in the Linux codebase the vmalloc is happening
specifically, I don't know for sure, my information is limited to the
stack trace that you see in the link (I don't have a Rasperry Pi 4 yet
but I shall have one soon.)


> > Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > ---
> >   drivers/xen/swiotlb-xen.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index b6d27762c6f8..a42129cba36e 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -335,6 +335,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t
> > size, void *vaddr,
> >   	int order = get_order(size);
> >   	phys_addr_t phys;
> >   	u64 dma_mask = DMA_BIT_MASK(32);
> > +	struct page *pg;
> >     	if (hwdev && hwdev->coherent_dma_mask)
> >   		dma_mask = hwdev->coherent_dma_mask;
> > @@ -346,9 +347,11 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t
> > size, void *vaddr,
> >   	/* Convert the size to actually allocated. */
> >   	size = 1UL << (order + XEN_PAGE_SHIFT);
> >   +	pg = is_vmalloc_addr(vaddr) ? vmalloc_to_page(vaddr) :
> > +				      virt_to_page(vaddr);
> 
> Common DMA code seems to protect this check with CONFIG_DMA_REMAP. Is it
> something we want to do it here as well? Or is there any other condition where
> vmalloc can happen?

I can see it in dma_direct_free_pages:

	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr))
		vunmap(cpu_addr);

I wonder why the common DMA code does that. is_vmalloc_addr should work
regardless of CONFIG_DMA_REMAP. Maybe just for efficiency?
