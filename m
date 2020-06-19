Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B28C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10663207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qmXiDeVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbgFSKoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:44:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51674 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732521AbgFSKhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:37:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200619103704euoutp02e4e968fa30aa6f2ee006af76137d2a09~Z66IYdI6t2242422424euoutp02Y
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:37:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200619103704euoutp02e4e968fa30aa6f2ee006af76137d2a09~Z66IYdI6t2242422424euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592563024;
        bh=IwcN7HT+JUiCjrdqrw1qwR5B7c/UG3T+h59divjRKuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmXiDeVRiq7DtEsjOqNfXfqd0I6cQu5PunFnzeroHOVkVh+SpnlPbAfZ1vm6lDyvW
         p5yoAB/FfukegNSRArwvEOBTk13igrOnVckZPDHKmNUFukplCMDmIvVyWWEafHcBtd
         9pE8sD7WVy/66WcXgx+IJqMKuGuWYc0YFx00ET9g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200619103704eucas1p1ce7615f2cccfbc294d682719040855f8~Z66IBNL5P3246032460eucas1p1b;
        Fri, 19 Jun 2020 10:37:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 91.9C.06318.0559CEE5; Fri, 19
        Jun 2020 11:37:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200619103703eucas1p2b8b0e90f9559c3fff12d61f76b861cc1~Z66HsQVcv2383423834eucas1p2j;
        Fri, 19 Jun 2020 10:37:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200619103703eusmtrp108812fcc95a44dd2886dccafce48b2b4~Z66HrmZ7t0949709497eusmtrp1Q;
        Fri, 19 Jun 2020 10:37:03 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-66-5eec95502108
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D2.EA.06314.F459CEE5; Fri, 19
        Jun 2020 11:37:03 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200619103703eusmtip2693e0f25c0525ff1f822863679de2107~Z66HBJUsF0246802468eusmtip2g;
        Fri, 19 Jun 2020 10:37:03 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v7 16/36] drm: panfrost: fix common struct sg_table related
 issues
Date:   Fri, 19 Jun 2020 12:36:16 +0200
Message-Id: <20200619103636.11974-17-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRzv+zx3zz1uTo+j+SVL3VabVmKopzS9+eNp9YctW1sbeuQZ4rA7
        pNrKiujo5q2xXrCmqeO8ZfKeux0qugqrQ8LQSCUR6YU8HtV/n+/nZZ99v/uSuLxO7EiGR8Vy
        qig2UkFIRTVtCy92+N34GOg2k7WWvm5+itGVeeVieqkmE6d7vk0R9IOSVowufOxNz/YMY3TV
        yGsx3V1/m6D1pgEJvdRYK6ENX0bFtFbfRRyQMaX5pcDUDhQB0zRXKGKqdNcI5tHckJgZTGvH
        mIdFl5j+xRGcybYUA9PQm0gw2modMDNVG/2sT0r3hXCR4fGcaqfPKWlYg66PiOlECWPTHZJE
        eGKvASsSUZ6o8k0JaEBKyqn7gAreGTENkMvDLKAHIQI/A2jkdj78DbTmJ4sFoRjQ+PvcFWEl
        kFrE8pig3JHmk4bgsT2VDOjJdWs+gFOjGLJ814t5wY7yRy19WpzHImoLqstckPBYRvkgbc8r
        TGhzRiUVLSseq2V+Msmw0oyoZxKktXQSgskXzf8wrQbs0If2aomAnVBHdrpICFwBNGzWS4Qh
        HVD35bzVhbzRW/MPgl8ap1xQef1OgT6IDPP3RDyNKBtk+WTL0/gyzKrJxQVahlKvygX3VnSz
        vexfreFl16qFQTkpwcKxMgH1dvVDBjjf/N9VCKADBy5OrQzl1B5R3FlXNatUx0WFup6OVlbB
        8kN1LLZ/q4XmX8FGoEhQWMvG/ScD5WI2Xn1OaQRE4gp72aHnHYFyWQh77jynig5SxUVyaiNs
        IEUKB5nH3YkAORXKxnIRHBfDqf6qGGnlmAjeu7dGNGVMNl9QZZk2XfG1TZFWDBZ4KlqXVCGG
        aUgq3veVSji+ZgLYtO2fg/RtWGuSW/xehz1gMzfksq60YL8h21I93/czoHTKxqbRNG65k+eW
        NpHrNPtzqOyEdmjQbf73kffx7gtjlUfP6C7ar88JyCve5edl62W+tTnnWNphT4VIHca6b8NV
        avYPwdhveUwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7r+U9/EGTz6ZWTRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFv/37GC3OPjhCatF
        39pLbA68HmvmrWH02HF3CaPH3m8LWDw2repk89j+7QGrx/3u40wem5fUe9z+95jZY/KN5Ywe
        u282sHn0bVnF6PF5k1wAT5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
        TUpqTmZZapG+XYJexu5Vt9gKzkhUPP14mr2B8YRIFyMnh4SAicTRea2sILaQwFJGiY/b3SDi
        MhInpzWwQtjCEn+udbF1MXIB1XxilPh1YiUTSIJNwFCi6y1EQkSgk1FiWvdHdpAEs8AbJolL
        VyNAbGGBIIklHx6zgNgsAqoSOyf+BKvhFbCT6LtykQlig7zE6g0HmEFsTqD465aDUBfZSixf
        8J55AiPfAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIExs+3Yz807GC9tDD7EKMDBqMTD
        +yLkdZwQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAh01kVlKNDkfGM95
        JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoY21csuacy8+LHVM6r
        zIXyB3h76yfWFz/58DFkWoGg2aGIa8bxLfN2fBaYsXFn1CtbQ76HF3Rv3VGeed9x06mcJ+Kv
        96veL+12u2Qmf2LJvUc5u8SWtXCo9BqF1H5QTG8OePvZJqM/MmnxfH/F92k3JuZcNvP5z6x+
        +48Vs4hlmPzN+58UecRFlViKMxINtZiLihMBpDuXsK8CAAA=
X-CMS-MailID: 20200619103703eucas1p2b8b0e90f9559c3fff12d61f76b861cc1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200619103703eucas1p2b8b0e90f9559c3fff12d61f76b861cc1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103703eucas1p2b8b0e90f9559c3fff12d61f76b861cc1
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
        <CGME20200619103703eucas1p2b8b0e90f9559c3fff12d61f76b861cc1@eucas1p2.samsung.com>
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
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 4 ++--
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index ac5d0aa80276..ba8450ea04d0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -41,8 +41,8 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
 
 		for (i = 0; i < n_sgt; i++) {
 			if (bo->sgts[i].sgl) {
-				dma_unmap_sg(pfdev->dev, bo->sgts[i].sgl,
-					     bo->sgts[i].nents, DMA_BIDIRECTIONAL);
+				dma_unmap_sgtable(pfdev->dev, &bo->sgts[i],
+						  DMA_BIDIRECTIONAL, 0);
 				sg_free_table(&bo->sgts[i]);
 			}
 		}
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 0a339c6fbfaa..fd294f6a7d3b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -253,7 +253,7 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 	struct io_pgtable_ops *ops = mmu->pgtbl_ops;
 	u64 start_iova = iova;
 
-	for_each_sg(sgt->sgl, sgl, sgt->nents, count) {
+	for_each_sgtable_dma_sg(sgt, sgl, count) {
 		unsigned long paddr = sg_dma_address(sgl);
 		size_t len = sg_dma_len(sgl);
 
@@ -517,10 +517,9 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	if (ret)
 		goto err_pages;
 
-	if (!dma_map_sg(pfdev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL)) {
-		ret = -EINVAL;
+	ret = dma_map_sgtable(pfdev->dev, sgt, DMA_BIDIRECTIONAL, 0);
+	if (ret)
 		goto err_map;
-	}
 
 	mmu_map_sg(pfdev, bomapping->mmu, addr,
 		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
-- 
2.17.1

