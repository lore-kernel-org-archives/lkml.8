Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AE3C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1287A2074A
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uB9foU01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgIDOTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:19:42 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42601 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbgIDNn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:43:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200904133502euoutp0247fbe5873149dd993f8785ae60e833bd~xmAgFAg_k2949729497euoutp02C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200904133502euoutp0247fbe5873149dd993f8785ae60e833bd~xmAgFAg_k2949729497euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599226502;
        bh=8L76JluA1DA+XDINuFmhMyh7/pZztphzaFRThYOm+6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uB9foU016qk8FbvUweGBohpwZ67IKdgcnzAyamJyQDWR2zzz58/gsLqNMgrQa3bPw
         WXA3p1F1JfsK6W8YjzcHIx4VL4bHsf/bwkhroIjxjUhVLv2dMnXeC+qLvKe0kxAktM
         VDSBqW5o7etTQhPLw6k3Fkt8WULdZtZ4leRiUuYc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200904133502eucas1p196b49998aab3c682956fb60b3d67d430~xmAf1G6TK0115901159eucas1p1q;
        Fri,  4 Sep 2020 13:35:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EF.01.06456.682425F5; Fri,  4
        Sep 2020 14:35:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200904133502eucas1p136e346bfdcd361d9e0320923f653d843~xmAfZ3mri2307423074eucas1p1T;
        Fri,  4 Sep 2020 13:35:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200904133502eusmtrp2422309161fdf1068ef9cd28c5980cdc3~xmAfZCW100977009770eusmtrp2M;
        Fri,  4 Sep 2020 13:35:02 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-48-5f52428624a8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FF.AE.06314.682425F5; Fri,  4
        Sep 2020 14:35:02 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200904133501eusmtip1619a515147b9ee7852a476c127af4056~xmAe2m8ar2113121131eusmtip1t;
        Fri,  4 Sep 2020 13:35:01 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v10 14/30] drm: panfrost: fix common struct sg_table related
 issues
Date:   Fri,  4 Sep 2020 15:16:55 +0200
Message-Id: <20200904131711.12950-15-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfyyUcRzH+95zzw83T3sc8k0/rKuUWmTFnjCV9cez9UeNVGuLjnuGOcfu
        EKqh1hUiv1ayyqWLOnfoki40v39EHWF2JSujNjVpfi2t0T2e6L/X9/15fb6fz777Eoi4HnUm
        ohTxrFIhlUswkbC2Y8G8Rx0QGLrXUriNzja/FtBPi6pQeqk2D6EH56Yw+klFu4DWNPrSs4Oj
        Ato4NoTSA3V3MdrQNoLTSw0mnG7+OY7SOYZ+7BDJ6O/rAWMa0QLm1bxGyBh1GRjzYv4zynzK
        6hQwz7SpzPDiGMIUWMoBU/8+DWNyanSAmTFuPm57RuQnY+VRiazSw/+cKLKvtBeNewOTtLfM
        eBrocsgENgSk9sOMknKEYzH1GMCyNCoTiKw8C2DpRAXGH2YAbP2hQ1c6Cr5MCvlCOYBLw13Y
        akvhnY5lC6M8YeZkJsaxA3UVwK5sW05CqHEBtPwyWCWCsKeCYUajK+cIqe2wudUg4Jik/GFf
        XjHGT3OBFdVNy/vZWPPnReModw+kunHY9mBKyEtHoKZ7COfZHn7rrPnHG+HSyxIB33AFwFGz
        AecPNwAcuFwEeMsXfjT/xriNEMoNVtV58PFh2P6uUcjFkFoLLZN2XIxYMb/2NsLHJLyuFvO2
        KyzurFwd29zXj/DMwOo/s4B/oDwANa1deC5wKf4/TAOADjixCaqYCFblqWDPu6ukMaoERYR7
        eGyMEVi/VM9i57QJzPWHtQCKABJbcs3BwFAxKk1UJce0AEggEgcy4G1PiJiUSZNTWGVsqDJB
        zqpawAZCKHEi95VOnBVTEdJ4Nppl41jlSlVA2DingfR1yqzvascUWpSEX2rPze6+KHsE7k3r
        b5bJprN6vKrsgG+ItoBwUZxKOHDUGXr6fK3IbTgdt8P32qYTlR/qfYZsXNfnp0Yf260IMqvx
        nfiU94UAPyRkZouerFQshMtleuKhaaDpZLBXNWPcSvYaTWGOQbUTbnVyb3VejSFdIlRFSj13
        IUqV9C8azGD4TgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7ptTkHxBqc6OS16z51kstg4Yz2r
        xf9tE5ktrnx9z2axcvVRJosF+60tvlx5yGSx6fE1VovLu+awWaw9cpfd4v+eHewWBz88YbXo
        W3uJzYHXY828NYweO+4uYfTY+20Bi8emVZ1sHtu/PWD1uN99nMlj85J6j9v/HjN7TL6xnNFj
        980GNo++LasYPT5vkgvgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rez
        SUnNySxLLdK3S9DLuLDoPGvBGYmKJdPOsTcwnhDpYuTkkBAwkZj89C0LiC0ksJRR4vZlIYi4
        jMTJaQ2sELawxJ9rXWxdjFxANZ8YJWZ/3c8EkmATMJToeguREBHoZJSY1v2RHSTBLPCGSeLS
        1QgQW1ggWOJ4z1uwBhYBVYmDh9eC2bwCdhIXJs5ig9ggL7F6wwFmEJsTKL51xhNWiItsJT7M
        WcwygZFvASPDKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMCY2Xbs5+YdjJc2Bh9iFOBgVOLh
        ZbAPihdiTSwrrsw9xCjBwawkwut09nScEG9KYmVValF+fFFpTmrxIUZToKMmMkuJJucD4zmv
        JN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOj+x7W9iezA08x5Ezi
        XP/vTJ28hVAi32SBF2/i0iZ+FmayMfuWw3XZ8elPZy2J/yYKpRG79n8L6vc+dnNF6q39V94z
        cHEsVpq8c1Jsyo4H7/K5wwsOb1xzZ3P/nzuHyl7+vWaxMub27eSTQgvWme1bqnfcoedeS3SI
        9aMDdfnWdh3OUYn2tgvUlFiKMxINtZiLihMBUqF+Ua8CAAA=
X-CMS-MailID: 20200904133502eucas1p136e346bfdcd361d9e0320923f653d843
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200904133502eucas1p136e346bfdcd361d9e0320923f653d843
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133502eucas1p136e346bfdcd361d9e0320923f653d843
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
        <CGME20200904133502eucas1p136e346bfdcd361d9e0320923f653d843@eucas1p1.samsung.com>
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
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 4 ++--
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 33355dd302f1..1a6cea0e0bd7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -41,8 +41,8 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
 
 		for (i = 0; i < n_sgt; i++) {
 			if (bo->sgts[i].sgl) {
-				dma_unmap_sg(pfdev->dev, bo->sgts[i].sgl,
-					     bo->sgts[i].nents, DMA_BIDIRECTIONAL);
+				dma_unmap_sgtable(pfdev->dev, &bo->sgts[i],
+						  DMA_BIDIRECTIONAL, 0);
 				sg_free_table(&bo->sgts[i]);
 			}
 		}
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index e8f7b11352d2..776448c527ea 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -253,7 +253,7 @@ static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_mmu *mmu,
 	struct io_pgtable_ops *ops = mmu->pgtbl_ops;
 	u64 start_iova = iova;
 
-	for_each_sg(sgt->sgl, sgl, sgt->nents, count) {
+	for_each_sgtable_dma_sg(sgt, sgl, count) {
 		unsigned long paddr = sg_dma_address(sgl);
 		size_t len = sg_dma_len(sgl);
 
@@ -517,10 +517,9 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	if (ret)
 		goto err_pages;
 
-	if (!dma_map_sg(pfdev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL)) {
-		ret = -EINVAL;
+	ret = dma_map_sgtable(pfdev->dev, sgt, DMA_BIDIRECTIONAL, 0);
+	if (ret)
 		goto err_map;
-	}
 
 	mmu_map_sg(pfdev, bomapping->mmu, addr,
 		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
-- 
2.17.1

