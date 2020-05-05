Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF52C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995B42075E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DwPzGLBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgEEIqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:46:34 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48176 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgEEIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:46:29 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200505084627euoutp018883fd5b1e44f39864c36d9bb0ce7897~MFXsliotA0325703257euoutp01a
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:46:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200505084627euoutp018883fd5b1e44f39864c36d9bb0ce7897~MFXsliotA0325703257euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588668387;
        bh=kVItjuzkDZEWgWWKI3FgsiswD6i+/SL80m0l+V0hN28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DwPzGLBxZhh4g1jktHAp0peUHDhIlb3NPoiSsIdhOGYVCiBIF2qTINWJjfYJBp1KE
         w8M5TLed7PNXLMOrmtFVahVe64l/nCAoBxJmVi0T0wkNHAEfXH77L+EFd34Ao9LQ+T
         jgXexE5+sEbXy0S/Jw9Hammvz5CnNdzCrI+1zhDE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200505084626eucas1p2bd08c1934dd8d39db7ddf52dfe576b9d~MFXsULUhN1058410584eucas1p2r;
        Tue,  5 May 2020 08:46:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E0.CF.61286.2E721BE5; Tue,  5
        May 2020 09:46:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200505084626eucas1p20abe79e406f60ae92fec252072befc5a~MFXsB2CIY1942419424eucas1p2I;
        Tue,  5 May 2020 08:46:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200505084626eusmtrp18fa2f153b5af7296c4a2a944ba75303f~MFXsBOMfc0942509425eusmtrp15;
        Tue,  5 May 2020 08:46:26 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-97-5eb127e2d689
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 24.21.07950.2E721BE5; Tue,  5
        May 2020 09:46:26 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200505084626eusmtip198ef62d087e4d50afa1a00ff5371d8a9~MFXreJocU0686606866eusmtip1H;
        Tue,  5 May 2020 08:46:25 +0000 (GMT)
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
        Lucas Stach <l.stach@pengutronix.de>,
        etnaviv@lists.freedesktop.org
Subject: [PATCH v3 05/25] drm: etnaviv: fix common struct sg_table related
 issues
Date:   Tue,  5 May 2020 10:45:54 +0200
Message-Id: <20200505084614.30424-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505084614.30424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7qP1DfGGRy9aWrRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLXTPusFusXH2UyWLBfmuLB3NvMll8ufKQyWLT42usFpd3zWGzWHvkLrvF
        wQ9PWB14PdbMW8PosffbAhaP7d8esHrc7z7O5LF5Sb3H7X+PmT0m31jO6LH7ZgObR/9fA4++
        LasYPT5vkgvgjuKySUnNySxLLdK3S+DKaGsxKngjVrH540+2BsZ1wl2MHBwSAiYSBzrsuhi5
        OIQEVjBKHLiwgRnC+cIo0fvnBwuE85lR4uTkHUAZTrCOI2fXQCWWM0rMb5mM0HJ29joWkCo2
        AUOJrrddbCC2iEAro8SJXh4Qm1ngPpPE75dZILawQLDEmtVvwKayCKhKfJzVA9bLK2Ar8e7a
        aiaIbfISqzccAKvhFLCTeHzpDhvIMgmBY+wSB/5+ZoQocpFYPa2NBcIWlnh1fAs7hC0jcXpy
        DwtEQzOjxMNza9khnB5GictNM6C6rSXunPvFBgoOZgFNifW79CHCjhLzGh+yQUKJT+LGW0GI
        B/gkJm2bzgwR5pXoaBOCqFaTmHV8HdzagxcuQUPLQ6Lry2NGSAAdZZRY++A20wRG+VkIyxYw
        Mq5iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITEun/x3/tIPx66WkQ4wCHIxKPLwRn9fH
        CbEmlhVX5h5ilOBgVhLhXfZjQ5wQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1Kz
        U1MLUotgskwcnFINjHo2PJ33RHV8L0nbMh1dV2V2/9WfqqXyiz9GXld7+U9nw7NNL+5L39+e
        8Cy0giFh5soMjcA7eeaefmz/tjGEv61eofMk/lmcz2rNGxL/suf2Sk+NfSWavv7E4XUNztvq
        /99/PuXQjKkMNU8O/Tr/ZE9JhP3qxuVPOvP96rWYvh4LPNDQcU37iZgSS3FGoqEWc1FxIgDg
        MXN2RwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsVy+t/xu7qP1DfGGVzbomjRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLXTPusFusXH2UyWLBfmuLB3NvMll8ufKQyWLT42usFpd3zWGzWHvkLrvF
        wQ9PWB14PdbMW8PosffbAhaP7d8esHrc7z7O5LF5Sb3H7X+PmT0m31jO6LH7ZgObR/9fA4++
        LasYPT5vkgvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxL
        LdK3S9DLaGsxKngjVrH540+2BsZ1wl2MnBwSAiYSR86uYeli5OIQEljKKPFxyT82iISMxMlp
        DawQtrDEn2tdbBBFnxglnk6/zQ6SYBMwlOh6C5EQEehklJjW/REswSzwnEniZYt+FyMHh7BA
        oMTfdgGQMIuAqsTHWT0sIDavgK3Eu2urmSAWyEus3nCAGcTmFLCTeHzpDtgRQgKFEh/Of2ed
        wMi3gJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmCUbDv2c8sOxq53wYcYBTgYlXh4N3xd
        HyfEmlhWXJl7iFGCg1lJhHfZjw1xQrwpiZVVqUX58UWlOanFhxhNgY6ayCwlmpwPjOC8knhD
        U0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MAR/zt7hp3xEWyrk0N5Sp
        unbJzPtTxZP7LzwR0on/Khzzdd+C5UqcGU8St2ueOeiebbG/+0zd6XKbGHaFZ5fKpJVCeh6f
        LlhR0/wufdNn092PWFmcAq613276Y5rQ3fxFXaw+q1HdbJlvdo673YyLR+9UNJqmJzbrVVje
        4tXSZzN41KzkvUuJpTgj0VCLuag4EQC8t0YKqAIAAA==
X-CMS-MailID: 20200505084626eucas1p20abe79e406f60ae92fec252072befc5a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200505084626eucas1p20abe79e406f60ae92fec252072befc5a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084626eucas1p20abe79e406f60ae92fec252072befc5a
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
        <20200505084614.30424-1-m.szyprowski@samsung.com>
        <CGME20200505084626eucas1p20abe79e406f60ae92fec252072befc5a@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
numer of the created entries in the DMA address space. However the
subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
called with the original number of the entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. A common mistake was to ignore a result
of the dma_map_sg function and don't use the sg_table->orig_nents at all.

To avoid such issues, lets use common dma-mapping wrappers operating
directly on the struct sg_table objects and adjust references to the
nents and orig_nents respectively.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v3 00/25] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/5/187
---
 drivers/gpu/drm/etnaviv/etnaviv_gem.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index dc9ef30..340026b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -27,7 +27,7 @@ static void etnaviv_gem_scatter_map(struct etnaviv_gem_object *etnaviv_obj)
 	 * because display controller, GPU, etc. are not coherent.
 	 */
 	if (etnaviv_obj->flags & ETNA_BO_CACHE_MASK)
-		dma_map_sg(dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
+		dma_map_sgtable(dev->dev, sgt, DMA_BIDIRECTIONAL);
 }
 
 static void etnaviv_gem_scatterlist_unmap(struct etnaviv_gem_object *etnaviv_obj)
@@ -51,7 +51,7 @@ static void etnaviv_gem_scatterlist_unmap(struct etnaviv_gem_object *etnaviv_obj
 	 * discard those writes.
 	 */
 	if (etnaviv_obj->flags & ETNA_BO_CACHE_MASK)
-		dma_unmap_sg(dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
+		dma_unmap_sgtable(dev->dev, sgt, DMA_BIDIRECTIONAL);
 }
 
 /* called with etnaviv_obj->lock held */
@@ -404,9 +404,8 @@ int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
 	}
 
 	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
-		dma_sync_sg_for_cpu(dev->dev, etnaviv_obj->sgt->sgl,
-				    etnaviv_obj->sgt->nents,
-				    etnaviv_op_to_dma_dir(op));
+		dma_sync_sgtable_for_cpu(dev->dev, etnaviv_obj->sgt,
+					 etnaviv_op_to_dma_dir(op));
 		etnaviv_obj->last_cpu_prep_op = op;
 	}
 
@@ -421,8 +420,7 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
 	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
 		/* fini without a prep is almost certainly a userspace error */
 		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
-		dma_sync_sg_for_device(dev->dev, etnaviv_obj->sgt->sgl,
-			etnaviv_obj->sgt->nents,
+		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
 			etnaviv_op_to_dma_dir(etnaviv_obj->last_cpu_prep_op));
 		etnaviv_obj->last_cpu_prep_op = 0;
 	}
-- 
1.9.1

