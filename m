Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DC7C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D815320784
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgDHPm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:42:28 -0400
Received: from verein.lst.de ([213.95.11.211]:42929 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgDHPm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:42:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 313AE68C4E; Wed,  8 Apr 2020 17:42:26 +0200 (CEST)
Date:   Wed, 8 Apr 2020 17:42:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/28] dma-mapping: use vmap insted of reimplementing it
Message-ID: <20200408154225.GA28676@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200408131736.9532-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408131736.9532-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 09:17:36PM +0800, Hillf Danton wrote:
> > @@ -62,24 +42,20 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
> >  void *dma_common_contiguous_remap(struct page *page, size_t size,
> >  			pgprot_t prot, const void *caller)
> >  {
> > -	int i;
> > +	int count = size >> PAGE_SHIFT;
> >  	struct page **pages;
> > -	struct vm_struct *area;
> > +	void *vaddr;
> > +	int i;
> >  
> > -	pages = kmalloc(sizeof(struct page *) << get_order(size), GFP_KERNEL);
> > +	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> 
> Is it making sense to vmalloc pages as long as array size is bigger than
> PAGE_SIZE?

Maybe, maybe not.  But it certainly doesn't fit this series.
