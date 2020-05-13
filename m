Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC598C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BA0204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D61Ngs7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388519AbgEMNfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:35:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38058 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388062AbgEMNdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:33:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200513133312euoutp02bad55f7670cdc07ec7b47be2d8ce6b3f~OmcWAHZt93219432194euoutp025
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:33:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200513133312euoutp02bad55f7670cdc07ec7b47be2d8ce6b3f~OmcWAHZt93219432194euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589376792;
        bh=25k9eKiRX3J34TeqF/vBEPAfhsULwcRZAJqITrVJfzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D61Ngs7VNNxJEtr8uXQMU2SX8trzwtkN5KpJJGU40xoMzU/q1+sVVsxPPt9QxvCXW
         R5NK3k70mlLugnUbVEt4UNXJw4hBNfj4+nMsRqc0npQzpmLpFHZaoVnulKLqK29u3K
         4CFYjyH4PvvaUNiZo3WIJ44ON24+MOh4xGeSDNbM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200513133311eucas1p1b5912233949edfc862c9bf62174d30b5~OmcVtYY1N2350623506eucas1p1N;
        Wed, 13 May 2020 13:33:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E9.D8.60698.717FBBE5; Wed, 13
        May 2020 14:33:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200513133311eucas1p261d84f947b03e4fc733137048aab55fb~OmcVSC_Vt1009610096eucas1p2D;
        Wed, 13 May 2020 13:33:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200513133311eusmtrp1cbc89a111ded0b5b1626fb75b1957bba~OmcVRGpG61011910119eusmtrp1S;
        Wed, 13 May 2020 13:33:11 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-dc-5ebbf7178c56
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5F.37.07950.717FBBE5; Wed, 13
        May 2020 14:33:11 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200513133310eusmtip15a961a7c1de5f2c3e3944c8c366b7dfe~OmcUlWgKD3222032220eusmtip18;
        Wed, 13 May 2020 13:33:10 +0000 (GMT)
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
Subject: [PATCH v5 20/38] drm: radeon: fix common struct sg_table related
 issues
Date:   Wed, 13 May 2020 15:32:27 +0200
Message-Id: <20200513133245.6408-20-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN60ynQ6FkKJg+0YjWqIFEoAGTSVii0Y8xUYPKl4lghbGgtJCW
        RYxRVjUVDNKwFRcgbLJVAStS2ZrKGvbVCJZNjQ0EDZsYBFtGkb9zzj0n592bhyN8I9sRD5VF
        0nKZOEyIcVFt61rPUcGqLsB9XXOETO3pYJGZ4zo2WaSJ55CvsjVsct5oppvaxwg5tLyAkS/K
        37PIvCYvcmloikVWz4ywycH6JxhZaZjgkC3fZ9nHbankgd8YVfGsAlANK3ko9WZlkk0ZH7ax
        qJrCu9THjRmEUo2VAEr3IQ6jHtWWAWqxep+f9SWudzAdFhpNy918r3BD8rtK0YhZwc3ujW5O
        HNi0VwIch4QnNGS4KAEX5xOlAGZNKzGGLAE4MfMWZcgigEu5k0AJrLYSVZmdHGZQAuBA+3Ow
        HVHFazGLCyNEUDmv3MIORDKA7ak2FhNCFCKwcLwRtQzsiQswM62PZcEocQiOdFdyLJhH+MCE
        bgPK1DnB8pfNiAVbmXXTeBPKeOxgR87sFkbMnsTXuYilABJrHKiqa8CY8ClYq/7KZrA9NLXV
        chi8F3apUlAmkAjgVE8lhyEpAA4mZP/d1AuO9/zCLHdCCGeoqXdj5BNwtTgfMOezhWPzdswj
        bGG6NgthZB58cI/PuA9DdVvVdm1L3wDCYAoO9yZhaeCAesc66h3rqP/35gGkDAjoKIVUQis8
        ZHSMq0IsVUTJJK5B4dJqYP52XRtty3Wgcf2qHhA4ENrwJkd1AXy2OFoRK9UDiCNCB945jVni
        BYtjb9Hy8EB5VBit0IM9OCoU8DwKvl3mExJxJH2DpiNo+b8pC7dyjAP4Hb0/uOjqcubpbtHp
        8oikH6kiI7fgZP6gYU5lss/xkfjEzRmy/Kz51wP3/2zNKP0S1J88Wpz6CZcFDDXjcwd8vfu1
        AeBYnqlJqIt1918uHO28b7wWuCs3o6J32LmoRrhwcFJXILgdNi01cT1bEjucYs72f06Xqdzf
        8XvheZEQVYSIRS6IXCH+AzVrLwJyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7ri33fHGXyfxWvRe+4kk8W0O7tZ
        LZaub2S32DhjPavF2/tA7v9tE5ktrnx9z2axcvVRJosF+60tvlx5yGSx6fE1VovLu+awWaw9
        cpfd4uCHJ6wOfB6tl/6yeayZt4bRY++3BSwe2789YPW4332cyWPzknqP2/8eM3tMvrGc0WP3
        zQY2j74tqxg9Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
        Sc3JLEst0rdL0MtYeHoFS8ET8Yqz/86yNzD+F+5i5OSQEDCRWDftFDuILSSwlFFi/UxfiLiM
        xMlpDawQtrDEn2tdbF2MXEA1nxglTjRdYwNJsAkYSnS9hUiICHQySkzr/sgO4jALrGGWuPd9
        OdhYYYEAiT27roLZLAKqEtfOrgWzeQVsJZrOHmGBWCEvsXrDAWYQmxMo/urOfhaIk/Il9i7e
        xwZRLyhxcuYToDgH0AJ1ifXzhEDCzECtzVtnM09gFJyFpGoWQtUsJFULGJlXMYqklhbnpucW
        G+kVJ+YWl+al6yXn525iBEbwtmM/t+xg7HoXfIhRgINRiYfX4tbuOCHWxLLiytxDjBIczEoi
        vH7rgUK8KYmVValF+fFFpTmpxYcYTYFem8gsJZqcD0wueSXxhqaG5haWhubG5sZmFkrivB0C
        B2OEBNITS1KzU1MLUotg+pg4OKUaGJ0aNndxn3w6fe+Ma8ccraL2z7mWFOfQr3pjn7tT5a9o
        FR/hNe/srzRKTWd/+iD3xbrvbxzC2TcHcn0uDrm1XT7xLIPnbpO/f7d4poec35XUnsKVYhl4
        +Ovi5uvrJgZuDygQErtf6dLiyMaa1fDF4qDM/B/FG5d/S00NzPs+r/j2mQ6VHT18okosxRmJ
        hlrMRcWJAP1Nkov2AgAA
X-CMS-MailID: 20200513133311eucas1p261d84f947b03e4fc733137048aab55fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200513133311eucas1p261d84f947b03e4fc733137048aab55fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133311eucas1p261d84f947b03e4fc733137048aab55fb
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
        <20200513133245.6408-1-m.szyprowski@samsung.com>
        <CGME20200513133311eucas1p261d84f947b03e4fc733137048aab55fb@eucas1p2.samsung.com>
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
For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 5d50c9e..0e3eb0d 100644
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
1.9.1

