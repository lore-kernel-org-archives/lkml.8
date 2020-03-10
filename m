Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BFAC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C8A20873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCJSro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:47:44 -0400
Received: from verein.lst.de ([213.95.11.211]:54558 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbgCJSrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:47:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2A66068BE1; Tue, 10 Mar 2020 19:47:41 +0100 (CET)
Date:   Tue, 10 Mar 2020 19:47:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [rfc 5/6] dma-direct: atomic allocations must come from
 unencrypted pools
Message-ID: <20200310184740.GA9745@lst.de>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011538040.213582@chino.kir.corp.google.com> <20200305154456.GC5332@lst.de> <alpine.DEB.2.21.2003061623060.27928@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003061623060.27928@chino.kir.corp.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:36:07PM -0800, David Rientjes wrote:
> As a preliminary change to this series, I could move the atomic pools and 
> coherent_pool command line to a new kernel/dma/atomic_pools.c file with a 
> new CONFIG_DMA_ATOMIC_POOLS that would get "select"ed by CONFIG_DMA_REMAP 
> and CONFIG_AMD_MEM_ENCRYPT and call into dma_common_contiguous_remap() if 
> we have CONFIG_DMA_DIRECT_REMAP when adding pages to the pool.

Yes.  Although I'd just name it kernel/dma/pool.c and
CONFIG_DMA_COHERENT_POOL or so, as I plan to reuse the code for
architectures that just preallocate all coherent memory at boot time
as well.

> I think that's what you mean by splitting the pool from remapping, 
> otherwise we still have a full CONFIG_DMA_REMAP dependency here.  If you 
> had something else in mind, please let me know.  Thanks!

Yes, that is exactly what I meant.
