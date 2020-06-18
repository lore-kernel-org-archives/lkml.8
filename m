Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7BEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F7102070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hD7WacUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbgFRPm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:42:26 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54918 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731700AbgFRPki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:40:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200618154037euoutp0190d2ae794d80d68239eb7ad0d6b74bd3~ZrZ3ygkoU1844218442euoutp01R
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:40:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200618154037euoutp0190d2ae794d80d68239eb7ad0d6b74bd3~ZrZ3ygkoU1844218442euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592494837;
        bh=uHaHrVj9uEjHIe4StK4tJYVPskphxegmYKiq5klM8TA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hD7WacUMzhbtAo/IxhsXRxve2LOqp/6uM+0oZP8iFNhlydYW8/Y5oY8M9Ad4o6DUl
         iQhTDeKQ/8jv7ZwJxTSH7QmzQHH44d2bndi1rALEj/auBQke45jIZ3YvkbXNOedOya
         6qmr5ORz2UOBEBOz/ETRUbOqcChnSD7bB+NFcFoo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200618154036eucas1p12b1b5bb16a87b93f8c608072f0299566~ZrZ3iWPVL1755717557eucas1p1X;
        Thu, 18 Jun 2020 15:40:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FA.1F.61286.4FA8BEE5; Thu, 18
        Jun 2020 16:40:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200618154036eucas1p2f4ba8a422fcf2843627d639cd193c90f~ZrZ25Z76N2945829458eucas1p20;
        Thu, 18 Jun 2020 15:40:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200618154036eusmtrp1db46a96eb0cf1f0c63cf7e0222937e54~ZrZ24q8NZ2230622306eusmtrp1M;
        Thu, 18 Jun 2020 15:40:36 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-ef-5eeb8af45f00
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 61.F9.07950.4FA8BEE5; Thu, 18
        Jun 2020 16:40:36 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154035eusmtip14307191b27018d21a029dcd22091c1ee~ZrZ2NS2vX0742307423eusmtip1X;
        Thu, 18 Jun 2020 15:40:35 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 31/36] misc: fastrpc: fix common struct sg_table related
 issues
Date:   Thu, 18 Jun 2020 17:39:52 +0200
Message-Id: <20200618153956.29558-32-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTcRTut7u7zeHqNgV/qGQMKkp8ocIlY5kU3T8CjcIoSJt5UUmnbL7/
        yNlUbL4nodk0S0vT+Wj5fmvqEnHkozJKTFymTtFyPnJpbbtq/33nO993vsPhsBBuO2rLChNG
        kyKhIJzHYNObBn9rnPQyXYCratMZz9IM0fAd+SATf11Yh+J/m/IQfGJ9hYFLy+oY+KvqARpe
        2u2F6ydmaLhq9iOKj7cpGHhN/xQT713Vot4cQlmiBIRhWw6Izo1SOtG88Q0luouVTGI6Q00j
        3pQnEV92ZxEif7ICEO2fJQwiu6EKEGuqY36Wt9jngsnwsFhS5MK/ww5NG5lGoyaw+E+bU3QJ
        WOXIgAULYh5Q+V1KM2EuVgmgznBZBthGrAfw3VI7ShVrADbXPkX2HWvKMiblqACwI+3IgSMj
        XUk3NRiYG5QtyxgmbI2lGkdlWZpECLZIgyWKh6ipYYVdhymNWWYRHTsBtf1S81QOxoejrRso
        leYAq+t7zMkWRn5YnWpeCWIaJtzp+LMnugiTX8r3sBVcVDcwKWwPh/Mz6ZRBCuCMpoZJFZkA
        jj8oBJTKC37VbBvXYBn3Ow3r2lwo+gJ89lYJTDTEDsPJ5aMmGjFCeVMBQtEcmJ7GpdQnYZG6
        9iC29/3Y3rUI2Dk/D6gL5QEoaV9CcoFD0f+wUgCqgA0ZI44IIcVuQjLOWSyIEMcIQ5zvRkao
        gPGlhnfVv1rA+lhQH8BYgGfJ8b6hC+CiglhxQkQfgCyEZ83xGRkO4HKCBQmJpCgyUBQTTor7
        gB2LzrPhuD9fuM3FQgTR5D2SjCJF+10ay8JWAvCzPvbhfj8eY8T9ueRcbbnkkgIcnwxy9awT
        yt0HPHJ19T8N+pSem1cVC/5aML7FH2I7kfN8/ayj59buSu/OWteLU9dWmnPinxRoD533dpy8
        0uhn51sTNPMoaXw0x8r3Q3O20MuQF2DHKEycq5Sw/Z0CV5LjCoptDF1prS3OuTy6OFTgdgYR
        iQX/APrcvXROAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7pful7HGSy6x2zRe+4kk8XfScfY
        LTbOWM9q8X/bRGaLK1/fs1k0L17PZrFy9VEmiwX7rS2+XHnIZLHp8TVWi8u75rBZrD1yl93i
        4IcnrA68HmvmrWH0+P1rEqPH3m8LWDy2f3vA6rF/7hp2j/vdx5k8Ni+p97j97zGzx+Qbyxk9
        dt9sYPPo27KK0ePzJrkAnig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
        m5TUnMyy1CJ9uwS9jLaz91kLrghUXP9+l6WB8QNvFyMnh4SAicTnNYvZuxi5OIQEljJKzN16
        iAUiISNxcloDK4QtLPHnWhcbRNEnRonzCycxgSTYBAwlut5CJEQEOhklpnV/BBvFLPCJSeLI
        tdNsIFXCAkESa3vXMYLYLAKqEk+ONLOD2LwCdhIXd36DWiEvsXrDAWYQmxMofvp4K1hcSMBW
        4vmHNrYJjHwLGBlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbNtmM/t+xg7HoXfIhRgINR
        iYf3RcjrOCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYjQFOmois5Rocj4w
        pvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTDufPqN/YNwekJH
        v/a9D02M4ZNydLbNmXxMW1v02vUI8dJpXxwFbXllmTtct34/v3/vmfPXb8uVaa/zuuZueWnK
        yfmfvlbzsM65yrf0Kq/EHFnTH/f3HlTl+LWx+0rcf81bf601VTM3V03p2HZ5RdUDoYe2FTL3
        siftNfj/+Kj+y3URXy/e4+ksVGIpzkg01GIuKk4EAEZmncmxAgAA
X-CMS-MailID: 20200618154036eucas1p2f4ba8a422fcf2843627d639cd193c90f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200618154036eucas1p2f4ba8a422fcf2843627d639cd193c90f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154036eucas1p2f4ba8a422fcf2843627d639cd193c90f
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
        <CGME20200618154036eucas1p2f4ba8a422fcf2843627d639cd193c90f@eucas1p2.samsung.com>
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
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7939c55daceb..9d6867749316 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -518,7 +518,7 @@ fastrpc_map_dma_buf(struct dma_buf_attachment *attachment,
 
 	table = &a->sgt;
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents, dir))
+	if (!dma_map_sgtable(attachment->dev, table, dir, 0))
 		return ERR_PTR(-ENOMEM);
 
 	return table;
@@ -528,7 +528,7 @@ static void fastrpc_unmap_dma_buf(struct dma_buf_attachment *attach,
 				  struct sg_table *table,
 				  enum dma_data_direction dir)
 {
-	dma_unmap_sg(attach->dev, table->sgl, table->nents, dir);
+	dma_unmap_sgtable(attach->dev, table, dir, 0);
 }
 
 static void fastrpc_release(struct dma_buf *dmabuf)
-- 
2.17.1

