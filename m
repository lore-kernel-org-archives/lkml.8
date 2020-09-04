Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F89C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1DE20709
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l8ZplvoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgIDOMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:12:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44883 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbgIDNpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:45:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200904133503euoutp01750f97f9f029b6bccff5d1af6c6f81f7~xmAg1aeuN0637106371euoutp01H
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:35:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200904133503euoutp01750f97f9f029b6bccff5d1af6c6f81f7~xmAg1aeuN0637106371euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599226503;
        bh=l+uE0Uw/hmYgweTMJTNZUtDyKghxm7SM+gopIC5qQSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8ZplvoW20A9Syt7Adirzg1qySQxeE/ho6uu7gd6rTG/FdI/FNmEpbGHx+EVvpIpg
         dicp532i9zN62EP7vI3CD9OfH5QkkTFBU0TQvKrH4dgj6ZKXG/jcNnjISTtZrr5JFX
         7Oxc6Z2nIyocpmSzPJddvOEYKzjM4JYXFq/GhaLc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200904133503eucas1p2c5b8774cd10d214618af91db641a78f4~xmAgbZ7rk1447814478eucas1p2q;
        Fri,  4 Sep 2020 13:35:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 21.11.06456.782425F5; Fri,  4
        Sep 2020 14:35:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200904133502eucas1p10c2344eef1f77b82c455215056fd5770~xmAgB2t020116001160eucas1p1y;
        Fri,  4 Sep 2020 13:35:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200904133502eusmtrp25a0e98b8339aded79c9ecf382d66e707~xmAgBH-Ja0977109771eusmtrp2C;
        Fri,  4 Sep 2020 13:35:02 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-4a-5f5242876b10
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E0.BE.06314.682425F5; Fri,  4
        Sep 2020 14:35:02 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200904133502eusmtip1d5af0b81300a8a7631cc0e8fd4073377~xmAfZq8YZ1624216242eusmtip1p;
        Fri,  4 Sep 2020 13:35:02 +0000 (GMT)
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
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v10 15/30] drm: rockchip: use common helper for a
 scatterlist contiguity check
Date:   Fri,  4 Sep 2020 15:16:56 +0200
Message-Id: <20200904131711.12950-16-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUhTURjGO7sfu063btPo2Jcx+qAgbRR0wbKMqItEH0L/VGYzLxa6GbtZ
        KUXDSmXNSgsbo3RmaK7l59Iyam2la1lLl4pmMW1SZJmfszLacl6z/37Pc97nvO97OAQiNmPz
        iaOK44xSIUuR4AK0rumXY3X2ltj4Ndq2QCrXYedR1dpKjPLV5SFUm2cQp8rvNvIo38evGHUz
        /wylN0dSY229PKrG3YFRbxtu4NRIjw+h7j3/wKcsQ33YZhFtLDQC+vG4HqXrx3sw2nXRxqNr
        b5+lu71uhL7aWQboR10qnP6jM6P0JZMB0PUdhQg9WrN4d9A+wYZEJuXoCUYZEXVIcERXegk9
        9iHoVJbRhKhAu0ANAghIroOljzJxNRAQYvIOgK+s3QgnxgDMtTTxODE6KSbe8NWAmIpoahWc
        Xwago8qMzyR+lwzy/PfipBSqB9S4n0PICwC+yA3yM0IWINDg2ebnYPIQdNf7pupRchkc/9aH
        +llIRsEfrmt8br4weLfqKeLngEn/vrYP8zeDZAcfmpwuwBVtheWXL08HgmG/zTTNC6HvYRGP
        C5wDsNdxj88JDYBvM7XT6Uj43jGB+3dDyJWwsiGCs6NhgdeJciuLYOfAHG4BEcyvu45wthDm
        ZIm56uVQZ6uYaWtpcSIc0/BJcT/KPVAegJoLBdgVEKb730wPgAHMY9JYeRLDShXMyXBWJmfT
        FEnhh1PlNWDyWzV7bSMPgMeZYAUkASRBwlmbYuPFmOwEmy63AkggkhDhltfNB8XCRFl6BqNM
        jVempTCsFSwgUMk84dpbX+LEZJLsOJPMMMcY5b9THhEwXwWiN+rxPk3Dw+WWIsO71NqY7K4y
        +P3mbJPSo9qzuyuxuO3jdu/E/p+fLSJXy44YYVx8RVHgp21/ftLDhiWuuVKwFNWrV7Qa229V
        nK7zZsFFc1XiAy+7VT32KF/v2Dn7QIl1Y6suwR0a1hgOLDHDwH4jdO9Qxs71Oc92VZ8nk9US
        lD0ik65ClKzsL76WlwNSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7ptTkHxBkdW6Fv0njvJZLFxxnpW
        i//bJjJbXPn6ns1i5eqjTBb/H71mtZg7qdZiwX5riy9XHjJZbHp8jdXi8q45bBafHvxntlh7
        5C67xcEPT1gd+DzWzFvD6LH32wIWj+3fHrB63O8+zuSxeUm9x+1/j5k9Jt9Yzuix+2YDm8ff
        WftZPPq2rGL02H5tHrPH501yATxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZG
        pkr6djYpqTmZZalF+nYJehmzlvWxFNzlqWhbs4W5gfEqVxcjB4eEgIlEz+a8LkYuDiGBpYwS
        F26/YOxi5ASKy0icnNbACmELS/y51sUGUfSJUeLM13tsIAk2AUOJrrcQCRGBTkaJad0f2UEc
        ZoF5zBLLVx1mAqkSFoiT6DgwE8xmEVCV+PbmCQuIzStgJ/H9/hR2iBXyEqs3HGAGsTmB4ltn
        PAFbLSRgK/FhzmKWCYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRGz7ZjPzfvYLy0
        MfgQowAHoxIPL4N9ULwQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAh01
        kVlKNDkfGNl5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYyz78
        573D/V031uQ8j/0lF7U/782W7uvRztWXK75itJA9+k/4xQzlqwWh9z1YVpvaCitENnsuc4vp
        Yvivq3ZzkfrC2KMzpRk26l/dqj7hoP+P3auvp3x8tF9Ekf30xd7WR3/t41Y+CnQTN2Y+ck/k
        xjqhCepGC6flSK2Q+q/AEx0etkQk7LubEktxRqKhFnNRcSIAEvCk4rQCAAA=
X-CMS-MailID: 20200904133502eucas1p10c2344eef1f77b82c455215056fd5770
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200904133502eucas1p10c2344eef1f77b82c455215056fd5770
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133502eucas1p10c2344eef1f77b82c455215056fd5770
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
        <CGME20200904133502eucas1p10c2344eef1f77b82c455215056fd5770@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper for checking the contiguity of the imported dma-buf.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index b9275ba7c5a5..2970e534e2bb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -460,23 +460,6 @@ struct sg_table *rockchip_gem_prime_get_sg_table(struct drm_gem_object *obj)
 	return sgt;
 }
 
-static unsigned long rockchip_sg_get_contiguous_size(struct sg_table *sgt,
-						     int count)
-{
-	struct scatterlist *s;
-	dma_addr_t expected = sg_dma_address(sgt->sgl);
-	unsigned int i;
-	unsigned long size = 0;
-
-	for_each_sg(sgt->sgl, s, count, i) {
-		if (sg_dma_address(s) != expected)
-			break;
-		expected = sg_dma_address(s) + sg_dma_len(s);
-		size += sg_dma_len(s);
-	}
-	return size;
-}
-
 static int
 rockchip_gem_iommu_map_sg(struct drm_device *drm,
 			  struct dma_buf_attachment *attach,
@@ -498,7 +481,7 @@ rockchip_gem_dma_map_sg(struct drm_device *drm,
 	if (!count)
 		return -EINVAL;
 
-	if (rockchip_sg_get_contiguous_size(sg, count) < attach->dmabuf->size) {
+	if (drm_prime_get_contiguous_size(sg) < attach->dmabuf->size) {
 		DRM_ERROR("failed to map sg_table to contiguous linear address.\n");
 		dma_unmap_sg(drm->dev, sg->sgl, sg->nents,
 			     DMA_BIDIRECTIONAL);
-- 
2.17.1

