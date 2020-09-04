Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63364C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F35B206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t3uxmPk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbgIDOMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:12:48 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44854 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730602AbgIDNpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:45:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200904133504euoutp01ed343a12e1c763c90a0862d5e339d7cc~xmAhQS7yt0639206392euoutp01E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:35:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200904133504euoutp01ed343a12e1c763c90a0862d5e339d7cc~xmAhQS7yt0639206392euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599226504;
        bh=WoSv7+spuaWSTpC0ImjM1JGhGz54zUZOrmHK6BoCMAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t3uxmPk144iGmZccFubyx8kp4qqAFRyFpClR4GzWDDGPrnXmnScnxt61vkZWfpu5c
         Tb8dI5f4t7zhJxj4n0RawzO+Qk5SaCm1FH8/HH132YBOk2Rb1/sxLFoeBUx2OJWRyY
         CZHuCDqEXdQ3C+1lWo/XmAPeMBCBX4gwAG+RjpuA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200904133503eucas1p1c3f2f92b70014c423162a2ac9e98d2d7~xmAg_j8pX2307023070eucas1p1P;
        Fri,  4 Sep 2020 13:35:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8A.66.05997.782425F5; Fri,  4
        Sep 2020 14:35:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200904133503eucas1p202bbb31f2dcc8430b2a22ba419738c91~xmAgoATIm0781307813eucas1p26;
        Fri,  4 Sep 2020 13:35:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200904133503eusmtrp2ee8d1fce3a5b6f4482712eb495a6c7bd~xmAgnT6eF0977109771eusmtrp2D;
        Fri,  4 Sep 2020 13:35:03 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-66-5f5242874e7e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 87.A0.06017.782425F5; Fri,  4
        Sep 2020 14:35:03 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200904133502eusmtip1c46ed2d097e498bc4b7cea60e9587303~xmAf-Ah8B1932019320eusmtip1Q;
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
Subject: [PATCH v10 16/30] drm: rockchip: fix common struct sg_table related
 issues
Date:   Fri,  4 Sep 2020 15:16:57 +0200
Message-Id: <20200904131711.12950-17-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSeUhUURTGvfMWn+bYaxS8aCYMFBjkkv7xSrHUqBeWhFFhUfbSl0rOaDNq
        WVaiZDLuGmYyuUQy5ZLmuFdulUviKGrulssYmIrhForj5PjM/vt9556P75zDJRBBHWZOBIpD
        WYmYCRLihmhl86rq0BM3Lx+74RE7KlHVxqPeZZZglLYyFaF6l+dx6k3hFx6lnZjBqBdpD6jc
        eidqqXecR5VN9mFUT60cpxbGtAhV/HlUn2r8rcaOG9NF2UWA/riSi9JVK2MY/SO+hUcrXz2i
        hzcmETp9QAHo94NROK3JqkfppPICQFf1ZSP0Ytm+c0aXDZ392KDAcFZi63LdMEAjT0dDGi3v
        DiWv8qJAA5QBgoCkI9woBTJgSAjI1wDWZ6sRTiwBKJ9cwTmxCGBDYbq+DBhsOTR1s9sWBYCd
        8ufYjiWuog/XdeGkPZTNybbYlHwMYGuikY4RMgOBBcsndWxCXoD9aR+AjlFyP+zKiMV0zCdd
        4GCyAuXSrGBhaQOiY4PNekWmeisMkt36cGh+CnBNJ2B/eRHOsQn81VK+PepeqK3J4XGGGADH
        VcX6nEgAsCc6c9vtBEdUa7juHAhpDUtqbbmyK4yO+4ZwVzKGA3N7uAWMYVrls+0yH8bFCrju
        AzCr5e1ObGNXN8IxDbWavK29BGQqgMtJLinAKut/Vi4ABcCMDZOK/FnpYTF7x0bKiKRhYn8b
        32BRGdj8Ve0bLUvVoHb9RhMgCSA04usd8/IRYEy4NELUBCCBCE35bh3t1wR8PybiHisJ9pGE
        BbHSJmBBoEIzvsPL6asC0p8JZW+xbAgr+ffKIwzMo0B0kVIcbtdsVkHNbDgfuX9KT+mhWUg+
        w0zna2siGffT389bjCa07vrk1Hb0iuWlPst8pKeaPuuwHlxPWP+sIyPXbgvzvNUeOaaKp5am
        f4oHVY7Vu+M9w29GWngGKL1TJoIHvGJEaoN+9/5O3wmUmL0oWZ962BFoXj0+4erz1cFMiEoD
        GPuDiETK/AXS5GSlUQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xu7rtTkHxBqf3SFr0njvJZLFxxnpW
        i//bJjJbXPn6ns1i5eqjTBb/H71mtZg7qdZiwX5riy9XHjJZbHp8jdXi8q45bBafHvxntlh7
        5C67xcEPT1gd+DzWzFvD6LH32wIWj+3fHrB63O8+zuSxeUm9x+1/j5k9Jt9Yzuix+2YDm8ff
        WftZPPq2rGL02H5tHrPH501yATxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZG
        pkr6djYpqTmZZalF+nYJehl/50xmKTgoW3Gr/ydTA+MBiS5GTg4JAROJv/veMHYxcnEICSxl
        lJh6YAEjREJG4uS0BlYIW1jiz7UuNoiiT4wSq7oOsIEk2AQMJbreQiREBDoZJaZ1f2QHcZgF
        5jFLLF91mAmkSlggWOJ7yzIwm0VAVeLCtDawsbwCdhI3+5ezQKyQl1i94QAziM0JFN864wlY
        jZCArcSHOYtZJjDyLWBkWMUoklpanJueW2ykV5yYW1yal66XnJ+7iREYP9uO/dyyg7HrXfAh
        RgEORiUeXgb7oHgh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZWpRblxxeV5qQWH2I0BTpqIrOU
        aHI+MLbzSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUw2r+wftb1
        7deV2PK7btzLLPMm1cV4+z36sufljUMXf2/UZmppYzDXFLzUdPN8DWe4tCLXp0X282+7u0Tu
        9UmMMpYs8X+jNTnY4fM6+dPx9YbHrW7N3bt3NcNKuRg1/+bMG+6301YFuKw6f+rZmjfah7fb
        9DhXtnA+b1r2eUH43RWFL1N4vq7eqsRSnJFoqMVcVJwIAPaeM961AgAA
X-CMS-MailID: 20200904133503eucas1p202bbb31f2dcc8430b2a22ba419738c91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200904133503eucas1p202bbb31f2dcc8430b2a22ba419738c91
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133503eucas1p202bbb31f2dcc8430b2a22ba419738c91
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
        <CGME20200904133503eucas1p202bbb31f2dcc8430b2a22ba419738c91@eucas1p2.samsung.com>
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 23 +++++++++------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 2970e534e2bb..cb50f2ba2e46 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -36,8 +36,8 @@ static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
 
 	rk_obj->dma_addr = rk_obj->mm.start;
 
-	ret = iommu_map_sg(private->domain, rk_obj->dma_addr, rk_obj->sgt->sgl,
-			   rk_obj->sgt->nents, prot);
+	ret = iommu_map_sgtable(private->domain, rk_obj->dma_addr, rk_obj->sgt,
+				prot);
 	if (ret < rk_obj->base.size) {
 		DRM_ERROR("failed to map buffer: size=%zd request_size=%zd\n",
 			  ret, rk_obj->base.size);
@@ -98,11 +98,10 @@ static int rockchip_gem_get_pages(struct rockchip_gem_object *rk_obj)
 	 * TODO: Replace this by drm_clflush_sg() once it can be implemented
 	 * without relying on symbols that are not exported.
 	 */
-	for_each_sg(rk_obj->sgt->sgl, s, rk_obj->sgt->nents, i)
+	for_each_sgtable_sg(rk_obj->sgt, s, i)
 		sg_dma_address(s) = sg_phys(s);
 
-	dma_sync_sg_for_device(drm->dev, rk_obj->sgt->sgl, rk_obj->sgt->nents,
-			       DMA_TO_DEVICE);
+	dma_sync_sgtable_for_device(drm->dev, rk_obj->sgt, DMA_TO_DEVICE);
 
 	return 0;
 
@@ -350,8 +349,8 @@ void rockchip_gem_free_object(struct drm_gem_object *obj)
 		if (private->domain) {
 			rockchip_gem_iommu_unmap(rk_obj);
 		} else {
-			dma_unmap_sg(drm->dev, rk_obj->sgt->sgl,
-				     rk_obj->sgt->nents, DMA_BIDIRECTIONAL);
+			dma_unmap_sgtable(drm->dev, rk_obj->sgt,
+					  DMA_BIDIRECTIONAL, 0);
 		}
 		drm_prime_gem_destroy(obj, rk_obj->sgt);
 	} else {
@@ -476,15 +475,13 @@ rockchip_gem_dma_map_sg(struct drm_device *drm,
 			struct sg_table *sg,
 			struct rockchip_gem_object *rk_obj)
 {
-	int count = dma_map_sg(drm->dev, sg->sgl, sg->nents,
-			       DMA_BIDIRECTIONAL);
-	if (!count)
-		return -EINVAL;
+	int err = dma_map_sgtable(drm->dev, sg, DMA_BIDIRECTIONAL, 0);
+	if (err)
+		return err;
 
 	if (drm_prime_get_contiguous_size(sg) < attach->dmabuf->size) {
 		DRM_ERROR("failed to map sg_table to contiguous linear address.\n");
-		dma_unmap_sg(drm->dev, sg->sgl, sg->nents,
-			     DMA_BIDIRECTIONAL);
+		dma_unmap_sgtable(drm->dev, sg, DMA_BIDIRECTIONAL, 0);
 		return -EINVAL;
 	}
 
-- 
2.17.1

