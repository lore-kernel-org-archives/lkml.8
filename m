Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF216CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C390320643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u3jm5kAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbgEMNf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:35:26 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58736 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387993AbgEMNdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:33:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200513133305euoutp016691266db91a315ec685362e2cc17440~OmcPgiGPx2196321963euoutp01f
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:33:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200513133305euoutp016691266db91a315ec685362e2cc17440~OmcPgiGPx2196321963euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589376785;
        bh=zLYKfPb4qw5bY7cQ37GTtVEmglKBPh+N4DgVi4xuw7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3jm5kAWbL1rPokzFymYaRun0aMygcAJKTEthOwy2VqQmUpuI9Rc4YR+8UN3kc4Re
         jnokfwIsIDq05ICeGb/N8kOUCdPtwC3Kf67yYfDnUnFh7Qx9QjVNKCXSAo2Ux4u5RN
         vwkHYZmZSghJ50hqmbavo9DlcE4xpOAMppiiiXAk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200513133304eucas1p1d80aaa744236db1298d022efabb686c5~OmcO54ulV2350723507eucas1p1x;
        Wed, 13 May 2020 13:33:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B6.01.60679.017FBBE5; Wed, 13
        May 2020 14:33:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200513133304eucas1p1114334ce7250cf8189553a22080b69f4~OmcOoLRfj2350723507eucas1p1u;
        Wed, 13 May 2020 13:33:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200513133304eusmtrp1300e8ff97a8e2c23428b64e49e4c23ec~OmcOnF2kl1049110491eusmtrp1D;
        Wed, 13 May 2020 13:33:04 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-33-5ebbf710e917
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A6.37.07950.017FBBE5; Wed, 13
        May 2020 14:33:04 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200513133303eusmtip1d4f4865d63ac5bf40122891f810cb272~OmcN8dd7s3239232392eusmtip1c;
        Wed, 13 May 2020 13:33:03 +0000 (GMT)
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
Subject: [PATCH v5 11/38] drm: exynos: fix common struct sg_table related
 issues
Date:   Wed, 13 May 2020 15:32:18 +0200
Message-Id: <20200513133245.6408-11-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO7t3d9fh5DYNDxZaA6MEZ1bEXVYWRl0IQoKCisyVFzWf7PqG
        TBNT5iN1WVMiRbOZr5lTE5f5qJyPUFEzdYrK0nSlRpqRhrXr1frve77fz/f8Dj8Ojojr+Q54
        YGgErQiVB0swIVrf/qvHlfip9zlQpIZkRk8nj3yh1vLJP/XZCDn4YxEjn5e/45E5E1koWdjs
        QS4PTvHIGtMQnxxofIyR6t7XPLLy7biAbP32iU+qVXPYSRuq4kkFoJpWClHq5cokn5pIM/Ao
        3dM7lHHdhFCqYQ2g9CMJGJVZWwaopRpHb+EV4TE/Ojgwila4nfAVBhhSygThHXYxdd3LSALQ
        bFcCKxwSh+H9jgpMCYS4mCgF8PNCooANxMQygA2lLlywBOBi8Sxvq1FdsCbgAg2A44tGwB0s
        jZneTJSlMMIdKueVGKvtiGQAOzKsWQghUhE4lF1gaeC4LXEBZlZeYhmUcIZ5FeMbvIg4Drv6
        xgTcNCdYXt2CsNrK4pvHmlH2Hki0C6CuYA7joNNwYSYZ5bQtNBtqN8u7YLcqfbOQBOBUT6WA
        O6QDOHBXDTjKA471rGLsixBiP9Q2unH2KTg+38ZjbUjYwOH5jYUhFplT/wjhbBFMvSfm6L0w
        31D1b2xrXz/CaQp2KqcRbkFvACzMXeRnAaf8/8MKASgD9nQkE+JPMwdD6WgpIw9hIkP9pTfD
        QmqA5Td1rxuWG0Dj7xttgMCBxFpEjup9xHx5FBMb0gYgjkjsROe1FkvkJ4+NoxVh1xWRwTTT
        BnbiqMRedKho7pqY8JdH0EE0HU4rtlIebuWQAKhnI57ZiSUBJbIvjvkTSSlBIrlX92hanL1L
        8b6jzpLhbXyH+PgY/axpaEHg9UpflSdTT2ovy4Ie5MYlmR/WmZvCjM5n3c+ZGKNKPNP1scV1
        tZ/Y44uVe0elVcq+itM9pWvfY1RXNR+ipdZnEJ1y9JamYcfti13vj8SW7tatTEtQJkDu7oIo
        GPlfXwZqpUkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7oC33fHGaw4yGrRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMllMuj+BxWLBfmuLL1ceMllsenyN1eLyrjlsFjPO72OyWHvkLrvF
        wQ9PWC1mTH7J5sDnsWbeGkaPvd8WsHhs//aA1eN+93Emj81L6j1u/3vM7DH5xnJGj903G9g8
        +rasYvT4vEkugCtKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
        LLVI3y5BL+N4+yr2ghMiFVtPf2FuYFwu2MXIySEhYCKxYf5v9i5GLg4hgaWMEgteTmWCSMhI
        nJzWwAphC0v8udbFBlH0iVHiwrfJzCAJNgFDia63EAkRgU5GiWndH8FGMQtMYJa437KaEaRK
        WCBAouncIrAOFgFViZlr7rKB2LwCthKnLtxhh1ghL7F6wwGwGk6g+Ks7+1lAbCGBfIm9i/ex
        TWDkW8DIsIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwWrYd+7llB2PXu+BDjAIcjEo8vBa3
        dscJsSaWFVfmHmKU4GBWEuH1Ww8U4k1JrKxKLcqPLyrNSS0+xGgKdNREZinR5HxgJOeVxBua
        GppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamAMeKu88P9p9srvnsG9edE+
        b64/K5sQ/+fDitA8NxPX+WH3lq4yyT89k6/vO6OHiEDG+y2fIsTfCvK9qT0927z4GP+x2o3t
        354opPAZSLM9Tm3bZ5DuGrztlOza4vivoXrPmvj7U+Yv2eDi3TyFtcFaw/TRVoN7+bNjI7RU
        A/KSdXvZ+S413lRiKc5INNRiLipOBABIc1RErAIAAA==
X-CMS-MailID: 20200513133304eucas1p1114334ce7250cf8189553a22080b69f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200513133304eucas1p1114334ce7250cf8189553a22080b69f4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133304eucas1p1114334ce7250cf8189553a22080b69f4
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
        <20200513133245.6408-1-m.szyprowski@samsung.com>
        <CGME20200513133304eucas1p1114334ce7250cf8189553a22080b69f4@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
returns the number of the created entries in the DMA address space.
However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
dma_unmap_sg must be called with the original number of the entries
passed to the dma_map_sg().

struct sg_table is a common structure used for describing a non-contiguous
memory buffer, used commonly in the DRM and graphics subsystems. It
consists of a scatterlist with memory pages and DMA addresses (sgl entry),
as well as the number of scatterlist entries: CPU pages (orig_nents entry)
and DMA mapped pages (nents entry).

It turned out that it was a common mistake to misuse nents and orig_nents
entries, calling DMA-mapping functions with a wrong number of entries or
ignoring the number of mapped entries returned by the dma_map_sg()
function.

To avoid such issues, lets use a common dma-mapping wrappers operating
directly on the struct sg_table objects and use scatterlist page
iterators where possible. This, almost always, hides references to the
nents and orig_nents entries, making the code robust, easier to follow
and copy/paste safe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index fcee33a..7014a8c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -395,8 +395,8 @@ static void g2d_userptr_put_dma_addr(struct g2d_data *g2d,
 		return;
 
 out:
-	dma_unmap_sg(to_dma_dev(g2d->drm_dev), g2d_userptr->sgt->sgl,
-			g2d_userptr->sgt->nents, DMA_BIDIRECTIONAL);
+	dma_unmap_sgtable(to_dma_dev(g2d->drm_dev), g2d_userptr->sgt,
+			  DMA_BIDIRECTIONAL, 0);
 
 	pages = frame_vector_pages(g2d_userptr->vec);
 	if (!IS_ERR(pages)) {
@@ -511,10 +511,10 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct g2d_data *g2d,
 
 	g2d_userptr->sgt = sgt;
 
-	if (!dma_map_sg(to_dma_dev(g2d->drm_dev), sgt->sgl, sgt->nents,
-				DMA_BIDIRECTIONAL)) {
+	ret = dma_map_sgtable(to_dma_dev(g2d->drm_dev), sgt,
+			      DMA_BIDIRECTIONAL, 0);
+	if (ret) {
 		DRM_DEV_ERROR(g2d->dev, "failed to map sgt with dma region.\n");
-		ret = -ENOMEM;
 		goto err_sg_free_table;
 	}
 
-- 
1.9.1

