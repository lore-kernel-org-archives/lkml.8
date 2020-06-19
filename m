Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351BFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4C9208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pN2LIMKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbgFSKiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:38:17 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51229 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732400AbgFSKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:37:02 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200619103700euoutp02809b84c71c43ee7111aa7f562cdf2d81~Z66Ek9yB52242422424euoutp02P
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:37:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200619103700euoutp02809b84c71c43ee7111aa7f562cdf2d81~Z66Ek9yB52242422424euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592563020;
        bh=3Uytyvwzt4UX7mjIW5nSX3tNMM/3bhp/av3KF6qTx7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pN2LIMKgQ2C9Mr1LCcp1YtdQpWBpE2ZRylR1TTz98Ft4oFsyWbEYlH3I5pInSZyaB
         WiwgCTUKZFGx++brsBebUlHkj5o3nU6sUag53JJkB1RefikE1jUdTX4oXDiWvvFUhC
         cGZ14lfqahzylgzlOSA3ffJOc3y795UzEsDCTkUU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200619103700eucas1p1d0eaf478d3169376d5c1ae4142fe0012~Z66EMseGC0706007060eucas1p1n;
        Fri, 19 Jun 2020 10:37:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id ED.8C.06318.C459CEE5; Fri, 19
        Jun 2020 11:37:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200619103659eucas1p15d57f701ea85df16e953bfd5098423f6~Z66D1x1_M0550605506eucas1p1n;
        Fri, 19 Jun 2020 10:36:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200619103659eusmtrp1cc184c2cf49a2fe9b3ebee1f26d43797~Z66D1GWMR0949709497eusmtrp1F;
        Fri, 19 Jun 2020 10:36:59 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-5a-5eec954c959f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.0B.06017.B459CEE5; Fri, 19
        Jun 2020 11:36:59 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200619103659eusmtip2ee4aded76d4a08a25256a4a1d9badba6~Z66DN1fjk0247402474eusmtip2Z;
        Fri, 19 Jun 2020 10:36:59 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Qiang Yu <yuq825@gmail.com>,
        lima@lists.freedesktop.org
Subject: [PATCH v7 10/36] drm: lima: fix common struct sg_table related
 issues
Date:   Fri, 19 Jun 2020 12:36:10 +0200
Message-Id: <20200619103636.11974-11-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7o+U9/EGeybwGrRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlks2G9t8XneJjaLL1ceMllsenyN1eLyrjlsFmuP3GW3OPjhCavF
        h7VfmRx4PdbMW8PosffbAhaPnbPusnts//aA1eN+93Emj81L6j1u/3vM7DH5xnJGj903G9g8
        +rasYvT4vEkugDuKyyYlNSezLLVI3y6BK+PA8/+MBfekKt4fCmlgnCfWxcjJISFgIvHx02Xm
        LkYuDiGBFYwSp5qvMUI4XxglTnc3skM4nxklrr7ayArTcvXwajaIxHJGie6ONia4lnuT/jOD
        VLEJGEp0ve1iA7FFBFoZJU708oAUMQtcZpKYf7SJBSQhLBAg8anpGSOIzSKgKrHw5D+wFbwC
        dhL75l5kg1gnL7F6wwGwoZxA8dctB6HOOMYu0fg8FMJ2kTjX+5URwhaWeHV8CzuELSNxenIP
        C8hiCYFmRomH59ayQzg9jBKXm2ZAdVhL3Dn3C2gbB9B5mhLrd+lDhB0lPt09DxaWEOCTuPFW
        ECTMDGRO2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xihrA9JPp/zQZ7RUhgIqPEvhcBExjlZyHs
        WsDIuIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwMZ3+d/zrDsZ9f5IOMQpwMCrx8L4I
        eR0nxJpYVlyZe4hRgoNZSYTX6ezpOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJpCeW
        pGanphakFsFkmTg4pRoYu9Z5uW8xvzzp/NFmxglWKfmzww8lFTZ5xLEVcBVc3u96gZ9faqlT
        w4IFs/pvxlxKDXDYeIFp3WIhS93SpEXJpccXLE0IVLm9YuvHmc2P67gC/FWlVFYc0vAXnn1i
        s9WVdOH/Ue4On08syL/8eOqnwyFZUy0DqoO+Lnhkn/Db9GXhP6/C7Td4lViKMxINtZiLihMB
        KRwfp0gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7reU9/EGSw4omfRe+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMlks2G9t8XneJjaLL1ceMllsenyN1eLyrjlsFmuP3GW3OPjhCavF
        h7VfmRx4PdbMW8PosffbAhaPnbPusnts//aA1eN+93Emj81L6j1u/3vM7DH5xnJGj903G9g8
        +rasYvT4vEkugDtKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
        LLVI3y5BL+PA8/+MBfekKt4fCmlgnCfWxcjJISFgInH18Gq2LkYuDiGBpYwSJ49sYodIyEic
        nNbACmELS/y51gVV9IlRoufPPxaQBJuAoUTXW4iEiEAno8S07o/sIA6zwG0miTNzJzB3MXJw
        CAv4ScztNgBpYBFQlVh48h/YVF4BO4l9cy+yQWyQl1i94QAziM0JFH/dchCsRkjAVmL5gvfM
        Exj5FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMlG3Hfm7Zwdj1LvgQowAHoxIP74uQ
        13FCrIllxZW5hxglOJiVRHidzp6OE+JNSaysSi3Kjy8qzUktPsRoCnTURGYp0eR8YBTnlcQb
        mhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgnL6TPWxPnGP8ss+ROVOe
        J5mV7Pnc/HpFjE9lAPehy+eXT3Pad9Rae9YxkRZj7kXMCysOs9/lP2+ZGvxTwGqxlqfrAsn7
        7zbOap78a+a+xbxKa6OPT/pQlBg9N6op4XDzVNlZSRsDw9P0WJWU/j7VtFj11azewejaGRsx
        qbPap1OLUj/+DmviU2Ipzkg01GIuKk4EAI22K9KqAgAA
X-CMS-MailID: 20200619103659eucas1p15d57f701ea85df16e953bfd5098423f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200619103659eucas1p15d57f701ea85df16e953bfd5098423f6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103659eucas1p15d57f701ea85df16e953bfd5098423f6
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
        <CGME20200619103659eucas1p15d57f701ea85df16e953bfd5098423f6@eucas1p1.samsung.com>
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
Reviewed-by: Qiang Yu <yuq825@gmail.com>
---
 drivers/gpu/drm/lima/lima_gem.c | 11 ++++++++---
 drivers/gpu/drm/lima/lima_vm.c  |  5 ++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 155f2b4b4030..11223fe348df 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -69,8 +69,7 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
 		return ret;
 
 	if (bo->base.sgt) {
-		dma_unmap_sg(dev, bo->base.sgt->sgl,
-			     bo->base.sgt->nents, DMA_BIDIRECTIONAL);
+		dma_unmap_sgtable(dev, bo->base.sgt, DMA_BIDIRECTIONAL, 0);
 		sg_free_table(bo->base.sgt);
 	} else {
 		bo->base.sgt = kmalloc(sizeof(*bo->base.sgt), GFP_KERNEL);
@@ -80,7 +79,13 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
 		}
 	}
 
-	dma_map_sg(dev, sgt.sgl, sgt.nents, DMA_BIDIRECTIONAL);
+	ret = dma_map_sgtable(dev, &sgt, DMA_BIDIRECTIONAL, 0);
+	if (ret) {
+		sg_free_table(&sgt);
+		kfree(bo->base.sgt);
+		bo->base.sgt = NULL;
+		return ret;
+	}
 
 	*bo->base.sgt = sgt;
 
diff --git a/drivers/gpu/drm/lima/lima_vm.c b/drivers/gpu/drm/lima/lima_vm.c
index 5b92fb82674a..2b2739adc7f5 100644
--- a/drivers/gpu/drm/lima/lima_vm.c
+++ b/drivers/gpu/drm/lima/lima_vm.c
@@ -124,7 +124,7 @@ int lima_vm_bo_add(struct lima_vm *vm, struct lima_bo *bo, bool create)
 	if (err)
 		goto err_out1;
 
-	for_each_sg_dma_page(bo->base.sgt->sgl, &sg_iter, bo->base.sgt->nents, 0) {
+	for_each_sgtable_dma_page(bo->base.sgt, &sg_iter, 0) {
 		err = lima_vm_map_page(vm, sg_page_iter_dma_address(&sg_iter),
 				       bo_va->node.start + offset);
 		if (err)
@@ -298,8 +298,7 @@ int lima_vm_map_bo(struct lima_vm *vm, struct lima_bo *bo, int pageoff)
 	mutex_lock(&vm->lock);
 
 	base = bo_va->node.start + (pageoff << PAGE_SHIFT);
-	for_each_sg_dma_page(bo->base.sgt->sgl, &sg_iter,
-			     bo->base.sgt->nents, pageoff) {
+	for_each_sgtable_dma_page(bo->base.sgt, &sg_iter, pageoff) {
 		err = lima_vm_map_page(vm, sg_page_iter_dma_address(&sg_iter),
 				       base + offset);
 		if (err)
-- 
2.17.1

