Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43931C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DED2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="stb/zMtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgEDMyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:54:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59138 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgEDMyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:54:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200504125411euoutp028a8c2e32312760514ef4c5773ff33deb~L1GtuqfVm1839718397euoutp02i
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:54:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200504125411euoutp028a8c2e32312760514ef4c5773ff33deb~L1GtuqfVm1839718397euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588596851;
        bh=eR8oFUiJZMXOv3u7xfQ4au5Namlj9CitJYXcY2fG1iQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stb/zMtXRIhrrjQhXHaNJFyd6VOrSH0fT6eprQ0sW32pmFweAaElI4sW16IHuztEO
         H025n7qaEYKhpdblpCiayhR3U160IvzIX4oRhP/yUlB7xBaP0mqlFYvgVhDiOsu7KP
         yIU5ucMlqJUPs6Pm/XusXgLcp3FoQP9H9rIMg/GE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200504125411eucas1p15bd4342b7b927fff40a0f083ac880ab7~L1GtZhilf0157201572eucas1p1v;
        Mon,  4 May 2020 12:54:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C7.D2.60679.27010BE5; Mon,  4
        May 2020 13:54:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200504125410eucas1p21e7a58138893b2fd1d599832357c9f21~L1GtCR_Af2430724307eucas1p2g;
        Mon,  4 May 2020 12:54:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200504125410eusmtrp161ea359617c9a2dd746f0d10e93662c3~L1GtBN1qP2497724977eusmtrp1S;
        Mon,  4 May 2020 12:54:10 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-92-5eb0107239a9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 13.69.08375.27010BE5; Mon,  4
        May 2020 13:54:10 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200504125409eusmtip256d96640042a910976e7d8bad704c7e0~L1GsSxleE0241702417eusmtip2G;
        Mon,  4 May 2020 12:54:09 +0000 (GMT)
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
Subject: [PATCH v2 02/21] drm: amdgpu: fix sg_table nents vs. orig_nents
 misuse
Date:   Mon,  4 May 2020 14:53:40 +0200
Message-Id: <20200504125359.5678-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125359.5678-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO7edrWbHKfiWpTTMKCi7SBzoQkE/jkSQ9SeizJUnjZzKjrMs
        KtPWZWYXR2tqlJWleZtOU1llZdY0y2JazNLMC5ahZGyzu7V5svr3PM/7PN/zvvDRuKKfnE7v
        SkjmNQmqeCUlI2oefX02X2AqohZef4zYrNZmjDV23iLZa+bDErbSZCbZ4W4P/VVzFmcLXM9I
        tt39kWJvlDzE2Py7y1hXew/GWvpekmyb9QLFljV2Sdj7I/3kqqmczv6T4kovliLuzmg+wdWO
        viW57kwbxlUVHOJej/XhnMFRiLhbHWkUd6q6GHFOS9D6yZtly2P4+F0pvCZsZbQs7kRLOpHU
        DnvtpmxJGnrjr0dSGphwqO1xS/RIRiuYIgTdLhMhEheCwvIiJBInAndxJjURMTqz/0QKEYw9
        qEd/I/ZK70RKU8wi0A/rxxP+jA5BU9YUrwlnXuBQWvCK9A78mEgoamocNxHMbDBcfkJ4sZxZ
        DrWn3ZhYFwwlFfdwPaJpKbMCcrLmiBZfaM7pH7fjHkvGzTzc+z4wOhrsludIzK6BgZwhQsR+
        8MFWLRHxDGgxnCTEQAaCntYyiUhOImhLN/1JL4PO1m+Utxln5oLZGibKq2H4nRV5ZWB8wDHs
        Ky7hA9k153FRlsPxowrRHQq5tvK/tfef23ERc3Ci/gt2Bs3K/e+c3P/Oyf3Xm4/wYhTAawV1
        LC8sTuD3LBBUakGbELtgR6Lagjx/r2XM5qpD1h/bGxBDI+UU+SanOUpBqlKEVHUDAhpX+svr
        jngkeYwqdR+vSdym0cbzQgMKpAllgHzJlcGtCiZWlczv5vkkXjMxxWjp9DRk7D1c33dto22n
        0w+rDgkU3LIS/Z2Iyu9Pjw1RdRdHmK7AyMb9zuBzC6fV2TMUIZ2x4dHEppVJB2lT1bGoAUem
        9OrovAOGPL/QwYFLOVpHXH/yPWPA2i1pvbqymSlr3EsnNUBQRVjHp46Wz5gr5PZMo7mTiGh8
        P3/DKnmQf2r4OiUhxKkWzcM1guo3Uql9VHcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsVy+t/xe7pFAhviDCY2alj0njvJZDHtzm5W
        i6XrG9ktNs5Yz2rx9j6Q+3/bRGaLJV/Os1pc+fqezWLl6qNMFgv2W1t8ufKQyWLT42usFpd3
        zWGzWHvkLrvFwQ9PWB34PVov/WXzWDNvDaPH3m8LWDy2f3vA6nG/+ziTx+Yl9R63/z1m9ph8
        Yzmjx+6bDWwefVtWMXp83iQXwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2Vk
        qqRvZ5OSmpNZllqkb5egl9F5uoml4IpExaUZk9gbGO+JdDFyckgImEhM+zyJvYuRi0NIYCmj
        ROOWZ4wQCRmJk9MaWCFsYYk/17rYIIo+MUr8WPCUCSTBJmAo0fUWIiEi0MkoMa37IztIglng
        LrPEiim5ILawgL/E810vWUBsFgFVickLz4DZvAI2Etv7vzJBbJCXWL3hAHMXIwcHp4CtxMxe
        dZCwkEC+xN2n/6DKBSVOznzCAlLCLKAusX6eEMQmeYnmrbOZJzAKzkJSNQuhahaSqgWMzKsY
        RVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI3nbsZ+bdzBe2hh8iFGAg1GJhzfi8/o4IdbEsuLK
        3EOMEhzMSiK8O1qAQrwpiZVVqUX58UWlOanFhxhNgT6byCwlmpwPTDJ5JfGGpobmFpaG5sbm
        xmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYI8rWvno0tfb66beBz2fNTWU6t7p1S0f4
        B9eLdhu8g5z27aiT5zZQuLBCJstvJavC82lrXTg833oUMnq4R2yT4PizLDkhI0n7HndluaL6
        d4PLoplh3u/6s6tX8b7nDpk/I/PmpNeHku9MDnlcIiZh96L/pdzLvZNSDnaWyUa/fTfZQvqF
        ic9rJZbijERDLeai4kQAqK3jcPoCAAA=
X-CMS-MailID: 20200504125410eucas1p21e7a58138893b2fd1d599832357c9f21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200504125410eucas1p21e7a58138893b2fd1d599832357c9f21
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504125410eucas1p21e7a58138893b2fd1d599832357c9f21
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
        <20200504125359.5678-1-m.szyprowski@samsung.com>
        <CGME20200504125410eucas1p21e7a58138893b2fd1d599832357c9f21@eucas1p2.samsung.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 43d8ed7..4df813e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -307,8 +307,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		if (IS_ERR(sgt))
 			return sgt;
 
-		if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
-				      DMA_ATTR_SKIP_CPU_SYNC))
+		sgt->nents = dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->orig_nents,
+					      dir, DMA_ATTR_SKIP_CPU_SYNC);
+		if (!sgt->nents)
 			goto error_free;
 		break;
 
@@ -349,7 +350,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 
 	if (sgt->sgl->page_link) {
-		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
+		dma_unmap_sg(attach->dev, sgt->sgl, sgt->orig_nents, dir);
 		sg_free_table(sgt);
 		kfree(sgt);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index eff1f73..1f8c507 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1043,7 +1043,6 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(ttm->bdev);
 	struct amdgpu_ttm_tt *gtt = (void *)ttm;
-	unsigned nents;
 	int r;
 
 	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
@@ -1059,8 +1058,9 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 
 	/* Map SG to device */
 	r = -ENOMEM;
-	nents = dma_map_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-	if (nents == 0)
+	ttm->sg->nents = dma_map_sg(adev->dev, ttm->sg->sgl,
+				    ttm->sg->orig_nents, direction);
+	if (ttm->sg->nents == 0)
 		goto release_sg;
 
 	/* convert SG to linear array of pages and dma addresses */
@@ -1091,7 +1091,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
 		return;
 
 	/* unmap the pages mapped to the device */
-	dma_unmap_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
+	dma_unmap_sg(adev->dev, ttm->sg->sgl, ttm->sg->orig_nents, direction);
 
 	sg_free_table(ttm->sg);
 
-- 
1.9.1

