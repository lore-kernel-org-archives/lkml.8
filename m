Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C0EC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B383206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zn3nvp77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgD1NVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:21:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53152 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgD1NU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:20:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200428132027euoutp01d5b63935202d7234c105aaa71d320e32~J-l8J8QgU1812618126euoutp01a
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:20:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200428132027euoutp01d5b63935202d7234c105aaa71d320e32~J-l8J8QgU1812618126euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588080027;
        bh=iiDoNXd2I2uZJvMUZbMxL2Ptv0Z8LqeafqM11E0kBGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zn3nvp77UMInrMBDUjQz/JL5X6tluIfXV6cyyX7bA5zj5x25je7pyZYDRq4SEE1Dd
         EkqV3VdYwOAD4MvuxyOhVoDJiodxjjIk6sGEbA6Le5QuFetY3yaJ9hFj7n6g2/QD1m
         jF+e/aEwLthJ/tojjkps4GRyOnmQdsapGH9qKaLM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200428132027eucas1p2bf7351c216129d4c3844011054e35b5f~J-l73ukUC2653326533eucas1p2H;
        Tue, 28 Apr 2020 13:20:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 25.26.60698.B9D28AE5; Tue, 28
        Apr 2020 14:20:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200428132027eucas1p2fed88e94fecf1ef12b312ba80a78bc00~J-l7dZiru2650126501eucas1p2Y;
        Tue, 28 Apr 2020 13:20:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200428132027eusmtrp13880f99fd34b732752a5b54a4f362c78~J-l7ctbMv1743317433eusmtrp1y;
        Tue, 28 Apr 2020 13:20:27 +0000 (GMT)
X-AuditID: cbfec7f5-e577d9c00001ed1a-84-5ea82d9bfd7c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.96.08375.A9D28AE5; Tue, 28
        Apr 2020 14:20:26 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200428132026eusmtip2b28d73f748142c681ff6e519c2ace1cb~J-l61pT0f0625706257eusmtip2I;
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
Subject: [RFC 08/17] drm: msm: fix sg_table nents vs. orig_nents misuse
Date:   Tue, 28 Apr 2020 15:19:56 +0200
Message-Id: <20200428132005.21424-9-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428132005.21424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSaUwTYRD167a7S6GyVBLGepAU0aABNPXHJihBY8L6S6J/xERg1RWQQ9MC
        CsRYDhE5lCMRKB6VWLmlgKkCKkfAgk0qEYKoeECBUAnBpFQDAkpZ0H9v3rw3bzIZEpN2imRk
        dHwCp4xnY+W4WGh4Pf/Wt9y3KmzvnUGg8819AlrXkEbQjaUNIjq96w1O/zEUYvSgfRanq2t7
        BHR5QbOA1rYH0HODowK6yTIkogda7+J0ffdngu78MS6i33y2EUGuTN39OsS8/KkVMiNDL3Dm
        2c9vIuZrrlHAND+6xnxatmBM8XAlYto+qHHm1tMaxNiatoc4nxIfOMfFRidxSv/ACHFU+7CF
        uDTmdkWjNSE1SnPNQU4kUPvBtDgpzEFiUkpVIejptIj4Yg7BUoYO8YUNgf7JfWzdclP9bM1S
        iaCoZQr9s+QtlK2qcGof5Mzk4A7sTl1H0Jvv4hBhlAGD8cpuwtHYRAXD2O3qVZGQ8oa6lt/I
        gSXUQejIXCb4OE+o1XesDnWiAkE3NoHz/BAB1veePD4CC7ZpxONN8N34dM27FUzFeaurApWB
        YNRcT/BFHoKB9NI1RwCMmBdWppIr6/lAQ6s/Tx+CyQd2gYMGaiMMz7g5aGwFFhlKMJ6WQHaW
        lFfvBI3xyb/Yzv53a9diYLLhBsEfqBDBwscyVIA8Nf/DtAjVIA8uURUXyakU8dxlPxUbp0qM
        j/Q7ezGuCa08lmnZaH+OXi2e6UIUieQuEr1LVZhUxCapkuO6EJCY3F0yFvU4TCo5xyancMqL
        4crEWE7VhbaQQrmHRFFhPS2lItkELobjLnHK9a6AdJKpkdwvQt/i3m/356jG426awMN22bxR
        b7Wnqm197aHVtEwjPUb6bB5XFLd6heR6lVZc2Bk+kcpOx2Rh2o9BOr9y7+AN80mKWe8vImvf
        DrRNe68kxbkNBhOuZp7sFacshdYMndg4+rDkuZfFPLt4vrpj6mhwdKFC1rtHnr3rlwsrF6qi
        2H27MaWK/QsHrceJVAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7qzdFfEGdxotLToPXeSyWLp+kZ2
        i40z1rNaNB06xWbxf9tEZosrX9+zWaxcfZTJYvaEzUwWC/ZbW3y58pDJYtPja6wWl3fNYbNY
        e+Quu8XBD09YLU7d/czuwO+xZt4aRo+93xaweNy5tofNY/u3B6we97uPM3lsXlLvcfvfY2aP
        yTeWM3rsvtnA5tG3ZRWjx+dNcgHcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFW
        RqZK+nY2Kak5mWWpRfp2CXoZ+288Zi94JFgxa8FpxgbGRv4uRk4OCQETic6G7SxdjFwcQgJL
        GSUOr5vNDJGQkTg5rYEVwhaW+HOtiw2i6BOjxIrO8ywgCTYBQ4mutxAJEYFORolp3R/ZQRxm
        gQPMEt3nTzKBVAkLuEs86l/JBmKzCKhKrNn5mxHE5hWwlTjQ8o8dYoW8xOoNB8BWcwrYSSx9
        9BSongNona3E5ZbcCYx8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTGz7ZjPzfvYLy0
        MfgQowAHoxIP7waeFXFCrIllxZW5hxglOJiVRHgfZSyLE+JNSaysSi3Kjy8qzUktPsRoCnTT
        RGYp0eR8YGznlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpglI+3
        Zz7etdi54PMp+41hRf+euGt4z9ZJzfj2jNeGv9JUyCtltsNGgaWdQut93358Pf2hHgf/4SAh
        z5Cfz/jVXZ6zJFhrslzhdClcvGVON1thRanohyt2Iv/8omv/TQsSOZIorCM3OVNXvFWXMe23
        88e27xV3T2Rc3hrNtCbhZNFq/qKLAb1KLMUZiYZazEXFiQDsidxMtQIAAA==
X-CMS-MailID: 20200428132027eucas1p2fed88e94fecf1ef12b312ba80a78bc00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200428132027eucas1p2fed88e94fecf1ef12b312ba80a78bc00
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200428132027eucas1p2fed88e94fecf1ef12b312ba80a78bc00
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
        <CGME20200428132027eucas1p2fed88e94fecf1ef12b312ba80a78bc00@eucas1p2.samsung.com>
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
 drivers/gpu/drm/msm/msm_gem.c   | 8 ++++----
 drivers/gpu/drm/msm/msm_iommu.c | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 5a6a79f..54c3bbb 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -54,10 +54,10 @@ static void sync_for_device(struct msm_gem_object *msm_obj)
 
 	if (get_dma_ops(dev) && IS_ENABLED(CONFIG_ARM64)) {
 		dma_sync_sg_for_device(dev, msm_obj->sgt->sgl,
-			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+			msm_obj->sgt->orig_nents, DMA_BIDIRECTIONAL);
 	} else {
 		dma_map_sg(dev, msm_obj->sgt->sgl,
-			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+			msm_obj->sgt->orig_nents, DMA_BIDIRECTIONAL);
 	}
 }
 
@@ -67,10 +67,10 @@ static void sync_for_cpu(struct msm_gem_object *msm_obj)
 
 	if (get_dma_ops(dev) && IS_ENABLED(CONFIG_ARM64)) {
 		dma_sync_sg_for_cpu(dev, msm_obj->sgt->sgl,
-			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+			msm_obj->sgt->orig_nents, DMA_BIDIRECTIONAL);
 	} else {
 		dma_unmap_sg(dev, msm_obj->sgt->sgl,
-			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
+			msm_obj->sgt->orig_nents, DMA_BIDIRECTIONAL);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index ad58cfe..b0ca084 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -43,7 +43,8 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 	size_t ret;
 
-	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
+	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->orig_nents,
+			   prot);
 	WARN_ON(!ret);
 
 	return (ret == len) ? 0 : -EINVAL;
-- 
1.9.1

