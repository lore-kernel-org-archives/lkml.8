Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8763C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CF020675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgEEKPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:15:14 -0400
Received: from verein.lst.de ([213.95.11.211]:34449 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEEKPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:15:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A96F968C4E; Tue,  5 May 2020 12:15:08 +0200 (CEST)
Date:   Tue, 5 May 2020 12:15:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 02/25] drm: core: fix common struct sg_table related
 issues
Message-ID: <20200505101508.GA14860@lst.de>
References: <20200505083926.28503-1-m.szyprowski@samsung.com> <20200505084614.30424-1-m.szyprowski@samsung.com> <CGME20200505084625eucas1p1a3c25fd171f360e0aab2f76700699454@eucas1p1.samsung.com> <20200505084614.30424-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505084614.30424-2-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -		for_each_sg_page(st->sgl, &sg_iter, st->nents, 0)
> +		for_each_sg_page(st->sgl, &sg_iter, st->orig_nents, 0)

Would it make sense to also add a for_each_sgtable_page helper that
hides the use of orig_nents?  To be used like:

		for_each_sgtable_page(st, &sg_iter, 0) {

> +	for_each_sg(sgt->sgl, sg, sgt->orig_nents, count) {

Same here, e.g.

	for_each_sgtable_entry(sgt, sg, count) {

?
