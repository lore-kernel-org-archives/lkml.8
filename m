Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE473C4725F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9760120721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qjqCFs7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgEDMzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:55:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59248 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgEDMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:54:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200504125418euoutp02b5c21bb02ac07488d463ddc327a99712~L1G0MOF9-1779417794euoutp02T
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:54:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200504125418euoutp02b5c21bb02ac07488d463ddc327a99712~L1G0MOF9-1779417794euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588596858;
        bh=MKuNM5F/aAqf4foAqWxZ/wfkeugl/f0VOXKL2W35qzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qjqCFs7A3fHIE6oTVa+vulccSqXAMee48C0gswuFbhMYFttmKEbG48XlR0wnh1p+5
         usOl3H7Ip+1NNjad1N0q0V9j6DYheITchMdkUuTHMs8g1Ihf4OYvNXY0UVeLdY0t2c
         wQ+6LgVRdN+zh8V4q4Az5aSmNRcsAoVMnUsE8h4U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200504125417eucas1p29975f37839a21bb71daff7da2708876c~L1GzpCSgB1833418334eucas1p2C;
        Mon,  4 May 2020 12:54:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1D.D2.60679.97010BE5; Mon,  4
        May 2020 13:54:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200504125417eucas1p1672a3ad3263e5f6b9162ecf7bef7af2b~L1GzW3G_L1097010970eucas1p1e;
        Mon,  4 May 2020 12:54:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200504125417eusmtrp2a738da8603417531cc6899ad38350e8f~L1GzWOUco2826928269eusmtrp2R;
        Mon,  4 May 2020 12:54:17 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-a7-5eb0107905aa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 39.69.08375.97010BE5; Mon,  4
        May 2020 13:54:17 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200504125416eusmtip2c18734bdecf75a1d1cd5f215d8a79491~L1GyqxnTi0350503505eusmtip2N;
        Mon,  4 May 2020 12:54:16 +0000 (GMT)
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
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH v2 11/21] drm: rockchip: fix sg_table nents vs. orig_nents
 misuse
Date:   Mon,  4 May 2020 14:53:49 +0200
Message-Id: <20200504125359.5678-11-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504125359.5678-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTYRTHe3Z3765ri9sUfTDJGGRpqE0lLplRkHA/iSC9oGTOvKjppmzT
        UrKWVsRSU/ugiZqJNHO+TplvlU7T2wpWvmZZmVmSiWVORWVqmzft2/+c8/uf/+HhwRFRO+qK
        x8tVtEIuTRRjfK6hb8XsnUY0RB42zh4ic8wmDtlYVI+SG4Z8hBxa/I2RT3S9HHLj6wxKlhZk
        kOWdgeTC0ASH1E+OoORgewlG1r74xCONc9/QE0KqpqwGUM+WyrlUy9IXlBq/y3Copsrr1Nj6
        JELdH9UCquO9GqPWiju5VG5zNaBaRsoQyqLfGyoI5x+LoRPjU2mF7/Eofpxap8eSl1yu1M0N
        8tRgxlEDHHBIBMC2hXlEA/i4iKgCsClPjbLFAoBvhrsAW1gAbMzVY1uWqs99PHagBTCbKUW2
        LY8rGcROYYQEamY1mw4n4haAL3MEdggh5jjQaMrchByJMDjWtrIJcYn9cHr5A2rXQiIIPrzR
        gLJx7lDX0GXjcdzB1n+Qc8C+BxKveLDLouWwzCmosyz+O88R/mSaeax2gxttDzmsIQvACXMt
        jy2yARzMLAIsFQg/mlcxewJCeML6dl+7hMRJqH7qzMpdcHR2tx1GbLLAUIiwbSG8c1vE7vCA
        xUzddqrx7QDCagqWTNzD2PfpAXCNeY7lAffi/1nlAFQDFzpFKYullX5y+rKPUipTpshjfS4m
        yfTA9qNerzMLraDdGt0NCByIBcJzlvpIESpNVabJugHEEbGTsPWmrSWMkaal04qkC4qURFrZ
        DfbgXLGL0L9i+ryIiJWq6ASaTqYVW1MO7uCqBoVMR3KOX5hG7Zw/FRue0COYV8mCZbzgZWvw
        jmjdNbrCxIRmXX13duVg9Y/yfSPN4gLfgHHd0YypiuE/4/2/4lWKmDMavtl/otca4S05MtbS
        pPI4HeIljGKG3Aqd0iVkZ4RpdXFVcImrd45otYaUeTrzDdpHQf0D35t3moFUzFXGSSVeiEIp
        /QtEZExuTQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7qVAhviDA5tlrToPXeSyWLjjPWs
        Fv+3TWS2uPL1PZvFytVHmSz+P3rNajF3Uq3Fgv3WFl+uPGSy2PT4GqvF5V1z2CzWHrnLbnHw
        wxNWB16PNfPWMHrs/baAxWP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObxd9Z+Fo++
        LasYPbZfm8fs8XmTXABPlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
        SmpOZllqkb5dgl5Gw+pNbAXfxCvWfbjM3sD4WriLkZNDQsBEYsW9Y+xdjFwcQgJLGSWO/7vO
        DpGQkTg5rYEVwhaW+HOtiw2i6BOjxNWr01hAEmwChhJdbyESIgKdjBLTuj+CjWIW+MEk8WjF
        REaQKmGBQInbva1gHSwCqhIvf9wCG8srYCsxv3ED1Ap5idUbDjB3MXJwcALFZ/aqg4SFBPIl
        7j79xzKBkW8BI8MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwJjZduzn5h2MlzYGH2IU4GBU
        4uGN+Lw+Tog1say4MvcQowQHs5II744WoBBvSmJlVWpRfnxRaU5q8SFGU6CbJjJLiSbnA+M5
        ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo9A9VtNVze+jOoNk
        b649dT824fm1G9f2iQtuTynh2Hb4iVRDVpKr/gROh4MXfeKS/VXClnC/FjtrkO+6I26vmqGL
        2+4PH3k1w8/V/OcI+XDZz7e54Peez1M1e9hepNm/eXjGi7Hz7bKjxXnzxIVnL7qmeM9Fv+fl
        px3ud4QOZa338mjyZFzqp8RSnJFoqMVcVJwIAGHOQO+vAgAA
X-CMS-MailID: 20200504125417eucas1p1672a3ad3263e5f6b9162ecf7bef7af2b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200504125417eucas1p1672a3ad3263e5f6b9162ecf7bef7af2b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200504125417eucas1p1672a3ad3263e5f6b9162ecf7bef7af2b
References: <20200504125017.5494-1-m.szyprowski@samsung.com>
        <20200504125359.5678-1-m.szyprowski@samsung.com>
        <CGME20200504125417eucas1p1672a3ad3263e5f6b9162ecf7bef7af2b@eucas1p1.samsung.com>
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
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 0d18846..a024c71 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -37,7 +37,7 @@ static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
 	rk_obj->dma_addr = rk_obj->mm.start;
 
 	ret = iommu_map_sg(private->domain, rk_obj->dma_addr, rk_obj->sgt->sgl,
-			   rk_obj->sgt->nents, prot);
+			   rk_obj->sgt->orig_nents, prot);
 	if (ret < rk_obj->base.size) {
 		DRM_ERROR("failed to map buffer: size=%zd request_size=%zd\n",
 			  ret, rk_obj->base.size);
@@ -98,11 +98,11 @@ static int rockchip_gem_get_pages(struct rockchip_gem_object *rk_obj)
 	 * TODO: Replace this by drm_clflush_sg() once it can be implemented
 	 * without relying on symbols that are not exported.
 	 */
-	for_each_sg(rk_obj->sgt->sgl, s, rk_obj->sgt->nents, i)
+	for_each_sg(rk_obj->sgt->sgl, s, rk_obj->sgt->orig_nents, i)
 		sg_dma_address(s) = sg_phys(s);
 
-	dma_sync_sg_for_device(drm->dev, rk_obj->sgt->sgl, rk_obj->sgt->nents,
-			       DMA_TO_DEVICE);
+	dma_sync_sg_for_device(drm->dev, rk_obj->sgt->sgl,
+			       rk_obj->sgt->orig_nents, DMA_TO_DEVICE);
 
 	return 0;
 
@@ -351,7 +351,8 @@ void rockchip_gem_free_object(struct drm_gem_object *obj)
 			rockchip_gem_iommu_unmap(rk_obj);
 		} else {
 			dma_unmap_sg(drm->dev, rk_obj->sgt->sgl,
-				     rk_obj->sgt->nents, DMA_BIDIRECTIONAL);
+				     rk_obj->sgt->orig_nents,
+				     DMA_BIDIRECTIONAL);
 		}
 		drm_prime_gem_destroy(obj, rk_obj->sgt);
 	} else {
@@ -493,14 +494,14 @@ static unsigned long rockchip_sg_get_contiguous_size(struct sg_table *sgt,
 			struct sg_table *sg,
 			struct rockchip_gem_object *rk_obj)
 {
-	int count = dma_map_sg(drm->dev, sg->sgl, sg->nents,
+	int count = dma_map_sg(drm->dev, sg->sgl, sg->orig_nents,
 			       DMA_BIDIRECTIONAL);
 	if (!count)
 		return -EINVAL;
 
 	if (rockchip_sg_get_contiguous_size(sg, count) < attach->dmabuf->size) {
 		DRM_ERROR("failed to map sg_table to contiguous linear address.\n");
-		dma_unmap_sg(drm->dev, sg->sgl, sg->nents,
+		dma_unmap_sg(drm->dev, sg->sgl, sg->orig_nents,
 			     DMA_BIDIRECTIONAL);
 		return -EINVAL;
 	}
-- 
1.9.1

