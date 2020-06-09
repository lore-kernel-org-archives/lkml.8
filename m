Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA58C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9718920737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591739450;
	bh=n8q6RBqf99l7e7L1EOCdjDHHs3POGMUOsceVpb6TqsY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=JhsmZ1SVCB5doAgfZxPHUsdcBJJbVUHgUagqq/O3NXb6YSBqBsuW9p1Ke/Yr7XSDE
	 nA1x/gHBTJOYTDbUW+ZeE/MppM/R/RpjnQomol9rb/3JtDF6IQUZ7r0QrhXbyQXdje
	 ciuGMcuEBTcg1QtTJpWYZWDhWLdpuPOiSeZ+2a8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgFIVus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgFIVus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:50:48 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA98B206D5;
        Tue,  9 Jun 2020 21:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591739448;
        bh=n8q6RBqf99l7e7L1EOCdjDHHs3POGMUOsceVpb6TqsY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lVBxOO94oJCocVzgGYmxBV/gu6l2FaYei13cIzYMryQHWhbZi9YaLr7cUz1MLaG/w
         0bRbjImP1w5xBQtTIIuvOMS2PPZMzHArb4ACkNEFsb07qxEhJdHgvYjszfQY3Gfyp9
         iAYY4qIeIYOHSZ7he94+zdY72e7wCdtwCk17qwBM=
Date:   Tue, 9 Jun 2020 14:50:46 -0700 (PDT)
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
In-Reply-To: <20200609053240.GA3015@infradead.org>
Message-ID: <alpine.DEB.2.21.2006091246350.2815@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s> <20200603222247.11681-8-sstabellini@kernel.org> <20200608070850.GD15742@infradead.org> <alpine.DEB.2.21.2006081558400.2815@sstabellini-ThinkPad-T480s>
 <20200609053240.GA3015@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020, Christoph Hellwig wrote:
> On Mon, Jun 08, 2020 at 04:06:57PM -0700, Stefano Stabellini wrote:
> > I understand what you are suggesting about having something like:
> > 
> >     xen_phys_to_dma(...)
> >     {
> >         phys_addr_t phys = xen_phys_to_bus(dev, paddr)
> >         return phys_to_dma(phys);
> >     }
> > 
> > I thought about it myself. I'll do it.
> 
> "something", yes. Except that I think the bus is a little confusing,
> isn't it?  What is the Xen term for these addresses?

Xen reasons in terms of frame numbers. Xen calls them "dfn" for device
frame number. They were supposed to be called "bfn" but eventually they
settled for a different name when the series was committed.

I could s/bfn/dfn/g to match the terminology, if that helps.


> Also we probably don't need the extra local variable.

Sure


> > But I don't think I understood the comment about XEN_PFN_PHYS.
> 
> There is a comment above xen_phys_to_bus that it avoids using
> XEN_PFN_PHYS because XEN_PFN_PHYS of the phys_addr_t vs dma_addr_t
> mismatch.  But XEN_PFN_PHYS could just use a u64 instead of the
> phys_addr_t and then we could use it.   Especially as XEN_PFN_PHYS
> isn't actually used anywhere except in swiotlb-xen.c.  Or we could
> remove XEN_PFN_PHYS enirely, as it isn't all that useful to start
> with.

I'll remove it.
