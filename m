Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B5EC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BEB2208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fnw2RHm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbgFSKho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:37:44 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38648 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732415AbgFSKg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:36:58 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200619103656euoutp0110ce9475f55d2ec5267f872f25ca3919~Z66A3FPaE1836618366euoutp01S
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:36:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200619103656euoutp0110ce9475f55d2ec5267f872f25ca3919~Z66A3FPaE1836618366euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592563016;
        bh=CcvLwj30v0ZE0u3onBoCrQSZV9YR8EBATMNe+CvGifQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnw2RHm45eJ7Mu16yM3x+Q4IMGqPOQRRXfeBEGtBRK76InbQCRpvCkGsBxcVA7cjI
         qutNgQdKOs0tQeMOc0vVY0na4JObA3cDbAeqUxzM501o63ybHpEESb6+MA+r1pbWVh
         mukr8dzcELwo/BZ762AOD7nMIkAIRJ0kNUkyaWSw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200619103656eucas1p2eeb35cd864c4c3ac324180a29467bd36~Z66AZc7vo2889228892eucas1p2i;
        Fri, 19 Jun 2020 10:36:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5D.8D.05997.8459CEE5; Fri, 19
        Jun 2020 11:36:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200619103655eucas1p28ea4bf59428550217c8962666d6f077b~Z66AForP73081430814eucas1p2h;
        Fri, 19 Jun 2020 10:36:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200619103655eusmtrp1765c6535087319d4063a4fbdb267f94c~Z66AE9UQY0949709497eusmtrp17;
        Fri, 19 Jun 2020 10:36:55 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-d0-5eec95487ea4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BB.DA.06314.7459CEE5; Fri, 19
        Jun 2020 11:36:55 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200619103655eusmtip22bfe57e52a587852b365a94a7ce76a4a~Z65-ah3Dv2581725817eusmtip2j;
        Fri, 19 Jun 2020 10:36:55 +0000 (GMT)
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
Subject: [PATCH v7 04/36] drm: amdgpu: fix common struct sg_table related
 issues
Date:   Fri, 19 Jun 2020 12:36:04 +0200
Message-Id: <20200619103636.11974-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+XZ2zo7LyXGKflhkDjJS8lIWhzTL8I8TRIX6V3lp6UElN21T
        ywiampVXLCtvNYYo2tS85CUnWUo6pzlLpQyXl7y1zBRcVjatzaPlf8/zfr+H533hwxH+KOqA
        R4vjaYlYGCPAuOymrl/afdT9r6EeyUqEzNZqWOQDXStKltUkc8i6ghqUnB8z2T9NdxBy6PsC
        Rj6u7GSRihfepGFogkXWT75DyUHVQ4ysfvWRQ7YvTqHHrKi0gVWMqpJXAer5soJNNS+Po9RY
        pppFPS29To2sTSJU3nA5oFo/yDAqp0EJqKX6nWe2neX6RNAx0Ym0xN33PDdKZcxixcn3XClZ
        qUVlYHpXBrDAIeEF345NszMAF+cTFQA2548gjDEAOH6rFDBmCcC+31pkM/KjWrZBlQPYNtkB
        /kVGDUrUTGGEJ8yYz8DM2pZIA7A729IMIUQpAkt1baZGHLchAmBrcYiZYRO7oWxJwzFrHnEE
        tuQWs5k2R1hZ+3K92YLwhXM32lGGsYaawql1BjExqY3F6xtBYpUD5TmFGBP2h9XpGhajbeAX
        dQOH0Ttgb14WmwmkAjihreYwJgvAwZQCwFDeUKddwcybIsReWKNyZ8Z+sH8mZX0MCSs4PG/N
        LGEF7zblI8yYB2/f5DO0MyxSP/lX2/5mYAOhoFHjmQucirZcU7TlmqL/tQqAKIE9nSAVRdLS
        /WL6sptUKJImiCPdwmNF9cD063rX1IZnQGW80AEIHAgseZ+D5kL5qDBRmiTqABBHBLa84329
        oXxehDDpKi2JDZMkxNDSDrAdZwvseQdK9CF8IlIYT1+k6ThasvnKwi0cZCD7mwyfPuzuijj9
        1OmPVvjMckVrtNHlEV5+ujxb2egR4ZaalG6rONVd6XQoXraaEpNO5Z5rWminxMFyx1n0ZJrs
        2qCrc6FIH9jzfrHuYFDVXJ3YLuzTiYLwvvnO2Znue2q9Euu5RHQF+k/He3AyXwd4+WVZBfYX
        BBvsAlosygRsaZTQ0wWRSIV/AZnPp0BxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7ruU9/EGcyZom3Re+4kk8W0O7tZ
        LZaub2S32DhjPavF2/tA7v9tE5ktrnx9z2axcvVRJosF+60tvlx5yGSx6fE1VovLu+awWaw9
        cpfd4uCHJ6wOfB6tl/6yeayZt4bRY++3BSwe2789YPW4332cyWPzknqP2/8eM3tMvrGc0WP3
        zQY2j74tqxg9Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0MvY9aeHqWCeesWiXxtYGxifKnQxcnJICJhIfF/bwNzFyMUhJLCUUaKxbz8j
        REJG4uS0BlYIW1jiz7UuNoiiT4wSF082M4Mk2AQMJbreQiREBDoZJaZ1f2QHcZgF1jBL3Pu+
        nB2kSlggQOLXp/VgY1kEVCUaPp8Ei/MK2ErsnDCbBWKFvMTqDQfApnIK2Em8bjkItloIqGb5
        gvfMEPWCEidnPgGq5wBaoC6xfp4QSJgZqLV562zmCYyCs5BUzUKomoWkagEj8ypGkdTS4tz0
        3GJDveLE3OLSvHS95PzcTYzAGN527OfmHYyXNgYfYhTgYFTi4X0R8jpOiDWxrLgy9xCjBAez
        kgiv09nTcUK8KYmVValF+fFFpTmpxYcYTYFem8gsJZqcD0wveSXxhqaG5haWhubG5sZmFkri
        vB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGA2lPs11kDv+c17Dslqf3gmd28VkrzGJHXOzMMl7
        o3Sp4ODx1TtZilv9haawpr15b5decNdNYpfsinnvjD9vMVt2toRRs7fs4enF3aJKvusei/MF
        z+QK0/fQiZvwxDno1FReNlX1yzEXziutOdqSVbGGbSN7PfODhyLFcpespnMquD7wKVhSpsRS
        nJFoqMVcVJwIAM3A34H3AgAA
X-CMS-MailID: 20200619103655eucas1p28ea4bf59428550217c8962666d6f077b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200619103655eucas1p28ea4bf59428550217c8962666d6f077b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103655eucas1p28ea4bf59428550217c8962666d6f077b
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
        <CGME20200619103655eucas1p28ea4bf59428550217c8962666d6f077b@eucas1p2.samsung.com>
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
index d399e5893170..c281aa13f5ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -477,11 +477,11 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	if (r)
 		goto error_free;
 
-	for_each_sg((*sgt)->sgl, sg, num_entries, i)
+	for_each_sgtable_sg((*sgt), sg, i)
 		sg->length = 0;
 
 	node = mem->mm_node;
-	for_each_sg((*sgt)->sgl, sg, num_entries, i) {
+	for_each_sgtable_sg((*sgt), sg, i) {
 		phys_addr_t phys = (node->start << PAGE_SHIFT) +
 			adev->gmc.aper_base;
 		size_t size = node->size << PAGE_SHIFT;
@@ -501,7 +501,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	return 0;
 
 error_unmap:
-	for_each_sg((*sgt)->sgl, sg, num_entries, i) {
+	for_each_sgtable_sg((*sgt), sg, i) {
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

