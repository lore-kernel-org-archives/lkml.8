Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42285C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1625E207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lzRWGr4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbgFSKlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:41:12 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51682 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732523AbgFSKhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:37:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200619103707euoutp029c9f76357812cb724d8bf2c793a6235f~Z66LDRjZC2242422424euoutp02e
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:37:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200619103707euoutp029c9f76357812cb724d8bf2c793a6235f~Z66LDRjZC2242422424euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592563027;
        bh=Z9l2woQ40ZPmHmgLmD1FIzI5uZAPuWFYYBjv7TcHHj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzRWGr4bOFJ3OooXJpEieNb7fxObSiAyBTUqTEH1YGUY8kDmr6xNtzOjK2wUYrkPp
         Z1sb7LlNbgkqov4gOC8FRWLrpxPXhcJrL7hNjCJgomcHWpEAHNUG9kTwYI+ZhHGoM+
         QYgaUFuwoN0OQzOi+XOO49b6325NPW09eECb/98c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200619103707eucas1p1aa3961c5a770c18123d171f9ba781bc0~Z66KkHOgr3246432464eucas1p1u;
        Fri, 19 Jun 2020 10:37:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A4.9C.06318.2559CEE5; Fri, 19
        Jun 2020 11:37:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200619103706eucas1p2b9a9926941e812db1111ec46a97695cd~Z66KRaPFk2893928939eucas1p2d;
        Fri, 19 Jun 2020 10:37:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200619103706eusmtrp175a36441d776a8bb6dff075ae22b4b9d~Z66KQwXOU0949709497eusmtrp1a;
        Fri, 19 Jun 2020 10:37:06 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-70-5eec9552936b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7F.0B.06017.2559CEE5; Fri, 19
        Jun 2020 11:37:06 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200619103705eusmtip20afd05ddb910ee09064c1699ebcefa22~Z66Jl4QAg0246802468eusmtip2j;
        Fri, 19 Jun 2020 10:37:05 +0000 (GMT)
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
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v7 20/36] drm: tegra: fix common struct sg_table related
 issues
Date:   Fri, 19 Jun 2020 12:36:20 +0200
Message-Id: <20200619103636.11974-21-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSaUhUYRSG+eYuc11GbqPkh4rCYIKRGwpeUSSjH/dHtKgQKY1OelHLGWXG
        nUhJKxu1Ms1lEjMxNZdcMzMrR7Kp1Klccsql1Ah3K5dUSpvbVfv3nvc873cOh49AhGrMgoiQ
        xTBymSRShBuiLS/XtQ6+t+bEzkNlHlSW9jWPaiiow6itlmyEGlhZxKn71V08quS5J5WmKkWp
        5YFxHtU4+QGj+tuKcOrqsgqnal+M8in1968Ytd5WjB40oWuKawD9dLUEpR+rRvn0o9UvGP05
        Q8Ojm8qS6eHNSYTO0VUA+snHFJzOSl3A6WvNVYBearQ+bhxg6BXKREbEMXIn72DD8PKxt0h0
        unPC4sMZPAXM2imBAQFJN6iemOYpgSEhJCsBvFdSiHDFMoAZa3mAK5YArJ5L5e9EcirLUa5R
        AeDgm0J0NzK8fBtjKZx0gcp5Jc5qM/ISgK+yjFkIITMR2JH3C7ANU/IEzC3o+weh5D7Y2zPF
        Y7WA9IZV5TqUG2cDq+s7EFYb6P3ZNDXGPgTJT3yY++Mnj4MOwytbbTinTeGMpnl7VyvYnZOJ
        coFUAMe1tXyuyASw/2IB4ChPOKLd0KcJ/X72sK7NibN9YMNEBsbakDSBuvk9rI3o5c2WfISz
        BTD9spCj7aBK82B3rPpd3zZCw558S+5A2QDe3WpHbgAb1f9ZJQBUAXMmViENYxSuMibeUSGR
        KmJlYY4hUdJGoP9Y3ZualVbw7PeZTkASQGQsmPKfFQsxSZwiUdoJIIGIzASHervFQkGoJDGJ
        kUcFyWMjGUUnsCRQkbnAtXT6tJAMk8Qw5xgmmpHvdHmEgUUKcDhmlZOkSxCqAg/464aLh026
        wupxe6PqmD8LAWMRI3t9NK7lEcr682LPoSrt+wBbd+CcZ519tm9tSOPXW2Q8JQuOd1xsiY3z
        ncsSBB11MwpMFrde6LAlNuLmx9ybs+2OeHl8W+sZ8s1M9bMYPNl+/VRCSEa9karJEQbX9hXc
        cRahinCJy35ErpD8BWSngTVUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7pBU9/EGaz9p2bRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlks2G9t0TJrEYvFlysPmSw2Pb7GanF51xw2i84vs9gs1h65y25x
        8MMTVoufu+axOPB5rJm3htFj77cFLB47Z91l99j+7QGrx/3u40wem5fUe9z+95jZY/KN5Ywe
        u282sHn0Nr9j8+jbsorR4/MmuQCeKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81gr
        I1MlfTublNSczLLUIn27BL2MZffOMxd0GFS83/qKrYHxtVoXIyeHhICJxOQVy1i6GLk4hASW
        Mkp0zH7PBpGQkTg5rYEVwhaW+HOtCywuJPCJUWJXrzqIzSZgKNH1FiTOxSEi0MkoMa37IzuI
        wywwhVli6v0GRpAqYQF/iQV3TrOD2CwCqhJnz7xgArF5BewkVi27wQKxQV5i9YYDzCA2J1D8
        dctBVohtthLLF7xnnsDIt4CRYRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg/Gw79nPLDsau
        d8GHGAU4GJV4eF+EvI4TYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFGU6Cj
        JjJLiSbnA2M7ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD49Xv
        4t8un3XZfzh+4pcE9vnVs87x78vqvfJkZzpDuorUL02ht7s9lt9huWDFKnTzjvu67CMhlyuX
        Tliz+fSLJa5+M8Suxa2oCLiYqf409+/FtUwmcZ+338n46WCyt/jA9gTXdTe++ium1E+68MrZ
        +Y3kM8k56wuncpjaFF6smvL0iIqu862bwk1KLMUZiYZazEXFiQDgEq+0tQIAAA==
X-CMS-MailID: 20200619103706eucas1p2b9a9926941e812db1111ec46a97695cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200619103706eucas1p2b9a9926941e812db1111ec46a97695cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103706eucas1p2b9a9926941e812db1111ec46a97695cd
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
        <CGME20200619103706eucas1p2b9a9926941e812db1111ec46a97695cd@eucas1p2.samsung.com>
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
---
 drivers/gpu/drm/tegra/gem.c   | 27 ++++++++++-----------------
 drivers/gpu/drm/tegra/plane.c | 15 +++++----------
 2 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
index 723df142a981..01d94befab11 100644
--- a/drivers/gpu/drm/tegra/gem.c
+++ b/drivers/gpu/drm/tegra/gem.c
@@ -98,8 +98,8 @@ static struct sg_table *tegra_bo_pin(struct device *dev, struct host1x_bo *bo,
 		 * the SG table needs to be copied to avoid overwriting any
 		 * other potential users of the original SG table.
 		 */
-		err = sg_alloc_table_from_sg(sgt, obj->sgt->sgl, obj->sgt->nents,
-					     GFP_KERNEL);
+		err = sg_alloc_table_from_sg(sgt, obj->sgt->sgl,
+					     obj->sgt->orig_nents, GFP_KERNEL);
 		if (err < 0)
 			goto free;
 	} else {
@@ -196,8 +196,7 @@ static int tegra_bo_iommu_map(struct tegra_drm *tegra, struct tegra_bo *bo)
 
 	bo->iova = bo->mm->start;
 
-	bo->size = iommu_map_sg(tegra->domain, bo->iova, bo->sgt->sgl,
-				bo->sgt->nents, prot);
+	bo->size = iommu_map_sgtable(tegra->domain, bo->iova, bo->sgt, prot);
 	if (!bo->size) {
 		dev_err(tegra->drm->dev, "failed to map buffer\n");
 		err = -ENOMEM;
@@ -264,8 +263,7 @@ static struct tegra_bo *tegra_bo_alloc_object(struct drm_device *drm,
 static void tegra_bo_free(struct drm_device *drm, struct tegra_bo *bo)
 {
 	if (bo->pages) {
-		dma_unmap_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-			     DMA_FROM_DEVICE);
+		dma_unmap_sgtable(drm->dev, bo->sgt, DMA_FROM_DEVICE, 0);
 		drm_gem_put_pages(&bo->gem, bo->pages, true, true);
 		sg_free_table(bo->sgt);
 		kfree(bo->sgt);
@@ -290,12 +288,9 @@ static int tegra_bo_get_pages(struct drm_device *drm, struct tegra_bo *bo)
 		goto put_pages;
 	}
 
-	err = dma_map_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-			 DMA_FROM_DEVICE);
-	if (err == 0) {
-		err = -EFAULT;
+	err = dma_map_sgtable(drm->dev, bo->sgt, DMA_FROM_DEVICE, 0);
+	if (err)
 		goto free_sgt;
-	}
 
 	return 0;
 
@@ -571,7 +566,7 @@ tegra_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
 			goto free;
 	}
 
-	if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0)
+	if (dma_map_sgtable(attach->dev, sgt, dir, 0))
 		goto free;
 
 	return sgt;
@@ -590,7 +585,7 @@ static void tegra_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
 	struct tegra_bo *bo = to_tegra_bo(gem);
 
 	if (bo->pages)
-		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
+		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 
 	sg_free_table(sgt);
 	kfree(sgt);
@@ -609,8 +604,7 @@ static int tegra_gem_prime_begin_cpu_access(struct dma_buf *buf,
 	struct drm_device *drm = gem->dev;
 
 	if (bo->pages)
-		dma_sync_sg_for_cpu(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-				    DMA_FROM_DEVICE);
+		dma_sync_sgtable_for_cpu(drm->dev, bo->sgt, DMA_FROM_DEVICE);
 
 	return 0;
 }
@@ -623,8 +617,7 @@ static int tegra_gem_prime_end_cpu_access(struct dma_buf *buf,
 	struct drm_device *drm = gem->dev;
 
 	if (bo->pages)
-		dma_sync_sg_for_device(drm->dev, bo->sgt->sgl, bo->sgt->nents,
-				       DMA_TO_DEVICE);
+		dma_sync_sgtable_for_device(drm->dev, bo->sgt, DMA_TO_DEVICE);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index 9ccfb56e9b01..0d2ef1662a39 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -130,12 +130,9 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
 		}
 
 		if (sgt) {
-			err = dma_map_sg(dc->dev, sgt->sgl, sgt->nents,
-					 DMA_TO_DEVICE);
-			if (err == 0) {
-				err = -ENOMEM;
+			err = dma_map_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
+			if (err)
 				goto unpin;
-			}
 
 			/*
 			 * The display controller needs contiguous memory, so
@@ -143,7 +140,7 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
 			 * map its SG table to a single contiguous chunk of
 			 * I/O virtual memory.
 			 */
-			if (err > 1) {
+			if (sgt->nents > 1) {
 				err = -EINVAL;
 				goto unpin;
 			}
@@ -165,8 +162,7 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
 		struct sg_table *sgt = state->sgt[i];
 
 		if (sgt)
-			dma_unmap_sg(dc->dev, sgt->sgl, sgt->nents,
-				     DMA_TO_DEVICE);
+			dma_unmap_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
 
 		host1x_bo_unpin(dc->dev, &bo->base, sgt);
 		state->iova[i] = DMA_MAPPING_ERROR;
@@ -185,8 +181,7 @@ static void tegra_dc_unpin(struct tegra_dc *dc, struct tegra_plane_state *state)
 		struct sg_table *sgt = state->sgt[i];
 
 		if (sgt)
-			dma_unmap_sg(dc->dev, sgt->sgl, sgt->nents,
-				     DMA_TO_DEVICE);
+			dma_unmap_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
 
 		host1x_bo_unpin(dc->dev, &bo->base, sgt);
 		state->iova[i] = DMA_MAPPING_ERROR;
-- 
2.17.1

