Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098ABC4707B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFF4207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pBRM+zjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbgEMNdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:33:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37978 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387970AbgEMNdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:33:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200513133302euoutp02e66a37d10c2888d18b71ec14281ff902~OmcMp3nnb3219432194euoutp02o
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:33:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200513133302euoutp02e66a37d10c2888d18b71ec14281ff902~OmcMp3nnb3219432194euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589376782;
        bh=NUt9gf2d68JnWtBJYJdP52omh5VZlWjtysYT9fjiA6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBRM+zjbTwY5Hx871iQ8CbX0tLKcdMGj4BsAn5L++ZIo1mf9VatvlbcGBsZ9s1mEA
         OrmohXB5J4/2DF4ahpwE17rwbKpRytYPAub2ivGtuQOjV16OKaGx+I1S3TbQs5PsRt
         flauH4qFyWZRdbvJw3VUPGwZ+1HwZy8NE2HJZG8s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200513133301eucas1p26764c6cded8c947eb41e8ef72f7bc649~OmcMXEJl91007610076eucas1p28;
        Wed, 13 May 2020 13:33:01 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EE.C8.60698.D07FBBE5; Wed, 13
        May 2020 14:33:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200513133301eucas1p244d094c774ad0efd5ea9125747d5cb1b~OmcL9tIGm2681326813eucas1p2B;
        Wed, 13 May 2020 13:33:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200513133301eusmtrp14dc365d5bc7aba802842f4737fd35aed~OmcL8_DVa0994509945eusmtrp1j;
        Wed, 13 May 2020 13:33:01 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-b6-5ebbf70d3518
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 22.37.07950.D07FBBE5; Wed, 13
        May 2020 14:33:01 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200513133300eusmtip1b53f1498b7191853981c2707504c3fea~OmcLN5B6o3239232392eusmtip1b;
        Wed, 13 May 2020 13:33:00 +0000 (GMT)
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
Subject: [PATCH v5 07/38] drm: amdgpu: fix common struct sg_table related
 issues
Date:   Wed, 13 May 2020 15:32:14 +0200
Message-Id: <20200513133245.6408-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTYRSF83eWDtU2QyHhZwlCjRsJW/BhIqgYeZgHF2JIjCaiFSaAsqXD
        IiZGEFGCgFRQEIhAraCAsrYgDSCNUonYIJTFWAUCamgsGtlcWGwZQN7Oufc7c/6bDIGIRzEn
        Iio2gZHFSqMluABVd//WewoXNKE+coOEytH38Kh7Rg1GPapL41MNRXUYZR612BW1HKEMc99x
        6knNKx5V3ulPzRrGeVTjxBBGDbSV4tTTlx/5VNePSSxQRGf0L+F07YNaQLfPl6N0y/wYRo/e
        0vHoJuVV+sPyBELnj1QBWvM+Fadzm6sBPdPoGrzltCAgnImOSmJk3gfOCSIbh0wgvmv3Jfnf
        IjwV/HTPAjYEJPfCGVUvLwsICDH5GMCVuzfXzCyAfV9NGGdmACxRfOOtR0oKplFuUQVgQWUD
        thFZqWhZpXDSF2aZs3CrticzAHyds9UKIaQSgUpjB2pd2JEnoMHYsxpAyR1QPjC4GhCSAdBQ
        uIhxddtgTf0LxKptyP3QZOxEOcYW9tyfXNWIhUlXlSDWAkj+5kPT0iecCwfBPEUHwmk7aNI1
        8zntAt/kZ6NcIB3Acf1TPmeyARy4VgQ4yh8a9X8sXyIsFXtgXZs3Nz4EtUrrzYRFi+CI2ZZ7
        hAjeURci3FgIM2+IOXonLNY926jt6utfQ2hY0inJA+7Fm64p3nRN8f/acoBUAwcmkY2JYFi/
        WCbZi5XGsImxEV5hcTGNwPLbvVnWzbWCjsXzWkASQLJVODasCRVj0iQ2JUYLIIFI7IXH6iwj
        Ybg05TIjizsrS4xmWC1wJlCJg9BPMXVGTEZIE5iLDBPPyNa3PMLGKRXoK1Saz7LlKUeV0S1w
        qOlLcK4hfWGXZy01uFSoUJon4j1DXGgHo+LL2+dB7ZnQ1edq2pXcC2anYJEzqvh1XfA6YG5f
        TtTJ/vxnvf3zpeNqFgk6rDuVLPcs6uZ5VE61um0/EhpWWfYw8s+w48ERg3tBvTx+/rhIcftd
        VdnRkGlnCcpGSn09EBkr/QfdZI7GcgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7q833fHGayaw2PRe+4kk8W0O7tZ
        LZaub2S32DhjPavF2/tA7v9tE5ktrnx9z2axcvVRJosF+60tvlx5yGSx6fE1VovLu+awWaw9
        cpfd4uCHJ6wOfB6tl/6yeayZt4bRY++3BSwe2789YPW4332cyWPzknqP2/8eM3tMvrGc0WP3
        zQY2j74tqxg9Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0MvYdO0VY8FBjYqJv2ewNTB+Uuxi5OSQEDCRmD3lHQuILSSwlFFi0zEXiLiM
        xMlpDawQtrDEn2tdbF2MXEA1nxglNm6cwA6SYBMwlOh6C5EQEehklJjW/ZEdxGEWWMMsce/7
        crAqYYEAiaWbf4HZLAKqEhMvX2UDsXkFbCSuTP8DtUJeYvWGA8wgNqeArcSrO/uhTsqX2Lt4
        H1S9oMTJmU+A4hxAC9Ql1s8TAgkzA7U2b53NPIFRcBaSqlkIVbOQVC1gZF7FKJJaWpybnlts
        pFecmFtcmpeul5yfu4kRGMHbjv3csoOx613wIUYBDkYlHl6LW7vjhFgTy4orcw8xSnAwK4nw
        +q0HCvGmJFZWpRblxxeV5qQWH2I0BXptIrOUaHI+MLnklcQbmhqaW1gamhubG5tZKInzdggc
        jBESSE8sSc1OTS1ILYLpY+LglGpg1K6sO7fqspPH3vW7xNcndwUn380sfl1/5cpLdt5XXVz/
        H38O9T4Xvn51pI1rk9qBbBGWj2GvxPdZR01/MvFB/I1Vf5T3Scu1MhqG37S8Y1OjGZpb5/lt
        TtmxIgthq5xEjXbJD9lRS2eGL1aX3vR+5ZIvUxwObD5zL/1p8tXeea+ZfNrNzJo1lFiKMxIN
        tZiLihMBe/KcdfYCAAA=
X-CMS-MailID: 20200513133301eucas1p244d094c774ad0efd5ea9125747d5cb1b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200513133301eucas1p244d094c774ad0efd5ea9125747d5cb1b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133301eucas1p244d094c774ad0efd5ea9125747d5cb1b
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
        <20200513133245.6408-1-m.szyprowski@samsung.com>
        <CGME20200513133301eucas1p244d094c774ad0efd5ea9125747d5cb1b@eucas1p2.samsung.com>
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
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 9 +++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 8 ++++----
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 43d8ed7..519ce44 100644
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
index 9cbecd5..57a5d56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1024,7 +1024,6 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(ttm->bdev);
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
-	unsigned nents;
 	int r;
 
 	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
@@ -1039,9 +1038,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 		goto release_sg;
 
 	/* Map SG to device */
-	r = -ENOMEM;
-	nents = dma_map_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-	if (nents == 0)
+	r = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
+	if (r)
 		goto release_sg;
 
 	/* convert SG to linear array of pages and dma addresses */
@@ -1072,8 +1070,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
 		return;
 
 	/* unmap the pages mapped to the device */
-	dma_unmap_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-
+	dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
 	sg_free_table(ttm->sg);
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index d399e58..75495a7 100644
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
1.9.1

