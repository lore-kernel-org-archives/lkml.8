Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C409AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A9A20738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EDEBYhE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgHZGhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:37:42 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37857 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHZGfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:35:42 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200826063534euoutp01060c3832daed18e982d9e683171adad7~uverbc30z1716517165euoutp01f
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:35:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200826063534euoutp01060c3832daed18e982d9e683171adad7~uverbc30z1716517165euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598423734;
        bh=3Uytyvwzt4UX7mjIW5nSX3tNMM/3bhp/av3KF6qTx7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDEBYhE9dCmIGAhJrhx7/yPf0Kj5NAsJ4oYnEtVpppNU0KrZqn+745SA81Nfp9CGb
         dS6cY2pA8awO06Ntb49QRaCUGt49UdJozbxJB1N4dU+85ZCyVAxVG506LizmRuZGMD
         F5Ia5Xm1g7iyB1DhG1vOyZpw6T7ff5h/xG0T15B8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200826063533eucas1p16d9e6bf7c69818da119255358df382c1~uveq2zvo71478314783eucas1p1W;
        Wed, 26 Aug 2020 06:35:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A2.33.06456.5B2064F5; Wed, 26
        Aug 2020 07:35:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200826063533eucas1p1e346ac4a683f929be8adc344b3fe9ea0~uveqZGZqS1478314783eucas1p1U;
        Wed, 26 Aug 2020 06:35:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200826063533eusmtrp2b5d2ab77be8e4428570e50ecaa11247e~uveqYXm9A0466204662eusmtrp2G;
        Wed, 26 Aug 2020 06:35:33 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-c1-5f4602b55aa3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.53.06017.4B2064F5; Wed, 26
        Aug 2020 07:35:32 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200826063532eusmtip2a661488c75102a598df06eb563b1f6b1~uvep1HU9u2993829938eusmtip2g;
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
        Daniel Vetter <daniel@ffwll.ch>, Qiang Yu <yuq825@gmail.com>,
        lima@lists.freedesktop.org
Subject: [PATCH v9 09/32] drm: lima: fix common struct sg_table related
 issues
Date:   Wed, 26 Aug 2020 08:32:53 +0200
Message-Id: <20200826063316.23486-10-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djPc7pbmdziDW4/krLoPXeSyWLjjPWs
        Fv+3TWS2uPL1PZvFytVHmSwW7Le2+DxvE5vFlysPmSw2Pb7GanF51xw2i7VH7rJbHPzwhNXi
        w9qvTA68HmvmrWH02PttAYvHzll32T22f3vA6nG/+ziTx+Yl9R63/z1m9ph8Yzmjx+6bDWwe
        fVtWMXp83iQXwB3FZZOSmpNZllqkb5fAlXHg+X/GgntSFe8PhTQwzhPrYuTkkBAwkViwdAlb
        FyMXh5DACkaJs0+msUA4XxglTm89xgzhfGaUWLH4PBtMy4R5P6CqljNK3Lw2kwmu5c+LZSwg
        VWwChhJdb7vAOkQEWhklTvTygBQxC1xmkph/tAmsSFggQOJB3xZGEJtFQFXiz989TCA2r4Cd
        xKL50xgh1slLrN5wgBnE5gSKH+/uB7tWQuAYu8SiJ79ZIIpcJBa3rGOFsIUlXh3fwg5hy0j8
        3zmfCaKhmVHi4bm17BBOD6PE5aYZUCusJe6c+wU0lgPoPk2J9bv0IcKOEjueXGQCCUsI8Enc
        eCsIEmYGMidtm84MEeaV6GgTgqhWk5h1fB3c2oMXLkGVeEjM6IQG0ERGiXV7ZzBNYJSfhbBr
        ASPjKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMDUdPrf8U87GL9eSjrEKMDBqMTDu4DN
        NV6INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJ
        zU5NLUgtgskycXBKNTAu6WjRmvOsnOOzzrs2TtlIxby0KQfNPCyCLqwKPruWfbWAzMx69an1
        8wr6HnyxCfHirmRbaNTXEnZYQ029fXPyk2ihJMf8BF25ThE/Zq8lZ9j8jbdKTJdc/iz5GdfL
        xV/2L1j+Xe74QqcW991d7+PuTjcLnMSaXmDWH99+d486Y9GdhBusAUosxRmJhlrMRcWJAACn
        CqBJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7pbmNziDS6+t7HoPXeSyWLjjPWs
        Fv+3TWS2uPL1PZvFytVHmSwW7Le2+DxvE5vFlysPmSw2Pb7GanF51xw2i7VH7rJbHPzwhNXi
        w9qvTA68HmvmrWH02PttAYvHzll32T22f3vA6nG/+ziTx+Yl9R63/z1m9ph8Yzmjx+6bDWwe
        fVtWMXp83iQXwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
        llqkb5egl3Hg+X/GgntSFe8PhTQwzhPrYuTkkBAwkZgw7wdLFyMXh5DAUkaJ3UfusEAkZCRO
        TmtghbCFJf5c62KDKPrEKHGyYScjSIJNwFCi6y1EQkSgk1FiWvdHdhCHWeA2k8SZuROYQaqE
        Bfwk/v5+CzaWRUBV4s/fPUwgNq+AncSi+dMYIVbIS6zecACsnhMofry7nw3EFhKwlTi9dgbz
        BEa+BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJjZduxn1t2MHa9Cz7EKMDBqMTDu4DN
        NV6INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgY6ayCwlmpwPjOO8knhD
        U0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2Ml5zsefnybwseP/ZzyRv9
        nTrPr/cc3bD9wq622iLfZElOO7eahrf5f7z+c4j++j230eqHZs8l7wkzXidOejjpfjRTCsOf
        2cL3hGs+T+jITFHoSdrYoWE5x+v9ifOTL0z+XaSZLSmwrualmcwMwX8TvAvnn6vyNtwst+/g
        zaM/JDTTvJIi2XwdlFiKMxINtZiLihMB2n060qsCAAA=
X-CMS-MailID: 20200826063533eucas1p1e346ac4a683f929be8adc344b3fe9ea0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200826063533eucas1p1e346ac4a683f929be8adc344b3fe9ea0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063533eucas1p1e346ac4a683f929be8adc344b3fe9ea0
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
        <CGME20200826063533eucas1p1e346ac4a683f929be8adc344b3fe9ea0@eucas1p1.samsung.com>
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
Reviewed-by: Qiang Yu <yuq825@gmail.com>
---
 drivers/gpu/drm/lima/lima_gem.c | 11 ++++++++---
 drivers/gpu/drm/lima/lima_vm.c  |  5 ++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 155f2b4b4030..11223fe348df 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -69,8 +69,7 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
 		return ret;
 
 	if (bo->base.sgt) {
-		dma_unmap_sg(dev, bo->base.sgt->sgl,
-			     bo->base.sgt->nents, DMA_BIDIRECTIONAL);
+		dma_unmap_sgtable(dev, bo->base.sgt, DMA_BIDIRECTIONAL, 0);
 		sg_free_table(bo->base.sgt);
 	} else {
 		bo->base.sgt = kmalloc(sizeof(*bo->base.sgt), GFP_KERNEL);
@@ -80,7 +79,13 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
 		}
 	}
 
-	dma_map_sg(dev, sgt.sgl, sgt.nents, DMA_BIDIRECTIONAL);
+	ret = dma_map_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
+	if (ret) {
+		sg_free_table(&sgt);
+		kfree(bo->base.sgt);
+		bo->base.sgt = NULL;
+		return ret;
+	}
 
 	*bo->base.sgt = sgt;
 
diff --git a/drivers/gpu/drm/lima/lima_vm.c b/drivers/gpu/drm/lima/lima_vm.c
index 5b92fb82674a..2b2739adc7f5 100644
--- a/drivers/gpu/drm/lima/lima_vm.c
+++ b/drivers/gpu/drm/lima/lima_vm.c
@@ -124,7 +124,7 @@ int lima_vm_bo_add(struct lima_vm *vm, struct lima_bo *bo, bool create)
 	if (err)
 		goto err_out1;
 
-	for_each_sg_dma_page(bo->base.sgt->sgl, &sg_iter, bo->base.sgt->nents, 0) {
+	for_each_sgtable_dma_page(bo->base.sgt, &sg_iter, 0) {
 		err = lima_vm_map_page(vm, sg_page_iter_dma_address(&sg_iter),
 				       bo_va->node.start + offset);
 		if (err)
@@ -298,8 +298,7 @@ int lima_vm_map_bo(struct lima_vm *vm, struct lima_bo *bo, int pageoff)
 	mutex_lock(&vm->lock);
 
 	base = bo_va->node.start + (pageoff << PAGE_SHIFT);
-	for_each_sg_dma_page(bo->base.sgt->sgl, &sg_iter,
-			     bo->base.sgt->nents, pageoff) {
+	for_each_sgtable_dma_page(bo->base.sgt, &sg_iter, pageoff) {
 		err = lima_vm_map_page(vm, sg_page_iter_dma_address(&sg_iter),
 				       base + offset);
 		if (err)
-- 
2.17.1

