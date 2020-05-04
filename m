Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E53C4725A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94062071C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O/TAKsrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgEDMzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:55:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59235 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgEDMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:54:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200504125417euoutp02d35bc777bf2b51219459e61d40fee5ed~L1Gzdw9It1833318333euoutp023
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:54:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200504125417euoutp02d35bc777bf2b51219459e61d40fee5ed~L1Gzdw9It1833318333euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588596857;
        bh=c7vIvhcriEUaiVnoYU6N02QN2Wz5ujHuRtSB4X7g6BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/TAKsrY3mkcyCgaE5XUC/j1bPX01J9fhIYBD6w2Gg+agfBfDmujcv9YQMZKk4JTB
         FZ7D3qof+Ij8joNhxpOjMQnDf0fz0lFcwzDl2DV4zwj71FMdAlxKtlwxjudD99FlgT
         bThwQFzvErk+WtORKnds7fwoqluV9kzIwgKqPPE4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200504125417eucas1p266462b46ae2d3038bfc90a510f51e63c~L1GzEKRtQ2227522275eucas1p2q;
        Mon,  4 May 2020 12:54:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 77.12.60698.97010BE5; Mon,  4
        May 2020 13:54:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200504125416eucas1p2ab599ff4137e6c25d6847b83e7f69613~L1GysgZyu2427724277eucas1p2z;
        Mon,  4 May 2020 12:54:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200504125416eusmtrp13fc13fb058264e8dbf61f580005ea276~L1GyryiwX2497724977eusmtrp1Z;
        Mon,  4 May 2020 12:54:16 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-50-5eb010791bb5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D8.06.07950.87010BE5; Mon,  4
        May 2020 13:54:16 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200504125415eusmtip25424ca4fe224be8c1293eca7b13ce65f~L1Gx666kE3246632466eusmtip2b;
        Mon,  4 May 2020 12:54:15 +0000 (GMT)
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
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 10/21] drm: radeon: fix sg_table nents vs. orig_nents
 misuse
Date:   Mon,  4 May 2020 14:53:48 +0200
Message-Id: <20200504125359.5678-10-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125359.5678-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djP87qVAhviDH48ZrHoPXeSyWLand2s
        FkvXN7JbbJyxntXi7X0g9/+2icwWS76cZ7W48vU9m8XK1UeZLBbst7b4cuUhk8Wmx9dYLS7v
        msNmsfbIXXaLgx+esDrwe7Re+svmsWbeGkaPvd8WsHhs//aA1eN+93Emj81L6j1u/3vM7DH5
        xnJGj903G9g8+rasYvT4vEkugDuKyyYlNSezLLVI3y6BK2NX9zPGgslCFXPWPWFsYFzH38XI
        wSEhYCLx42NSFyMXh5DACkaJhx+XMkE4Xxgl1i3ezQLhfGaUWPDmAXMXIydYx7OWRjaIxHJG
        iYVXLzDCtSz7/wGsik3AUKLrbRcbiC0i0MoocaKXB6SIWeAqs8SaJbdYQRLCAoESL2Z0gxWx
        CKhK9P+dzwRi8wrYSpx9u4EVYp28xOoNB5hBjuUEis/sVYcoEZQ4OfMJC4jNDFTSvHU2M8h8
        CYFGDomZFxcxQfS6SPw5tZURwhaWeHV8CzuELSNxenIPC0RDM9DX59ayQzg9jBKXm2ZAdVhL
        3Dn3iw1kM7OApsT6XfoQYUeJjmlTWSGhxydx460gxBF8EpO2TWeGCPNKdLQJQVSrScw6vg5u
        7cELl6Ch6CHxZVIf8wRGxVlI3pmF5J1ZCHsXMDKvYhRPLS3OTU8tNs5LLdcrTswtLs1L10vO
        z93ECEx6p/8d/7qDcd+fpEOMAhyMSjy8EZ/XxwmxJpYVV+YeYpTgYFYS4d3RAhTiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomDU6qB0TmD0TTfqTNix9cYrYKU
        vPWtsvuLxb/HGwrM1Hy8ji3myPKDu8y+ThAW/2/Vc+SX5dWj+Uu/VwuvMf3Pn9ihWfJRvvTQ
        VJ6XN1da+VZNaduw197ecGez1NnGHfGbwlPDNx44eUXGRMhy/idXM56YOr60e9fqg+x3dS7I
        FP4921enpImrU+m7EktxRqKhFnNRcSIAHDGrtXYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsVy+t/xe7oVAhviDPZO0LHoPXeSyWLand2s
        FkvXN7JbbJyxntXi7X0g9/+2icwWS76cZ7W48vU9m8XK1UeZLBbst7b4cuUhk8Wmx9dYLS7v
        msNmsfbIXXaLgx+esDrwe7Re+svmsWbeGkaPvd8WsHhs//aA1eN+93Emj81L6j1u/3vM7DH5
        xnJGj903G9g8+rasYvT4vEkugDtKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srI
        VEnfziYlNSezLLVI3y5BL2NX9zPGgslCFXPWPWFsYFzH38XIySEhYCLxrKWRrYuRi0NIYCmj
        xN0JD1ggEjISJ6c1sELYwhJ/rnVBFX1ilOg7tJsJJMEmYCjR9RYiISLQySgxrfsjO0iCWeAu
        s8SKKbkgtrCAv8SJX2vBprIIqEr0/50P1swrYCtx9u0GqA3yEqs3HGDuYuTg4ASKz+xVBwkL
        CeRL3H36jwWiXFDi5MwnLCAlzALqEuvnCUFskpdo3jqbeQKj4CwkVbMQqmYhqVrAyLyKUSS1
        tDg3PbfYSK84Mbe4NC9dLzk/dxMjMJK3Hfu5ZQdj17vgQ4wCHIxKPLwbvq6PE2JNLCuuzD3E
        KMHBrCTCu6MFKMSbklhZlVqUH19UmpNafIjRFOizicxSosn5wCSTVxJvaGpobmFpaG5sbmxm
        oSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB0eUMVyin70GGuSrxc9K+ZgWUGa3QM4w+dfti
        73XDzc+eF3/a9t14qWrmw++MQvc+v1GM2b3pT8OTm+2JUm9cHRjL9ygvvnXpkzHj1egtrXGr
        NHhPCEhfqGJ23NF08Ovpk4YnCvnKkkuDLhYui1z+8twWln8x097Nz2aNfep3c3Ni7/foT0xG
        25RYijMSDbWYi4oTAfEh4x36AgAA
X-CMS-MailID: 20200504125416eucas1p2ab599ff4137e6c25d6847b83e7f69613
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200504125416eucas1p2ab599ff4137e6c25d6847b83e7f69613
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504125416eucas1p2ab599ff4137e6c25d6847b83e7f69613
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
        <20200504125359.5678-1-m.szyprowski@samsung.com>
        <CGME20200504125416eucas1p2ab599ff4137e6c25d6847b83e7f69613@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
numer of the created entries in the DMA address space. However the
subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
called with the original number of entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. Adapt the code to obey those rules.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
For more information, see '[PATCH v2 00/21] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/4/373
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 5d50c9e..f8275c8 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -481,7 +481,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 {
 	struct radeon_device *rdev = radeon_get_rdev(ttm->bdev);
 	struct radeon_ttm_tt *gtt = (void *)ttm;
-	unsigned pinned = 0, nents;
+	unsigned pinned = 0;
 	int r;
 
 	int write = !(gtt->userflags & RADEON_GEM_USERPTR_READONLY);
@@ -522,8 +522,9 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 		goto release_sg;
 
 	r = -ENOMEM;
-	nents = dma_map_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-	if (nents == 0)
+	ttm->sg->nents = dma_map_sg(rdev->dev, ttm->sg->sgl,
+				    ttm->sg->orig_nents, direction);
+	if (ttm->sg->nents == 0)
 		goto release_sg;
 
 	drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
@@ -554,9 +555,9 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
 		return;
 
 	/* free the sg table and pages again */
-	dma_unmap_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
+	dma_unmap_sg(rdev->dev, ttm->sg->sgl, ttm->sg->orig_nents, direction);
 
-	for_each_sg_page(ttm->sg->sgl, &sg_iter, ttm->sg->nents, 0) {
+	for_each_sg_page(ttm->sg->sgl, &sg_iter, ttm->sg->orig_nents, 0) {
 		struct page *page = sg_page_iter_page(&sg_iter);
 		if (!(gtt->userflags & RADEON_GEM_USERPTR_READONLY))
 			set_page_dirty(page);
-- 
1.9.1

