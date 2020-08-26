Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC42C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74930207DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d/2w0Mo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgHZGi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:38:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39429 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgHZGfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:35:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200826063534euoutp02887e8f35a0f01d86af0c9eb20e38854c~uversa_yd1511215112euoutp02O
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:35:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200826063534euoutp02887e8f35a0f01d86af0c9eb20e38854c~uversa_yd1511215112euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598423734;
        bh=bm4jyzGdoL7eueSepHu8xbaOpsUiBlIaWdzcyPajcJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/2w0Mo9bX1NLGeRcW20inr3skCuLL7er4lv14reNyRrglBDthd8/gQkWFS24dOgm
         /FkPBSiw7lMpHbJ4ZhpkrP4NYeMHWC1Hpo6nMN7jO+GCE8fTwIFKuH0hWpajmmkDBP
         Eemu9ZZGltfP0tECsmyJF+Jm3vN9FtwqssTf53WY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200826063534eucas1p2871cf4916187b9bc380232b26bd6865e~uverSnhkK0402704027eucas1p2g;
        Wed, 26 Aug 2020 06:35:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6E.4D.06318.5B2064F5; Wed, 26
        Aug 2020 07:35:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200826063533eucas1p1fad2f2afb117b026081468d2d840ab0f~uveq-NYT81942019420eucas1p1m;
        Wed, 26 Aug 2020 06:35:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200826063533eusmtrp168812a4b34355f043831c99f380de8ca~uveq_iG8T1091110911eusmtrp1S;
        Wed, 26 Aug 2020 06:35:33 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-d8-5f4602b5b2b9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 50.D0.06314.5B2064F5; Wed, 26
        Aug 2020 07:35:33 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200826063533eusmtip25d907c392a9195b908baf25bf473b36a~uveqX7eyd0300803008eusmtip2u;
        Wed, 26 Aug 2020 06:35:32 +0000 (GMT)
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v9 10/32] drm: mediatek: use common helper for a scatterlist
 contiguity check
Date:   Wed, 26 Aug 2020 08:32:54 +0200
Message-Id: <20200826063316.23486-11-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfyyUcRzue+97772O43Us35S027Kx5cdkvaaZjPZu/sg//ZGtdPLuWO7o
        zo+utbqdNB2HSy2RQtqJk1xSLuKII3XLj0njRDRTGePYSOrOi/57nufzfJ5nn+++OMI3sT3x
        ZEk6LZUIUwQYF23uWTMfeck6GR/YmBtKqs19LLKxpIFNVqnVKPm3WYOQwysLGPm0rptFVrSH
        kdbhKRapnx5hk0OGBxg5lD0AyPp3Fg6pvBFMWiZ6UdK4OMOOcKF0D3WAalutQKmWUguH0tfe
        wqhXq5Ns6mueiUW9qL5OjW1OI1TxqBZQb74oMKrwTyBV0FQLqGX9wVheHPd4Ip2SnElLA8LP
        c5N68jc4aUrny5XFxYgCDDuqgAMOiaNwtFzPUQEuzidqAOyd/b1NrACWLXSjDFkGcHzgF9hZ
        6ar8yWIGWgBHZ1qQ3ZUJ6wRmd2FEEFTNq7awO5FjC1Y72U0I0YrAKsO6LRfH3Yh4OGBIsHtQ
        4jCcvzuI2jGPCId1i2Uo0+YN6553IHbsYNNNeYUYo3/jQI2BbY+BRBQcKw1hZDf4w9TEYfAB
        2F+cv3UBJLIBnDLXcxiSD+CQsmT7nDA4bl7H7EEI4QsbDAGMfAKuDfcgTL4zHJ13tcuIDd5u
        vrct82DuTT7j9oGlpme7tcZPgwiDKZg7o8OY59EAqB0zYUXAu/R/WQUAtcCDzpCJRbQsWEJn
        +cuEYlmGROR/IVWsB7bv1b9pWnkN3m4kdAICBwInXgUWHc9nCzNlcnEngDgicOdFfuw/x+cl
        CuVXaGlqvDQjhZZ1gv04KvDgBVfNneUTImE6fZGm02jpzpSFO3gqgLh+vSAGWFz4SxzESBWV
        x/iKGltD2id4czVZ8s/B0i6lBQmMWHLXLekcs2Y390iuKpseF2UeOvNdvWR9Hxlnnrz05I7R
        qp/z3evxSC4ZWYzqMEh7P5xSNFfnLKuP+bl4xep8nLTavrzQaK8czbXTYdOCpn2u92vaFJrs
        LIG/AJUlCYP8EKlM+A9H7DbLWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xe7pbmdziDfY+UrfoPXeSyWLjjPWs
        Fot6e1ks/m+byGxx5et7NouVq48yWSzYb23x5cpDJotNj6+xWlzeNYfN4nLzRUaLtUfusls0
        tRhb3L13gsXi4IcnrA78HmvmrWH02PttAYvHzll32T02repk89j+7QGrx/3u40wem5fUe9z+
        95jZY/KN5Yweu282sHn0/zXw6NuyitHj8ya5AN4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0j
        E0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxjPX/YC5r4KhZOnszcwHiFu4uRk0NCwETi8MLX
        TF2MXBxCAksZJbYs2ccEkZCRODmtgRXCFpb4c62LDaLoE6PEx7tXGUESbAKGEl1vIRIiAp2M
        EtO6P7KDOMwCx5glNj5+zwxSJSwQK/F10UV2EJtFQFXi7dRLLCA2r4CdxOoPs1kgVshLrN5w
        AKyeEyh+vLufDcQWErCVOL12BvMERr4FjAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAiNq
        27Gfm3cwXtoYfIhRgINRiYd3AZtrvBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pz
        UosPMZoCHTWRWUo0OR8Y7Xkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqY
        ODilGhhVSyMMFBO4hNkYQq57ey+y1tgZ0mMnUL99W9yZ/T9/vL4eLJ34P9/748v+FXr/ZCw3
        1f2cIvf8KZsP51kO2+nLuHzu3O10m9Nbu/3yKY3HuRJ7Vi/JMDWc7XAndq6Sb+WJ1Ry3Le7N
        Cl1buy3rwRqVc1XifkfWvtkVsHf1n8Vxq2pN3ddtTHdSYinOSDTUYi4qTgQAYwLi+b4CAAA=
X-CMS-MailID: 20200826063533eucas1p1fad2f2afb117b026081468d2d840ab0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200826063533eucas1p1fad2f2afb117b026081468d2d840ab0f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063533eucas1p1fad2f2afb117b026081468d2d840ab0f
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
        <CGME20200826063533eucas1p1fad2f2afb117b026081468d2d840ab0f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper for checking the contiguity of the imported dma-buf and
do this check before allocating resources, so the error path is simpler.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 28 ++++++--------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 6190cc3b7b0d..3654ec732029 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -212,37 +212,21 @@ struct drm_gem_object *mtk_gem_prime_import_sg_table(struct drm_device *dev,
 			struct dma_buf_attachment *attach, struct sg_table *sg)
 {
 	struct mtk_drm_gem_obj *mtk_gem;
-	int ret;
-	struct scatterlist *s;
-	unsigned int i;
-	dma_addr_t expected;
 
-	mtk_gem = mtk_drm_gem_init(dev, attach->dmabuf->size);
+	/* check if the entries in the sg_table are contiguous */
+	if (drm_prime_get_contiguous_size(sg) < attach->dmabuf->size) {
+		DRM_ERROR("sg_table is not contiguous");
+		return ERR_PTR(-EINVAL);
+	}
 
+	mtk_gem = mtk_drm_gem_init(dev, attach->dmabuf->size);
 	if (IS_ERR(mtk_gem))
 		return ERR_CAST(mtk_gem);
 
-	expected = sg_dma_address(sg->sgl);
-	for_each_sg(sg->sgl, s, sg->nents, i) {
-		if (!sg_dma_len(s))
-			break;
-
-		if (sg_dma_address(s) != expected) {
-			DRM_ERROR("sg_table is not contiguous");
-			ret = -EINVAL;
-			goto err_gem_free;
-		}
-		expected = sg_dma_address(s) + sg_dma_len(s);
-	}
-
 	mtk_gem->dma_addr = sg_dma_address(sg->sgl);
 	mtk_gem->sg = sg;
 
 	return &mtk_gem->base;
-
-err_gem_free:
-	kfree(mtk_gem);
-	return ERR_PTR(ret);
 }
 
 void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
-- 
2.17.1

