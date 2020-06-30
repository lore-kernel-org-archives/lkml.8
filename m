Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BA3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C084320768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RRrOjFfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgF3Iot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:44:49 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46385 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbgF3Ios (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:44:48 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200630084446euoutp01ea689f0ea5f74de77efb84fe563d0201~dReN8W5fc3090330903euoutp01_
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 08:44:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200630084446euoutp01ea689f0ea5f74de77efb84fe563d0201~dReN8W5fc3090330903euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593506686;
        bh=lXmtVvOi3m7BClTCphUvb9QrD/BPO3J1D0W3H9sRRl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRrOjFfBh4VNzuEdaoyc+Eh9Ohxna44hidUV2nA4gjBEE6cMIO7ARANbq9g0UEJUG
         4NeoS245VVYwV6Z8Rost0jDJDYGU7Osv5jxjcgzhHNcrrAv/wrXWTVkFb4wOYxxxRA
         cgLY6odOKxb3N/CS5UVyAnJ/XKTLUr5M879TO4XA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200630084446eucas1p13b09fade29608137f68bae8f0b60e780~dReNjgNmy1186511865eucas1p1M;
        Tue, 30 Jun 2020 08:44:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F5.A6.06318.E7BFAFE5; Tue, 30
        Jun 2020 09:44:46 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200630084445eucas1p1e85857b5d046648578f1447f8ba521a5~dReNOvCZB1180111801eucas1p1G;
        Tue, 30 Jun 2020 08:44:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200630084445eusmtrp1c40012032f3073b4340ec8d12cbfa4d4~dReNN-2SD2091120911eusmtrp1D;
        Tue, 30 Jun 2020 08:44:45 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-ed-5efafb7eab0e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E3.D3.06314.D7BFAFE5; Tue, 30
        Jun 2020 09:44:45 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200630084445eusmtip16232b756e66744d9f85ca187702d2593~dReMjdeol2968129681eusmtip1f;
        Tue, 30 Jun 2020 08:44:44 +0000 (GMT)
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
Subject: [PATCH v8] rapidio: fix common struct sg_table related issues
Date:   Tue, 30 Jun 2020 10:44:31 +0200
Message-Id: <20200630084431.4935-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-34-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHObvb3XU4u03Ng4+EQWFKmlh0U0uTiAsF1R9BBU1XXlRyU3bV
        VKQ0zWrNd5JK1FJRc75SW6mYabqpoyVqOi3fvVz5CF/4yHJes/++33M+39/38ONgiKCBY4uF
        SCMomVQcKkR5bLVmWb//xuqK6MDkAEKk6DtYxHipASGe51RyiD/qDIToXZhBiWeqNhahbPIi
        5nvHWET1RB+H6Kl/hBLlrUNcIvv9EkI0z37m+PLJssdlgGxcVLLJurwhLqn4mcQhXy6OcsiR
        +1oWWVN4k/y4PoGQWYZiQDYMxKNkam0pIOeqd581v8TzDqRCQ6IomduxAF7wh6Y1VviLXdHy
        1Dw0HjQK5MAMg/hBWDlewpYDHibASwAcvqMEjJkHUJM9zWXMHID91aXov0h+h3qLKgawoN/I
        2Y7EFxewTBSKu0P5lHwzYYXfBrA9xdykEXyaBVvnnE3aEj8JB5ebNhk2vgeOzwxvaj7uDZ9M
        r3GZNkeoqnqDmLQZ7gMzM9YRUxnE9VyYPzS+YbANcwJO1kQzvCU0amu3svZQl6VgM3wigGP6
        ci5jFAD23MoBDOUFP+lXUNMgBN8HK+vdmOPjMLehhcvMt4CGqZ3M+y1gpvrhVi0f3k3e2uNe
        mKet2K5t7upGGE3CX20jKLOfTAC7nhah6cAx73+ZEoBSYENF0pIgivaQUtddabGEjpQGuV4N
        k1SDjS+lW9cuvAKv1660ABwDQnN+gH5ZJOCIo+gYSQuAGCK04vu904kE/EBxTCwlC/OXRYZS
        dAuww9hCG75H/uRlAR4kjqCuUVQ4Jft3y8LMbOPBhcOn3EYRqiSwL4fuq5NeDB8csOt8G8HL
        /VqUMKIROR3lTf5O8PRbLbT2UqzGWel2dB9Z+nY6XWWMMyjKYkHSalpIiFPjg0RD6pduewea
        31eVpkn2O9de3O7bnj9RpP2RZFSdz6lZ/45X+M/6HOp0cfGxVnuKNEtdDmdUKfdqhGw6WOzu
        jMho8V+6eyNKTgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7q1v3/FGbQd1rDoPXeSyeLRqhvM
        FhtnrGe1+L9tIrPFla/v2SxWrj7KZLFgv7XFlysPmSw2Pb7GanF51xw2i7VH7rJbTD3/ndni
        4IcnrA68HmvmrWH02PttAYvHzll32T163rSwemz/9oDV4373cSaPzUvqPW7/e8zsMfnGckaP
        3Tcb2Dz6tqxi9Pi8SS6AJ0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEv4+r+P0wFW8UquvpmsTUw7hXqYuTkkBAwkVh0chtjFyMXh5DAUkaJh1tn
        M0IkZCROTmtghbCFJf5c62KDKPrEKPFu0UWwBJuAoUTXW4iEiEAno8S07o/sIA6zwDcmiUlL
        b7GBVAkLuEnc+rkfzGYRUJV49P4emM0rYCMx/90fdogV8hKrNxxgBrE5BewlJk38B2YLCdhJ
        3JmznmkCI98CRoZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgXGz7djPzTsYL20MPsQowMGo
        xMObcO5nnBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pzUosPMZoCHTWRWUo0OR8Y
        03kl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhhDDnTNtLxxcdEW
        ibK2H7sl9vN7h52b1xP+wPkBt8W5A+k3Xi67fWl22J11G9RWxu+ftKT8UJzG3Xtrc96fj73O
        Lbbik6DwOuGrU5rlPbsKbB12u+q0hqRduFU+Q77z2Y0XXut2ybosfJBTsSfpgOst5usp+/mD
        w77PX2nw19w6K+kW22bHxSnFSizFGYmGWsxFxYkA1yBJGLECAAA=
X-CMS-MailID: 20200630084445eucas1p1e85857b5d046648578f1447f8ba521a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200630084445eucas1p1e85857b5d046648578f1447f8ba521a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200630084445eucas1p1e85857b5d046648578f1447f8ba521a5
References: <20200619103636.11974-34-m.szyprowski@samsung.com>
        <CGME20200630084445eucas1p1e85857b5d046648578f1447f8ba521a5@eucas1p1.samsung.com>
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
v8: fixed issues pointed by kbuilt test robot (use of uninitialized
    variable)
---
 drivers/rapidio/devices/rio_mport_cdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 3abbba8c2b5b..351c08b886ec 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -573,8 +573,7 @@ static void dma_req_free(struct kref *ref)
 			refcount);
 	struct mport_cdev_priv *priv = req->priv;
 
-	dma_unmap_sg(req->dmach->device->dev,
-		     req->sgt.sgl, req->sgt.nents, req->dir);
+	dma_unmap_sgtable(req->dmach->device->dev, &req->sgt, req->dir, 0);
 	sg_free_table(&req->sgt);
 	if (req->page_list) {
 		unpin_user_pages(req->page_list, req->nr_pages);
@@ -814,7 +813,6 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 	struct mport_dev *md = priv->md;
 	struct dma_chan *chan;
 	int ret;
-	int nents;
 
 	if (xfer->length == 0)
 		return -EINVAL;
@@ -930,15 +928,14 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 				xfer->offset, xfer->length);
 	}
 
-	nents = dma_map_sg(chan->device->dev,
-			   req->sgt.sgl, req->sgt.nents, dir);
-	if (nents == 0) {
+	ret = dma_map_sgtable(chan->device->dev, &req->sgt, dir, 0);
+	if (ret) {
 		rmcd_error("Failed to map SG list");
 		ret = -EFAULT;
 		goto err_pg;
 	}
 
-	ret = do_dma_request(req, xfer, sync, nents);
+	ret = do_dma_request(req, xfer, sync, req->sgt.nents);
 
 	if (ret >= 0) {
 		if (sync == RIO_TRANSFER_ASYNC)
-- 
2.17.1

