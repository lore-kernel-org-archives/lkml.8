Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE38C54E97
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D0620714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZOBinC0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgELJDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:03:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40505 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbgELJBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:01:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200512090116euoutp0249e9e82bf14bbb3d9a693cfc8bae12d7~OPFpGMPSE0455404554euoutp02_
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:01:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200512090116euoutp0249e9e82bf14bbb3d9a693cfc8bae12d7~OPFpGMPSE0455404554euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589274076;
        bh=FOPPdxU+0LEhPjdzPi8aS4v8b8m8psmozn5mljH3uS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZOBinC0VU82gZG9Wc49ZVfLoXcYKPgWnMcODAW7/V3wGwssNrYXUWtsvMMLxf68+8
         V0WEtaQ/14QYFULnSd6DvNM5yrF2dOmS9nn6VL357eqiK3Ocjo+VdG3xv9yoHtBFBn
         jfuQIwx34dAXA1DVaMNZt97CCH25mRrze8egwOmU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200512090116eucas1p16a0359c180cfb6683c7f57acfd80b160~OPForFGuZ3053030530eucas1p1i;
        Tue, 12 May 2020 09:01:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2F.57.61286.CD56ABE5; Tue, 12
        May 2020 10:01:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200512090116eucas1p2089d6eb7aa6bad4d2cbc2875c175873f~OPFoRHXTC2091220912eucas1p2y;
        Tue, 12 May 2020 09:01:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200512090116eusmtrp197fa74059f4a4853a6e0110c21fa5b19~OPFoQcF2W0183401834eusmtrp1h;
        Tue, 12 May 2020 09:01:16 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-70-5eba65dc5dda
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 87.F2.07950.BD56ABE5; Tue, 12
        May 2020 10:01:15 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200512090115eusmtip1c346d1cf1b9749bd8cbc614d27033b57~OPFnqNbVH1181011810eusmtip1l;
        Tue, 12 May 2020 09:01:15 +0000 (GMT)
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
Subject: [PATCH v4 15/38] drm: mediatek: use common helper for extracting
 pages array
Date:   Tue, 12 May 2020 11:00:35 +0200
Message-Id: <20200512090058.14910-15-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHe885Ozsup6dp+GKaNTJIzEsKHVDEIOQIfrAsLCV15kElp7Kp
        ZYR5S21qlgMTkRILTZ3XzHQa5kg3MWWpeSGvTYJEs7wstJptnlnffs/vef48Dy8vgQo0HHsi
        PjGFkSSKEoQ4D+sY2B45PcMoIzyG5Yep4pFBhGotb+ZQ1cXFGLXb8QilxrfWcKquoR+hqnp9
        qM3xRYRq001wqDFlJU6N5XwAVOO7WS6VnetFzc5pMKrv+xLH35pWPFEA+o2+CqO7Kma5dFv9
        fZx+rV/g0POFaoR++fwu/cmgQ2n5VC2gu6czcbrkjwf9oL0e0BttR4P5YTzfGCYhPo2RuPtF
        8eIWxn7gyZUHbw1/04FMoLSQAQsCkt6wZroMlwEeISBfAKjK2uCwxSaAv4Y/I2yxAeBGzSR3
        P6JRdWJsoxbAPv0KZmrsRVoWTpgYJz2hbFWGm9iWvAegptjSFEDJHhRWK3f2AjZkKNSuLaEm
        xkhnmDe5gpiYT/rBwRKleZsTbGh5uzdjYfTzT39jrJ/jwoV8wPJ52N08ZJ63gcvqdjM7wCF5
        0d6lkMwBcHGkkcsWRQCOZZeb0z5wZmTHeCphPO8UbFa6s/ocfF+bj5k0JK3g1Oohk0aNWNrx
        GGU1HxbkCdjpk7BC3fRvbZ92FGWZhjmrrebH6gdQ8VODPQROFf+XVQFQD+yYVKk4lpF6JjI3
        3aQisTQ1MdbtepK4DRj/15BBvd4JtkajVYAkgNCSX3CmK0LAEaVJ08UqAAlUaMvPjTcqfowo
        /TYjSYqUpCYwUhU4QmBCO75X9ddrAjJWlMLcYJhkRrLfRQgL+0wgX1dGh2HySsO2VsEUOQYF
        gaDtWkOga5Om1cen32Eg6dXFqIkQSel6ry78yqWsCl00L2OuLBySNaFp2q7uLNT52W4wepbx
        DYoMLjywNR/oKNy+YHDNyF4O+BhXqa1LDmkduqqIdrEuuzw6afVFf0zsr+5BLO8ct0qyS7P3
        DhBi0jiRpwsqkYr+AtRYEstbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xu7q3U3fFGZw7bWPRe+4kk8XGGetZ
        LRb19rJY/N82kdniytf3bBYrVx9lsliw39riy5WHTBabHl9jtbi8aw6bxeXmi4wWa4/cZbdo
        ajG2uHvvBIvFwQ9PWB34PdbMW8PosffbAhaPnbPusntsWtXJ5rH92wNWj/vdx5k8Ni+p97j9
        7zGzx+Qbyxk9dt9sYPPo/2vg0bdlFaPH501yAbxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpG
        JpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkPLn9kK5jDXXH23WPGBsZdnF2MnBwSAiYSJw7t
        YOli5OIQEljKKLH20htmiISMxMlpDawQtrDEn2tdbBBFnxgl3u85CJZgEzCU6HoLkRAR6GSU
        mNb9kR3EYRY4xiyx8fF7sFHCAqESjd/Ps4HYLAKqEm3X3zCB2LwCdhIn+3exQ6yQl1i94QBY
        PSdQ/P78PywgtpBAocSjq29ZJjDyLWBkWMUoklpanJueW2ykV5yYW1yal66XnJ+7iREYUduO
        /dyyg7HrXfAhRgEORiUe3g6jnXFCrIllxZW5hxglOJiVRHhbMoFCvCmJlVWpRfnxRaU5qcWH
        GE2BjprILCWanA+M9rySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxS
        DYzcZ54IKl/4ltzlyN3+c5u4Q9jyy/+d4nWuvNiRzV02a65SkujS8BNNUT0ix5PlV0tfvr/8
        QOWpHle5qq6AazOnL7l5LnoKp3VlTM+Tqwvz2JryFyyu2y5yvWNF/MQTVbkTZs89IDR5dWP5
        1D/1r3l+R31ReS783HU/e8uHU292rCs48ps94sEPJZbijERDLeai4kQA7bBGYr4CAAA=
X-CMS-MailID: 20200512090116eucas1p2089d6eb7aa6bad4d2cbc2875c175873f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200512090116eucas1p2089d6eb7aa6bad4d2cbc2875c175873f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090116eucas1p2089d6eb7aa6bad4d2cbc2875c175873f
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
        <20200512090058.14910-1-m.szyprowski@samsung.com>
        <CGME20200512090116eucas1p2089d6eb7aa6bad4d2cbc2875c175873f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper for converting a sg_table object into struct
page pointer array.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 6c34c06..14fcd48 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -233,9 +233,7 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct mtk_drm_gem_obj *mtk_gem = to_mtk_gem_obj(obj);
 	struct sg_table *sgt;
-	struct sg_page_iter iter;
 	unsigned int npages;
-	unsigned int i = 0;
 
 	if (mtk_gem->kvaddr)
 		return mtk_gem->kvaddr;
@@ -249,11 +247,8 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 	if (!mtk_gem->pages)
 		goto out;
 
-	for_each_sg_page(sgt->sgl, &iter, sgt->orig_nents, 0) {
-		mtk_gem->pages[i++] = sg_page_iter_page(&iter);
-		if (i > npages)
-			break;
-	}
+	drm_prime_sg_to_page_addr_arrays(sgt, mtk_gem->pages, NULL, npages);
+
 	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
 			       pgprot_writecombine(PAGE_KERNEL));
 
-- 
1.9.1

