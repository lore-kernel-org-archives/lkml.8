Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C3AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C91620774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TMxv+Qz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgFIFiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgFIFiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:38:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF1DC03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TaoLQA/iHofCA82dwdTGmf/d+d6nTw1lk728rMya7LM=; b=TMxv+Qz+Z2VzON5gsdIxcbjqf1
        NzglBzFgoUfCgS+BonQq8w8owGelI6UxV7CQd8KKHRH2vrqB4gWNC4xAnUQMZ6Xk0emCuqFDDUZN8
        43aesbmuvY5m8XGuGM7eCOdKinI4Oauwq/iRDNua4u1OHm6ytKPBm9xgFYjRKwtgsn52ZTiS4Urt6
        qao/+nZoFeC5nk3/TMSQtxcz+4ABzV7wGbpujPWX0CdLINwfPpL3cI7Hjy0butd/0qS2vw4jIWxOq
        ZQwRIK6GUfhXpHZJOa3gGG/KKm0myQsIimI9mC9XHlENO5KP2QnP88nACyy5We+sRVVCRp9UFJ/zw
        QWANqufQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiWxW-0006qv-Bf; Tue, 09 Jun 2020 05:38:02 +0000
Date:   Mon, 8 Jun 2020 22:38:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        tamas@tklengyel.com, roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 10/11] xen/arm: introduce phys/dma translations in
 xen_dma_sync_for_*
Message-ID: <20200609053802.GB3015@infradead.org>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
 <20200603222247.11681-10-sstabellini@kernel.org>
 <20200608071221.GF15742@infradead.org>
 <alpine.DEB.2.21.2006081614530.2815@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2006081614530.2815@sstabellini-ThinkPad-T480s>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 05:38:28PM -0700, Stefano Stabellini wrote:
> Yeah, the pfn_valid check is a bit weird by definition because we are
> using it to understand whether the address belong to us or to another
> VM. To do the pfn_valid check we need to translate the dma address into
> something the CPU understands, hence, the dma_to_phys call.
> 
> Why can't we use the already-provided paddr? Because paddr has been
> translated twice:
> 1) from dma to maybe-foreign phys address (could be ours, or another VM)
> 2) from maybe-foreign address to local (using our local mapping of the foreign page)
> 
> In fact, it would be clearer if we had all three addresses as parameters
> of xen_dma_sync_for_cpu: the dma address, the maybe-foreign physical
> address (we tend to call it xenbus address, baddr), the local physical
> address. Something like:

I think instead we should move the arch_sync_dma_for_{device,cpu}
calls from xen_dma_sync_for_{device,cpu} into the callers, as they
are provided by the generic dma-noncoherent.h and optimized out for
coherent architectures like x86.  Then the swiotlb-xen.c code only
need to call dma_cache_maint as the interface (which would have to
grow a better name), which should then only need a single kind of
address.
