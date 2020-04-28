Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E00C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB33A206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgD1ODB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:03:01 -0400
Received: from verein.lst.de ([213.95.11.211]:56414 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgD1ODA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:03:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7569968CEC; Tue, 28 Apr 2020 16:02:57 +0200 (CEST)
Date:   Tue, 28 Apr 2020 16:02:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC 00/17] DRM: fix struct sg_table nents vs. orig_nents
 misuse
Message-ID: <20200428140257.GA3433@lst.de>
References: <CGME20200428132022eucas1p2aa4716cbaca61c432ee8028be15fef7a@eucas1p2.samsung.com> <20200428132005.21424-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 03:19:48PM +0200, Marek Szyprowski wrote:
> 1. introduce a dma_{map,sync,unmap}_sgtable() wrappers, which will use
>    a proper sg_table entries and call respective DMA-mapping functions
>    and adapt current code to it

That sounds reasonable to me.  Those could be pretty trivial wrappers.

>
> 
> 2. rename nents and orig_nents to nr_pages, nr_dmas to clearly state
>    which one refers to which part of the scatterlist; I'm open for
>    other names for those entries

nr_cpu_ents and nr_dma_ents might be better names, but it still would be
a whole lot of churn for little gain.  I think just good wrappers like
suggested above might be more helpful.
