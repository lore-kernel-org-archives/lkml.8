Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E630C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A142067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgFOG43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:56:29 -0400
Received: from verein.lst.de ([213.95.11.211]:59842 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbgFOG43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:56:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C8E768B05; Mon, 15 Jun 2020 08:56:26 +0200 (CEST)
Date:   Mon, 15 Jun 2020 08:56:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [patch for-5.8 2/4] dma-direct: re-encrypt memory if
 dma_direct_alloc_pages() fails
Message-ID: <20200615065625.GB21248@lst.de>
References: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com> <alpine.DEB.2.22.394.2006111219200.153880@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006111219200.153880@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 12:20:29PM -0700, David Rientjes wrote:
> If arch_dma_set_uncached() fails after memory has been decrypted, it needs
> to be re-encrypted before freeing.
> 
> Fixes: fa7e2247c572 ("dma-direct: make uncached_kernel_address more
> general")
> Cc: stable@vger.kernel.org # 5.7
> Signed-off-by: David Rientjes <rientjes@google.com>

Note that this can't really happen in practice as
CONFIG_ARCH_HAS_DMA_SET_UNCACHED and memory encryption are mutally
exclusive in pracrie.  Still looks ok and useful otherwise.
