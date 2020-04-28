Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E75C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D37A206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ces5k71L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgD1NUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:20:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59471 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgD1NU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:20:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200428132026euoutp02e116dc1c5530ec6d624fc6e3545f69d5~J-l7IrTG92992529925euoutp02E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:20:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200428132026euoutp02e116dc1c5530ec6d624fc6e3545f69d5~J-l7IrTG92992529925euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588080026;
        bh=eD0W2i9dbIiSz9HVwrPxquvropyufixfeCFzM0la5XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ces5k71LJ+t35ODGiktp+UcYljmvLJW+mG5dXL4vg9C9YOfbI/O43ldeDO3+YTeFA
         YszMr9qpIdzbneNSZlMsDL84Uupp+T8yZ1e8ZTB/0+X3Lk+XVBWwXpMobCeg28X521
         vBQ871tMN0zxFUMrg0iO0Dm8c6XpJCXPnEVh4jIk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200428132025eucas1p12ba6985126a68a90e062c5bae34067c3~J-l6Odzch1367713677eucas1p1R;
        Tue, 28 Apr 2020 13:20:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A5.B4.61286.99D28AE5; Tue, 28
        Apr 2020 14:20:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200428132025eucas1p15cf78bdedef6eebc477c7e8429a6f971~J-l5sOP1g3052430524eucas1p1R;
        Tue, 28 Apr 2020 13:20:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200428132025eusmtrp16811b52fea5ba357114dc7da2cdd64d0~J-l5rYnUg1743317433eusmtrp1w;
        Tue, 28 Apr 2020 13:20:25 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-6e-5ea82d9927fb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5B.96.08375.99D28AE5; Tue, 28
        Apr 2020 14:20:25 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200428132024eusmtip2571a9aa820afc51fde9f2a6ce911c63e~J-l5H3l9V1062310623eusmtip2l;
        Tue, 28 Apr 2020 13:20:24 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [RFC 05/17] drm: exynos: fix sg_table nents vs. orig_nents misuse
Date:   Tue, 28 Apr 2020 15:19:53 +0200
Message-Id: <20200428132005.21424-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djP87ozdVfEGWyfrGHRe+4kk8XS9Y3s
        FhtnrGe1aDp0is3i/7aJzBZXvr5ns1i5+iiTxewJm5ksFuy3tvhy5SGTxabH11gtLu+aw2ax
        9shddouDH56wWpy6+5ndgd9jzbw1jB57vy1g8bhzbQ+bx/ZvD1g97ncfZ/LYvKTe4/a/x8we
        k28sZ/TYfbOBzaNvyypGj8+b5AK4o7hsUlJzMstSi/TtErgyLm+bw1TwhKdiXddD9gbGj1xd
        jJwcEgImEo8nzWPuYuTiEBJYwSjRdGwnlPOFUaKvZSIThPOZUWJ+axcbTMv5hkZ2iMRyRokj
        83YgtJxcNBusik3AUKLrLUSHiEAro8SJXh6QImaBbcwST5YfYQdJCAt4SVztWgZmswioSuxc
        sRTI5uDgFbCV2HRUH2KbvMTqDQeYQWxOATuJpY+esoHMkRC4xi5x4eIuFogiF4k/a/ZDnScs
        8er4FnYIW0bi9OQeFoiGZkaJh+fWskM4PYwSl5tmMEJUWUvcOfeLDWQzs4CmxPpdUJsdJU42
        94EdJCHAJ3HjrSBImBnInLRtOjNEmFeio00IolpNYtbxdXBrD164xAxhe0gsXPyVERJAExkl
        ds/fyjyBUX4WwrIFjIyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAhPW6X/HP+1g/Hop
        6RCjAAejEg/vBp4VcUKsiWXFlbmHGCU4mJVEeB9lLIsT4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zmu86GWskEB6YklqdmpqQWoRTJaJg1OqgdHIx1w+zHBW+UZWB760Swpf5LYptyxrf6Ju891F
        3vWthwC744qp0jfsWOKLq6J5ThbH2ffulXtxv1xe62/hlHTOrU8+nC1z/DzDTPxS4veu637p
        +g/XMgoaGCv5cBxbwG3y9br+7AIj3erC+IMLOc33yoq9Uw9KPHvv6bqGeH67xZ9eLr3DpMRS
        nJFoqMVcVJwIAJzKOCZUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7ozdVfEGXRtYLXoPXeSyWLp+kZ2
        i40z1rNaNB06xWbxf9tEZosrX9+zWaxcfZTJYvaEzUwWC/ZbW3y58pDJYtPja6wWl3fNYbNY
        e+Quu8XBD09YLU7d/czuwO+xZt4aRo+93xaweNy5tofNY/u3B6we97uPM3lsXlLvcfvfY2aP
        yTeWM3rsvtnA5tG3ZRWjx+dNcgHcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFW
        RqZK+nY2Kak5mWWpRfp2CXoZl7fNYSp4wlOxrushewPjR64uRk4OCQETifMNjexdjFwcQgJL
        GSUOrvjLBpGQkTg5rYEVwhaW+HOtiw2i6BOjxJV50xhBEmwChhJdbyESIgKdjBLTuj+CjWIW
        OMAs0X3+JBNIlbCAl8TVrmXsIDaLgKrEzhVLgWwODl4BW4lNR/UhNshLrN5wgBnE5hSwk1j6
        6CkbSIkQUMnlltwJjHwLGBlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBEbPtmM/N+9gvLQx
        +BCjAAejEg/vBp4VcUKsiWXFlbmHGCU4mJVEeB9lLIsT4k1JrKxKLcqPLyrNSS0+xGgKdNJE
        ZinR5HxgZOeVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamCcwzgn
        8cTeVwdumHRneBio2leurSzYvM7xyc9lrwwfrBf3M/f59Xfur+6aVM+7ootf3cw8u/3Y2zdP
        jB4fa2ZrYv5omBR8xO3ZiS1tK6XuFro1sxp+vfLNfBJbIcfc8zOPisU9e+veOEeP0eFUiKqW
        SHiLbm2ciodebgf37ODKBzfFJS60fDRSYinOSDTUYi4qTgQATjNhTLQCAAA=
X-CMS-MailID: 20200428132025eucas1p15cf78bdedef6eebc477c7e8429a6f971
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200428132025eucas1p15cf78bdedef6eebc477c7e8429a6f971
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132025eucas1p15cf78bdedef6eebc477c7e8429a6f971
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
        <CGME20200428132025eucas1p15cf78bdedef6eebc477c7e8429a6f971@eucas1p1.samsung.com>
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
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index fcee33a..e27715c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -396,7 +396,7 @@ static void g2d_userptr_put_dma_addr(struct g2d_data *g2d,
 
 out:
 	dma_unmap_sg(to_dma_dev(g2d->drm_dev), g2d_userptr->sgt->sgl,
-			g2d_userptr->sgt->nents, DMA_BIDIRECTIONAL);
+		     g2d_userptr->sgt->orig_nents, DMA_BIDIRECTIONAL);
 
 	pages = frame_vector_pages(g2d_userptr->vec);
 	if (!IS_ERR(pages)) {
@@ -511,8 +511,9 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct g2d_data *g2d,
 
 	g2d_userptr->sgt = sgt;
 
-	if (!dma_map_sg(to_dma_dev(g2d->drm_dev), sgt->sgl, sgt->nents,
-				DMA_BIDIRECTIONAL)) {
+	sgt->nents = dma_map_sg(to_dma_dev(g2d->drm_dev), sgt->sgl,
+				sgt->orig_nents, DMA_BIDIRECTIONAL)
+	if (!sgt->nents) {
 		DRM_DEV_ERROR(g2d->dev, "failed to map sgt with dma region.\n");
 		ret = -ENOMEM;
 		goto err_sg_free_table;
-- 
1.9.1

