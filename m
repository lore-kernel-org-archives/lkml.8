Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD8C8300C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 669CB2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uHCLOybd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgD1NUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:20:38 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59481 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgD1NU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:20:29 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200428132027euoutp020d2fd56444fb9e0d816c32c0c92358e3~J-l7f6NuZ2982129821euoutp02d
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:20:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200428132027euoutp020d2fd56444fb9e0d816c32c0c92358e3~J-l7f6NuZ2982129821euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588080027;
        bh=9be3YElguP5sWoqQkdSkQh0w/wJ/kV9jDuhjOHmn6bM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHCLOybd5NCq5MXkji9EJTsi86FPzUOavKVGr19EVSQ4cpXjyQVlMD3IKtPF1TgX1
         VWPwHHeqsw1Iu6rl6eg5V6ywTwYGAMngHkBq6VQ+xMaagSs7lfBO6pTudPkOf79hVg
         S4s3Axv4B2yhSfggyZ+ji9R5zlh4f5NcCsa5cFW0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200428132026eucas1p169e8d8d422146536585e4fc43de045ca~J-l7KU8T73057830578eucas1p1O;
        Tue, 28 Apr 2020 13:20:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 52.26.60698.A9D28AE5; Tue, 28
        Apr 2020 14:20:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200428132025eucas1p21580e634500a3e85564551cddf168b4a~J-l6ZWveu1083610836eucas1p2S;
        Tue, 28 Apr 2020 13:20:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200428132025eusmtrp27192d0ccb55d208d4463f4bf76cd415f~J-l6YtIQE2140221402eusmtrp2J;
        Tue, 28 Apr 2020 13:20:25 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-7f-5ea82d9ab5eb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AC.D3.07950.99D28AE5; Tue, 28
        Apr 2020 14:20:25 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200428132025eusmtip2bf75034e3fddc8716b8207d0cb35a6aa~J-l5rXDuX1062310623eusmtip2m;
        Tue, 28 Apr 2020 13:20:25 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [RFC 06/17] drm: i915: fix sg_table nents vs. orig_nents misuse
Date:   Tue, 28 Apr 2020 15:19:54 +0200
Message-Id: <20200428132005.21424-7-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSeUgUYRjG+WZmZ0dzc1wFv+wwt1Iq1MywIU0SJQbKEKSISG3TScWTHbX0
        j3K1QjRDDcpWq0W88lovplpT07Q1jcUL8ax0VVDxygOU1Nwdtf+e53l/7/fAy0eg4kaBFREa
        GcPIIqXhEtwY476tae0V9sX+Z5Yybal07XeEKlDJhVRVtkpAJTW349QWl4lSvSvzOPW+tBWh
        cjJqEErZ6Eot944iVLWuT0D1qHNxqrxlREg1LYwLqPaRJeElU7rsbRmg61eVGD3c9xmnP6z+
        FtC/0jQIXZP/iB7a1KH0i/4iQNcNJOL089oSQC9VH/HZd8vYLYgJD41jZI7ud4xD3kzfjO4I
        eDAoz8cSwaR3KjAiIHkOyrkfwlRgTIjJYgDnuNc7ZhnArqlFjDdLAOYPpaC7K3PyXJwfFAGY
        PFeL7K2oelqFegonnWDqbCqu1xbkEwDb0k30EEpyKBwvajFA5iQN68aqDM9i5AnINa5u5wQh
        Ii9Cpdyfb7OGpZVfDIgR6Q4LxiYMzZDsFsL5vHUhD3nBrPaXCK/N4bSmdic/BLc+vUP4hWQA
        R7XlQt48A7AnKRvwlCsc1q7j+maUPAlVakc+9oCFjYOYPobkftg/a6aP0W2Zxb1C+VgEU56K
        edoWKjQVe7VNnd0716JhWluBQYvJTADrFeYZwFrxv0sJQAmwZGLZiGCGdY5k7juw0gg2NjLY
        ITAqohpsf6uOTc3KR9Dw924zIAkgMRFVmhT7iwXSODY+ohlAApVYiMZCCv3FoiBpfAIjiwqQ
        xYYzbDM4SGASS5Fz3pSfmAyWxjBhDBPNyHanCGFklQiqqq95Lx7g7L5Onp2xueDsZ4IQDxHU
        y/7nQtcxX3XF1SKb41k2bEHgaTvOJ/Nx20DCPdx05vKN6Abfpl6X+o0/o9mYtvj8oHrATZ0i
        z1HozGQToTqNVWmVa3dMjiTn6G1Pz8RQl+sJc1dGDkuSVqPXwpzsPCbpjXRWO7GcEdgpwdgQ
        qdMpVMZK/wE0Mvw8UgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7ozdVfEGaz9pGfRe+4kk8XS9Y3s
        FhtnrGe1aDp0is3i/7aJzBZXvr5ns1i5+iiTxewJm5ksFuy3tvhy5SGTxabH11gtLu+aw2ax
        9shddouDH56wWpy6+5ndgd9jzbw1jB57vy1g8bhzbQ+bx/ZvD1g97ncfZ/LYvKTe4/a/x8we
        k28sZ/TYfbOBzaNvyypGj8+b5AK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOt
        jEyV9O1sUlJzMstSi/TtEvQy5r6KKDgdX3GrcQlLA+Mz3y5GTg4JAROJd41z2LoYuTiEBJYy
        Srx+8IwJIiEjcXJaAyuELSzx51oXVNEnRomdDVvBitgEDCW63kIkRAQ6GSWmdX9kB3GYBQ4w
        S3SfPwlWJSzgIbH70UZmEJtFQFVi2/5vQEUcHLwCthILGuMgNshLrN5wAKyEU8BOYumjp2wg
        JUJAJZdbcicw8i1gZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGDvbjv3csoOx613wIUYB
        DkYlHt4NPCvihFgTy4orcw8xSnAwK4nwPspYFifEm5JYWZValB9fVJqTWnyI0RTopInMUqLJ
        +cC4ziuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwLhZqjRl+p63
        e05HK4vU179I8qg9/9VH8mHx7bkt/glfvpw/pvf0BUvNgYYtZ48ee/Rn+r4ZrAGGB6TsjK7F
        nDdi9Z943kqwUO7q2+RZvnr5SkI/T/feDiqb6nPCPlfgfPmp0J0ZtrZH2W4faF+7+7LOV+YC
        boV3Fbt/18qIeYXrXUl5/k1PcZMSS3FGoqEWc1FxIgDfCJZbswIAAA==
X-CMS-MailID: 20200428132025eucas1p21580e634500a3e85564551cddf168b4a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200428132025eucas1p21580e634500a3e85564551cddf168b4a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132025eucas1p21580e634500a3e85564551cddf168b4a
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
        <CGME20200428132025eucas1p21580e634500a3e85564551cddf168b4a@eucas1p2.samsung.com>
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
---
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c       | 13 +++++++------
 drivers/gpu/drm/i915/gem/i915_gem_internal.c     |  4 ++--
 drivers/gpu/drm/i915/gem/i915_gem_region.c       |  4 ++--
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c        |  5 +++--
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c  | 10 +++++-----
 drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c |  5 +++--
 drivers/gpu/drm/i915/gt/intel_ggtt.c             | 12 ++++++------
 drivers/gpu/drm/i915/i915_gem_gtt.c              | 12 +++++++-----
 drivers/gpu/drm/i915/i915_scatterlist.c          |  4 ++--
 drivers/gpu/drm/i915/selftests/scatterlist.c     |  8 ++++----
 10 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index 7db5a79..d829852 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -36,21 +36,22 @@ static struct sg_table *i915_gem_map_dma_buf(struct dma_buf_attachment *attachme
 		goto err_unpin_pages;
 	}
 
-	ret = sg_alloc_table(st, obj->mm.pages->nents, GFP_KERNEL);
+	ret = sg_alloc_table(st, obj->mm.pages->orig_nents, GFP_KERNEL);
 	if (ret)
 		goto err_free;
 
 	src = obj->mm.pages->sgl;
 	dst = st->sgl;
-	for (i = 0; i < obj->mm.pages->nents; i++) {
+	for (i = 0; i < obj->mm.pages->orig_nents; i++) {
 		sg_set_page(dst, sg_page(src), src->length, 0);
 		dst = sg_next(dst);
 		src = sg_next(src);
 	}
 
-	if (!dma_map_sg_attrs(attachment->dev,
-			      st->sgl, st->nents, dir,
-			      DMA_ATTR_SKIP_CPU_SYNC)) {
+	st->nents = dma_map_sg_attrs(attachment->dev,
+				     st->sgl, st->orig_nents, dir,
+				     DMA_ATTR_SKIP_CPU_SYNC);
+	if (!st->nents) {
 		ret = -ENOMEM;
 		goto err_free_sg;
 	}
@@ -74,7 +75,7 @@ static void i915_gem_unmap_dma_buf(struct dma_buf_attachment *attachment,
 	struct drm_i915_gem_object *obj = dma_buf_to_obj(attachment->dmabuf);
 
 	dma_unmap_sg_attrs(attachment->dev,
-			   sg->sgl, sg->nents, dir,
+			   sg->sgl, sg->orig_nents, dir,
 			   DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sg);
 	kfree(sg);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
index cbbff81..a8ebfdd 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
@@ -73,7 +73,7 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
 	}
 
 	sg = st->sgl;
-	st->nents = 0;
+	st->nents = st->orig_nents = 0;
 	sg_page_sizes = 0;
 
 	do {
@@ -94,7 +94,7 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
 
 		sg_set_page(sg, page, PAGE_SIZE << order, 0);
 		sg_page_sizes |= PAGE_SIZE << order;
-		st->nents++;
+		st->nents = st->orig_nents = st->nents + 1;
 
 		npages -= 1 << order;
 		if (!npages) {
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_region.c b/drivers/gpu/drm/i915/gem/i915_gem_region.c
index 1515384..58ca560 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_region.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_region.c
@@ -53,7 +53,7 @@
 	GEM_BUG_ON(list_empty(blocks));
 
 	sg = st->sgl;
-	st->nents = 0;
+	st->nents = st->orig_nents = 0;
 	sg_page_sizes = 0;
 	prev_end = (resource_size_t)-1;
 
@@ -78,7 +78,7 @@
 
 			sg->length = block_size;
 
-			st->nents++;
+			st->nents = st->orig_nents = st->nents + 1;
 		} else {
 			sg->length += block_size;
 			sg_dma_len(sg) += block_size;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 5d5d7ee..851a732 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -80,7 +80,7 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
 	noreclaim |= __GFP_NORETRY | __GFP_NOWARN;
 
 	sg = st->sgl;
-	st->nents = 0;
+	st->nents = st->orig_nents = 0;
 	sg_page_sizes = 0;
 	for (i = 0; i < page_count; i++) {
 		const unsigned int shrink[] = {
@@ -140,7 +140,8 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
 				sg_page_sizes |= sg->length;
 				sg = sg_next(sg);
 			}
-			st->nents++;
+			st->nents = st->orig_nents = st->nents + 1;
+
 			sg_set_page(sg, page, PAGE_SIZE, 0);
 		} else {
 			sg->length += PAGE_SIZE;
diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index c9988b6..bd141f9 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -76,7 +76,7 @@ static int get_huge_pages(struct drm_i915_gem_object *obj)
 
 	rem = obj->base.size;
 	sg = st->sgl;
-	st->nents = 0;
+	st->nents = st->orig_nents = 0;
 	sg_page_sizes = 0;
 
 	/*
@@ -99,7 +99,7 @@ static int get_huge_pages(struct drm_i915_gem_object *obj)
 
 			sg_set_page(sg, page, page_size, 0);
 			sg_page_sizes |= page_size;
-			st->nents++;
+			st->nents = st->orig_nents = st->nents + 1;
 
 			rem -= page_size;
 			if (!rem) {
@@ -201,7 +201,7 @@ static int fake_get_huge_pages(struct drm_i915_gem_object *obj)
 	/* Use optimal page sized chunks to fill in the sg table */
 	rem = obj->base.size;
 	sg = st->sgl;
-	st->nents = 0;
+	st->nents = st->orig_nents = 0;
 	sg_page_sizes = 0;
 	do {
 		unsigned int page_size = get_largest_page_size(i915, rem);
@@ -217,7 +217,7 @@ static int fake_get_huge_pages(struct drm_i915_gem_object *obj)
 
 		sg_page_sizes |= len;
 
-		st->nents++;
+		st->nents = st->orig_nents = st->nents + 1;
 
 		rem -= len;
 		if (!rem) {
@@ -252,7 +252,7 @@ static int fake_get_huge_pages_single(struct drm_i915_gem_object *obj)
 	}
 
 	sg = st->sgl;
-	st->nents = 1;
+	st->nents = st->orig_nents = 1;
 
 	page_size = get_largest_page_size(i915, obj->base.size);
 	GEM_BUG_ON(!page_size);
diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
index debaf7b..5723525 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_dmabuf.c
@@ -28,7 +28,8 @@ static struct sg_table *mock_map_dma_buf(struct dma_buf_attachment *attachment,
 		sg = sg_next(sg);
 	}
 
-	if (!dma_map_sg(attachment->dev, st->sgl, st->nents, dir)) {
+	st->nents = dma_map_sg(attachment->dev, st->sgl, st->orig_nents, dir);
+	if (!st->nents) {
 		err = -ENOMEM;
 		goto err_st;
 	}
@@ -46,7 +47,7 @@ static void mock_unmap_dma_buf(struct dma_buf_attachment *attachment,
 			       struct sg_table *st,
 			       enum dma_data_direction dir)
 {
-	dma_unmap_sg(attachment->dev, st->sgl, st->nents, dir);
+	dma_unmap_sg(attachment->dev, st->sgl, st->orig_nents, dir);
 	sg_free_table(st);
 	kfree(st);
 }
diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index 66165b1..9a298bf 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -1221,7 +1221,7 @@ void i915_ggtt_resume(struct i915_ggtt *ggtt)
 	for (column = 0; column < width; column++) {
 		src_idx = stride * (height - 1) + column + offset;
 		for (row = 0; row < height; row++) {
-			st->nents++;
+			st->nents = st->orig_nents = st->nents + 1;
 			/*
 			 * We don't need the pages, but need to initialize
 			 * the entries so the sg list can be happily traversed.
@@ -1259,7 +1259,7 @@ void i915_ggtt_resume(struct i915_ggtt *ggtt)
 	if (ret)
 		goto err_sg_alloc;
 
-	st->nents = 0;
+	st->nents = st->orig_nents = 0;
 	sg = st->sgl;
 
 	for (i = 0 ; i < ARRAY_SIZE(rot_info->plane); i++) {
@@ -1306,7 +1306,7 @@ void i915_ggtt_resume(struct i915_ggtt *ggtt)
 
 			length = min(left, length);
 
-			st->nents++;
+			st->nents = st->orig_nents = st->nents + 1;
 
 			sg_set_page(sg, NULL, length, 0);
 			sg_dma_address(sg) = addr;
@@ -1343,7 +1343,7 @@ void i915_ggtt_resume(struct i915_ggtt *ggtt)
 	if (ret)
 		goto err_sg_alloc;
 
-	st->nents = 0;
+	st->nents = st->orig_nents = 0;
 	sg = st->sgl;
 
 	for (i = 0 ; i < ARRAY_SIZE(rem_info->plane); i++) {
@@ -1389,7 +1389,7 @@ void i915_ggtt_resume(struct i915_ggtt *ggtt)
 	GEM_BUG_ON(!iter);
 
 	sg = st->sgl;
-	st->nents = 0;
+	st->nents = st->orig_nents = 0;
 	do {
 		unsigned int len;
 
@@ -1400,7 +1400,7 @@ void i915_ggtt_resume(struct i915_ggtt *ggtt)
 			sg_dma_address(iter) + (offset << PAGE_SHIFT);
 		sg_dma_len(sg) = len;
 
-		st->nents++;
+		st->nents = st->orig_nents = st->nents + 1;
 		count -= len >> PAGE_SHIFT;
 		if (count == 0) {
 			sg_mark_end(sg);
diff --git a/drivers/gpu/drm/i915/i915_gem_gtt.c b/drivers/gpu/drm/i915/i915_gem_gtt.c
index cb43381..c4122cd3 100644
--- a/drivers/gpu/drm/i915/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
@@ -28,10 +28,11 @@ int i915_gem_gtt_prepare_pages(struct drm_i915_gem_object *obj,
 			       struct sg_table *pages)
 {
 	do {
-		if (dma_map_sg_attrs(&obj->base.dev->pdev->dev,
-				     pages->sgl, pages->nents,
-				     PCI_DMA_BIDIRECTIONAL,
-				     DMA_ATTR_NO_WARN))
+		pages->nents = dma_map_sg_attrs(&obj->base.dev->pdev->dev,
+						pages->sgl, pages->orig_nents,
+						PCI_DMA_BIDIRECTIONAL,
+						DMA_ATTR_NO_WARN);
+		if (page->nents)
 			return 0;
 
 		/*
@@ -68,7 +69,8 @@ void i915_gem_gtt_finish_pages(struct drm_i915_gem_object *obj,
 		}
 	}
 
-	dma_unmap_sg(kdev, pages->sgl, pages->nents, PCI_DMA_BIDIRECTIONAL);
+	dma_unmap_sg(kdev, pages->sgl, pages->orig_nents,
+		     PCI_DMA_BIDIRECTIONAL);
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/i915_scatterlist.c b/drivers/gpu/drm/i915/i915_scatterlist.c
index cc6b384..05bee13 100644
--- a/drivers/gpu/drm/i915/i915_scatterlist.c
+++ b/drivers/gpu/drm/i915/i915_scatterlist.c
@@ -15,11 +15,11 @@ bool i915_sg_trim(struct sg_table *orig_st)
 	if (orig_st->nents == orig_st->orig_nents)
 		return false;
 
-	if (sg_alloc_table(&new_st, orig_st->nents, GFP_KERNEL | __GFP_NOWARN))
+	if (sg_alloc_table(&new_st, orig_st->orig_nents, GFP_KERNEL | __GFP_NOWARN))
 		return false;
 
 	new_sg = new_st.sgl;
-	for_each_sg(orig_st->sgl, sg, orig_st->nents, i) {
+	for_each_sg(orig_st->sgl, sg, orig_st->orig_nents, i) {
 		sg_set_page(new_sg, sg_page(sg), sg->length, 0);
 		sg_dma_address(new_sg) = sg_dma_address(sg);
 		sg_dma_len(new_sg) = sg_dma_len(sg);
diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/drm/i915/selftests/scatterlist.c
index d599186..4456fe5 100644
--- a/drivers/gpu/drm/i915/selftests/scatterlist.c
+++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
@@ -48,9 +48,9 @@ static noinline int expect_pfn_sg(struct pfn_table *pt,
 	unsigned long pfn, n;
 
 	pfn = pt->start;
-	for_each_sg(pt->st.sgl, sg, pt->st.nents, n) {
+	for_each_sg(pt->st.sgl, sg, pt->st.orig_nents, n) {
 		struct page *page = sg_page(sg);
-		unsigned int npages = npages_fn(n, pt->st.nents, rnd);
+		unsigned int npages = npages_fn(n, pt->st.orig_nents, rnd);
 
 		if (page_to_pfn(page) != pfn) {
 			pr_err("%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sg)\n",
@@ -86,7 +86,7 @@ static noinline int expect_pfn_sg_page_iter(struct pfn_table *pt,
 	unsigned long pfn;
 
 	pfn = pt->start;
-	for_each_sg_page(pt->st.sgl, &sgiter, pt->st.nents, 0) {
+	for_each_sg_page(pt->st.sgl, &sgiter, pt->st.orig_nents, 0) {
 		struct page *page = sg_page_iter_page(&sgiter);
 
 		if (page != pfn_to_page(pfn)) {
@@ -256,7 +256,7 @@ static int alloc_table(struct pfn_table *pt,
 		pfn += npages;
 	}
 	sg_mark_end(sg);
-	pt->st.nents = n;
+	pt->st.nents = pt->st.orig_nents = n;
 	pt->end = pfn;
 
 	return 0;
-- 
1.9.1

