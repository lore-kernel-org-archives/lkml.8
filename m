Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00FACA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F625207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bPJpgt8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbgEMNeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:34:44 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38237 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgEMNdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:33:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200513133317euoutp02174ef15223a527e99a4b7ce730393a67~OmcaoljO90034400344euoutp02Z
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:33:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200513133317euoutp02174ef15223a527e99a4b7ce730393a67~OmcaoljO90034400344euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589376797;
        bh=MxXtwPFeqegif4HlAx0ieDJD2dsgeJX9eJCBPth0NkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPJpgt8VuXkVNgjfyAPOKxkJUOGWc559Au+XESo6RfQLtqDQY8JOsgf+m2WZIWwYV
         VyPgJJsJFEIg4wSRliVqoQLg7mM/CtatyylMuXap1010xXlGBtKQ4v5n1BptEdBWAM
         osgilRuadHwJOzoi0xb1nRmw9wTREBJ4rksQm/p0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200513133316eucas1p14f8338b43b0ca57538811a5d90a84071~OmcaVfN4L2633026330eucas1p1V;
        Wed, 13 May 2020 13:33:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2F.D8.60698.C17FBBE5; Wed, 13
        May 2020 14:33:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200513133316eucas1p2ad01d27ea4388cb50424bcf112d710ef~OmcaFLccM0359403594eucas1p2m;
        Wed, 13 May 2020 13:33:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200513133316eusmtrp1137b1bc87b13093a87f9bf46333dbe6c~OmcaEjEe81050610506eusmtrp1V;
        Wed, 13 May 2020 13:33:16 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-ed-5ebbf71c62d2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 75.47.07950.C17FBBE5; Wed, 13
        May 2020 14:33:16 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200513133315eusmtip11bd7d51f6d64aee3d21ad3edfd6dd66a~OmcZYTFoT0693306933eusmtip1G;
        Wed, 13 May 2020 13:33:15 +0000 (GMT)
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
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Subject: [PATCH v5 27/38] xen: gntdev: fix common struct sg_table related
 issues
Date:   Wed, 13 May 2020 15:32:34 +0200
Message-Id: <20200513133245.6408-27-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+3bO2Y7i7DgNP8wUFxZG3iUPWFYgcgiMKCowMlcevM0pm5eM
        ILGM3LxUGoqI2YW8rukaGpr3a1iiOXXLiS4vmWRq3qWsHY/Wf7/3eb6H5+XlwxFBO2aHR0ri
        aalEJBZyzdGazo1eV/u1+hCPe4bDZGbvew5Zna/CyP68NJT8U/MIIbUr81yyrKKDQxY3+ZGF
        ei9yWWvkkOqJIYwcqCvkksr2UR7ZsjCJkWuaHM4pS6qyqBJQDavFKFW7Oo5RY4ouDvXm5R1q
        ZGsCoXJ0JYBqW9CiVL0+hUstTn1GqSxNOaBUmkGUWlI7nOMHmx8Po8WRibTU3T/UPCJbPsWL
        67e92VltxFJAubUcmOGQ8IGLZYMcOTDHBUQpgJv6up1hGcDswWaMHZYA1Dc2cXcjuVm/AWuU
        AKgwzgDG2I5U1QcyzCU8oXxOvh2wIdIA7M60YAIIoUDgE2U5xhjWxHmomPq4HUYJZ7ipM6AM
        84kTsONrJWDbHGFFVTPCsJlJnzU0oaw+xIOD88EsB8CC9Bc8lq3hbJdmh+1hT04GyhRD4i6A
        xl4ljx0yABxIzd9p8IOG3k3TqrhpPReoqnNn5dNw/el3wMiQsIS6OStGRkz4uCYPYWU+fHBf
        wL4+BAu6Xv+rben7hLBMwaKsdS57rDYA+z/UgofAseB/WTEA5cCWTpDFhNMybwmd5CYTxcgS
        JOFuN2Jj1MD0t3q2ulbegsZf11sBgQOhBX98uD5EgIkSZckxrQDiiNCGf1ZlkvhhouRbtDT2
        mjRBTMtawX4cFdryvZ9/uyogwkXxdDRNx9HSXZeDm9mlgINWrrj9eNrKZfWyh1E145874lIZ
        dkFBREmIV8mwBL190X5dOb53ci4p+5JYLTz68wudmhE17Ru6bzQgejpdb/HjnT+tD3w2aiE+
        aXBwskzUAkuOT1/fMfeyVc2ZCTS7cWzzQNB0qa57bdK5zGmroi8odCOgwderf1geskd5RYjK
        IkSeRxCpTPQXYGbUzFcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xu7oy33fHGZzrFLPoPXeSyWLjjPWs
        Fhent7JY/N82kdniytf3bBYrVx9lsliw39pizk0jiy9XHjJZbHp8jdXi8q45bBZrj9xltzj4
        4Qmrxfctk5kc+DzWzFvD6LH32wIWj+3fHrB63O8+zuSxeUm9x+1/j5k9Jt9Yzuhx+MMVFo/d
        NxvYPD4+vcXi0bdlFaPH+i1XWTw+b5IL4I3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQy+jvespecFG84tjGh6wNjKuEuxg5OSQETCSm9P1l7GLk
        4hASWMoo8e/sNCaIhIzEyWkNrBC2sMSfa11sEEWfGCXuX7sJlmATMJToeguREBHoZJSY1v2R
        HcRhFpjMLPFs9XWwUcICARJT9p9jBrFZBFQlft24wwJi8wrYShx9voYRYoW8xOoNB8BqOIHi
        r+7sB6sREsiX2Lt4H9sERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAiNp27GfW3Yw
        dr0LPsQowMGoxMNrcWt3nBBrYllxZe4hRgkOZiURXr/1QCHelMTKqtSi/Pii0pzU4kOMpkBH
        TWSWEk3OB0Z5Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxivl
        QdUBSx+8kvJblRct/6Hu3CSZ+Kn/Vvfd3HRj+o3tP47J7LvdPtm2uzhBe5HR6XiLXSWWeTdl
        +M/PtLE/yvXAZpW0vJzPLrO5bbZ3uZamT7Pf0vMtz5Gx9dc61VeambJ6S3KT+JI+Xlt86KGh
        7OJ0Di+N9W7ik3LbHqz6t29169qLykWKbkosxRmJhlrMRcWJABDblfe6AgAA
X-CMS-MailID: 20200513133316eucas1p2ad01d27ea4388cb50424bcf112d710ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200513133316eucas1p2ad01d27ea4388cb50424bcf112d710ef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133316eucas1p2ad01d27ea4388cb50424bcf112d710ef
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
        <20200513133245.6408-1-m.szyprowski@samsung.com>
        <CGME20200513133316eucas1p2ad01d27ea4388cb50424bcf112d710ef@eucas1p2.samsung.com>
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
 drivers/xen/gntdev-dmabuf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index 75d3bb9..ba6cad8 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -247,10 +247,9 @@ static void dmabuf_exp_ops_detach(struct dma_buf *dma_buf,
 
 		if (sgt) {
 			if (gntdev_dmabuf_attach->dir != DMA_NONE)
-				dma_unmap_sg_attrs(attach->dev, sgt->sgl,
-						   sgt->nents,
-						   gntdev_dmabuf_attach->dir,
-						   DMA_ATTR_SKIP_CPU_SYNC);
+				dma_unmap_sgtable(attach->dev, sgt,
+						  gntdev_dmabuf_attach->dir,
+						  DMA_ATTR_SKIP_CPU_SYNC);
 			sg_free_table(sgt);
 		}
 
@@ -288,8 +287,8 @@ static void dmabuf_exp_ops_detach(struct dma_buf *dma_buf,
 	sgt = dmabuf_pages_to_sgt(gntdev_dmabuf->pages,
 				  gntdev_dmabuf->nr_pages);
 	if (!IS_ERR(sgt)) {
-		if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
-				      DMA_ATTR_SKIP_CPU_SYNC)) {
+		if (dma_map_sgtable(attach->dev, sgt, dir,
+				    DMA_ATTR_SKIP_CPU_SYNC)) {
 			sg_free_table(sgt);
 			kfree(sgt);
 			sgt = ERR_PTR(-ENOMEM);
@@ -625,7 +624,7 @@ static struct gntdev_dmabuf *dmabuf_imp_alloc_storage(int count)
 
 	/* Now convert sgt to array of pages and check for page validity. */
 	i = 0;
-	for_each_sg_page(sgt->sgl, &sg_iter, sgt->nents, 0) {
+	for_each_sgtable_page(sgt, &sg_iter, 0) {
 		struct page *page = sg_page_iter_page(&sg_iter);
 		/*
 		 * Check if page is valid: this can happen if we are given
-- 
1.9.1

