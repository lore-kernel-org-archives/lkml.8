Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE98C47077
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFC5207FB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AxktBt90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388101AbgEMNdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:33:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58653 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbgEMNdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:33:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200513133304euoutp0166d3c164fd2722b63a1736bda0d8d6d5~OmcOpq_J02196321963euoutp01e
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:33:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200513133304euoutp0166d3c164fd2722b63a1736bda0d8d6d5~OmcOpq_J02196321963euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589376784;
        bh=u43bSmXm1rHUf8SYhMFLxk81xdh7y6631lLl0ikPwaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxktBt90t20JqgheS+NxwSIsrojE+1nBfoglFBPvNWSRwBTVa2/Q2c7KAou08pxwj
         bFdSbT84EX2//UmUGi8iXrnpnl2nI97C9fdHUMNpa2Ktw0gyI2UgTKq6tCl7RpEFIL
         lswhGMPlKn3WQ9AM7mObfKpPZrS3mXfLASywus2g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200513133303eucas1p1b8a3a0a9825af31ba19b0341f328aa56~OmcOQJc492350723507eucas1p1q;
        Wed, 13 May 2020 13:33:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 65.01.60679.F07FBBE5; Wed, 13
        May 2020 14:33:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200513133303eucas1p1e3ede8aa38f730d2be317dff27c03019~OmcN8Gns52350623506eucas1p15;
        Wed, 13 May 2020 13:33:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200513133303eusmtrp1d098a14ab77d5bb25a786d9565f5798c~OmcN7ZvPR1011910119eusmtrp17;
        Wed, 13 May 2020 13:33:03 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-2f-5ebbf70f6d6b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 10.1A.08375.F07FBBE5; Wed, 13
        May 2020 14:33:03 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200513133302eusmtip19bb2d9f6ce9d2ea12ae27f03f3db0dee~OmcNQj13R0693406934eusmtip1P;
        Wed, 13 May 2020 13:33:02 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v5 10/38] drm: exynos: use common helper for a scatterlist
 contiguity check
Date:   Wed, 13 May 2020 15:32:17 +0200
Message-Id: <20200513133245.6408-10-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87r833fHGUy5rm7Re+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMllMuj+BxWLBfmuLL1ceMllsenyN1eLyrjlsFjPO72OyWHvkLrvF
        wQ9PWC1mTH7J5sDnsWbeGkaPvd8WsHhs//aA1eN+93Emj81L6j1u/3vM7DH5xnJGj903G9g8
        +rasYvT4vEkugCuKyyYlNSezLLVI3y6BK2PHz39MBbd5Ko7dOsHcwHiIq4uRk0NCwERi3Y9j
        TF2MXBxCAisYJY6fvMAO4XxhlPg/dxo7SJWQwGdGiaUvarsYOcA6fq8ogahZziixoPEiC1zD
        xwfHWEEa2AQMJbredrGB2CICrYwSJ3p5QIqYBTqYJa5NnM8IkhAWiJW43/yZGcRmEVCVWHy6
        B6yBV8BWYvrBj6wQ98lLrN5wAKyGEyj+6s5+sG0SAsfYJY7t6GeGOMlFYsVBBYh6YYlXx7ew
        Q9gyEqcn90DVNzNKPDy3lh3C6WGUuNw0gxGiylrizrlfbCCDmAU0Jdbv0ocIO0pc3feDEWI+
        n8SNt4IgYWYgc9K26VBreSU62oQgqtUkZh1fB7f24IVLzBC2h0TP9Q5WSAAdZpS4s7ubcQKj
        /CyEZQsYGVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEJqbT/45/2cG460/SIUYBDkYl
        Hl6LW7vjhFgTy4orcw8xSnAwK4nw+q0HCvGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQyVkgg
        PbEkNTs1tSC1CCbLxMEp1cDYfjZ075W/Ys5+Hk+9eHb9FZ6xR/srn9jkaVOX7eT74GomeqrU
        8p31wa0d2ZpsWesdT12Kfxqcr+LylXvn49Jao8gLS3p4/I0mNMXaTuRcc4lpinTjh+fntx+4
        eO/L80TJOYwvRN8IK0zRWXmD+QvPT2u3+5l7Ol+uqzT5XO6XsnvVBi/zqRzdSizFGYmGWsxF
        xYkAHrQEOEgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xu7r833fHGUxZIGrRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMllMuj+BxWLBfmuLL1ceMllsenyN1eLyrjlsFjPO72OyWHvkLrvF
        wQ9PWC1mTH7J5sDnsWbeGkaPvd8WsHhs//aA1eN+93Emj81L6j1u/3vM7DH5xnJGj903G9g8
        +rasYvT4vEkugCtKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
        LLVI3y5BL2PHz39MBbd5Ko7dOsHcwHiIq4uRg0NCwETi94qSLkYuDiGBpYwS7SeXsHYxcgLF
        ZSROTmuAsoUl/lzrYoMo+sQocfHrarAEm4ChRNdbiISIQCejxLTuj+wgDrPABGaJ+y2rGUGq
        hAWiJQ6sOg3WwSKgKrH4dA8biM0rYCsx/eBHqBXyEqs3HGAGsTmB4q/u7GcBsYUE8iX2Lt7H
        NoGRbwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAWNl27OfmHYyXNgYfYhTgYFTi4bW4
        tTtOiDWxrLgy9xCjBAezkgiv33qgEG9KYmVValF+fFFpTmrxIUZToKMmMkuJJucD4zivJN7Q
        1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOjN5eoR8x/Q9WP9zUnuin/
        nlWzszzq4NwLW3fuiirZYV+SVze7+WfchitFXM1ypR7ai9s7CxRf7rxYWqvQnfhmn8fHi/qL
        YhzLBWXXXZy8zHwm/6k800/C7a/XH/h2z+zduwPvbkekLLz77cWTV7tNnj7VOPV/ZkawjhQD
        65k81rmHL/yUrlc6qcRSnJFoqMVcVJwIAGK75XWrAgAA
X-CMS-MailID: 20200513133303eucas1p1e3ede8aa38f730d2be317dff27c03019
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200513133303eucas1p1e3ede8aa38f730d2be317dff27c03019
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133303eucas1p1e3ede8aa38f730d2be317dff27c03019
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
        <20200513133245.6408-1-m.szyprowski@samsung.com>
        <CGME20200513133303eucas1p1e3ede8aa38f730d2be317dff27c03019@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper for checking the contiguity of the imported dma-buf.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index 0df57ee..a49a8ea 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -431,27 +431,10 @@ struct drm_gem_object *
 {
 	struct exynos_drm_gem *exynos_gem;
 
-	if (sgt->nents < 1)
+	/* check if the entries in the sg_table are contiguous */
+	if (drm_prime_get_contiguous_size(sgt) < attach->dmabuf->size) {
+		DRM_ERROR("buffer chunks must be mapped contiguously");
 		return ERR_PTR(-EINVAL);
-
-	/*
-	 * Check if the provided buffer has been mapped as contiguous
-	 * into DMA address space.
-	 */
-	if (sgt->nents > 1) {
-		dma_addr_t next_addr = sg_dma_address(sgt->sgl);
-		struct scatterlist *s;
-		unsigned int i;
-
-		for_each_sg(sgt->sgl, s, sgt->nents, i) {
-			if (!sg_dma_len(s))
-				break;
-			if (sg_dma_address(s) != next_addr) {
-				DRM_ERROR("buffer chunks must be mapped contiguously");
-				return ERR_PTR(-EINVAL);
-			}
-			next_addr = sg_dma_address(s) + sg_dma_len(s);
-		}
 	}
 
 	exynos_gem = exynos_drm_gem_init(dev, attach->dmabuf->size);
-- 
1.9.1

