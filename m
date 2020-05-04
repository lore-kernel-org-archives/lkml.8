Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900A6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B9B206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XV44t1ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgEDMzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:55:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56246 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgEDMyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:54:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200504125412euoutp019fec4ce86de2532e0428ab8f7014ba4b~L1Guvd5Fy2848128481euoutp01w
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:54:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200504125412euoutp019fec4ce86de2532e0428ab8f7014ba4b~L1Guvd5Fy2848128481euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588596852;
        bh=7HGSt2R/zExJEcnP64x1LN4W0tfsgffJO1RfzuEm2Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XV44t1ax8fNg17FmsDQHxrILVSza7FD4D2qV2sTA/OitmKm5Xav8gniAnZAZB6IHQ
         NNczJjwlLgKVTdJH6DznM3/War1IxN+MB4vzRKYbXS4wCNu7ZAPdqqfbeD9UsugBiQ
         DzOPWJQrVJdmPMR7HKuq1HVqLCIlsOlYFh19b1/M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200504125411eucas1p187c163f9e8fd81407167766963dbbde4~L1GuN24ZS1058810588eucas1p1c;
        Mon,  4 May 2020 12:54:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 22.12.60698.37010BE5; Mon,  4
        May 2020 13:54:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200504125411eucas1p1d516115c221176c0903d77336b563c26~L1Gts1o7x1172711727eucas1p1R;
        Mon,  4 May 2020 12:54:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200504125411eusmtrp280a77196c4cf0378539a7fe7a12ba0f5~L1GtsFZUI2826928269eusmtrp2E;
        Mon,  4 May 2020 12:54:11 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-40-5eb010739798
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 34.69.08375.37010BE5; Mon,  4
        May 2020 13:54:11 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200504125410eusmtip29d451bb482b7eb7481d4ed9f45c35f45~L1GtBHIfN0350503505eusmtip2L;
        Mon,  4 May 2020 12:54:10 +0000 (GMT)
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
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v2 03/21] drm: armada: fix sg_table nents vs. orig_nents
 misuse
Date:   Mon,  4 May 2020 14:53:41 +0200
Message-Id: <20200504125359.5678-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125359.5678-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djP87rFAhviDM78MrHoPXeSyWLjjPWs
        Fv+3TWS2uPL1PZvFytVHmSwW7Le2+HLlIZPFpsfXWC0u75rDZnFo6l5Gi7VH7rJbHPzwhNWB
        x2PNvDWMHpevXWT22PttAYvH9m8PWD3udx9n8ti8pN7j9r/HzB6Tbyxn9Nh9s4HNo2/LKkaP
        z5vkArijuGxSUnMyy1KL9O0SuDLed01lKbglWLGhp4e1gfEcXxcjJ4eEgInE0gmv2UFsIYEV
        jBLHP2l1MXIB2V8YJWau/s4O4XxmlLj5ehcTTMf6h+tYIRLLGSWut+1hgmtZunkWM0gVm4Ch
        RNfbLjYQW0SglVHiRC8PSBGzwAEmibZ3r8FGCQsESlxtagQrYhFQlbgzdSLYIbwCNhKbvp9g
        hVgnL7F6wwGgoRwcnAK2EjN71UHmSAgcYpfY/uov1EkuEtP2bmCGsIUlXh3fwg5hy0j83zmf
        CaKhmVHi4bm17BBOD6PE5aYZjBBV1hJ3zv1iA9nALKApsX6XPkTYUeL3vmesIGEJAT6JG28F
        QcLMQOakbdOZIcK8Eh1tQhDVahKzjq+DW3vwwiWoEg+J6dvcIOFzGOiC998YJzDKz0LYtYCR
        cRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgOjr97/jXHYz7/iQdYhTgYFTi4Y34vD5O
        iDWxrLgy9xCjBAezkgjvjhagEG9KYmVValF+fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NT
        C1KLYLJMHJxSDYzpHm32pxJ2Xm/Y/3DWyt6JXxiDDQ6XaRhn5qr8vb34mv5uM8YE7Xdt7zqm
        pTtf/lX9rTpnxpnbk+vO8Eb84pgVyNwUeTTy+vsFwbdXnDzNb/lj2vvKzi9czrcfnj9anuYY
        oiCenCO8+lC2L9v/uf6Oj1l/3lOb+3/LwpyCT3aq9hHaVbE//GcosRRnJBpqMRcVJwIA8H0c
        GEMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xe7rFAhviDBqfiln0njvJZLFxxnpW
        i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBaXd81hszg0dS+jxdojd9ktDn54wurA
        47Fm3hpGj8vXLjJ77P22gMVj+7cHrB73u48zeWxeUu9x+99jZo/JN5Yzeuy+2cDm0bdlFaPH
        501yAdxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJ
        ehnvu6ayFNwSrNjQ08PawHiOr4uRk0NCwERi/cN1rF2MXBxCAksZJVZO2coOkZCRODmtgRXC
        Fpb4c62LDcQWEvjEKLFtOzOIzSZgKNH1FiTOxSEi0MkoMa37IzuIwyxwjEli4a+PLCBVwgL+
        Ev2t/8C6WQRUJe5MnQi2gVfARmLT9xNQG+QlVm84ADSVg4NTwFZiZq86xLJ8ibtP/7FMYORb
        wMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzA+th37uXkH46WNwYcYBTgYlXh4Iz6vjxNi
        TSwrrsw9xCjBwawkwrujBSjEm5JYWZValB9fVJqTWnyI0RToponMUqLJ+cDYzSuJNzQ1NLew
        NDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwNjwtWjqmlN9Dza7RPX92fDkxjPJ
        gm+R8sotSirvz7bx8kRVbdo56Z3/3yu2bzabGCuV79+8+FxPdOpbrT52ntVxb+tuR31ucuqZ
        t/uf8se7y6u0Y+UPCOVeTPGSvGW+8obpihnN3l5FP7K337mR/lEnKJz7yfLS/6/+zPjS8z6g
        +XjQBJvgOjklluKMREMt5qLiRACDSulppQIAAA==
X-CMS-MailID: 20200504125411eucas1p1d516115c221176c0903d77336b563c26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200504125411eucas1p1d516115c221176c0903d77336b563c26
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504125411eucas1p1d516115c221176c0903d77336b563c26
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
        <20200504125359.5678-1-m.szyprowski@samsung.com>
        <CGME20200504125411eucas1p1d516115c221176c0903d77336b563c26@eucas1p1.samsung.com>
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
 drivers/gpu/drm/armada/armada_gem.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index 976685f..749647f 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -407,8 +407,10 @@ int armada_gem_pwrite_ioctl(struct drm_device *dev, void *data,
 			sg_set_page(sg, page, PAGE_SIZE, 0);
 		}
 
-		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0) {
-			num = sgt->nents;
+		sgt->nents = dma_map_sg(attach->dev, sgt->sgl, sgt->orig_nents,
+					dir);
+		if (sgt->nents == 0) {
+			num = sgt->orig_nents;
 			goto release;
 		}
 	} else if (dobj->page) {
@@ -418,7 +420,9 @@ int armada_gem_pwrite_ioctl(struct drm_device *dev, void *data,
 
 		sg_set_page(sgt->sgl, dobj->page, dobj->obj.size, 0);
 
-		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0)
+		sgt->nents = dma_map_sg(attach->dev, sgt->sgl, sgt->orig_nents,
+					dir);
+		if (sgt->nents == 0)
 			goto free_table;
 	} else if (dobj->linear) {
 		/* Single contiguous physical region - no struct page */
@@ -449,11 +453,11 @@ static void armada_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
 	int i;
 
 	if (!dobj->linear)
-		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
+		dma_unmap_sg(attach->dev, sgt->sgl, sgt->orig_nents, dir);
 
 	if (dobj->obj.filp) {
 		struct scatterlist *sg;
-		for_each_sg(sgt->sgl, sg, sgt->nents, i)
+		for_each_sg(sgt->sgl, sg, sgt->orig_nents, i)
 			put_page(sg_page(sg));
 	}
 
-- 
1.9.1

