Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0214C4345C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B218206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m4D9YoDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgFRPk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:40:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54809 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731660AbgFRPkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:40:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200618154030euoutp01869b6fc68d943ade3bda0155c7758e0c~ZrZxvyaV31844818448euoutp01D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:40:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200618154030euoutp01869b6fc68d943ade3bda0155c7758e0c~ZrZxvyaV31844818448euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592494830;
        bh=sMb+Mv9Dts6uUUOaPB9xk7pdpjF26BUiX5CJmeVUofs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4D9YoDtavHq+3LzGxxaZhVpC0sSsQQZzfLVKx0H40E+hsAz32mC27bV//3smkpDP
         D4R+Ex4klaoyU5pxyBkyuorGWQbuf0+obQNKc0UvmUco5j3wfH9FxePuvxhTjmPKgt
         To26Z5c6l8oWo0e9cJM+PLp3YFH3FfU9PVGTHJEI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200618154030eucas1p1df9f9ba2d8f63e37ed6574baa6b41401~ZrZxezWVE0074000740eucas1p1D;
        Thu, 18 Jun 2020 15:40:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E7.1F.61286.EEA8BEE5; Thu, 18
        Jun 2020 16:40:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200618154029eucas1p274f275e89dc985634bbd309823ad0f0d~ZrZxHjXT80608706087eucas1p2Z;
        Thu, 18 Jun 2020 15:40:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200618154029eusmtrp1efb981a9bc98b975c3e96d2e9e3a2289~ZrZxGzYWS2169821698eusmtrp1k;
        Thu, 18 Jun 2020 15:40:29 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-dc-5eeb8aeec338
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2B.E9.07950.DEA8BEE5; Thu, 18
        Jun 2020 16:40:29 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154029eusmtip1cf112f2b00c4845d77120cb512973c04~ZrZwbXNA50864308643eusmtip1M;
        Thu, 18 Jun 2020 15:40:29 +0000 (GMT)
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
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>
Subject: [PATCH v6 23/36] drm: vmwgfx: fix common struct sg_table related
 issues
Date:   Thu, 18 Jun 2020 17:39:44 +0200
Message-Id: <20200618153956.29558-24-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djPc7rvul7HGVw7wm/Re+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVq8OXKM0eLyrjlsFmuP3GW3OPjhCavF
        6k5HB16PNfPWMHrs/baAxWP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObRt2UVo8fn
        TXIe7+a/ZQvgjuKySUnNySxLLdK3S+DK+Nb9lL2gT7xia8sv9gbGBcJdjJwcEgImEkf3z2ft
        YuTiEBJYwSix5uBnNgjnC6PEwqlXGSGcz4wSd3ufsMO0vHx+DqpqOaPElTfbWOFaOj4uZQSp
        YhMwlOh628UGYosItDJKnOjlASliFvjLJHHp8SRWkISwQJDE2nmHmUBsFgFViXU/5oE18ArY
        STxa9I4JYp28xOoNB5hBbE6g+OnjrWDbJAQOsUs8/dIFVeQisah9IpQtLPHq+BaoW2UkTk/u
        YYFoaGaUeHhuLTuE08MocblpBiNElbXEnXO/gFZzAN2nKbF+lz5E2FHiXt8mRpCwhACfxI23
        giBhZiBz0rbpzBBhXomONiGIajWJWcfXwa09eOESM4TtIbH48CWwRUICExklbl1LnMAoPwth
        1wJGxlWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBqen0v+OfdjB+vZR0iFGAg1GJh9ch
        /HWcEGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5Y
        kpqdmlqQWgSTZeLglGpgtPZoK9vKO/PDjoMTWT5fajvOLT75rPH6exHblf8e3cbteevg9L7y
        5ZeaCrKnl7ix//LT1ZsyX7lSTa3W/9zFui3a4f6y0SI6q58vc5u7zqpVlnl1gHZuc07B51su
        BvMUA52nXMy2Vl8dckMj7EnPHG3JZaJe842Cly9Kfl3WmJwnovRG/MIDJZbijERDLeai4kQA
        AgRoZ0kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7pvu17HGby5aWLRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVq8OXKM0eLyrjlsFmuP3GW3OPjhCavF
        6k5HB16PNfPWMHrs/baAxWP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObRt2UVo8fn
        TXIe7+a/ZQvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxL
        LdK3S9DL+Nb9lL2gT7xia8sv9gbGBcJdjJwcEgImEi+fn2PrYuTiEBJYyihxZH0jI0RCRuLk
        tAZWCFtY4s+1LqiiT4wSDzfPZANJsAkYSnS9hUiICHQySkzr/sgOkmAWaGaWOP+yFsQWFgiQ
        WH/iIFicRUBVYt2PeWDNvAJ2Eo8WvWOC2CAvsXrDAWYQmxMofvp4K9hmIQFbiecf2tgmMPIt
        YGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERgp24793LKDsetd8CFGAQ5GJR7eFyGv44RY
        E8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU6KiJzFKiyfnAKM4riTc0NTS3
        sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cC45fRs5a9lRQ57tS6s5W9+pSJs
        Zrd6qrnJpC9PXX5u62TJn/PHMY3/RaOg2mW9z3O/2iZnuasse+f15rqoygWHBW9emGydxMmd
        U8617YTFtCuf73U2vjzgc7u+4i+7d9HkstN/ReU1vCq3FF4TKdnz8bwX04qAeG1mzqB19lbR
        RyJfSK7zm2arxFKckWioxVxUnAgANn8hQqoCAAA=
X-CMS-MailID: 20200618154029eucas1p274f275e89dc985634bbd309823ad0f0d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200618154029eucas1p274f275e89dc985634bbd309823ad0f0d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154029eucas1p274f275e89dc985634bbd309823ad0f0d
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
        <CGME20200618154029eucas1p274f275e89dc985634bbd309823ad0f0d@eucas1p2.samsung.com>
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
Acked-by: Roland Scheidegger <sroland@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index bf0bc4697959..49ed6add6969 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -362,8 +362,7 @@ static void vmw_ttm_unmap_from_dma(struct vmw_ttm_tt *vmw_tt)
 {
 	struct device *dev = vmw_tt->dev_priv->dev->dev;
 
-	dma_unmap_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.nents,
-		DMA_BIDIRECTIONAL);
+	dma_unmap_sgtable(dev, vmw_tt->sgt, DMA_BIDIRECTIONAL, 0);
 	vmw_tt->sgt.nents = vmw_tt->sgt.orig_nents;
 }
 
@@ -383,16 +382,8 @@ static void vmw_ttm_unmap_from_dma(struct vmw_ttm_tt *vmw_tt)
 static int vmw_ttm_map_for_dma(struct vmw_ttm_tt *vmw_tt)
 {
 	struct device *dev = vmw_tt->dev_priv->dev->dev;
-	int ret;
-
-	ret = dma_map_sg(dev, vmw_tt->sgt.sgl, vmw_tt->sgt.orig_nents,
-			 DMA_BIDIRECTIONAL);
-	if (unlikely(ret == 0))
-		return -ENOMEM;
 
-	vmw_tt->sgt.nents = ret;
-
-	return 0;
+	return dma_map_sgtable(dev, vmw_tt->sgt, DMA_BIDIRECTIONAL, 0);
 }
 
 /**
@@ -449,10 +440,10 @@ static int vmw_ttm_map_dma(struct vmw_ttm_tt *vmw_tt)
 		if (unlikely(ret != 0))
 			goto out_sg_alloc_fail;
 
-		if (vsgt->num_pages > vmw_tt->sgt.nents) {
+		if (vsgt->num_pages > vmw_tt->sgt.orig_nents) {
 			uint64_t over_alloc =
 				sgl_size * (vsgt->num_pages -
-					    vmw_tt->sgt.nents);
+					    vmw_tt->sgt.orig_nents);
 
 			ttm_mem_global_free(glob, over_alloc);
 			vmw_tt->sg_alloc_size -= over_alloc;
-- 
2.17.1

