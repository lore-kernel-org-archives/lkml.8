Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBB2C83006
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F10321744
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fzAeGV6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgD1NVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:21:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53163 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgD1NU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:20:29 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200428132028euoutp01b0d8c7e0d3f26f4c440ad13ce5300cab~J-l81hY-F2026420264euoutp01N
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:20:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200428132028euoutp01b0d8c7e0d3f26f4c440ad13ce5300cab~J-l81hY-F2026420264euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588080028;
        bh=aKlVh1Yd+e6H8/Pcigy35hvIVmgdGLEAjejUfzy0WpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzAeGV6lJTMygUOd1IFpVJSZ6HWWFzngW7HBGaXcc2VQooyjr5It6M5Cgdmso9VVC
         iKcn1Hxc37Xv2d61mH5nvcqh8XrYEB/GhVx9V+m8NhQQqyeH1ni2b2vkeVEa4mt+0e
         m9h+m7hbXU/PpRK4F3hZxe+muvCWiwbTmYbgPUNk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200428132028eucas1p1dee8e65442d128c6217e586827484277~J-l8hUjaz3055730557eucas1p1Y;
        Tue, 28 Apr 2020 13:20:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 95.C1.60679.C9D28AE5; Tue, 28
        Apr 2020 14:20:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200428132027eucas1p1a045e89a0058ccff3ea94d1da2236af7~J-l8BOAzr3057830578eucas1p1Q;
        Tue, 28 Apr 2020 13:20:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200428132027eusmtrp1b8816ccb4cde4d447caa4a031d06fa5b~J-l8AjGCn1743317433eusmtrp1z;
        Tue, 28 Apr 2020 13:20:27 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-9a-5ea82d9c9b9d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7E.96.08375.B9D28AE5; Tue, 28
        Apr 2020 14:20:27 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200428132026eusmtip2dabf1824e2aabc8f7023ced4cd9531a2~J-l7ZkcxN1116911169eusmtip2W;
        Tue, 28 Apr 2020 13:20:26 +0000 (GMT)
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
Subject: [RFC 09/17] drm: panfrost: fix sg_table nents vs. orig_nents misuse
Date:   Tue, 28 Apr 2020 15:19:57 +0200
Message-Id: <20200428132005.21424-10-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSaUhUURiGO3PnLjM6dhslDyYZAwoFbil0yRKTgvvDIvwVQdakN8d0RplR
        U6NyydJxHcUFc0M0x91cJnEpNcstzFKGEfc1Ms1IUxSXZrya/973/Z7ve+FwCETYjloQfrJg
        Ri4TB4gwPlfzafOLba6t2suhLAalkgZ6OVRJTRROvcmuQanozj6M2tOoEGr47wpGlVV85FCv
        Uus5VOF7F2pteJpD1c1qUWqoORejqrrGcarj9xxK9Y2v4m7H6cr8SkC3rRdy6TFtK0a/XZ9C
        6cmEbg5dX/yMHt2dReh0XSmgW0YiMTq5oRzQq3Wnbxrd5l/yYQL8Qhm5ves9viSzdx4EqU3C
        vi5s4JFgz0gJeAQkneHieBSiBHxCSKoBjNqe5LBmDcCMguQDswpgQtQA53ClcWsaZQelAC53
        rR+tjDb2cA0URjpC5bISM2gzMhbAniRjA4SQGgTOlXbhhoEp6QH/ZKbsay5pDRvzpvYXBKQr
        3JnRcdk6K1hR244YNE+fl8zMY4ZDkNTicGSyWm8IvbkKNTNyljeFi90NOKstYX96IpflYwCc
        HqjCWZMI4FB0NmApFzg2sLV/CCHPwppmeza+AjPylgB73wTqlk8YYkQv0zRZCBsLYNwLIUvb
        wJzu6v+1HYPfDhAaTrfeYN9HBeBEQR6aCqxyjroKASgH5kyIQurLKM7LmEd2CrFUESLztfMO
        lNYB/b/q3+1eawLN2/c7AUkAkbGg1ljtJUTFoYpwaSeABCIyE8xIXnsJBT7i8AhGHnhXHhLA
        KDrBKYIrMhc4Ff24IyR9xcGMP8MEMfLDKYfgWUSC0iVt/Zr1rV91J9MdzLKafFY9mmSh3+Mu
        VlekTBAC/89TEsyhqMKm0HRe/cHpulJs9GQnbbQFz47oi7d0K3Z/Hqudr35X7v3YXrrZ5q96
        +cM1RSpxc1dJHvQEXru88nBQu3FmOTYFOsc3e+b/tNV1eK7w+p2PrSyAIezC0zLvMBFXIRE7
        nkPkCvE/gk01dlMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7qzdVfEGUx7rGDRe+4kk8XS9Y3s
        FhtnrGe1aDp0is3i/7aJzBZXvr5ns1i5+iiTxewJm5ksFuy3tvhy5SGTxabH11gtLu+aw2ax
        9shddouDH56wWpy6+5ndgd9jzbw1jB57vy1g8bhzbQ+bx/ZvD1g97ncfZ/LYvKTe4/a/x8we
        k28sZ/TYfbOBzaNvyypGj8+b5AK4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOt
        jEyV9O1sUlJzMstSi/TtEvQypp18yliwgq/i4rPv7A2M/7m7GDk5JARMJLb+esjaxcjFISSw
        lFFi++v3TBAJGYmT0xpYIWxhiT/Xutggij4xSsx9v4sFJMEmYCjR9RYiISLQySgxrfsjO4jD
        LHCAWaL7/EmwUcICPhKfpvWzg9gsAqoSW+c+YAOxeQXsJP4+usECsUJeYvWGA8wgNidQfOmj
        p0A1HEDrbCUut+ROYORbwMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzB+th37uXkH46WN
        wYcYBTgYlXh4N/CsiBNiTSwrrsw9xCjBwawkwvsoY1mcEG9KYmVValF+fFFpTmrxIUZToJsm
        MkuJJucDYzuvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOjmO+h
        vMNHf57kjn+/XGGxnQpbEr+mvF31zfqj08TfLP+ka3fAz139+Kxl++dyXv3zIS/ngkNi6u/z
        E5UuM+gdPF+7eNaE7jPP5u6zOWw7izVLyl7nQZhcf+ANq5RTcm8iYrfJ+UsXapvrfXSbdldV
        sGs+0/NjKn56S9bKTZiyL+HCtiJxwcN3lViKMxINtZiLihMBY2oseLUCAAA=
X-CMS-MailID: 20200428132027eucas1p1a045e89a0058ccff3ea94d1da2236af7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200428132027eucas1p1a045e89a0058ccff3ea94d1da2236af7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132027eucas1p1a045e89a0058ccff3ea94d1da2236af7
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
        <CGME20200428132027eucas1p1a045e89a0058ccff3ea94d1da2236af7@eucas1p1.samsung.com>
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
 drivers/gpu/drm/panfrost/panfrost_gem.c | 3 ++-
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 17b654e..22fec7c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -42,7 +42,8 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
 		for (i = 0; i < n_sgt; i++) {
 			if (bo->sgts[i].sgl) {
 				dma_unmap_sg(pfdev->dev, bo->sgts[i].sgl,
-					     bo->sgts[i].nents, DMA_BIDIRECTIONAL);
+					     bo->sgts[i].orig_nents,
+					     DMA_BIDIRECTIONAL);
 				sg_free_table(&bo->sgts[i]);
 			}
 		}
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index ed28aeb..2d9b1f9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -517,7 +517,9 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
 	if (ret)
 		goto err_pages;
 
-	if (!dma_map_sg(pfdev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL)) {
+	sgt->nents = dma_map_sg(pfdev->dev, sgt->sgl, sgt->orig_nents,
+				DMA_BIDIRECTIONAL);
+	if (!sgt->nents) {
 		ret = -EINVAL;
 		goto err_map;
 	}
-- 
1.9.1

