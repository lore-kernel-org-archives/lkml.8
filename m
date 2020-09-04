Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE9AC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C05206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rJ7vpQZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgIDONk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:13:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44698 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbgIDNpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:45:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200904133507euoutp01e6e02826db9cd1cd8a0cf45415437b8b~xmAkOt0vK0722107221euoutp01s
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:35:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200904133507euoutp01e6e02826db9cd1cd8a0cf45415437b8b~xmAkOt0vK0722107221euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599226507;
        bh=M6LUpUR0yeAQpj3I0Hzt+0kX5PVbzJKyJpNcEwtoCPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJ7vpQZd6k/ci8vZ9dNBFafOcWJX/a61zmJeRw8vmkv/yq5SIMF/EitQPqlxsDPO2
         U9J28iMeduQMOl+NdItqrrrX9N4sh8F14oKzzyOh47arjiyL/WhbX/ZiCpeQWSDAAQ
         VdVOh1bKD+cNEkHl9i4Q7uUdewBdzM4xDwM7Y7+s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200904133506eucas1p16f875fb1a1d79b21dfd37ea6cc11a0ff~xmAjujuXO1156611566eucas1p1K;
        Fri,  4 Sep 2020 13:35:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0D.39.06318.A82425F5; Fri,  4
        Sep 2020 14:35:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200904133506eucas1p170dd4d393f12bf79c9ba4a3c9532c29f~xmAjaoAAZ0117201172eucas1p1y;
        Fri,  4 Sep 2020 13:35:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200904133506eusmtrp2d63e1b01372524ece3713ef834439e25~xmAjZ9k5q0977109771eusmtrp2J;
        Fri,  4 Sep 2020 13:35:06 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-b1-5f52428aa09e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8E.A0.06017.A82425F5; Fri,  4
        Sep 2020 14:35:06 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200904133505eusmtip163609e20523e3ff142d855a3f0b8eaa4~xmAiz6CsY1932019320eusmtip1S;
        Fri,  4 Sep 2020 13:35:05 +0000 (GMT)
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
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v10 21/30] drm: xen: fix common struct sg_table related
 issues
Date:   Fri,  4 Sep 2020 15:17:02 +0200
Message-Id: <20200904131711.12950-22-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904131711.12950-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfSxVcRjH+51zz73HzbHTJX5RsbvVqg0Zf5zlTrHWzj9tprU2ltvFCcWl
        e1DMMMrL9TJiCIuFvFO6EUrIa3IZMm8NsRnztrwU85LTQf99n8/3++x59uzBUUkDZox7KwMY
        lVLhIxWKBTXtm73magcn+eXGCksqUduFUG8zqzBqryYFpQbXl4VUSVkbQuV9tqXWBqcQqnp6
        CKMG6nOEVEXrDxG1UraMUc0rMxj1W5OKXCPo8pflgB4vrAP0p408AV27MYnRE/EdCP2uIJwe
        251G6dThIkB/WRkU0A0jEUI6SVMK6NXqs466zmKZB+PjHcSoLO3uib1yS9uBf5Lek5jdcRAB
        Fo+rgQ4OSRuYtLAiUgMxLiGLAVztTBbwxRqA9W2jKF+sApi29wI5bEkYikZ4owjAzZwicNRS
        3b8LuJSQtILqRbWQ0wbkMwA7E3W5EEr+QaD2daeIM/RJR7gW24SpAY4LyHMwr8eDwwRpB0uK
        p0T8NFNY9qYJ5bTOPn+fOYPxXCuC6RsyXl+HE0sLB3l9ON+hOdCn4V5d7r9NIRkF4JS2QsQX
        CQAORGYCPmULx7VbQm4JlLwIq+oteWwP4yNrBByGpB4cXjzBYXRfPq/JQHlMwNhoCZ8+D7M6
        Ko/GNvf1o7ymYUll/8FJU/bPMLEpSgamWf+H5QFQCoyYQNbXk2GtlcxjC1bhywYqPS3c/Xyr
        wf5Lde92rH8AjdtuLYDEgVSXOHbVSS7BFEFssG8LgDgqNSAcerpdJYSHIjiEUfnJVYE+DNsC
        THCB1IiwfjV3V0J6KgKYhwzjz6gOXQTXMY4AITvu2XoDGtd58/xbUbRh3Pf0EKMLJz+2C0+F
        a9c2escXikeXXB4k22blGzWa6c3P0cTtgZ4r2yOzoTfCCsesSqU7X72UT+8vnXG702RmUtn1
        KzotTGa4VTApaw1KrmD7bL45yzJu/oyTx+S7aOxDzQ2JbNnmbKshVe82XSsXP5IKWC+F1SVU
        xSr+AqiFDBtOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7pdTkHxBse3S1j0njvJZLFxxnpW
        i//bJjJbXPn6ns1i5eqjTBYL9ltbfLnykMli0+NrrBaXd81hs1h75C67xYfV71ktDn54wmrx
        fctkJgdejzXz1jB63Fm6k9Fj77cFLB7bvz1g9bjffZzJY/OSeo/b/x4ze0y+sZzR4/CHKywe
        u282sHn0bVnF6PF5k1wAT5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
        TUpqTmZZapG+XYJexvxVxxgL+vgq2v/dYWxgfMvdxcjJISFgItFzrY2pi5GLQ0hgKaNEX+MU
        NoiEjMTJaQ2sELawxJ9rXWwQRZ8YJfY0PmcBSbAJGEp0vYVIiAh0MkpM6/7IDuIwC/xjkjix
        dzsTSJWwgJ/E1u9XGbsYOThYBFQlFpxNAQnzCthJrFzxkB1ig7zE6g0HmEFsTqD41hlPwDYL
        CdhKfJizmGUCI98CRoZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgVGz7djPLTsYu94FH2IU
        4GBU4uFlsA+KF2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlOavEhRlOgmyYyS4km
        5wMjOq8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA6NZYzFDSrT+
        zEYH20lhl1sVs9t9z81h2F3m6iVk8K3lgOffF6wS1WH3/t2Pn5H8mKPzesEVxdblAt2tPhqM
        UmZcT1V2b+T4dmKebaoJm6mZi98WBTX1ZcmFMh/O/edUiS8/v7z+0Ml9P1p/fdsk/2ReqVTa
        kYvJOZf7vA9XtsqpFLx7u//+ESWW4oxEQy3mouJEAH4u/TOwAgAA
X-CMS-MailID: 20200904133506eucas1p170dd4d393f12bf79c9ba4a3c9532c29f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200904133506eucas1p170dd4d393f12bf79c9ba4a3c9532c29f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200904133506eucas1p170dd4d393f12bf79c9ba4a3c9532c29f
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
        <CGME20200904133506eucas1p170dd4d393f12bf79c9ba4a3c9532c29f@eucas1p1.samsung.com>
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

Fix the code to refer to proper nents or orig_nents entries. This driver
reports the number of the pages in the imported scatterlist, so it should
refer to sg_table->orig_nents entry.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index 39ff95b75357..0e57c80058b2 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -216,7 +216,7 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
 		return ERR_PTR(ret);
 
 	DRM_DEBUG("Imported buffer of size %zu with nents %u\n",
-		  size, sgt->nents);
+		  size, sgt->orig_nents);
 
 	return &xen_obj->base;
 }
-- 
2.17.1

