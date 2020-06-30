Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2549C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870742073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbgF3KJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbgF3KJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:09:51 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D16C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:09:51 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 88B422A7; Tue, 30 Jun 2020 12:09:49 +0200 (CEST)
Date:   Tue, 30 Jun 2020 12:09:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: SUN50I_IOMMU should depend on HAS_DMA
Message-ID: <20200630100947.GL28824@8bytes.org>
References: <20200629121146.24011-1-geert@linux-m68k.org>
 <c2047394-ea6e-3bc3-4bf0-a732237dbeca@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2047394-ea6e-3bc3-4bf0-a732237dbeca@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 05:29:36PM +0100, Robin Murphy wrote:
> On 2020-06-29 13:11, Geert Uytterhoeven wrote:
> > If NO_DMA=y (e.g. Sun-3 all{mod,yes}-config):
> > 
> >      drivers/iommu/dma-iommu.o: In function `iommu_dma_mmap':
> >      dma-iommu.c:(.text+0x92e): undefined reference to `dma_pgprot'
> > 
> > IOMMU_DMA must not be selected, unless HAS_DMA=y.
> 
> Wait, no, IOMMU_DMA should not be selected by drivers at all - it's for arch
> code to choose.

Okay, but that is a different fix, right? I queued this patch for v5.8
for now.
