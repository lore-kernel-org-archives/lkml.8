Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9153C81821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8619C20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HlpOu2ag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgELJBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:01:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34312 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgELJBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:01:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200512090129euoutp0144defd1568eb55a04db14cdadd2c338c~OPF0258ds2643526435euoutp01L
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:01:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200512090129euoutp0144defd1568eb55a04db14cdadd2c338c~OPF0258ds2643526435euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1589274089;
        bh=PaSShSxED90KNxpkYwSSyeOdX5YGDnfxv6ZgggLohKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlpOu2agtIybvI3HLIueyCoSu+kngj8sOtrWM6TYFEOyC/lETKjAlQUQ/VI3HHjxP
         ZjebVFktGGawQ/7yG2jGcZFt5cNZCKly+Zb3wvLW5AFWfZ4v/Ci7yiENOWLGFq/fQ0
         cXwFcYqbzGQO6XcbQVmLDpkLALIOLVMqnEU1psWc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200512090129eucas1p24cc34b311be1ae013d327669187046bb~OPF0f_jp-2660626606eucas1p2j;
        Tue, 12 May 2020 09:01:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D7.32.60679.9E56ABE5; Tue, 12
        May 2020 10:01:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200512090128eucas1p11ee8a5e72ca37dc6b3e8a07ea094bab6~OPF0Dgdh-0904609046eucas1p1B;
        Tue, 12 May 2020 09:01:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200512090128eusmtrp2067652dfbf86e4fac8989d6cb30584c6~OPF0CF46z0472504725eusmtrp2c;
        Tue, 12 May 2020 09:01:28 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-dc-5eba65e994db
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D0.55.08375.8E56ABE5; Tue, 12
        May 2020 10:01:28 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200512090128eusmtip162274653ef501091a87861f9e14ac8b1~OPFzbUefC1257212572eusmtip1y;
        Tue, 12 May 2020 09:01:27 +0000 (GMT)
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
Subject: [PATCH v4 35/38] rapidio: fix common struct sg_table related issues
Date:   Tue, 12 May 2020 11:00:55 +0200
Message-Id: <20200512090058.14910-35-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeUgUURzm7ezMjuLauBq+zLKWihTStaIGDCkSnChQAqOErDEnlbzYUcsQ
        2tQs1qPUQrPQRbT1Nm93vfJWrK1cC0/UTMFzpVW7PNp1rP77jt/3vvd7PBwR1aM2eGBIOCMN
        oYPEmCm/pvOn5sgMo/aRKNJxMknTwyO/FA4gZHlGGUpu1qQgZP+KDiMLijp4pKLZhVzun+CR
        FZOfUVKrfomRJe2jAvLZ++8I2bL0FT0tpIqzigHVuKrgU6rMUQGVOB+HUrWr4yg1ltDFoypz
        71HDG5MIlTagBFT9oAyjkqsKAaWv2Otp5m16yo8JCoxkpE6u100DviV0oGFrlneqK9sEMjBI
        yIEJDonjsHY8F8iBKS4i8gHUlw8JOLIM4POGLIwjegBrtcPgb2SgLQfhDCWAyrxUntHYikwv
        IUaMEc5QviDHjNiKeABgd5KZESPEIg+26x2M2JK4AOdn07ayfOIg7CuY3CoQEq6wOnYS5crs
        YNHrN1tnmhj0sew1vrEYEhoBVMm1Am7IDc5qBjEOW8LZrqpt3RZuqrJ5XCAWwAlNiYAjiQBq
        YzK293GBI5pfhjRuuJ49LFM7cfIZ2PnqPjDKkDCHAwsW3ALmMLUmHeFkIXwUL+KmD8HMrtJ/
        tS0f+hAOU/BjU8P2K3YAmDsyJXgC7DL/lykAKATWTAQb7M+wR0OY244sHcxGhPg73ggNrgCG
        L9W70bVcB9Rrvq2AwIHYTCiRqHxEKB3JRgW3AogjYithXKBBEvrRUXcZaeg1aUQQw7aC3Thf
        bC08ljNzVUT40+HMLYYJY6R/XR5uYiMDT5eGJLqTM7E7Ljfr3ao9vKxjg/YkF8XnelmWeujm
        8nRYvoU3veh7+K2mMbpb53Bp2qbUf5fzi3SvAzNVP+ZOjO+0nc7pAVptjOTTys397Hrnxd8j
        nXGDqizbqboI+17Ppnf6qr5Gdyt3W6XTuX3rKVdWz8rIx+c3oj0fKumygkAxnw2gnR0QKUv/
        AXRmaSZOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7ovUnfFGSxs07DoPXeSyeLRqhvM
        FhtnrGe1+L9tIrPFla/v2SxWrj7KZLFgv7XFlysPmSw2Pb7GanF51xw2i7VH7rJbTD3/ndni
        4IcnrA68HmvmrWH02PttAYvHzll32T163rSwemz/9oDV4373cSaPzUvqPW7/e8zsMfnGckaP
        3Tcb2Dz6tqxi9Pi8SS6AJ0rPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
        JiU1J7MstUjfLkEv41P3UdaCP8IVWzcfZm9gvCnQxcjJISFgInHj8CLmLkYuDiGBpYwSy74s
        ZIRIyEicnNbACmELS/y51sUGUfSJUWLh7WVMIAk2AUOJrrcQCRGBTkaJad0f2UEcZoFvTBKT
        lt5iA6kSFvCRePNqMlgHi4CqxKWVj8FW8ArYSWxtfgy1Ql5i9YYDzCA2J1D8/vw/LCC2kECh
        xKOrb1kmMPItYGRYxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERg324793LyD8dLG4EOMAhyM
        Sjy8HUY744RYE8uKK3MPMUpwMCuJ8LZkAoV4UxIrq1KL8uOLSnNSiw8xmgIdNZFZSjQ5HxjT
        eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGCuqJl6ZsD4idLut
        8wIfm538E1b6vdabIryozena/8pd/m2ro6Zrf7m15+yW5wcnulnaNc16lP3twQq3ph+Jb4S+
        +cz2XmzZcCLTYdq96PPqAX9/nLdf96Pn8fc/Qnk65d+eTDao2ODA1By069mxHTK7ywJUPzdV
        dWR+OFUkwl992uzzkbn/5W8psRRnJBpqMRcVJwIAQ0ag5LECAAA=
X-CMS-MailID: 20200512090128eucas1p11ee8a5e72ca37dc6b3e8a07ea094bab6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200512090128eucas1p11ee8a5e72ca37dc6b3e8a07ea094bab6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200512090128eucas1p11ee8a5e72ca37dc6b3e8a07ea094bab6
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
        <20200512090058.14910-1-m.szyprowski@samsung.com>
        <CGME20200512090128eucas1p11ee8a5e72ca37dc6b3e8a07ea094bab6@eucas1p1.samsung.com>
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
 drivers/rapidio/devices/rio_mport_cdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 4029637..df7dba8 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -574,8 +574,7 @@ static void dma_req_free(struct kref *ref)
 	struct mport_cdev_priv *priv = req->priv;
 	unsigned int i;
 
-	dma_unmap_sg(req->dmach->device->dev,
-		     req->sgt.sgl, req->sgt.nents, req->dir);
+	dma_unmap_sgtable(req->dmach->device->dev, req->sgt, req->dir);
 	sg_free_table(&req->sgt);
 	if (req->page_list) {
 		for (i = 0; i < req->nr_pages; i++)
@@ -927,9 +926,8 @@ static int do_dma_request(struct mport_dma_req *req,
 				xfer->offset, xfer->length);
 	}
 
-	nents = dma_map_sg(chan->device->dev,
-			   req->sgt.sgl, req->sgt.nents, dir);
-	if (nents == 0) {
+	ret = dma_map_sgtable(chan->device->dev, req->sgt, dir);
+	if (ret) {
 		rmcd_error("Failed to map SG list");
 		ret = -EFAULT;
 		goto err_pg;
-- 
1.9.1

