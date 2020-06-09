Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28642C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C602072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663117;
	bh=dZEsuHc63lSqJBCxvHs+BfEmnrOBWd5r93zBgTcjIfE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=RJKcVA/shh5FjnRNL48JQ8nMrfbNVs73Hxu9ghwaWaTFdeGvE+ByxyrE0jD58aF1U
	 9cXgMOcbtKTAWBOYaBy+abPBGl3c18l5p/JCpLNVMT2qZRw2l8QEOByYjpmwm9e/T+
	 Djhy4MPK/7CDLxg9QIueRMOhRs7F1WkKGuI219Uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgFIAig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgFIAia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:38:30 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF5F207ED;
        Tue,  9 Jun 2020 00:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591663109;
        bh=dZEsuHc63lSqJBCxvHs+BfEmnrOBWd5r93zBgTcjIfE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=zmKl2ZEkH3EPkdd/jdWO6poHzl1BGkaJeJqk7D8IWfcwf0Oy+viDzCfDk0hL7we2P
         ZJgWIIVk9+QTjD+rtMZELhnH2B5Qf0fORt1zwpbXbC6xxcsEeq1IDhEyN/iT784RaK
         kOjRS48WEd1Wq7jjCOild9hhx4Jod2X0IvbE8uII=
Date:   Mon, 8 Jun 2020 17:38:28 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@infradead.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        tamas@tklengyel.com, roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 10/11] xen/arm: introduce phys/dma translations in
 xen_dma_sync_for_*
In-Reply-To: <20200608071221.GF15742@infradead.org>
Message-ID: <alpine.DEB.2.21.2006081614530.2815@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s> <20200603222247.11681-10-sstabellini@kernel.org> <20200608071221.GF15742@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020, Christoph Hellwig wrote:
> On Wed, Jun 03, 2020 at 03:22:46PM -0700, Stefano Stabellini wrote:
> > From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > 
> > xen_dma_sync_for_cpu, xen_dma_sync_for_device, xen_arch_need_swiotlb are
> > getting called passing dma addresses. On some platforms dma addresses
> > could be different from physical addresses. Before doing any operations
> > on these addresses we need to convert them back to physical addresses
> > using dma_to_phys.
> > 
> > Add dma_to_phys calls to xen_dma_sync_for_cpu, xen_dma_sync_for_device,
> > and xen_arch_need_swiotlb.
> > 
> > dma_cache_maint is fixed by the next patch.
> 
> The calling conventions because really weird now because
> xen_dma_sync_for_{device,cpu} already get both a phys_addr_t and
> a dma_addr_t.  
> 
> > 
> > -	if (pfn_valid(PFN_DOWN(handle)))
> > +	if (pfn_valid(PFN_DOWN(dma_to_phys(dev, handle))))
> 
> But here we translate the dma address to a phys addr
> 
> >  		arch_sync_dma_for_cpu(paddr, size, dir);
> 
> While this still uses the passed in paddr.  I think the uses of
> addresses in this code really needs a major rethink.


Yeah, the pfn_valid check is a bit weird by definition because we are
using it to understand whether the address belong to us or to another
VM. To do the pfn_valid check we need to translate the dma address into
something the CPU understands, hence, the dma_to_phys call.

Why can't we use the already-provided paddr? Because paddr has been
translated twice:
1) from dma to maybe-foreign phys address (could be ours, or another VM)
2) from maybe-foreign address to local (using our local mapping of the foreign page)

In fact, it would be clearer if we had all three addresses as parameters
of xen_dma_sync_for_cpu: the dma address, the maybe-foreign physical
address (we tend to call it xenbus address, baddr), the local physical
address. Something like:


void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
			  phys_addr_t baddr, phys_addr_t paddr, size_t size,
			  enum dma_data_direction dir)
{
	if (pfn_valid(baddr))
		arch_sync_dma_for_cpu(paddr, size, dir);
	else if (dir != DMA_TO_DEVICE)
		dma_cache_maint(dev, handle, size, GNTTAB_CACHE_INVAL);
}
