Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CDBC2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CA6249E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgDFRRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:17:10 -0400
Received: from verein.lst.de ([213.95.11.211]:34502 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgDFRRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:17:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0319068BEB; Mon,  6 Apr 2020 19:17:06 +0200 (CEST)
Date:   Mon, 6 Apr 2020 19:17:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200406171706.GA3231@lst.de>
References: <87sghz2ibh.fsf@linux.ibm.com> <20200323172256.GB31269@lst.de> <ffce1af6-a215-dee8-7b5c-2111f43accfd@ozlabs.ru> <20200324075402.GJ23447@lst.de> <41975da3-3a4a-fc3c-2b90-8d607cf220e6@ozlabs.ru> <20200325083740.GC21605@lst.de> <a705afc5-779d-baf4-e5d2-e2da04c82743@ozlabs.ru> <213b0c7d-f908-b4f4-466d-6240c3622cd6@ozlabs.ru> <20200406115016.GA10941@lst.de> <348046e7-7a38-62d6-4df0-e4a537b98926@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <348046e7-7a38-62d6-4df0-e4a537b98926@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 11:25:09PM +1000, Alexey Kardashevskiy wrote:
> >> Do you see any serious problem with this approach? Thanks!
> > 
> > Do you have a link to the whole branch?  The github UI is unfortunately
> > unusable for that (or I'm missing something).
> 
> The UI shows the branch but since I rebased and forcepushed it, it does
> not. Here is the current one with:
> 
> https://github.com/aik/linux/commits/dma-bypass.3

Ok, so we use the core bypass without persistent memory, and then
have another bypass mode on top.  Not great, but I can't think
of anything better.  Note that your checks for the map_sg case
aren't very efficient - for one it would make sense to calculate
the limit only once, but also it would make sense to reuse the
calculted diecect mapping addresses instead of doing another pass
later on in the dma-direct code.
