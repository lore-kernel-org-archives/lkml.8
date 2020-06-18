Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B21BC4345D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F077E208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E0vCkp4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbgFRPkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:40:42 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38500 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731624AbgFRPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:40:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200618154024euoutp02e7d345ee9bcecc27313717359bba74d9~ZrZsKWE6b1470214702euoutp02D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:40:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200618154024euoutp02e7d345ee9bcecc27313717359bba74d9~ZrZsKWE6b1470214702euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592494824;
        bh=zV96V2vYwfqZCBn3pFDPDrE8ppfbK/CRdkHj1ScotiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0vCkp4Ae58MStY1dFoUDExDeKfDLwry1Eo6MX/5qinbAFfMJAsEBVHqUt3g8uyyx
         1FW5aTm1QhFN/CR8PRGnUeF5MZv9lf1O1ml6xUNRwqMm1+Xp4dR+LkY+KHE1QlR0ul
         TmivMMYdJxd/1Qy7dDUSptvZ5h4d07NXtIeSFKgY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200618154023eucas1p27ac6880c80f767a4c13a753f5d3f6a03~ZrZrfKlwE2977729777eucas1p2I;
        Thu, 18 Jun 2020 15:40:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 04.1F.61286.7EA8BEE5; Thu, 18
        Jun 2020 16:40:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154023eucas1p15053efd9e4d2732b047d2a1cdda7eddb~ZrZrQOSGq1755717557eucas1p1J;
        Thu, 18 Jun 2020 15:40:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200618154023eusmtrp28e8199d49750ba15e98982b1a9adced8~ZrZrPp1Ou0370403704eusmtrp2i;
        Thu, 18 Jun 2020 15:40:23 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-ce-5eeb8ae730ef
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7B.EE.08375.7EA8BEE5; Thu, 18
        Jun 2020 16:40:23 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154022eusmtip128b838702370ae92df6b090ae136508d~ZrZqngWRk0709107091eusmtip1t;
        Thu, 18 Jun 2020 15:40:22 +0000 (GMT)
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
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH v6 14/36] drm: omapdrm: use common helper for extracting
 pages array
Date:   Thu, 18 Jun 2020 17:39:35 +0200
Message-Id: <20200618153956.29558-15-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUgUYRjmm9mZnVW3ptXw0yRhQbEkzQob8MCiYDAoo4sirTWHVfJq1xsi
        STxa88pM0zyJzKu1ddPStFzUNRbNu/VCRTPMq/LINLRdR+3f8z4Hz/PjJVCBAjMn/AJDGEmg
        yF+IG3CqW/58PvRNNu11uKLTkUpq/4RQr7PkGLVRnYZSPUvzOFVS1oxQBR+cqMWeMYRSjPdh
        VHftM5yqaBrmUo0/JjBKnj+AuxnR5XnlgK5fLuDQNcujGD2SqEboquf36MH1cZRO1xYDuq4/
        GqeTlaWAVmtrEHpBsd/D8JqBsw/j7xfGSOxdbxr49uZm4MFZhhFzUyVoNIjlyQCPgOQxWFnf
        gciAASEgXwL4YuQnhz0WAZwoisPYYwHAlLY57nZkIiMGZ4ViAAemFfhOJH6wYdOFkw5QNivD
        9diEjAWwNclIb0JJFQKVsb0cvWBMXobJk4mYHnNIK9isXdkM8ElXmFPcwGHrLGFZ5UdUj3k6
        XqOO3dwEyQYuHFN+xVjTKVia3LcVMIbf1cqtrRZw410+wgZiABxrr+Cyx0MAu+9nAdblBIfa
        V3XVhG7fASivtWfpE/DxzDympyG5C2pn9+hpVAcfVWeiLM2HCXEC1m0Ns9WvdmobO7pQFtMw
        MbdmEwvINADTqn1SgWX2/64CAEqBKRMqDRAzUodAJtxOKgqQhgaK7W4FBSiA7pM06+pfb8FS
        l7cKkAQQGvHdrkx7CTBRmDQyQAUggQpN+CfbNF4Cvo8oMoqRBN2QhPozUhXYR3CEpvyjRVOe
        AlIsCmFuM0wwI9lWEYJnHg1yIqZD3/i5l66ehcr+/qi61NMXuNoZ0No9kmJXuLfT2hy1Whu0
        eF/o57r7iM2XqsrJv5mXele81+78Ho4ekh8fPjOa1dSSnr1q6yzim53XlFt2iQvkQ9fnrsa7
        e4nFXU/nS1wgMuHfUuiZ0Hf3iZnKlndxJtwxT2Ndcc7F4wFjI+RIfUUOB1GJVPQPY62EaUUD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7rPu17HGcz5pmzRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzWLtkbvsFgc/PGG1WD//FpsD
        j8eaeWsYPfZ+W8Disf3bA1aP+93HmTw2L6n3uP3vMbPH5BvLGT1232xg8+jbsorR4/iN7Uwe
        nzfJBXBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl
        6GVcnTuVrWAGd8W7lyuZGxhbObsYOTkkBEwknkxtZuti5OIQEljKKHGk9RgrREJG4uS0Bihb
        WOLPtS6ook+MEsfu9TODJNgEDCW63kIkRAQ6GSWmdX9kB3GYBU4wSdzbO58RpEpYIERi/q4m
        FhCbRUBV4uiNH2wgNq+AncTs5ftYIFbIS6zecABsKidQ/PTxVrDVQgK2Es8/tLFNYORbwMiw
        ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBGth37uXkH46WNwYcYBTgYlXh4X4S8jhNiTSwr
        rsw9xCjBwawkwut09nScEG9KYmVValF+fFFpTmrxIUZToKMmMkuJJucD4zevJN7Q1NDcwtLQ
        3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOjXmy4grMT19/DZ1bcy2m0k3ugvebO
        3jyZd5u1JrPcdt4s3avfuFLpydH35auMFgckLYkx+rHowLMHahKibhPTmXYIu4grJZdEViee
        2WIqljTl5cGkiHbZCY4VqvkRSq8mJ/bp3lBc9mhlmd1O4TthBav+NmpnTy0+NGF1cfF6JcfY
        kMclkuxKLMUZiYZazEXFiQDejUClpwIAAA==
X-CMS-MailID: 20200618154023eucas1p15053efd9e4d2732b047d2a1cdda7eddb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200618154023eucas1p15053efd9e4d2732b047d2a1cdda7eddb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154023eucas1p15053efd9e4d2732b047d2a1cdda7eddb
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
        <CGME20200618154023eucas1p15053efd9e4d2732b047d2a1cdda7eddb@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper for converting a sg_table object into struct
page pointer array.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index d0d12d5dd76c..ff0c4b0c3fd0 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -1297,10 +1297,9 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 		omap_obj->dma_addr = sg_dma_address(sgt->sgl);
 	} else {
 		/* Create pages list from sgt */
-		struct sg_page_iter iter;
 		struct page **pages;
 		unsigned int npages;
-		unsigned int i = 0;
+		unsigned int ret;
 
 		npages = DIV_ROUND_UP(size, PAGE_SIZE);
 		pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
@@ -1311,14 +1310,9 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 		}
 
 		omap_obj->pages = pages;
-
-		for_each_sg_page(sgt->sgl, &iter, sgt->orig_nents, 0) {
-			pages[i++] = sg_page_iter_page(&iter);
-			if (i > npages)
-				break;
-		}
-
-		if (WARN_ON(i != npages)) {
+		ret = drm_prime_sg_to_page_addr_arrays(sgt, pages, NULL,
+						       npages);
+		if (WARN_ON(ret)) {
 			omap_gem_free_object(obj);
 			obj = ERR_PTR(-ENOMEM);
 			goto done;
-- 
2.17.1

