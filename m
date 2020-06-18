Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5453C433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AC5206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OmQTYrvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgFRPkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:40:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54586 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbgFRPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:40:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200618154018euoutp011482183a0f83b26f0427a50a630ca367~ZrZmHgjpq1845018450euoutp01r
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:40:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200618154018euoutp011482183a0f83b26f0427a50a630ca367~ZrZmHgjpq1845018450euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592494818;
        bh=xw3K0/aFzn0fQ2snK5+3dg6k1O9SvppyMhipy/j8VoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OmQTYrvRVEswxSooRXkHVFhnIg8QIHlZj11hL4/gve3M9Is6r2xOu0m0H4E2jONdY
         LTWEbE3eSw4valGrrINwU0bRgUymLZZAZ3uO/m6MRBF4xd+2/9sYLht90PDjXH3oLm
         GrOWgWhQvdznqQ1n1Y+tAboO4VRYnLJMB66ZY8rU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200618154017eucas1p2d0dee3fb39ced9e7e6331cb55d1c6dc4~ZrZl3x_4M2977729777eucas1p28;
        Thu, 18 Jun 2020 15:40:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0E.0F.61286.1EA8BEE5; Thu, 18
        Jun 2020 16:40:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200618154017eucas1p25f266fbeb2273d9ed01b5196d698ad48~ZrZlXrvqK0501005010eucas1p2U;
        Thu, 18 Jun 2020 15:40:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200618154017eusmtrp2ec7be9572e641136a73192cbea718618~ZrZlXF-FH0399203992eusmtrp2S;
        Thu, 18 Jun 2020 15:40:17 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-bc-5eeb8ae1d246
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D2.EE.08375.1EA8BEE5; Thu, 18
        Jun 2020 16:40:17 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200618154016eusmtip187a63c1b6f07d44000b73a84c8b6b462~ZrZky0MRI0765807658eusmtip1Y;
        Thu, 18 Jun 2020 15:40:16 +0000 (GMT)
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
Subject: [PATCH v6 05/36] drm: armada: fix common struct sg_table related
 issues
Date:   Thu, 18 Jun 2020 17:39:26 +0200
Message-Id: <20200618153956.29558-6-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618153956.29558-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTUQDm3Lu7XXWL62Z5UkkaVCTlgwxuaKJRcIkgsx9SkTr1opabsqll
        f1yaZvOBTioT8ZGCpTNrmqnNfGROsWZOUUOtlpbU8v1KC23Xq/XvO9/jfB+Hg6NCLeaAR8ni
        aLlMEi3mWnPqO1cNh00qc5D7HeNRMsvQjZDP8mswcqM+FyUHlma45OOqNwhZ0uJFLg6YEFI7
        PoiR/U2FXLL9bjMgqzvGeGTb7ATmy6c0RRpA9Q/2oVTzcgmHerH8GaM+ZegRqrY8iRpZH0ep
        vOEKQL38oORS2XWVgFrQ7vG3uWjtHU5HRyXQcjefEOvIFXUOL7bX/vrogyJUCXQiFbDCIeEJ
        17qMXBWwxoXEIwCH57oxRhASiwCmzIexwgKAHYPPuduJLI0JYYUKAE3qVZQ9WBL96maEcXEJ
        D6iaUm0m7IhUALuy+IwJJVoRmDZt3jSJiADYWDazaeIQ++CsLpPHYAFxHJYvTAG2zhlWPW1F
        GWxF+MAefSrGXASJVzw4dG+Bx5pOwjGldmufCP7Q123xTnCjsRhhAymWrYZqHnvItGxNzt+q
        8IKjhjVLGrfsOwhrmtxY2g/+utmPMDQkdsDhKVuGRi1QXX8fZWkBTE8Tsu79sED/5F9t23sj
        ymIKFg9PbD1wLoCqmgE0BzgX/C8rAaAS2NPxCmkErfCQ0ddcFRKpIl4W4RoWI9UCy0/qWdfP
        N4AlY2g7IHAg5gt8A81BQkySoEiUtgOIo2I7wYl3PUFCQbgk8QYtjwmWx0fTinbgiHPE9oIj
        D79fFhIRkjj6Kk3H0vJtFcGtHJQgxMlf7uhs7qstzD8QYnOspcxzMtxpVwsidpj8cuuMi3xn
        XtafQ9KWkUuh6T/zbX4Htiq/lZtVa5q5RFQ9fyXpbXp2o+3KBb+61qaMjq/q0r1DIv9gfw1p
        7Dnvfc403Xw6MjTOLiHgbMNKp42Er3mtu70oGnfvndxdeupjbLIuDhFzFJESDxdUrpD8BfW/
        n0dFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xu7oPu17HGSz4JmzRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlks2G9t8eXKQyaLTY+vsVpc3jWHzeLQ1L2MFmuP3GW3OPjhCasD
        j8eaeWsYPS5fu8jssffbAhaP7d8esHrc7z7O5LF5Sb3H7X+PmT0m31jO6LH7ZgObR9+WVYwe
        nzfJBXBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl
        6GV8nzSBveC8eMWdmfOYGxj3CHcxcnJICJhI9K55yNTFyMUhJLCUUWLJtf8sEAkZiZPTGlgh
        bGGJP9e62CCKPjFKzOnZxASSYBMwlOh6C5EQEehklJjW/ZEdxGEWOMYksfDXR7BRwgIBEqdW
        H2QGsVkEVCU+7OlhB7F5BWwllnx+ywixQl5i9YYDYDWcAnYSp4+3gq0WAqp5/qGNbQIj3wJG
        hlWMIqmlxbnpucWGesWJucWleel6yfm5mxiBMbLt2M/NOxgvbQw+xCjAwajEw/si5HWcEGti
        WXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xmgIdNZFZSjQ5Hxi/eSXxhqaG5haW
        hubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGDtlZrVsPrJfO6HD7F3xuce7Zj2f
        a6DZ0fTvqfhr+T+/59k7lB4/sy232vJMnMCcpO2ZGkUnJ9/clnRZS0z6m1HoUoN6H1cGjxXL
        Oi9xNHvUqSklvpLUd1i3eE5msf/ScE3NwN7/e9Q6DmW8EWR0n5N5U6fWtMvYP0Yn3Ipbyalw
        deN2gScLlFiKMxINtZiLihMBBm6796cCAAA=
X-CMS-MailID: 20200618154017eucas1p25f266fbeb2273d9ed01b5196d698ad48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200618154017eucas1p25f266fbeb2273d9ed01b5196d698ad48
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200618154017eucas1p25f266fbeb2273d9ed01b5196d698ad48
References: <20200618153956.29558-1-m.szyprowski@samsung.com>
        <CGME20200618154017eucas1p25f266fbeb2273d9ed01b5196d698ad48@eucas1p2.samsung.com>
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
 drivers/gpu/drm/armada/armada_gem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index 8005614d2e6b..bedd8937d8a1 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -395,7 +395,7 @@ armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
 
 		mapping = dobj->obj.filp->f_mapping;
 
-		for_each_sg(sgt->sgl, sg, count, i) {
+		for_each_sgtable_sg(sgt, sg, i) {
 			struct page *page;
 
 			page = shmem_read_mapping_page(mapping, i);
@@ -407,8 +407,8 @@ armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
 			sg_set_page(sg, page, PAGE_SIZE, 0);
 		}
 
-		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0) {
-			num = sgt->nents;
+		if (dma_map_sgtable(attach->dev, sgt, dir, 0)) {
+			num = count;
 			goto release;
 		}
 	} else if (dobj->page) {
@@ -418,7 +418,7 @@ armada_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
 
 		sg_set_page(sgt->sgl, dobj->page, dobj->obj.size, 0);
 
-		if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0)
+		if (dma_map_sgtable(attach->dev, sgt, dir, 0))
 			goto free_table;
 	} else if (dobj->linear) {
 		/* Single contiguous physical region - no struct page */
@@ -449,11 +449,11 @@ static void armada_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
 	int i;
 
 	if (!dobj->linear)
-		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
+		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 
 	if (dobj->obj.filp) {
 		struct scatterlist *sg;
-		for_each_sg(sgt->sgl, sg, sgt->nents, i)
+		for_each_sgtable_sg(sgt, sg, i)
 			put_page(sg_page(sg));
 	}
 
-- 
2.17.1

