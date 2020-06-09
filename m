Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4888EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252A520774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g1VsEAhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgFIFjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIFjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:39:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06906C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9d5I29beiuD8NWd2IsPtQEkt8LGPlWEkqusG+bWe9Kc=; b=g1VsEAhWGLq6aDTVOGdfeDkonX
        y1gSr98rgZ2hcxCxV2zauJeM6hdWqvsFQnaSSQijOhtGEoNVA1aa07WMA42IHEOMq/RDPmo8hSeGi
        pSUOrrie20eynxqznnGZXRmEu1/qMjG58X0vq16YJiVur+7QfzhxYdh5LepnWkJE+y5Q2YhkQtlnN
        f+kBccJFktcR9xtsq7y6zdcC/88HnUpcCFZZumhRWXz6fTNUYIiGw1gf1PjM+9l6RRrNGSXBRyODQ
        Sq35sayJTmQD1/WhSvbwCL5ruGavLLTd3hYDtD9ueSN+BLG5UPao6Wl5u0Sf3OSSe+KU5/xRDXFQi
        YiB520Nw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiWzF-0006xo-UR; Tue, 09 Jun 2020 05:39:49 +0000
Date:   Mon, 8 Jun 2020 22:39:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        tamas@tklengyel.com, roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 10/11] xen/arm: introduce phys/dma translations in
 xen_dma_sync_for_*
Message-ID: <20200609053949.GA26473@infradead.org>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
 <20200603222247.11681-10-sstabellini@kernel.org>
 <20200608071221.GF15742@infradead.org>
 <alpine.DEB.2.21.2006081614530.2815@sstabellini-ThinkPad-T480s>
 <20200609053802.GB3015@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609053802.GB3015@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 10:38:02PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 08, 2020 at 05:38:28PM -0700, Stefano Stabellini wrote:
> > Yeah, the pfn_valid check is a bit weird by definition because we are
> > using it to understand whether the address belong to us or to another
> > VM. To do the pfn_valid check we need to translate the dma address into
> > something the CPU understands, hence, the dma_to_phys call.
> > 
> > Why can't we use the already-provided paddr? Because paddr has been
> > translated twice:
> > 1) from dma to maybe-foreign phys address (could be ours, or another VM)
> > 2) from maybe-foreign address to local (using our local mapping of the foreign page)
> > 
> > In fact, it would be clearer if we had all three addresses as parameters
> > of xen_dma_sync_for_cpu: the dma address, the maybe-foreign physical
> > address (we tend to call it xenbus address, baddr), the local physical
> > address. Something like:
> 
> I think instead we should move the arch_sync_dma_for_{device,cpu}
> calls from xen_dma_sync_for_{device,cpu} into the callers, as they
> are provided by the generic dma-noncoherent.h and optimized out for
> coherent architectures like x86.  Then the swiotlb-xen.c code only
> need to call dma_cache_maint as the interface (which would have to
> grow a better name), which should then only need a single kind of
> address.

... actually I'd keep the xen_dma_sync_for_{device,cpu} names for the
low-level interface, just move the arch_sync_dma_for_{device,cpu}
calls up.
