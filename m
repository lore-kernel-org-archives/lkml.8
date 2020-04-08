Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759D3C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF772075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgDHTpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:45:30 -0400
Received: from verein.lst.de ([213.95.11.211]:43872 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgDHTpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:45:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9488868C4E; Wed,  8 Apr 2020 21:45:27 +0200 (CEST)
Date:   Wed, 8 Apr 2020 21:45:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-debug: fix displaying of dma allocation type
Message-ID: <20200408194527.GA13647@lst.de>
References: <20200408194300.21426-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408194300.21426-1-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 10:43:00PM +0300, Grygorii Strashko wrote:
> +static const char *type2name[5] = {
> +	[dma_debug_single] = "single",
> +	[dma_debug_sg] = "scather-gather",
> +	[dma_debug_coherent] = "coherent",
> +	[dma_debug_resource] = "resource",
> +};

We actually only have 4, not 5 elements now (and don't really
need the sizing anyway).  But I can fix that when applying, thanks!
