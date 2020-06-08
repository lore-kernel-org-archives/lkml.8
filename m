Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B30DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6AE206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591656848;
	bh=aFtqwt+bYOZhJ7U9irm3TzEiOtvg48f3YiInMbcBYs0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=R6KfbZc9nGVo+2wbeUCFbcT5UkXsA5WtWqZcb+tfIuhCpOYYZ9rzzzGtbcW73pcEP
	 at2bVoM1KlncUPobQOW8NJAd+mFeVnpdzDNZo28nB/y0F3FLHVlmCL+2mFND+vf9WW
	 G1Xl7FxoQc0WYFmKFusymotKY8SSEjv81Jv6XXcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgFHWyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgFHWyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:54:00 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A0DD2076A;
        Mon,  8 Jun 2020 22:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591656839;
        bh=aFtqwt+bYOZhJ7U9irm3TzEiOtvg48f3YiInMbcBYs0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sV9brVTS0fbsMYHJ/0OiYUYepwLpKHZZvVEPsCcTclhj201DpvYC6IxwM1XDwdEIe
         K1aFJ5vaHAov9BwrlY9IHX4mYNHZkTNxt1DgO7EyhoVEcdrayUCUJJ00a6kr5y+QET
         7Agxg++7d8MkC5wB88ZPCM3NNvh4ps0v1mIPE2Lo=
Date:   Mon, 8 Jun 2020 15:53:58 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@infradead.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        tamas@tklengyel.com, roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 01/11] swiotlb-xen: use vmalloc_to_page on vmalloc
 virt addresses
In-Reply-To: <20200608070411.GA15742@infradead.org>
Message-ID: <alpine.DEB.2.21.2006081539110.2815@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s> <20200603222247.11681-1-sstabellini@kernel.org> <20200608070411.GA15742@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thanks you for the review.


On Mon, 8 Jun 2020, Christoph Hellwig wrote:
> Well, this isn't just RPi4, but basically any ARM or ARM64 system
> with non-coherent DMA (which is most of them).

Well... yes :-)


> > +	struct page *pg;
> 
> Please spell out page.

OK


> >  
> >  	if (hwdev && hwdev->coherent_dma_mask)
> >  		dma_mask = hwdev->coherent_dma_mask;
> > @@ -346,9 +347,11 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
> >  	/* Convert the size to actually allocated. */
> >  	size = 1UL << (order + XEN_PAGE_SHIFT);
> >  
> > +	pg = is_vmalloc_addr(vaddr) ? vmalloc_to_page(vaddr) :
> > +				      virt_to_page(vaddr);
> 
> Please use plain old if/else to make this more readable.

Sure
