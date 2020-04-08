Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA3FC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4552075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgDHSuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:50:01 -0400
Received: from verein.lst.de ([213.95.11.211]:43667 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbgDHSuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:50:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C976168C4E; Wed,  8 Apr 2020 20:49:58 +0200 (CEST)
Date:   Wed, 8 Apr 2020 20:49:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: fix displaying of dma allocation type
Message-ID: <20200408184958.GA9945@lst.de>
References: <20200408184804.30522-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408184804.30522-1-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 09:48:04PM +0300, Grygorii Strashko wrote:
> The commit 2e05ea5cdc1a ("dma-mapping: implement dma_map_single_attrs using
> dma_map_page_attrs") removed "dma_debug_page" enum, but missed to update
> type2name string table. This causes incorrect displaying of dma allocation
> type. Fix it by removing "page" string from type2name string table.
> 
> Before (dma_alloc_coherent()):
> k3-ringacc 4b800000.ringacc: scather-gather idx 2208 P=d1140000 N=d114 D=d1140000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
> k3-ringacc 4b800000.ringacc: scather-gather idx 2216 P=d1150000 N=d115 D=d1150000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
> 
> After:
> k3-ringacc 4b800000.ringacc: coherent idx 2208 P=d1140000 N=d114 D=d1140000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
> k3-ringacc 4b800000.ringacc: coherent idx 2216 P=d1150000 N=d115 D=d1150000 L=40 DMA_BIDIRECTIONAL dma map error check not applicable
> 
> Fixes: 2e05ea5cdc1a ("dma-mapping: implement dma_map_single_attrs using dma_map_page_attrs")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  kernel/dma/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 2031ed1ad7fa..09b85ba0c137 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -137,7 +137,7 @@ static const char *const maperr2str[] = {
>  	[MAP_ERR_CHECKED] = "dma map error checked",
>  };
>  
> -static const char *type2name[5] = { "single", "page",
> +static const char *type2name[5] = { "single",
>  				    "scather-gather", "coherent",
>  				    "resource" };

To make sure this doesn't happen anymore, can you switch to
named initializers?
