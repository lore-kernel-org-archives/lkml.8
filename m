Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DE0C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7BF206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M77Z30Ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgFRPk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:40:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54583 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbgFRPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:40:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200618154017euoutp0106eff206b9dbed0dd3849c4ae347a2e2~ZrZl758Y41844218442euoutp01u
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:40:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200618154017euoutp0106eff206b9dbed0dd3849c4ae347a2e2~ZrZl758Y41844218442euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592494818;
        bh=2j4VOIyj+ZqS7pbMauJtR1DqpO1spnMvG+cpfDpVzMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M77Z30UbbET4XcjuS422RXVyLFI7E7quP6UhDnBUIwUeKt3LnFvTY1P7iZYZ76tQV
         DweAD/0/BYc3eNiBWd6QiugEYCitA9TMAv+WDL6LLuqMftB0Ya8/0nqXHqM2rh974K
         vGVw1qWhs7aYrozMpKT/QbeAffurawZeyUlUTTUk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200618154017eucas1p2279d84a738dd9298e930e52c5efcc17e~ZrZlVclah2502725027eucas1p21;
        Thu, 18 Jun 2020 15:40:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EC.0F.61286.1EA8BEE5; Thu, 18
        Jun 2020 16:40:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154016eucas1p12cda9c412f9891f191cb9e997be9da26~ZrZk527A61547315473eucas1p1I;
        Thu, 18 Jun 2020 15:40:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200618154016eusmtrp269f3266141679068fd302e3ea7f17450~ZrZk5OVbL0370403704eusmtrp2a;
        Thu, 18 Jun 2020 15:40:16 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-ba-5eeb8ae11c8f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E1.EE.08375.0EA8BEE5; Thu, 18
        Jun 2020 16:40:16 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154016eusmtip1ceb3a9fbdfde399373beba80c1e11c50~ZrZkJ2UT40709107091eusmtip1q;
        Thu, 18 Jun 2020 15:40:16 +0000 (GMT)
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
        amd-gfx@lists.freedesktop.org
Subject: [PATCH v6 04/36] drm: amdgpu: fix common struct sg_table related
 issues
Date:   Thu, 18 Jun 2020 17:39:25 +0200
Message-Id: <20200618153956.29558-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN63TaAWkzFBKegAJ1QQlrAB1FEYkm86VGP0hMRCoMi9JCWhYx
        JlQISiooQiIIIpXUgKyKUFksW8SCQIGyCAEFBD8AQcOWsNaWAeTvnHPPeefe5GEIbxS1xMJE
        UZRYJAjns4yZyi8rGqdx2Yy/a7uCS6Rq2hjE85E6lHhT/oBNvM8qR4nZUT3VKZ8hRN/SHxbx
        triFQcgbvIjFvnEGUTExgBK9tS9ZROnn72yi6e8k6sMlk7QbLLLkVQkgVctyJvlxeQwlRx+r
        GeQHRTw5vDmBkBmDBYCsG5KyyCeVRYBcqDh4Zd914zNBVHhYDCV28Q4wDlWqNkBklv3dfIWf
        FIzayoARBnEPKHuUzpABY4yHFwKYNKdj02QRwPr1cSZNFgDMnVtl70R6kssQelAAoLYzhbUb
        0U2pgMHFwt2gbFbGMmBzPAnA1lQTgwnBFQhUjNQzDQMz/CrMWUvbepaJH4GVGfmIAXPws/Dr
        ylMmXWcDi981bulGuDdsVyehtMcUtr2Y3PIgek9iVc7WShDfYMOuto7t8AWo+bmwvbcZnFZX
        bmNrqKvJY9CBRADHNaVsmqQA2JuQBWiXFxzRrOpvwPQVx2F5rQstn4fT8+WoQYY4Fw7OmtJL
        cGG6MhOhZQ5Mfsij3Udhtrpst7apW4vQmIQNHclIGrDL3nNO9p5zsv/3ygFSBCyoaIkwhJK4
        iahYZ4lAKIkWhTgHRggrgP7btW+q56vBkvZWM8AxwDfh+PjN+PNQQYwkTtgMIIbwzTm+ne3+
        PE6QIO4eJY64KY4OpyTNwApj8i047vlTN3h4iCCKukNRkZR4Z8rAjCylwNHj9IHhIaz0csTF
        zCGnH6lSVBpSNxZQKLrta0Y5ULGtNodPRX9r/D2hq/RVVcd5WtnJTxpNulpaxq90Kep/naix
        trPoX8wzcffEg1U93v2fzq3bxm8o7b0cXzvODWoHVnMD87XX+DnN3ABlQsshoeKYyrwzeH/3
        /TWTqkugYpLPlIQK3BwQsUTwD1/fY55yAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xu7oPul7HGbRN17XoPXeSyWLand2s
        FkvXN7JbbJyxntXi7X0g9/+2icwWV76+Z7NYufook8WC/dYWX648ZLLY9Pgaq8XlXXPYLNYe
        uctucfDDE1YHPo/WS3/ZPNbMW8PosffbAhaP7d8esHrc7z7O5LF5Sb3H7X+PmT0m31jO6LH7
        ZgObR9+WVYwenzfJBXBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mk
        pOZklqUW6dsl6GVs2/uXsWCGesWiJeENjPcVuhg5OSQETCQudqxj7mLk4hASWMooseBRByNE
        Qkbi5LQGVghbWOLPtS42iKJPjBJn+pewgCTYBAwlut5CJEQEOhklpnV/ZAdxmAXWMEvc+74c
        yOHgEBYIkLi3oACkgUVAVWLL5EXMIDavgK3EqZ/9LBAb5CVWbzgAFucUsJM4fbwVbLMQUM3z
        D21sEPWCEidnPmEBGcksoC6xfp4QSJgZqLV562zmCYyCs5BUzUKomoWkagEj8ypGkdTS4tz0
        3GJDveLE3OLSvHS95PzcTYzA+N127OfmHYyXNgYfYhTgYFTi4X0R8jpOiDWxrLgy9xCjBAez
        kgiv09nTcUK8KYmVValF+fFFpTmpxYcYTYFem8gsJZqcD0wteSXxhqaG5haWhubG5sZmFkri
        vB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGAWcPa/3+e5vuzzdclfL0b1vcld032429InnMfGV
        XGFt5qNkUXujLCsgMM7s7v/rQieuqPAsqTodu1fR1IvXeQPnfUnmE7m6U8MjWcp9TiouuRWU
        9Wn/apn/rbVOLGoi3zccTe95r/l8ulSD/J3y/zL9F18tfSCmGRjHeaRhj8rUnI4WTg8pJZbi
        jERDLeai4kQASBqYOvUCAAA=
X-CMS-MailID: 20200618154016eucas1p12cda9c412f9891f191cb9e997be9da26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200618154016eucas1p12cda9c412f9891f191cb9e997be9da26
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154016eucas1p12cda9c412f9891f191cb9e997be9da26
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
        <CGME20200618154016eucas1p12cda9c412f9891f191cb9e997be9da26@eucas1p1.samsung.com>
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 9 +++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 8 ++++----
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 43d8ed7dbd00..519ce4427fce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -307,8 +307,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		if (IS_ERR(sgt))
 			return sgt;
 
-		if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
-				      DMA_ATTR_SKIP_CPU_SYNC))
+		if (dma_map_sgtable(attach->dev, sgt, dir,
+				    DMA_ATTR_SKIP_CPU_SYNC))
 			goto error_free;
 		break;
 
@@ -349,7 +349,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 
 	if (sgt->sgl->page_link) {
-		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
+		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5129a996e941..97fb73e5a6ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1025,7 +1025,6 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(ttm->bdev);
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
-	unsigned nents;
 	int r;
 
 	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
@@ -1040,9 +1039,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 		goto release_sg;
 
 	/* Map SG to device */
-	r = -ENOMEM;
-	nents = dma_map_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-	if (nents == 0)
+	r = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
+	if (r)
 		goto release_sg;
 
 	/* convert SG to linear array of pages and dma addresses */
@@ -1073,8 +1071,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
 		return;
 
 	/* unmap the pages mapped to the device */
-	dma_unmap_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-
+	dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
 	sg_free_table(ttm->sg);
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index d399e5893170..75495a7898b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -477,11 +477,11 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	if (r)
 		goto error_free;
 
-	for_each_sg((*sgt)->sgl, sg, num_entries, i)
+	for_each_sgtable_sg(*sgt, sg, i)
 		sg->length = 0;
 
 	node = mem->mm_node;
-	for_each_sg((*sgt)->sgl, sg, num_entries, i) {
+	for_each_sgtable_sg(*sgt, sg, i) {
 		phys_addr_t phys = (node->start << PAGE_SHIFT) +
 			adev->gmc.aper_base;
 		size_t size = node->size << PAGE_SHIFT;
@@ -501,7 +501,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	return 0;
 
 error_unmap:
-	for_each_sg((*sgt)->sgl, sg, num_entries, i) {
+	for_each_sgtable_sg(*sgt, sg, i) {
 		if (!sg->length)
 			continue;
 
@@ -532,7 +532,7 @@ void amdgpu_vram_mgr_free_sgt(struct amdgpu_device *adev,
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sg(sgt->sgl, sg, sgt->nents, i)
+	for_each_sgtable_sg(sgt, sg, i)
 		dma_unmap_resource(dev, sg->dma_address,
 				   sg->length, dir,
 				   DMA_ATTR_SKIP_CPU_SYNC);
-- 
2.17.1

