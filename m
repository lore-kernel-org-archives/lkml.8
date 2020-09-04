Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB92C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC937204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jyV90Pj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgIDNsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:48:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44845 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730611AbgIDNp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:45:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200904133502euoutp0116b50079705f49b049055d4068692955~xmAfnx9Kl0722107221euoutp01h
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200904133502euoutp0116b50079705f49b049055d4068692955~xmAfnx9Kl0722107221euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599226502;
        bh=miWTJ6cx6ut1i6kXEdULDZ4Mjgt6tos97ycfll4NlAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jyV90Pj9e09lki2dcAoXP+J3vcpoQNliAXnJc2uWx5UjkV4+x0PXzb+DpXCwRYnt9
         uGt99zVQtOXrgrzTwBCnzBywDmz1e/k38Uh/yaeFvuFGAG5/6fzWPGhgLJ1SHFxbWf
         uLkQSOLrApdzuepxg/rConkNq8JpMideYtxMDsrk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200904133501eucas1p29681af24cdf905bfac363202f9ab3415~xmAfPEI6l1447814478eucas1p2o;
        Fri,  4 Sep 2020 13:35:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B7.39.06318.582425F5; Fri,  4
        Sep 2020 14:35:01 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200904133501eucas1p27e474ceb366abd6c5070565abfc6ae21~xmAe3abe30593605936eucas1p2p;
        Fri,  4 Sep 2020 13:35:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200904133501eusmtrp26074756feaa5a81ed6778c01db1a8f4d~xmAe2r1et0977009770eusmtrp2K;
        Fri,  4 Sep 2020 13:35:01 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-a0-5f5242857798
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A5.A0.06017.582425F5; Fri,  4
        Sep 2020 14:35:01 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200904133501eusmtip15974690ea6539d6916dc94521461cfc8~xmAeVfoow1888418884eusmtip1T;
        Fri,  4 Sep 2020 13:35:00 +0000 (GMT)
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
Subject: [PATCH v10 13/30] drm: omapdrm: use common helper for extracting
 pages array
Date:   Fri,  4 Sep 2020 15:16:54 +0200
Message-Id: <20200904131711.12950-14-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRj227nseFkcp+CXhYtZkkKamHDAy0z6cSqC8E8k5Fx5UMtN29TU
        iIY2LW+pBa4lOsqweb+b5h11lTQlrVZeymaSiql5oUK0bSfr3/M+F56Hj49A+A2YKxErS2Tk
        MkmcELdDW4d+jRxRhYaJjy4OBVB5hpccqkFdh1E7rYUINb6xjFO6qkEOpe0JoNbHZzhUo+kd
        Ro11lOBUzcAUl+pbmcWourKPeIgDXV1aDeiuTS1Kt21+xuhPOXoO3VR+k57YNiH0PWMFoJ9/
        UOJ0fnMloPXGNg691uh21j7cLjCKiYtNZuQ+wZF2MfPf7+MJffYpIz8fokqgs80GtgQkj8En
        wwWIBfPJpwCOT4dnAzszXgew4WsvYI81ADdajfhu4tZqCcYKFQBqfugwNm6O9PTILRgnfWH2
        UrY14EyqAHyR52AJIGQ/Bzar3qIWwYk8B6fUr6wmlDwEdzSzwIJ5ZDB8r5zD2DYBrKrvte6z
        NfMt6llrMyS7udBQpkVY0wl4p30aZbETXNA3c1m8H+60l3HYQAaAM4YaLnvkAjiWrgasKwBO
        Gn6bZxDmfZ6wrsOHpY9DXeeGlYbkHmhccrTQiBkWtRYjLM2DtzP5rNsDavS1/2r7Rt/8nUZD
        9bKay75WIYDrg+lIARBo/pdpAagELkySQhrNKPxkzDVvhUSqSJJFe1+KlzYC80ca3tZvPAPd
        Wxf7AUkAoQPPRhQm5mOSZEWqtB9AAhE680JfD0fweVGS1DRGHi+WJ8Uxin6wj0CFLjy/R/MX
        +GS0JJG5wjAJjHxX5RC2rkrQKfMZ0C1ObOXrTVKvB/6B56Nri0LDL6eUm+L2rmbVPA65MXJ1
        zTHyrkrQ0iUwVl2PiTjcPdXkmz63Ish1Fx3sNkYGaTz5xWeIU/rIQneHkx41hjTfA2hOZpQb
        LvqysOd0lrN/WcaKt5i/s6hTi2pnSycjvs1n5ufECur9bYJGhagiRuLrhcgVkj8GjqjHRAMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xu7qtTkHxBgd+KFr0njvJZLFxxnpW
        i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBaXd81hs1h75C67xcEPT1gt1s+/xebA
        47Fm3hpGj73fFrB4bP/2gNXjfvdxJo/NS+o9bv97zOwx+cZyRo/dNxvYPPq2rGL0OH5jO5PH
        501yAdxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJ
        ehkv301hKzjIXXH+x2yWBsaVnF2MnBwSAiYSLR/nsHYxcnEICSxllOjoOssIkZCRODmtgRXC
        Fpb4c62LDaLoE6PEiadzWUASbAKGEl1vIRIiAp2MEtO6P7KDOMwCJ5gk7u2dDzSKg0NYIFRi
        e7cBSAOLgKrE/1lPwDbwCthJXG94BrVBXmL1hgPMIDYnUHzrjCdgcSEBW4kPcxazTGDkW8DI
        sIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwQrYd+7llB2PXu+BDjAIcjEo8vAz2QfFCrIll
        xZW5hxglOJiVRHidzp6OE+JNSaysSi3Kjy8qzUktPsRoCnTURGYp0eR8YPTmlcQbmhqaW1ga
        mhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgZDkhUZElzsfLc9tWuKKd8dT92ax2
        Fm+/hBe6Xbb5/uRz6/EcMeN/f/6W1+QwN899kc7i1ZvEZe/2fnd139Uo07Ab21hqXm28+EQs
        dzJz59Inspu3FD0WDvyblVe/2KQnuzyUq/fi6zMnpwk4ziji7O/M4q7I+Zdx+/WxNXycjIFy
        KfNkJeWUWIozEg21mIuKEwF5FVkTpgIAAA==
X-CMS-MailID: 20200904133501eucas1p27e474ceb366abd6c5070565abfc6ae21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200904133501eucas1p27e474ceb366abd6c5070565abfc6ae21
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133501eucas1p27e474ceb366abd6c5070565abfc6ae21
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
        <CGME20200904133501eucas1p27e474ceb366abd6c5070565abfc6ae21@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use common helper for converting a sg_table object into struct
page pointer array.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index d0d12d5dd76c..f67f223c6479 100644
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
+		if (ret) {
 			omap_gem_free_object(obj);
 			obj = ERR_PTR(-ENOMEM);
 			goto done;
-- 
2.17.1

