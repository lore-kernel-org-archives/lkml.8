Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC8AC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A6D206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mPDk7t5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgELJCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:02:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40577 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgELJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:01:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200512090112euoutp02826abc5de1167070fcbe76e57a310869~OPFkiWLRO0453404534euoutp02C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:01:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200512090112euoutp02826abc5de1167070fcbe76e57a310869~OPFkiWLRO0453404534euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589274072;
        bh=0z83gmhkMR5EjUdL8WkTGagsnSoPYyB1uYT7DziITiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPDk7t5SgibWywiUsFWcydQNw0XSnuS1AwoF3ulby7YltlXrgzqhPYRDFTiBPmoK/
         WhGb9okdxkgF1TwXy3Aiyf+R+0INcM2D0K+Y9iBtj+XWUbwAsxV7FglXfHy+DMu8nu
         wuur7WhHFiHpqUwh9beFg1yNdIQqUbJkrwDv8Qx4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200512090111eucas1p1d2f1f924c455cf9e6c6251192d756f7c~OPFkNhphe2839628396eucas1p1x;
        Tue, 12 May 2020 09:01:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 49.57.61286.7D56ABE5; Tue, 12
        May 2020 10:01:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200512090111eucas1p2fd703addaa7975c16a1ea2d7807cc6a6~OPFj1X8hG2564425644eucas1p2H;
        Tue, 12 May 2020 09:01:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200512090111eusmtrp262b48d8946df141f3aa9b123835997e7~OPFj0mr330472504725eusmtrp2_;
        Tue, 12 May 2020 09:01:11 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-54-5eba65d7bb3f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B7.35.08375.7D56ABE5; Tue, 12
        May 2020 10:01:11 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200512090110eusmtip12862a978e3691fd69c2bdc6b89a93d75~OPFjPYCFu1283712837eusmtip1h;
        Tue, 12 May 2020 09:01:10 +0000 (GMT)
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
Subject: [PATCH v4 07/38] drm: amdgpu: fix common struct sg_table related
 issues
Date:   Tue, 12 May 2020 11:00:27 +0200
Message-Id: <20200512090058.14910-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SV0xTYRj17+1tL4XWSyHhDxCFJiBiZOnDTUCiCYn3wQfHg4mJYJHLkFHs
        ZRoJm5AihhVFMECwyhahCAKR0QCFiICFMMsKw0gsIsugDGlvRd7OOd/5Zj4MEc6gllhQWAQl
        DROHiDg8dmPPzuD5MarF2yWz0IHIHOhjEc80rSjxujaRS9Tl16KEdvaQHjRmI8TI1g8OUVHV
        zSJK2t2JzZF5FlG/MIoSwy0vOURN1zSX6FxbRC8LyFT1HoesLqoG5MftEjbZtD2HkrMZKhap
        kMeTU/sLCJk7XgbI1okEDvm0oRKQG/Wnrhvf4Xn4USFBUZTU2fMeL1A7WcoO73CIyXzVChLA
        T1sZwDCIX4T9W5gM8DAhXg6g5vsWypBNALtqpwxkA8DirjS2DBjpM6pHK1lMoAzApKVc7lGK
        emqFpXNxcFco08o4OmyOpwLYm2miMyG4HIFyTZu+lBl+E64mKYAOs3E7uDqt1Ot8/BIc+jMC
        mHanYdW7DkSHjXBPOFu8a/CYwr4Xi3qMHHqS3xcijH+PC/vXzjDYC66XKAx1zOCKqoHLYGt4
        0FysXwHiyQDOD9RwGfIEwOGkfEOGO9QM/ObozoTgZ2FtizMjX4FpnzPYzPUEcFxryswggDmN
        zxFG5sP0NCHjtocFqrdHbTuH1IYxSZjz6w2aBWwLjm1TcGybgv99SwBSCSyoSDo0gKJdw6ho
        J1ocSkeGBTjdl4TWg8Ov+7SvWv8AttS+SoBjQGTCT3dr9hai4ig6NlQJIIaIzPkpQYcS308c
        +4iSSnykkSEUrQRWGFtkwb9Q+u2uEA8QR1DBFBVOSf9FWZiRZQJwvt3hVefPjR6sd7RfW8qz
        f2iVbOzrD+LjIiSL7baPzzUlNsndyOXIk9VR21nlFc797SmK5OBluV93Y4ad/6seYXALq03x
        tTdwZ+bLRF6H7a0Aa5nAxkN9w+dB9olEuwo3K95khOCaNlXiIgFFNnu8ReXY3FWv3Zg4Ryld
        FKsRselAsasjIqXFfwFcNyBYcQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7rXU3fFGUx/zmvRe+4kk8W0O7tZ
        LZaub2S32DhjPavF2/tA7v9tE5ktrnx9z2axcvVRJosF+60tvlx5yGSx6fE1VovLu+awWaw9
        cpfd4uCHJ6wOfB6tl/6yeayZt4bRY++3BSwe2789YPW4332cyWPzknqP2/8eM3tMvrGc0WP3
        zQY2j74tqxg9Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0Mt4e2sRS8EBjYrexbsZGxg/KnYxcnJICJhIrLm2iqmLkYtDSGApo8T95e0s
        EAkZiZPTGlghbGGJP9e62CCKPjFKfD8yD6yITcBQoustREJEoJNRYlr3R3YQh1lgDbPEve/L
        2UGqhAUCJN61dDKD2CwCqhLv7h4C6+YVsJW48PsKI8QKeYnVGw6A1XAK2Encn/8HrEZIoFDi
        0dW3UPWCEidnPgGyOYAWqEusnycEEmYGam3eOpt5AqPgLCRVsxCqZiGpWsDIvIpRJLW0ODc9
        t9hQrzgxt7g0L10vOT93EyMwhrcd+7l5B+OljcGHGAU4GJV4eDuMdsYJsSaWFVfmHmKU4GBW
        EuFtyQQK8aYkVlalFuXHF5XmpBYfYjQFem0is5Rocj4wveSVxBuaGppbWBqaG5sbm1koifN2
        CByMERJITyxJzU5NLUgtgulj4uCUamDkXvY0YPvmw33JGqt9p0s9kvu6WnHhnDfhczKX1EwR
        usLb9u5407oz74yCrj2Tdz4z71rTDCcVOcdzsrMajnOtSt2+nVv1WP+aLy9a3ym2772dcHLl
        y93KYlMTEy9L3+g58y5BIH3N67JN/JvP7Hi05kJbf92rvSt0PlQt2Kr5JIl7hWSL+/3uY0os
        xRmJhlrMRcWJAMozZl73AgAA
X-CMS-MailID: 20200512090111eucas1p2fd703addaa7975c16a1ea2d7807cc6a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200512090111eucas1p2fd703addaa7975c16a1ea2d7807cc6a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090111eucas1p2fd703addaa7975c16a1ea2d7807cc6a6
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
        <20200512090058.14910-1-m.szyprowski@samsung.com>
        <CGME20200512090111eucas1p2fd703addaa7975c16a1ea2d7807cc6a6@eucas1p2.samsung.com>
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
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
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

