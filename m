Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F283AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75F7208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgHTPtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:49:50 -0400
Received: from verein.lst.de ([213.95.11.211]:42808 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbgHTPto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:49:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 617AF68AFE; Thu, 20 Aug 2020 17:49:41 +0200 (CEST)
Date:   Thu, 20 Aug 2020 17:49:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: boot failure after merge of the dma-mapping tree
Message-ID: <20200820154941.GA11349@lst.de>
References: <20200820155112.29459f41@canb.auug.org.au> <20200820083617.GA6124@Asurada>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820083617.GA6124@Asurada>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 01:36:17AM -0700, Nicolin Chen wrote:
> Took a quick look -- the boundary_size is seemingly passed from
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/powerpc/kernel/iommu.c#n240
> 
> 	boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
> 			1 << tbl->it_page_shift);
> 
> Looks like an overflow happens due to (ULONG_MAX + 1). Should
> we fix here instead (or also)?

Yes, please.  I'll drop the patch again for now, but once we've
got this sorted out I'll readd it.
