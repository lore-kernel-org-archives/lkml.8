Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F024C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384EE2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ecd4bNb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgEDMy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:54:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59269 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgEDMyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:54:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200504125419euoutp020a6d635a4d82f04b0ea9fb002390ac3f~L1G1X_8AW1839718397euoutp02w
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:54:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200504125419euoutp020a6d635a4d82f04b0ea9fb002390ac3f~L1G1X_8AW1839718397euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588596859;
        bh=EVazr+cXLNtZz54aJWiekXBsP8o9spxnq0Q4oG69wq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ecd4bNb8EjmNpv0P3N36eH+6DjXF+KHpVWMzRqCfua3pyNZgRjv2xusws536qidMQ
         1MtXaySAb22/7+pPGUbBvKGkkal0MSjkuoofZa2khwSyFiqFD6uLVkcwcDYATCeLB1
         UkKUaeUGsBGUoi/pn9jEbSlbt0uIxla/hDD3zJho=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200504125419eucas1p13f96494d03af14a472a7468fc3e170cf~L1G075V3x1058810588eucas1p1i;
        Mon,  4 May 2020 12:54:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CE.D2.60679.B7010BE5; Mon,  4
        May 2020 13:54:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200504125418eucas1p190ccb7626f969de8c6d53d216ea12a96~L1G0om3GJ1174211742eucas1p1c;
        Mon,  4 May 2020 12:54:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200504125418eusmtrp21cec5b9ca8d0de30aeeacfc622a49999~L1G0n1nws2826928269eusmtrp2U;
        Mon,  4 May 2020 12:54:18 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-ab-5eb0107bf1dc
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6A.69.08375.A7010BE5; Mon,  4
        May 2020 13:54:18 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200504125418eusmtip225eeda603c17f6f2568f2a347c8f0b38~L1Gz-sE3x0241302413eusmtip2Y;
        Mon,  4 May 2020 12:54:18 +0000 (GMT)
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
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 13/21] drm: virtio: fix sg_table nents vs. orig_nents
 misuse
Date:   Mon,  4 May 2020 14:53:51 +0200
Message-Id: <20200504125359.5678-13-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125359.5678-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSezBUUQDG59x79+61WV3LjDM0qW3SE6nM3BmPamjm1h+V/rFD1JbrMezS
        LvKYhgplo9LLq8GUQR5LXnlMRFibbPKIUoMoZUIzWEOiXZf67zu/7/vON3PmEKigimNOBEhD
        GZlUHCTEeVh124LGOpos8943MsijkjVqhHqWVsqhVqpTUKp3bhqnnha1IlROowP17aMapWZ7
        RxCqfPQ9h+qpe4RTJS2fuVTTrzEOld+ZhR/m08VZxYB+oc3B6OfaYQ49dFOF0BW5MfTg8ihK
        3xvIB3T9h1icnm7ow+lblYWAninffGqDB8/RhwkKCGdkts7neP593cNYyAMYoZpPA7FgyEQB
        DAhIHoQPO4sRBeARArIAwNmJK0BvCMhZAJXtl1ljBsDWiQ7OemP8TQpgjXwAp3LLOOxB18jr
        T1pN4aQdVEwqcL02JeMBbE821IdQ8jsCE/5UrG6YkG4wMbUe02uM3A4rqm+vcj7pBGszBjB2
        zhIWlb1EFYAgDHQ8PXmH/h5IvubCwfYiwGZcYfxgGs5qEzihquSyehNcqc1G2MI1AEc0JVz2
        kARgz9W0tbYD/KRZxPULKLkLltbZsvgIvJ83h+kxJI3gwKSxHqM6ebc6FWUxH95IELBpK5ih
        Uv6bberqXovQcDLOnn2fVwAWaH8jd4Blxv+tHAAKgRkTJpf4MfL9UuaSjVwskYdJ/WwuBEvK
        ge4zdSyrZmtA3dL5ZkASQGjIF82Uegs44nB5pKQZQAIVmvJr4nSI7yOOjGJkwWdlYUGMvBlY
        EJjQjH/g8Q8vAeknDmUCGSaEka27CGFgHgu2nmgjxMePbVF6Oj8xcteOS0ezbHydAuNb3Pum
        Fr+mZqbE1HvtrS2JmPGwCDiZmGls9e6nlfDiSkOEo8hlz5lGEddKVLX01jA/aGffRt9Qt0Uf
        pb1rp3N/Vvr8mPWCRuIxue26unTULVx9Wnm0QhuFbzxU1eWizl7BMkU541+iPYWY3F9stxuV
        ycV/AbKNHBlIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7pVAhviDOYuNbboPXeSyWLjjPWs
        Fv+3TWS2uPL1PZvFytVHmSwW7Le2eHbrJLPFlysPmSw2Pb7GanF51xw2i7VH7rJbHPzwhNVi
        +dl5bA68HmvmrWH02PttAYvH9m8PWD3udx9n8ti8pN7j9r/HzB6Tbyxn9Nh9s4HN4/2+q2we
        fVtWMXp83iQXwB2lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZ
        llqkb5egl3H10gOWgqkSFce/z2BsYLwv3MXIySEhYCLx/MxExi5GLg4hgaWMEt0HmxghEjIS
        J6c1sELYwhJ/rnWxQRR9YpS4+GkdWIJNwFCi6y1EQkSgk1FiWvdHdhCHWeADk8S/v//YQKqE
        BfwlZq/cCDaWRUBVYvO2fjCbV8BWYuesGywQK+QlVm84wNzFyMHBCRSf2asOEhYSyJe4+/Qf
        ywRGvgWMDKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY2XbsZ+bdzBe2hh8iFGAg1GJhzfi
        8/o4IdbEsuLK3EOMEhzMSiK8O1qAQrwpiZVVqUX58UWlOanFhxhNgW6ayCwlmpwPjOO8knhD
        U0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MIekHj505vuwz6x4F8QOb
        dM8erzvxK5azf57GuabPUhVpmxVuZ7p6TV2TwWS4746f8Y4Cl1X3Vvz90vzQWv+BhNS7Cd9/
        GL/7cvJtR6Xormu7Xhm/spLOPMOXwsC0ewrbM6/UlXn5vwNV/ij8/3JqtvO3p7+Wfd9xL+Xi
        GsMNOro5DqmvbMRfcSmxFGckGmoxFxUnAgAuUHJ8qwIAAA==
X-CMS-MailID: 20200504125418eucas1p190ccb7626f969de8c6d53d216ea12a96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200504125418eucas1p190ccb7626f969de8c6d53d216ea12a96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504125418eucas1p190ccb7626f969de8c6d53d216ea12a96
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
        <20200504125359.5678-1-m.szyprowski@samsung.com>
        <CGME20200504125418eucas1p190ccb7626f969de8c6d53d216ea12a96@eucas1p1.samsung.com>
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
For more information, see '[PATCH v2 00/21] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/4/373
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 11 ++++++-----
 drivers/gpu/drm/virtio/virtgpu_vq.c     |  8 ++++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 6ccbd01..12f6bee 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -73,7 +73,8 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 		if (shmem->pages) {
 			if (shmem->mapped) {
 				dma_unmap_sg(vgdev->vdev->dev.parent,
-					     shmem->pages->sgl, shmem->mapped,
+					     shmem->pages->sgl,
+					     shmem->pages->orig_nents,
 					     DMA_TO_DEVICE);
 				shmem->mapped = 0;
 			}
@@ -157,13 +158,13 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 	}
 
 	if (use_dma_api) {
-		shmem->mapped = dma_map_sg(vgdev->vdev->dev.parent,
+		shmem->pages->nents = dma_map_sg(vgdev->vdev->dev.parent,
 					   shmem->pages->sgl,
-					   shmem->pages->nents,
+					   shmem->pages->orig_nents,
 					   DMA_TO_DEVICE);
-		*nents = shmem->mapped;
+		*nents = shmem->mapped = shmem->pages->nents;
 	} else {
-		*nents = shmem->pages->nents;
+		*nents = shmem->pages->orig_nents;
 	}
 
 	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 9e663a5..661325b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -604,8 +604,8 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 
 	if (use_dma_api)
 		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
-				       shmem->pages->sgl, shmem->pages->nents,
-				       DMA_TO_DEVICE);
+				       shmem->pages->sgl,
+				       shmem->pages->orig_nents, DMA_TO_DEVICE);
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
@@ -1020,8 +1020,8 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 
 	if (use_dma_api)
 		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
-				       shmem->pages->sgl, shmem->pages->nents,
-				       DMA_TO_DEVICE);
+				       shmem->pages->sgl,
+				       shmem->pages->orig_nents, DMA_TO_DEVICE);
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
-- 
1.9.1

