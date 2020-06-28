Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3429C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC32720768
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgF1HYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:24:50 -0400
Received: from verein.lst.de ([213.95.11.211]:55606 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgF1HYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:24:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1D36368AFE; Sun, 28 Jun 2020 09:24:47 +0200 (CEST)
Date:   Sun, 28 Jun 2020 09:24:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Landley <rob@landley.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-ID: <20200628072446.GB16344@lst.de>
References: <20200626080717.1999041-1-hch@lst.de> <20200626080717.1999041-10-hch@lst.de> <e908f620-62b8-f106-a1a8-9887f50216fd@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e908f620-62b8-f106-a1a8-9887f50216fd@landley.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 08:01:17PM -0500, Rob Landley wrote:
> On 6/26/20 3:07 AM, Christoph Hellwig wrote:
> > The code handling non-coherent DMA depends on being able to remap code
> > as non-cached.  But that can't be done without an MMU, so using this
> > option on NOMMU builds is broken.
> 
> I'm working on a nommu j-core board that's doing DMA behind the OS's back at the
> moment, which I have a todo item to teach the kernel about. The DMA does not go
> through the cache, there's currently a cache flush before looking at the result
> instead.
> 
> How should this be wired up after your patch?

The problem with nommu and non-coherent dma is the dma_alloc_coherent
calls.  Most platforms with an mmu set a nocache bit through the page
tables (including sh), but that option obviously doesn't exist for
nommu.  Some hardware has an uncached window where access is uncached
automatically if access through specific kernel virtual addresses,
for that the architecture needs to impement the arch_dma_set_uncached
helper and select CONFIG_ARCH_HAS_DMA_SET_UNCACHED.  If that also
doesn't exist you'll need some sort of pool of always uncached
memory (set by the firmware or early startup code).  That currently
doesn't exist in generic code, but we have a bunch of architectures
implementing that in arch_dma_alloc.  I plan to have a common
implementation of the pool soon hopefully.

Streaming DMA just works if you reuse the existing
arch_sync_dma_for_device implementation.
