Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C756C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D8B206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgEHHQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:16:14 -0400
Received: from verein.lst.de ([213.95.11.211]:50872 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgEHHQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:16:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AFF1B68B05; Fri,  8 May 2020 09:16:09 +0200 (CEST)
Date:   Fri, 8 May 2020 09:16:09 +0200
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
Message-ID: <20200508071609.GA31690@lst.de>
References: <20200505083926.28503-1-m.szyprowski@samsung.com> <20200505084614.30424-1-m.szyprowski@samsung.com> <CGME20200505084625eucas1p1a3c25fd171f360e0aab2f76700699454@eucas1p1.samsung.com> <20200505084614.30424-2-m.szyprowski@samsung.com> <20200505101508.GA14860@lst.de> <5dd1cb55-accb-0dc6-4ca5-90c57cd19527@samsung.com> <20200505110950.GA19067@lst.de> <b887c355-14db-ad37-0e93-733ff2249967@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b887c355-14db-ad37-0e93-733ff2249967@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 09:12:13AM +0200, Marek Szyprowski wrote:
> Then we would just need one more helper to construct scatterlist, as the 
> above two are read-only don't allow to modify scatterlist:
> 
> #define for_each_sgtable_sg(sgt, sg, i)                \
>         for_each_sg(sgt->sgl, sg, sgt->orig_nents, i)
> 
> With the above 3 helpers we can probably get rid of all instances of 
> sg_table->{nents,orig_nents} from the DRM code. I will prepare patches soon.

Sounds great, thanks!
