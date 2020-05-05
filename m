Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF9DC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B5A206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgEELJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:09:54 -0400
Received: from verein.lst.de ([213.95.11.211]:34758 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728756AbgEELJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:09:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A89768C4E; Tue,  5 May 2020 13:09:50 +0200 (CEST)
Date:   Tue, 5 May 2020 13:09:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 02/25] drm: core: fix common struct sg_table related
 issues
Message-ID: <20200505110950.GA19067@lst.de>
References: <20200505083926.28503-1-m.szyprowski@samsung.com> <20200505084614.30424-1-m.szyprowski@samsung.com> <CGME20200505084625eucas1p1a3c25fd171f360e0aab2f76700699454@eucas1p1.samsung.com> <20200505084614.30424-2-m.szyprowski@samsung.com> <20200505101508.GA14860@lst.de> <5dd1cb55-accb-0dc6-4ca5-90c57cd19527@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd1cb55-accb-0dc6-4ca5-90c57cd19527@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 12:51:58PM +0200, Marek Szyprowski wrote:
> Hi Christoph,
> 
> On 05.05.2020 12:15, Christoph Hellwig wrote:
> >> -		for_each_sg_page(st->sgl, &sg_iter, st->nents, 0)
> >> +		for_each_sg_page(st->sgl, &sg_iter, st->orig_nents, 0)
> > Would it make sense to also add a for_each_sgtable_page helper that
> > hides the use of orig_nents?  To be used like:
> >
> > 		for_each_sgtable_page(st, &sg_iter, 0) {
> 
> We would need two helpers:
> 
> for_each_sgtable_cpu_page() and for_each_sgtable_dma_page().
> 
> I considered them, but then I found that there are already 
> for_each_sg_page(), for_each_sg_dma_page() and various special iterators 
> like sg_page_iter, sg_dma_page_iter and sg_mapping_iter. Too bad that 
> they are almost not used, at least in the DRM subsystem. I wonder if it 
> make sense to apply them or simply provide the two above mentioned 
> wrappers?

None of the helpers helps with passing the right parameters from the
sg_table.  So in doube we'd need wrappers for all of the above, or
none..
