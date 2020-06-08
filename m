Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E120DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FF12076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qKLVusHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgFHHM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgFHHMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:12:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D00C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 00:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=emLpIRFKODtAY8nraJqoNKwCIZphU+FBPDM0NtY/3Cg=; b=qKLVusHbJYznuKqC4wYTwNYxiq
        Xb6vUmAIBx0gFjK3PxshUq4aOfkih9+uu++SCVrvyUUF5llRcys6YJGKrp517NSaA1JJZ7bNS+09r
        tXPPUoOVLkozSIBGBOEzhUFUoCkjs9Hg8EpdQGxOKEi4WxCluYOlXDbEJSOUbc6v0ItEHJ/I3jaBs
        Dv89DRKpkXZiuuiTOZHep+TxL8cYs4ex18Xqp94Rx+vbQJpwXr/VaHpkErBL23hnksk3bs5mByiAh
        SgBM5UQujchw6Unrh83lvTzP8E86P7LrQhjrwnpE3ZZd1kHV2+IssHu6Jh2EeGhfooWhxvL/aTlgc
        WenzY0Ng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiBxF-0006OS-9X; Mon, 08 Jun 2020 07:12:21 +0000
Date:   Mon, 8 Jun 2020 00:12:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com,
        roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 10/11] xen/arm: introduce phys/dma translations in
 xen_dma_sync_for_*
Message-ID: <20200608071221.GF15742@infradead.org>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
 <20200603222247.11681-10-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603222247.11681-10-sstabellini@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 03:22:46PM -0700, Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> xen_dma_sync_for_cpu, xen_dma_sync_for_device, xen_arch_need_swiotlb are
> getting called passing dma addresses. On some platforms dma addresses
> could be different from physical addresses. Before doing any operations
> on these addresses we need to convert them back to physical addresses
> using dma_to_phys.
> 
> Add dma_to_phys calls to xen_dma_sync_for_cpu, xen_dma_sync_for_device,
> and xen_arch_need_swiotlb.
> 
> dma_cache_maint is fixed by the next patch.

The calling conventions because really weird now because
xen_dma_sync_for_{device,cpu} already get both a phys_addr_t and
a dma_addr_t.  

> 
> -	if (pfn_valid(PFN_DOWN(handle)))
> +	if (pfn_valid(PFN_DOWN(dma_to_phys(dev, handle))))

But here we translate the dma address to a phys addr

>  		arch_sync_dma_for_cpu(paddr, size, dir);

While this still uses the passed in paddr.  I think the uses of
addresses in this code really needs a major rethink.
