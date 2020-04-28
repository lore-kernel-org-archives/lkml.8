Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFFEC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C20206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jTRemBu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgD1NVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:21:21 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59489 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgD1NU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:20:29 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200428132027euoutp0255de82526b84e542aa17c2d335b97aa8~J-l7ucaEM2985029850euoutp02X
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:20:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200428132027euoutp0255de82526b84e542aa17c2d335b97aa8~J-l7ucaEM2985029850euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588080027;
        bh=S123DYYqnTTc0mK1QGc+SsWbu6yYl+uUFjzgUYva8zE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTRemBu0LwKXrvVUkZTK+F7qrR2E5dq8wGIv9oE8956BWlgjn9xuN1/cvATqSVPV6
         PzXTDfxn1EePs9WuG60+MN7S6E9tBXP+z0iVqs5oAVixh6Y0HiiI467iIx4isIFE2s
         yy5uwRDzgEmekDqqy69kGCkfTEJh+DWRa9OoPAHk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200428132026eucas1p2f2f45bfb1303f110538b6b66f77c57b3~J-l7V_wFI2655426554eucas1p2R;
        Tue, 28 Apr 2020 13:20:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 73.26.60698.A9D28AE5; Tue, 28
        Apr 2020 14:20:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200428132026eucas1p27c64540e53f328d0bb7bf9dae2ccb98d~J-l63durv2653926539eucas1p2J;
        Tue, 28 Apr 2020 13:20:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200428132026eusmtrp2f4c5602e7f1c5ef72b67566b37079a60~J-l62gzCT2140321403eusmtrp2H;
        Tue, 28 Apr 2020 13:20:26 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-81-5ea82d9a64cf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AD.D3.07950.A9D28AE5; Tue, 28
        Apr 2020 14:20:26 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200428132025eusmtip2ab342adf9621cf32c585fd4975e1a181~J-l6Rqy4I1062310623eusmtip2n;
        Tue, 28 Apr 2020 13:20:25 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [RFC 07/17] drm: lima: fix sg_table nents vs. orig_nents misuse
Date:   Tue, 28 Apr 2020 15:19:55 +0200
Message-Id: <20200428132005.21424-8-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfyyUcRzH932ee5577jiejvhOLds1rV/IyB4jKW09W6s1+qPVwuEZys87
        p4iIaU0UactkUgvnDqfzq6TihkcyXchYlJ9/sIk4tzHRnUf67/X+ft/vz/uz774EKm7HHIio
        2ERGFiuNluBCXlPX6hfnYmdl0LER1o3K6/uEUOWau3zqdZEGozJ1PTi12VSAUoMrCzhVpe5E
        qGf59QhV9tGbMgxOIJR2agijBlpKcKqmY4xPtS9OY1TP2DLfz5quLq0G9HtjGY8eHWrF6Wbj
        OEb/fMAidP2rdPr7xhRKFw5XAvrdSAZOP2xQAXpZu++ixRWhTzgTHZXEyFx9Q4SRyp41JD7b
        4la9thHNAKWCHCAgIOkBK8c1SA4QEmJSCaCyZJXHCQOA2m9KjBPLJtH9C/0XqVht23ZVAtj4
        qBfsRKZZNd/swkk3mDOfg5vZlswGsDvP0mxCySYUTld2bJlsSBq26lVbzCOd4GKPeisgIk9A
        1Z8f23WOUF3XtsUC0heWT87g5kGQHOLDZi0XgOQZWLTWj3FsA+fYBj7He+Hm2+cIF8gCcKKv
        hs+JXAAHMosA5/KGo31rpkmEab9DUNPiakZInoKtoxYcWsHh+V1mM2rCx01PUe5YBO/fE3Mz
        DsBitnantV3fv70+DdX5jdvPWABgyZwByweOxf+7ygBQAXtGIY+JYOTuscxNF7k0Rq6IjXAJ
        i4vRAtPH+rzBrrwBH9ZDdYAkgMRSVGepDBJj0iR5cowOQAKV2IomIyuCxKJwaXIKI4sLlimi
        GbkO7CF4EnuR+8vZa2IyQprI3GCYeEb27xYhBA4ZwCrZGhsSXh3fPbO/93dAiFfvkdsGo/40
        r9RdKRt/oVv6Kg0NWBjxXMrtQjrZkxp/f/Tc+dS5tdqCQL1T8B2fsn6XQMw2bCLNwzn9kp9A
        k2JXuDSScHDsuHfIE0u22kKyLggV1KapjJm9nlFqtkpw4bIo/uxRRdb11NmEOi8HOwlPHil1
        O4zK5NK/Om+dzVQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7qzdFfEGfRNFbHoPXeSyWLp+kZ2
        i40z1rNaNB06xWbxf9tEZosrX9+zWaxcfZTJYvaEzUwWC/ZbW3y58pDJYtPja6wWl3fNYbNY
        e+Quu8XBD09YLU7d/czuwO+xZt4aRo+93xaweNy5tofNY/u3B6we97uPM3lsXlLvcfvfY2aP
        yTeWM3rsvtnA5tG3ZRWjx+dNcgHcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFW
        RqZK+nY2Kak5mWWpRfp2CXoZK079Yipo5a7YvGkrcwPjPM4uRk4OCQETiWU/D7B0MXJxCAks
        ZZTYdvg6K0RCRuLktAYoW1jiz7UuNoiiT4wSa298YQNJsAkYSnS9hUiICHQySkzr/sgO4jAL
        HGCW6D5/kgmkSljAQ2LPhVXsIDaLgKrEh1Orwbp5BWwlVv29xwyxQl5i9YYDYDangJ3E0kdP
        gWo4gNbZSlxuyZ3AyLeAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYPxsO/Zzyw7GrnfB
        hxgFOBiVeHg38KyIE2JNLCuuzD3EKMHBrCTC+yhjWZwQb0piZVVqUX58UWlOavEhRlOgmyYy
        S4km5wNjO68k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2N5uLan
        /L8psZZyXM/ljMzVr6h6lCX0xF//Z5UQf0R+kp7ulj2rPdd8mJtTUv+ALcg68nbXgaLo7Rui
        YgUtLNw+66xJ/n3tx76fYt5LD/Muf36Lx2ybwsG/Lu+vOc96WHY/SyL2hWjoM52+pzKeP/l+
        S8Z9m8Zx0TNZ68zaJU62v7+8CGu43KDEUpyRaKjFXFScCABYxucKtQIAAA==
X-CMS-MailID: 20200428132026eucas1p27c64540e53f328d0bb7bf9dae2ccb98d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200428132026eucas1p27c64540e53f328d0bb7bf9dae2ccb98d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132026eucas1p27c64540e53f328d0bb7bf9dae2ccb98d
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
        <CGME20200428132026eucas1p27c64540e53f328d0bb7bf9dae2ccb98d@eucas1p2.samsung.com>
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
 drivers/gpu/drm/lima/lima_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 5404e0d..3edd2ff 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -70,7 +70,7 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
 
 	if (bo->base.sgt) {
 		dma_unmap_sg(dev, bo->base.sgt->sgl,
-			     bo->base.sgt->nents, DMA_BIDIRECTIONAL);
+			     bo->base.sgt->orig_nents, DMA_BIDIRECTIONAL);
 		sg_free_table(bo->base.sgt);
 	} else {
 		bo->base.sgt = kmalloc(sizeof(*bo->base.sgt), GFP_KERNEL);
@@ -80,7 +80,7 @@ int lima_heap_alloc(struct lima_bo *bo, struct lima_vm *vm)
 		}
 	}
 
-	dma_map_sg(dev, sgt.sgl, sgt.nents, DMA_BIDIRECTIONAL);
+	sgt.nents = dma_map_sg(dev, sgt.sgl, sgt.orig_nents, DMA_BIDIRECTIONAL);
 
 	*bo->base.sgt = sgt;
 
-- 
1.9.1

