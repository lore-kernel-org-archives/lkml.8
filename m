Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8999CC8183E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB0B2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fmU6kEcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgELJBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:01:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34312 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgELJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:01:17 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200512090114euoutp015034aaf0300e7434cb5429ba16a87b67~OPFmt1HDq2629726297euoutp01L
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:01:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200512090114euoutp015034aaf0300e7434cb5429ba16a87b67~OPFmt1HDq2629726297euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589274074;
        bh=bvJb1ZIDineRz9lDLNNM1tOj04quyAdh8U8RzbUCleg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmU6kEcT1s4709GuZh5CYn8NHRS82RXSTWqBRFvV3bbzFkffTF+Fkp77MQWyu+FP1
         RcKmc7mukVa+RHHCTplNxKE3qQxQhz5ux1auVrF0EmZBB9qZ/4vDUn1qS+uPKxiQdI
         Eiv7b+Y0XFifkEA283wOHfjpqQi3FCx5BJpGiwLM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200512090113eucas1p1678531a352901ebf12c22e466b008a64~OPFmOBb4W1610016100eucas1p1Y;
        Tue, 12 May 2020 09:01:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A6.6B.60698.9D56ABE5; Tue, 12
        May 2020 10:01:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200512090113eucas1p254a8b23dd0ee63411df200f66d193203~OPFl_eaol2661826618eucas1p2P;
        Tue, 12 May 2020 09:01:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200512090113eusmtrp2f4fbc61e9c7f34e6202a8543d1888c5f~OPFl9zZv80472504725eusmtrp2D;
        Tue, 12 May 2020 09:01:13 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-0f-5eba65d9c6e2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3B.35.08375.9D56ABE5; Tue, 12
        May 2020 10:01:13 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200512090112eusmtip1bd56442fffa27ceb46aae681620039bb~OPFlXufgb1257212572eusmtip1n;
        Tue, 12 May 2020 09:01:12 +0000 (GMT)
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
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v4 11/38] drm: exynos: fix common struct sg_table related
 issues
Date:   Tue, 12 May 2020 11:00:31 +0200
Message-Id: <20200512090058.14910-11-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRjm2zk7OxubnKaxLxOlQdEFNbUfB7SRFHR+WVgWSl6WHnTlpux4
        LSopE1k6vGSZeMNE835faqg5tBXWrLykpampiIEX8kLa1LYds3/P87zP814+PhwRN3PtcYUq
        hlar5JFSTIDq3mz0O4/S7UEnO5bcyHTjOw7ZkFvHJXd0mQg5uLaEkRVVvRwyayIDJYu7PMnV
        wSkO2Tg9zCUH2vMxMre/k0PW9IzzyO7lGS6Zmz2PnbGhqgurAdWxXoxSL9cnudTEIwOHaiq9
        R33bnkao7JFyQL0aTcIobXMloFYaHS8KAgReYXSkIo5Wu8pCBBFr/d7RBruEMe0GlgTK9mkA
        H4fEKfjs/RJPAwS4mHgB4JR2k8uSVQA/ZebvkhUAtaYeM8GtkYK5s6xeDqBubQvdS2jralFL
        X4xwg5oFDWbBdsRDAN+mCy0mhEhF4HBmEbAUbAlfOD5VaDWhxGG49URnDYsIGTRWpfHYBZ1g
        Vf1rxIL5Zn2iyGSdBgk9D25+yEFY0zk425LKYbEt/Glo3g07wJ22Ig4beGC+zljDY0kagAP3
        cwHr8oRjxk3MchxCHIN17a7snd5ww+TCQhs4smB9MMQMs3RPEVYWwdQUMdvjCMwz1O5N7f74
        eXczCv7Y+WrFYqIXwKbewAzglPd/VDEAlUBCxzLKcJrxUNHxLoxcycSqwl1Co5SNwPyX+rYN
        a62g03RdDwgcSIWiVPe2IDFXHsckKvUA4ojUTpSsMEuiMHniLVodFayOjaQZPTiIo1KJyKNk
        PlBMhMtj6Js0HU2r/1U5ON8+CbgPufs4/D7k7wG5TiEBQ9cS+ip+LStkJ0RHW0rTvcpaF2cl
        I/UpoUSos4/fVf/OpAPM5uOhLzdmChKDjQu+xskem9s5l4SX78j9xw13hbbt/NOA6NCs1M/q
        O9GusJLu5O+yrv3Un6u65ore4PNpV5YlDX7P+U1zFza6HBeDq+OlKBMhdzuOqBn5X24SffxH
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xu7o3U3fFGVz4J2/Re+4kk8XGGetZ
        Lf5vm8hsceXrezaLlauPMllMuj+BxWLBfmuLL1ceMllsenyN1eLyrjlsFjPO72OyWHvkLrvF
        wQ9PWC1mTH7J5sDnsWbeGkaPvd8WsHhs//aA1eN+93Emj81L6j1u/3vM7DH5xnJGj903G9g8
        +rasYvT4vEkugCtKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSez
        LLVI3y5BL+PreceC4yIVd/p+sjUwLhPsYuTgkBAwkZj73LmLkYtDSGApo8SF3l+MXYycQHEZ
        iZPTGlghbGGJP9e62CCKPjFKrLt8hQUkwSZgKNH1FiIhItDJKDGt+yM7iMMsMIFZ4n7LarBR
        wgIBEkea17GB2CwCqhJ/p20D6+YVsJM4t7qHHWKFvMTqDQeYQWxOoPj9+X/AaoQECiUeXX3L
        MoGRbwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzASNl27OfmHYyXNgYfYhTgYFTi4e0w
        2hknxJpYVlyZe4hRgoNZSYS3JRMoxJuSWFmVWpQfX1Sak1p8iNEU6KiJzFKiyfnAKM4riTc0
        NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cAouNhf0GdGQIPehLuy1QeO
        t0+JfvlSxrE3jceruNquRvb/s3z9rsOx8g8mA9XYyF4PiHDa96mZf9vvyTcY0uJsBdRqzrYv
        XXlB2lz0d9bLnzMVBXtuqJ5g+tLI/v6i/5bA3JU3tJzdEqt7S/I/K1cYli9qejor5t2/GLZf
        Odycr14nB/lcUmIpzkg01GIuKk4EAHnl4oGqAgAA
X-CMS-MailID: 20200512090113eucas1p254a8b23dd0ee63411df200f66d193203
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200512090113eucas1p254a8b23dd0ee63411df200f66d193203
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090113eucas1p254a8b23dd0ee63411df200f66d193203
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
        <20200512090058.14910-1-m.szyprowski@samsung.com>
        <CGME20200512090113eucas1p254a8b23dd0ee63411df200f66d193203@eucas1p2.samsung.com>
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
For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread:
https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index fcee33a..7014a8c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -395,8 +395,8 @@ static void g2d_userptr_put_dma_addr(struct g2d_data *g2d,
 		return;
 
 out:
-	dma_unmap_sg(to_dma_dev(g2d->drm_dev), g2d_userptr->sgt->sgl,
-			g2d_userptr->sgt->nents, DMA_BIDIRECTIONAL);
+	dma_unmap_sgtable(to_dma_dev(g2d->drm_dev), g2d_userptr->sgt,
+			  DMA_BIDIRECTIONAL, 0);
 
 	pages = frame_vector_pages(g2d_userptr->vec);
 	if (!IS_ERR(pages)) {
@@ -511,10 +511,10 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct g2d_data *g2d,
 
 	g2d_userptr->sgt = sgt;
 
-	if (!dma_map_sg(to_dma_dev(g2d->drm_dev), sgt->sgl, sgt->nents,
-				DMA_BIDIRECTIONAL)) {
+	ret = dma_map_sgtable(to_dma_dev(g2d->drm_dev), sgt,
+			      DMA_BIDIRECTIONAL, 0);
+	if (ret) {
 		DRM_DEV_ERROR(g2d->dev, "failed to map sgt with dma region.\n");
-		ret = -ENOMEM;
 		goto err_sg_free_table;
 	}
 
-- 
1.9.1

