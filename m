Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA3DC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E54FA2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SYsPPFv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHZGg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:36:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37890 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgHZGfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:35:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200826063546euoutp0153d2e73df110c8916eb974c228f49bda~uve2kuKT02034920349euoutp01X
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:35:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200826063546euoutp0153d2e73df110c8916eb974c228f49bda~uve2kuKT02034920349euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598423746;
        bh=di+bodMCWptxnRGcC2+7UHVzTejlGSgl/l0PEsJnmNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYsPPFv4Zb0hRbxb5OAUYvSI3mkVYW2bW0Zc/53hTc8bWInCZxPoLcbejN6+mWRdN
         Puahb0GWaoNewcfQjFOuvq92EXeJ/oKJxe9oDw7SW5jhliSweC06qrLOb3nJ8Pr56s
         VEXwdnqEWr0QwsXl0d6RsLKtZk8WqP1ubJp18C3k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200826063545eucas1p2edc9ac63ec56f99bab8e271eff5440e2~uve2OSvwE0399203992eucas1p2k;
        Wed, 26 Aug 2020 06:35:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EC.33.06456.1C2064F5; Wed, 26
        Aug 2020 07:35:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200826063545eucas1p22eb2c7a643a299f3e1696b4c5bae0694~uve150Ac60404404044eucas1p2q;
        Wed, 26 Aug 2020 06:35:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200826063545eusmtrp22c87e823ad4305913648d2839e77db20~uve15K6oO0466204662eusmtrp2h;
        Wed, 26 Aug 2020 06:35:45 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-e2-5f4602c1d2a3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8D.53.06017.1C2064F5; Wed, 26
        Aug 2020 07:35:45 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200826063544eusmtip2f6851b137f50729822df24f66abac75d~uve1WBhZ00474104741eusmtip2Y;
        Wed, 26 Aug 2020 06:35:44 +0000 (GMT)
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
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>
Subject: [PATCH v9 29/32] rapidio: fix common struct sg_table related issues
Date:   Wed, 26 Aug 2020 08:33:13 +0200
Message-Id: <20200826063316.23486-30-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826063316.23486-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7oHmdziDWZO0LHoPXeSyeLRqhvM
        FhtnrGe1+L9tIrPFla/v2SxWrj7KZLFgv7XFlysPmSw2Pb7GanF51xw2i7VH7rJbTD3/ndni
        4IcnrA68HmvmrWH02PttAYvHzll32T163rSwemz/9oDV4373cSaPzUvqPW7/e8zsMfnGckaP
        3Tcb2Dz6tqxi9Pi8SS6AJ4rLJiU1J7MstUjfLoEr49zHhcwFd0Qr2r/sYGtg/CHYxcjJISFg
        InFj1nPmLkYuDiGBFYwSL0/8Y4RwvjBKPJz/mQXC+cwo8b/rCjtMy+eVM6BaljNKXFt+mh2u
        5cGfr2BVbAKGEl1vu9hAbBGBVkaJE708IDazwDsmiSOftUBsYQEfiRl7rzOC2CwCqhJvp30F
        q+cVsJPYNeEYG8Q2eYnVGw4wg9icQPHj3f1sIMskBM6xS+w70MYEUeQisffQf6gGYYlXx7dA
        nSoj8X/nfCaIhmagh86tZYdwehglLjfNYISospa4c+4XUDcH0HmaEut36UOEHSUW3gBp5gCy
        +SRuvBWEeIBPYtK26cwQYV6JjjYhiGo1iVnH18GtPXjhEjOE7SHRPvE6EySAJjJKXHndwzaB
        UX4WwrIFjIyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAtPU6X/HP+1g/Hop6RCjAAej
        Eg/vAjbXeCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJW
        SCA9sSQ1OzW1ILUIJsvEwSnVwOi6/5TRnxlG6xMi6/hW6+7La3jWu9n5kFk893O9E0/n5h2z
        71GO/as6PU3Mvk/7+6dZ80wsWKSUZ7e/nLtv+SITgSuvzcw+V0ywmrh9W92kqy5Gn/NPXA89
        NOMIn1e88Y1ohi53wUWBr2sqsq9cmTLNzvPfY//AhM2/c6caz1Le89Tk4pqzkppKLMUZiYZa
        zEXFiQBVLYjGTwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7oHmdziDdZ/F7XoPXeSyeLRqhvM
        FhtnrGe1+L9tIrPFla/v2SxWrj7KZLFgv7XFlysPmSw2Pb7GanF51xw2i7VH7rJbTD3/ndni
        4IcnrA68HmvmrWH02PttAYvHzll32T163rSwemz/9oDV4373cSaPzUvqPW7/e8zsMfnGckaP
        3Tcb2Dz6tqxi9Pi8SS6AJ0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEv49zHhcwFd0Qr2r/sYGtg/CHYxcjJISFgIvF55QzmLkYuDiGBpYwSE96t
        ZYJIyEicnNbACmELS/y51sUGYgsJfGKU6P4aDmKzCRhKdL0FiXNxiAh0MkpM6/7IDuIwC3xj
        kpi09BZYh7CAj8SMvdcZQWwWAVWJt9O+gsV5Bewkdk04xgaxQV5i9YYDzCA2J1D8eHc/1DZb
        idNrZzBPYORbwMiwilEktbQ4Nz232EivODG3uDQvXS85P3cTIzBqth37uWUHY9e74EOMAhyM
        Sjy8C9hc44VYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU6KiJzFKiyfnA
        iM4riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cDYN/lbUUdep/dj
        FaGTWZMlzJrm1krxL436zJLa/WRNbKiwln+a5oxivsxank18Nppmhkn3T9w9M1lv0+y3wSIq
        ToIznoa822efuObxseUbnjBt55+y9mbG8Z5d6jMU1Nau/N0yqzM8zbF1b8dE09tSMXsMVnut
        bynW034hoNuz8UbAoQoTQSclluKMREMt5qLiRABTDpensAIAAA==
X-CMS-MailID: 20200826063545eucas1p22eb2c7a643a299f3e1696b4c5bae0694
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200826063545eucas1p22eb2c7a643a299f3e1696b4c5bae0694
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826063545eucas1p22eb2c7a643a299f3e1696b4c5bae0694
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
        <CGME20200826063545eucas1p22eb2c7a643a299f3e1696b4c5bae0694@eucas1p2.samsung.com>
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
 drivers/rapidio/devices/rio_mport_cdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index a30342942e26..89eb3d212652 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -573,8 +573,7 @@ static void dma_req_free(struct kref *ref)
 			refcount);
 	struct mport_cdev_priv *priv = req->priv;
 
-	dma_unmap_sg(req->dmach->device->dev,
-		     req->sgt.sgl, req->sgt.nents, req->dir);
+	dma_unmap_sgtable(req->dmach->device->dev, &req->sgt, req->dir, 0);
 	sg_free_table(&req->sgt);
 	if (req->page_list) {
 		unpin_user_pages(req->page_list, req->nr_pages);
@@ -814,7 +813,6 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 	struct mport_dev *md = priv->md;
 	struct dma_chan *chan;
 	int ret;
-	int nents;
 
 	if (xfer->length == 0)
 		return -EINVAL;
@@ -930,15 +928,14 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
 				xfer->offset, xfer->length);
 	}
 
-	nents = dma_map_sg(chan->device->dev,
-			   req->sgt.sgl, req->sgt.nents, dir);
-	if (nents == 0) {
+	ret = dma_map_sgtable(chan->device->dev, &req->sgt, dir, 0);
+	if (ret) {
 		rmcd_error("Failed to map SG list");
 		ret = -EFAULT;
 		goto err_pg;
 	}
 
-	ret = do_dma_request(req, xfer, sync, nents);
+	ret = do_dma_request(req, xfer, sync, req->sgt.nents);
 
 	if (ret >= 0) {
 		if (sync == RIO_TRANSFER_ASYNC)
-- 
2.17.1

