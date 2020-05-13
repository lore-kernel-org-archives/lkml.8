Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DA9C2D109
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724EF208C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eYEKmPYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbgEMNd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:33:58 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38219 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388158AbgEMNdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:33:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200513133323euoutp02e7011224a60e67988dc8f6e9aa6e1f27~Omcg9z0oW0033500335euoutp02p
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:33:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200513133323euoutp02e7011224a60e67988dc8f6e9aa6e1f27~Omcg9z0oW0033500335euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589376803;
        bh=CZbbwG/c/y8+wYH8ObEE3tIAUZE/HWxN0ulpE2QNiE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYEKmPYmJIwJzHHc7tM+Ya6oHzwuAHyWDJNgCtvLhP1EZ1S4iJ93PwZ/VipmNANlt
         ouNyos6OzWlnGGgEpMoZBWQrA+3RwhVI3fK5ZTiCq/qZ2VOZBLTSVZqS2lspJibx+A
         FUMXvzny6ewSMHyJbZIZddUwVwQ/vx3AUG9IrnuY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200513133323eucas1p167560f10137968d51959b06f96d18508~OmcgqQDwP0384603846eucas1p1k;
        Wed, 13 May 2020 13:33:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 49.11.60679.327FBBE5; Wed, 13
        May 2020 14:33:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200513133323eucas1p1344fe42c8710f0ed84cf3c9fdb5ca515~OmcgULNyA0785007850eucas1p1G;
        Wed, 13 May 2020 13:33:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200513133323eusmtrp12afaeda27ef00a9d1e53f0fb03dfb511~OmcgTZQiB1050710507eusmtrp1a;
        Wed, 13 May 2020 13:33:23 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-77-5ebbf723f197
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 77.2A.08375.327FBBE5; Wed, 13
        May 2020 14:33:23 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200513133322eusmtip15b0156e78861f281e5548f723b5c1813~OmcfiHzeD0693406934eusmtip1d;
        Wed, 13 May 2020 13:33:22 +0000 (GMT)
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
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Subject: [PATCH v5 35/38] rapidio: fix common struct sg_table related issues
Date:   Wed, 13 May 2020 15:32:42 +0200
Message-Id: <20200513133245.6408-35-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfSzUcRzH+/4e7n5uzn6dq/sOYzvVli2i/vhtqmVa/WqtefirRF35DeOO
        7hBt6nIeLypkhGSyeY4QcuMikbRLSITkqSGSeU6jOz/03+vz/nze38/DvgQq0OBmhJ8smJHL
        JAFiDg+rblnVHbJe1ngdfjRhRiXq2hBqpKgXpV6kl+HURnUSSnUvznKowuK3CJWjdaQWuocR
        qmK0B6e66rI4VGnzIJdK/biMUo2/x/CTfLokuwTQ9Us5GP0qY5BLJ0xH4XTN0necHrrXitCV
        eXfo/vVRlE7pzQe0pk/Joe9XFQF6vsLSxfgS75g3E+AXysjtTlzl+fbHWwSphGHK3DlcCb6R
        amBEQPIobCuoBGrAIwRkAYDlymiMDRYA7FTPIWwwD+CziSSwbRlOTeWyiXwAJz5koTuWns/F
        iKGKQ9pD9YyaY2AhGQ3gu0RjA6PkLwQ2z9sY2JQ8D7ti6jEDY+R+2KHJ3PTyyeOwu3YRY7tZ
        weLy16iBjfT61IB2cz5IvufCkfYGDlt0CmYsx6Esm8Kp1iouyxawPSVhy6ACcFhXymWDBAC7
        ItO3FnKEA7o/+pcI/XgHYVmdHSs7wRVNAWKQIWkCe2d2swuYwOTqNJSV+TAuRsBWH4AZrc93
        2jZ2dG6NQ8PBvuytA70BMDIrB38IrDL+N8sBoAiImBCF1IdROMiYm7YKiVQRIvOxvR4orQD6
        L9W+3rpQC+r+XmsCJAHExnzqq8ZLgEtCFeHSJgAJVCzkXyjTS3xvSfgtRh54RR4SwCiagDmB
        iUX8I7mTngLSRxLM+DNMECPfziKEkZkS7Bl1D2ux/ZEWafNTtld0zs/STXs2BZud1ob2Cevp
        M5gzL+y2W7yLr/dkedPQg8I1lcPq4yd55nLPiA0Rddp1fEM1cHdf0pez/mvODWGxLQ7uL5ko
        c1Xn5bFOr6he0tHiotDLNdOaZ1LjsZJmIooQPHW6ERj8ibIfLtPG7hpP9hBjCl+JvQ0qV0j+
        AZ22r+JOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7rK33fHGbxtZrboPXeSyeLRqhvM
        FhtnrGe1+L9tIrPFla/v2SxWrj7KZLFgv7XFlysPmSw2Pb7GanF51xw2i7VH7rJbTD3/ndni
        4IcnrA68HmvmrWH02PttAYvHzll32T163rSwemz/9oDV4373cSaPzUvqPW7/e8zsMfnGckaP
        3Tcb2Dz6tqxi9Pi8SS6AJ0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEv43anTEGzSEXDoo+sDYz3BLoYOTkkBEwkHk6dyt7FyMUhJLCUUeL2wyvM
        EAkZiZPTGlghbGGJP9e62CCKPjFKtLafYwdJsAkYSnS9hUiICHQySkzr/gg2ilngG5PEpKW3
        2ECqhAV8JC637WUBsVkEVCUu7J7NBGLzCthKXNnxlQVihbzE6g0HwFZzAsVf3dkPFhcSyJfY
        u3gf2wRGvgWMDKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECo2bbsZ+bdzBe2hh8iFGAg1GJ
        h9fi1u44IdbEsuLK3EOMEhzMSiK8fuuBQrwpiZVVqUX58UWlOanFhxhNgY6ayCwlmpwPjOi8
        knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M89T2LWmXyqwpTXhQ
        qdMzLX/tv2UFv7dERKhOt/iaw8FgdWRJituRJzkqE7ymC/5dzOB/4HHcGv7q+oZiN9/HZk+n
        Pk/L+c0e2nNNUu/Y/wKFwLhZ9/Lk3pzl4e35KWdeMynnHofXK8+dq+M5ePZoSpw/ca6y3SJR
        8leopMznuvzpx2axXCtUYinOSDTUYi4qTgQAssdja7ACAAA=
X-CMS-MailID: 20200513133323eucas1p1344fe42c8710f0ed84cf3c9fdb5ca515
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200513133323eucas1p1344fe42c8710f0ed84cf3c9fdb5ca515
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133323eucas1p1344fe42c8710f0ed84cf3c9fdb5ca515
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
        <20200513133245.6408-1-m.szyprowski@samsung.com>
        <CGME20200513133323eucas1p1344fe42c8710f0ed84cf3c9fdb5ca515@eucas1p1.samsung.com>
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
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/rapidio/devices/rio_mport_cdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 4029637..92d8742 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -574,8 +574,7 @@ static void dma_req_free(struct kref *ref)
 	struct mport_cdev_priv *priv = req->priv;
 	unsigned int i;
 
-	dma_unmap_sg(req->dmach->device->dev,
-		     req->sgt.sgl, req->sgt.nents, req->dir);
+	dma_unmap_sgtable(req->dmach->device->dev, req->sgt, req->dir, 0);
 	sg_free_table(&req->sgt);
 	if (req->page_list) {
 		for (i = 0; i < req->nr_pages; i++)
@@ -927,9 +926,8 @@ static int do_dma_request(struct mport_dma_req *req,
 				xfer->offset, xfer->length);
 	}
 
-	nents = dma_map_sg(chan->device->dev,
-			   req->sgt.sgl, req->sgt.nents, dir);
-	if (nents == 0) {
+	ret = dma_map_sgtable(chan->device->dev, req->sgt, dir, 0);
+	if (ret) {
 		rmcd_error("Failed to map SG list");
 		ret = -EFAULT;
 		goto err_pg;
-- 
1.9.1

