Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6B3CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47363204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbgEMNrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:47:45 -0400
Received: from verein.lst.de ([213.95.11.211]:46653 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgEMNro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:47:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 643AB68BEB; Wed, 13 May 2020 15:47:41 +0200 (CEST)
Date:   Wed, 13 May 2020 15:47:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v5 00/38] DRM: fix struct sg_table nents vs. orig_nents
 misuse
Message-ID: <20200513134741.GA12712@lst.de>
References: <CGME20200513132127eucas1p23f6be10bbd627e69e36d2451068b3204@eucas1p2.samsung.com> <20200513132114.6046-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513132114.6046-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've pushed out a branch with the first three patches here:

   git://git.infradead.org/users/hch/dma-mapping.git dma-sg_table-helper

Gitweb:

   http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/dma-sg_table-helper

and merged it into the dma-mapping for-next tree.  Unless someone shouts
the branch should be considered immutable in 24 hours.
