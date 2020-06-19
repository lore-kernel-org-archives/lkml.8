Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB55CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F64206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FZVCstj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbgFSKkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:40:37 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51673 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732520AbgFSKhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:37:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200619103705euoutp029baea495ca4525808b7f3ec1cf34e8e1~Z66JeQBE92242122421euoutp02a
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 10:37:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200619103705euoutp029baea495ca4525808b7f3ec1cf34e8e1~Z66JeQBE92242122421euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592563025;
        bh=nbh13/xRlTnDhOSh+Kxv0NXU5d6Pqt7iXPYs90aE1m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FZVCstj4s62tuKTQsy/F4jn1PQlStxt86N/EXB6wBGi0XpT6gEaaPfMVX49MDcDCs
         9TJU3RPRYxifz7A/nxw7hBsqP117n7z15jriqFE/lk3j4PJEFoCWsPQ8s+e03i3uzs
         p9ls25aKDLdtztwKm3YusDZXsZgCcZ0seeZjPY0Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200619103705eucas1p11f16c29370943b94896ef56ddaef32e6~Z66I3gaXf0294402944eucas1p1F;
        Fri, 19 Jun 2020 10:37:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 10.AC.06456.1559CEE5; Fri, 19
        Jun 2020 11:37:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200619103704eucas1p1bf233e8914507323499186d9ab742c09~Z66IWCvuF0704707047eucas1p10;
        Fri, 19 Jun 2020 10:37:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200619103704eusmtrp18d2ec53252bf455c53a5187e65512832~Z66IVYPAA0959609596eusmtrp1F;
        Fri, 19 Jun 2020 10:37:04 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-55-5eec955158d8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B3.EA.06314.0559CEE5; Fri, 19
        Jun 2020 11:37:04 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200619103703eusmtip2858f7ecc195d53c8e5b3865722f607f8~Z66HoQ7iD0247402474eusmtip2c;
        Fri, 19 Jun 2020 10:37:03 +0000 (GMT)
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
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH v7 17/36] drm: radeon: fix common struct sg_table related
 issues
Date:   Fri, 19 Jun 2020 12:36:17 +0200
Message-Id: <20200619103636.11974-18-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619103636.11974-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxNcRje73zd09Vtxy31Wxq6m+9EYzpTkmZ2NkP8Yy7FpbOk7o17upFN
        XZVwlImhTyq3XX1TpFWkRrd2ddPHLGR1FzP60HeYSqcT+u95n/d5n+d9f/uRqPwj7kyGaCJY
        rUYVpiCkWHn9T8u6fbf6AjdMtJF0kqURoW93VuF0bskFCf0opQSn+7tmyunyZJRuH/tO0HkF
        rxA6q8aLHm23InRpz1ucbqvMIOiilx8ldO3gJ9zXjrnYOkkwhXcLAfNsPAtjno5340zXVRPC
        lBlimA9TPShzs8MImKp3eoK59jgfMCOlS/wXKKXeQWxYSCSrXe9zVHqipc9InDI6nn3Cr9WD
        DjkPbEhIbYLVzaU4D6SknHoAYLz5NSIWowA25fYSYjECoKF5HOMBOTvypUIt8kYAC+7F4/8n
        at4hgi9BeUC+nycE7EBdBLAhyVYQoZQBhYbO55jQsKf2Q3N6/ewARi2HgzlFEgHLKB+YZ84A
        4oJLYcHDF6iAbWb43vhaXNQshI2pn2Z90BlN3JN0VAiA1KQEZpuqCXHVHTBhLET0sYffTI8l
        InaB5puJmKiPA9BqEYKFIhHAttiUuWQv2Gn5NWuEUqthSeV6kd4OE57xiOhvBzv6F4o72MEb
        5XdQkZbBywlz77sCppmK/8XWvmlFRczA5Ku/wHXgmjbvmrR516T9z80CaD5wYnWcOpjlPDTs
        GXdOpeZ0mmD34+HqUjDz6cxTpuEKMNZ6rA5QJFDYynwP9AbKcVUkF6WuA5BEFQ4yvyZzoFwW
        pIo6x2rDj2h1YSxXBxaTmMJJtjHna4CcClZFsKEse4rV/u0ipI2zHsRYhrfd118i+IEm5UpN
        6wSMdQwPOZnpCVw3//BrYIqnR/z3Nka6SU/DoNQrW0m9daxy0RllHIdvj65HyqeXDfhH/3bS
        R/mV/QxoCY1dQTrckHuTboO7txw9vMrTO7N6z7GtOyv4Jmu2S0H3EKY7NPT+fFKP+UPL51vK
        wl0HnysVGHdC5bEG1XKqPxwLG3pwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xe7oBU9/EGUzsVrHoPXeSyWLand2s
        FkvXN7JbbJyxntXi7X0g9/+2icwWV76+Z7NYufook8WC/dYWX648ZLLY9Pgaq8XlXXPYLNYe
        uctucfDDE1YHPo/WS3/ZPNbMW8PosffbAhaP7d8esHrc7z7O5LF5Sb3H7X+PmT0m31jO6LH7
        ZgObR9+WVYwenzfJBXBH6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mk
        pOZklqUW6dsl6GVcfLOcrWC5WMXWLu0GxhtCXYwcHBICJhLPd+R2MXJxCAksZZRYMPUYYxcj
        J1BcRuLktAZWCFtY4s+1LjaIok+MEo/ebAUrYhMwlOh6C5EQEehklJjW/ZEdxGEWWMMsce/7
        cnaQKmGBAIm9W5cwgdgsAqoSHxatBYvzCthJrDw9B2qdvMTqDQeYQWxOoPjrloNgq4UEbCWW
        L3jPDFEvKHFy5hMWkLOZBdQl1s8TAgkzA7U2b53NPIFRcBaSqlkIVbOQVC1gZF7FKJJaWpyb
        nltsqFecmFtcmpeul5yfu4kRGL/bjv3cvIPx0sbgQ4wCHIxKPLwvQl7HCbEmlhVX5h5ilOBg
        VhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQaxOZpUST84GpJa8k3tDU0NzC0tDc2NzYzEJJ
        nLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2PwB2/OqzZMVrZXc/drrVlrtlqzZ4uvpkie49Om
        qErR+NS3vkYft89cLjbhc8+ypKb9n+e2CDJ4Xw53jPeXXbZ3UrHWouivmxYUnjknxi4f6jL5
        r0oMk4h6bLV25W6LnClB5ku0zNesyRDl25Dm5sZ9SeB56b2YxkOFL1nvOv1fK+e071v4XSWW
        4oxEQy3mouJEANQLM4z1AgAA
X-CMS-MailID: 20200619103704eucas1p1bf233e8914507323499186d9ab742c09
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200619103704eucas1p1bf233e8914507323499186d9ab742c09
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103704eucas1p1bf233e8914507323499186d9ab742c09
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
        <CGME20200619103704eucas1p1bf233e8914507323499186d9ab742c09@eucas1p1.samsung.com>
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 5d50c9edbe80..0e3eb0d22831 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -481,7 +481,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 {
 	struct radeon_device *rdev = radeon_get_rdev(ttm->bdev);
 	struct radeon_ttm_tt *gtt = (void *)ttm;
-	unsigned pinned = 0, nents;
+	unsigned pinned = 0;
 	int r;
 
 	int write = !(gtt->userflags & RADEON_GEM_USERPTR_READONLY);
@@ -521,9 +521,8 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 	if (r)
 		goto release_sg;
 
-	r = -ENOMEM;
-	nents = dma_map_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
-	if (nents == 0)
+	r = dma_map_sgtable(rdev->dev, ttm->sg, direction, 0);
+	if (r)
 		goto release_sg;
 
 	drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
@@ -554,9 +553,9 @@ static void radeon_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
 		return;
 
 	/* free the sg table and pages again */
-	dma_unmap_sg(rdev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
+	dma_unmap_sgtable(rdev->dev, ttm->sg, direction, 0);
 
-	for_each_sg_page(ttm->sg->sgl, &sg_iter, ttm->sg->nents, 0) {
+	for_each_sgtable_page(ttm->sg, &sg_iter, 0) {
 		struct page *page = sg_page_iter_page(&sg_iter);
 		if (!(gtt->userflags & RADEON_GEM_USERPTR_READONLY))
 			set_page_dirty(page);
-- 
2.17.1

