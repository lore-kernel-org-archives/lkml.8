Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFA0C54E92
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1F02082E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pttrtXnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgELJCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:02:43 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34437 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgELJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:01:21 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200512090119euoutp01d93d09c22bb60b56d476b29ccb12ded7~OPFrnWYF42633726337euoutp01S
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:01:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200512090119euoutp01d93d09c22bb60b56d476b29ccb12ded7~OPFrnWYF42633726337euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589274079;
        bh=0yI0kIf+rYJ6UoNyoIt+TrT7+zi+gmpMibLIv1/8Mcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pttrtXnu5Lr6oh0ZOZ5MlxdrlDccvm7mLfETe4QXKs85WK4131Lub/EuDHzqDHcu1
         1/6DLrZle8CpjArk+CwTGzHM52+IOkcJ2NsXb+Xa5/q/offSk7EpGAtQ9lVkXNsbxH
         0QLTJyhrc9ar0TWIPHZFMyw+eJkNg4jGoLBpsWzc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200512090119eucas1p11940982db9c164db4d85642968ef9c3d~OPFrXu7Le2839628396eucas1p1J;
        Tue, 12 May 2020 09:01:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5C.22.60679.FD56ABE5; Tue, 12
        May 2020 10:01:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200512090119eucas1p2c0db485fddf17f15135f8e69e46fc097~OPFrDcV3u3099730997eucas1p2B;
        Tue, 12 May 2020 09:01:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200512090119eusmtrp2cdd0ea0f62af7fa84d5f0f1dbe87ba24~OPFrCCJxt0472504725eusmtrp2O;
        Tue, 12 May 2020 09:01:19 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-b0-5eba65dfa81b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 73.45.08375.ED56ABE5; Tue, 12
        May 2020 10:01:18 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200512090118eusmtip1a596717f01754987556461b66c9eb4e1~OPFqdyOKg1352513525eusmtip1K;
        Tue, 12 May 2020 09:01:18 +0000 (GMT)
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
Subject: [PATCH v4 20/38] drm: radeon: fix common struct sg_table related
 issues
Date:   Tue, 12 May 2020 11:00:40 +0200
Message-Id: <20200512090058.14910-20-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm27nsbDU9boYfFpWDsoLUtB8HFCuQOP0rIQJJa9lpjnTJjrOU
        IFNntWV5icolKWJpc14zm1NLrbSLrVIbk8zbxBuIhZdIdLbjsfLfc/3e94WPQKQDmC+hUicx
        GrUiXo6L0YaO37a9g4w1JijnjozKtr0TUHf7mzDqUfVVIVV7vxqjpgfddKUhF6F652dw6knF
        GwFV/DKUmusdFlB1TjtG9VgLcary9Xch1fZjFDvoQeu6l3Ha/NAM6JaFYpR+vjCE0YOGTgH9
        tPQK/c3lROh8Rxmgm/rScPpWvQnQs3Vbj26IEoedZeJVyYwmMPy0OM5e2CFMdPpcmvyyIkgD
        LpkeiAhI7ocWhwXVAzEhJcsBLCm9AXgyB+DYTKuAJ7MATnzSCf9W0ntNa0YZgK+azThnrFbe
        f43mME7ug/pp/aruTeoAfJu9kSsgZCkCS/tfoJwhIyNhR9UEpgcEgZI7YPe3AE6WkOHQsmBG
        +WHbYEVNK8JhkVsfLFpC+YwXfFcwuooRdybj2QOEex+Sy0JoWVxa2zQC/u4w4DyWwanO+jV9
        C1xpLBLwhQwAh22VQp7cBLAn/T7gU6Gw37aIc9sh5G5YbQ3k5UOwZITbiHBjD+iY9uKX8IB5
        DffWZAm8niXl0zuhsbPq39i2z90Ij2k4tTKK5QA/47pzjOvOMf6fWwwQE/BhtGyCkmGD1czF
        AFaRwGrVyoDYCwl1wP3rPrg65yzAunSmHZAEkG+UBAU1xkgxRTKbktAOIIHIvSWZKrckOatI
        SWU0F05ptPEM2w42E6jcRxJSMhktJZWKJOY8wyQymr+ugBD5pgGG9XF01Ys8R6LKz78tH4io
        z+rq98+fDIu87hJT/vNC5UV7c5ff7ZeHfWPUy5vyPqKILvK4rW+XY+bckbG9iyHjgbGPr9k9
        C2p+GYc0Jm+vnO3PfA0HqmYnDKm1r/yPtZjH2QOXDdp5WYbBmVmp+lkQk5t4QnX8ZMPDocbC
        4JQSOcrGKfbtQTSs4g+Xn4NZcQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xu7r3UnfFGUxebm3Re+4kk8W0O7tZ
        LZaub2S32DhjPavF2/tA7v9tE5ktrnx9z2axcvVRJosF+60tvlx5yGSx6fE1VovLu+awWaw9
        cpfd4uCHJ6wOfB6tl/6yeayZt4bRY++3BSwe2789YPW4332cyWPzknqP2/8eM3tMvrGc0WP3
        zQY2j74tqxg9Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0Mu4NucYe8Fj8YqXF/8zNTD+E+5i5OSQEDCRaLqyiqmLkYtDSGApo8Sjq7fZ
        IBIyEienNbBC2MISf651sUEUfWKUOLT9PlgRm4ChRNdbiISIQCejxLTuj+wgDrPAGmaJe9+X
        AzkcHMICARKdH4NBTBYBVYlLt/VAenkF7CR2fFvDArFAXmL1hgPMIDYnUPz+/D9gcSGBQqCD
        3rJA1AtKnJz5hAVkDLOAusT6eUIgYWag1uats5knMArOQlI1C6FqFpKqBYzMqxhFUkuLc9Nz
        iw31ihNzi0vz0vWS83M3MQLjd9uxn5t3MF7aGHyIUYCDUYmHt8NoZ5wQa2JZcWXuIUYJDmYl
        Ed6WTKAQb0piZVVqUX58UWlOavEhRlOgzyYyS4km5wNTS15JvKGpobmFpaG5sbmxmYWSOG+H
        wMEYIYH0xJLU7NTUgtQimD4mDk6pBsau4MufuwVEO+Satp6P7uFfr3OWMzXr0ul7LdeOZtSX
        Kx23teo6zb9C29t4t1aD1MNtvyI5atIn6Ws83tPEfWf99Ieb8lZ/uqx0YdepDwvOxE3+Ilev
        WPb4Zpnhse7Ppcmuzbcsa/IXLi4Rvmz6RflfhzL7m8WK9zsFL3b/u3a93f7QqjCPawuUWIoz
        Eg21mIuKEwEmNFxg9QIAAA==
X-CMS-MailID: 20200512090119eucas1p2c0db485fddf17f15135f8e69e46fc097
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200512090119eucas1p2c0db485fddf17f15135f8e69e46fc097
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090119eucas1p2c0db485fddf17f15135f8e69e46fc097
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
        <20200512090058.14910-1-m.szyprowski@samsung.com>
        <CGME20200512090119eucas1p2c0db485fddf17f15135f8e69e46fc097@eucas1p2.samsung.com>
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
 drivers/gpu/drm/radeon/radeon_ttm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 5d50c9e..0e3eb0d 100644
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
@@ -521,9 +521,8 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 	if (r)
 		goto release_sg;
 
-	r = -ENOMEM;
-	nents = dma_map_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-	if (nents == 0)
+	r = dma_map_sgtable(rdev->dev, ttm->sg, direction, 0);
+	if (r)
 		goto release_sg;
 
 	drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
@@ -554,9 +553,9 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
 		return;
 
 	/* free the sg table and pages again */
-	dma_unmap_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
+	dma_unmap_sgtable(rdev->dev, ttm->sg, direction, 0);
 
-	for_each_sg_page(ttm->sg->sgl, &sg_iter, ttm->sg->nents, 0) {
+	for_each_sgtable_page(ttm->sg, &sg_iter, 0) {
 		struct page *page = sg_page_iter_page(&sg_iter);
 		if (!(gtt->userflags & RADEON_GEM_USERPTR_READONLY))
 			set_page_dirty(page);
-- 
1.9.1

