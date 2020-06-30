Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18978C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B774520759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qxavm+h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgF3IQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:16:17 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33962 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgF3IQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:16:16 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200630081613euoutp0193ad9943f48d6abe016d4b2b91391b21~dRFTAutuR0447904479euoutp01j
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 08:16:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200630081613euoutp0193ad9943f48d6abe016d4b2b91391b21~dRFTAutuR0447904479euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593504974;
        bh=Gc3IcEU2dlUOQ0VkbrJOiLpYc9GeFRiwO6+2Vp65ZaQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qxavm+h/9+NdNejMLLYosvdtMfLcJKS0Sxw9z024J9wk//WuFFPLut3wIu8peNQxi
         J7/AOAL+i7FaUMa8majcLUEJOEL7w2XxBJuLEhu8dOGerdagVYPjBwor8gP9hpoKZ0
         ezwK2of1whefCf7AP5U+Z/cUl61WMpUNAenwVQ20=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200630081613eucas1p1a70a7bec7dd97570d7b323334ae5fd92~dRFS1-ICi3086430864eucas1p1N;
        Tue, 30 Jun 2020 08:16:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BA.4F.06456.DC4FAFE5; Tue, 30
        Jun 2020 09:16:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200630081613eucas1p2af288e1a5b91c8e62cb8af2901cc45a4~dRFSg84fd2938129381eucas1p2f;
        Tue, 30 Jun 2020 08:16:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200630081613eusmtrp116e2dfc8e1d5da89f9107f06a848f45a~dRFSalIzk0231002310eusmtrp1O;
        Tue, 30 Jun 2020 08:16:13 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-d5-5efaf4cd4bf4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.5E.06314.DC4FAFE5; Tue, 30
        Jun 2020 09:16:13 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200630081612eusmtip1f757a87664781dbfdcc874991439ce9e~dRFSBs3N81581115811eusmtip18;
        Tue, 30 Jun 2020 08:16:12 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] scatterlist: protect parameters of the sg_table related
 macros
Date:   Tue, 30 Jun 2020 10:16:02 +0200
Message-Id: <20200630081602.30594-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTcRztv3t3dx2trpvgDyuTkUVR2tAPA01NEvZRP0WGj5WXabopuz4r
        QRRChln4KJOysQTnY24OWaWQOSuj6dStcpkmlgVqlq9ovnNetW/nnN85nPPhR2LCadyPTFNl
        02qVPENM8HHLm+WBM/1LK4lnZ54GSdtqjFxpY/NrjlTbFSZ1djwkpIZXYzxp99wkN4qQtdS1
        IFmlqwHJOj8VEbLy9iYkWzT7x3Lj+eEpdEZaLq0Ojkjmp/a/HcKzhg/mjxRPEEXonkCDvEig
        QqF2ahPTID4ppPQIhsybHJYsIXCPVXFZsojA0Oni7Ea+rbXw2EMDgsnb5by9SM8dC+FxEZQE
        NLOaLUySPlQ0OB8EeDwY1YrA1s16RFQczFS7cQ/GqUD4sVSBebCAOgc9fToe23YUmk0vtwcC
        5STAbljYmXEBRl2rOItFMN3bvhM4DLbKMpwNlCCYsBt4LClD4CyuQawrDEbtK9vzMOokGDuC
        Wfk8mPo+4B4ZqAPgmvX2yNgWrLDcx1hZAKW3hKz7ONT2tu7Vdg86MBbLoK5Ks60LqQTQPR/m
        3kX+tf+7tAg1IV86h1EqaEaiovOCGLmSyVEpgq5mKs1o6wNsG70Lz9AfxxUrokgk3i9Iti8n
        CrnyXKZAaUVAYmIfQXS/LVEoSJEXXKfVmUnqnAyasaJDJC72FYTophKElEKeTafTdBat3r1y
        SC+/IhTlvmFlcId3zHLo7O9L6fsK30UY6yXep+MGSxyx0ZeDdVmKNdETk2X+s74Q+xIon1i/
        2WU+Ys7fwB+/+KmZ/yvSg/69z6N46Wpe44n1kKTVr8ZxTuTFgo+RA7k94bYRbb35GFYf6Oec
        q24b+y75tXmtNGSjq1NrqnSoY8bdAWKcSZVLTmFqRv4P50OPw/0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsVy+t/xu7pnv/yKMzh3k9di44z1rBYrVx9l
        sliw39ri8q45bBZrj9xltzj44QmrA5vHmnlrGD0m31jO6LH7ZgObR9+WVYwenzfJBbBG6dkU
        5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWcPXGRpeA6
        f8WtpodsDYzTeLsYOTkkBEwkHv9Zw97FyMUhJLCUUaL38VpmiISMxMlpDawQtrDEn2tdbBBF
        nxglrr94xQiSYBMwlOh6C5Lg5BARcJH4sHklE0gRs8AGRonJe++ygySEBfwl/n+9DzaVRUBV
        4tmXSWA2r4CtxOEzi9ghNshLrN5wgHkCI88CRoZVjCKppcW56bnFhnrFibnFpXnpesn5uZsY
        gaG37djPzTsYL20MPsQowMGoxMObcO5nnBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lj
        i0pzUosPMZoCLZ/ILCWanA+Mi7ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalF
        MH1MHJxSDYw5+mF35+VUdR68Ev7fzckrQi2mvMPjqHq0zIN7/Z77vcWXJq0sfiGqYtu9evn9
        T39Efov4xZz6Zhp5Xzky4KD8vl0TdkyYveTr7KY6uSeTmya/mOHM0HBpaduJg0tmZPemPWiZ
        nd+u8v/u5Um6Z0/n8aqVXVM2kajR/Gq4aLvQDwnbk9euSN5VYinOSDTUYi4qTgQAy4Y/+1MC
        AAA=
X-CMS-MailID: 20200630081613eucas1p2af288e1a5b91c8e62cb8af2901cc45a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200630081613eucas1p2af288e1a5b91c8e62cb8af2901cc45a4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200630081613eucas1p2af288e1a5b91c8e62cb8af2901cc45a4
References: <CGME20200630081613eucas1p2af288e1a5b91c8e62cb8af2901cc45a4@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add brackets to protect parameters of the recently added sg_table related
macros from side-effects.

Fixes: 709d6d73c756 ("scatterlist: add generic wrappers for iterating over sgtable objects")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/scatterlist.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 4f922afb607a..45cf7b69d852 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -155,7 +155,7 @@ static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
  * Loop over each sg element in the given sg_table object.
  */
 #define for_each_sgtable_sg(sgt, sg, i)		\
-	for_each_sg(sgt->sgl, sg, sgt->orig_nents, i)
+	for_each_sg((sgt)->sgl, sg, (sgt)->orig_nents, i)
 
 /*
  * Loop over each sg element in the given *DMA mapped* sg_table object.
@@ -163,7 +163,7 @@ static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
  * of the each element.
  */
 #define for_each_sgtable_dma_sg(sgt, sg, i)	\
-	for_each_sg(sgt->sgl, sg, sgt->nents, i)
+	for_each_sg((sgt)->sgl, sg, (sgt)->nents, i)
 
 /**
  * sg_chain - Chain two sglists together
@@ -451,7 +451,7 @@ sg_page_iter_dma_address(struct sg_dma_page_iter *dma_iter)
  * See also for_each_sg_page(). In each loop it operates on PAGE_SIZE unit.
  */
 #define for_each_sgtable_page(sgt, piter, pgoffset)	\
-	for_each_sg_page(sgt->sgl, piter, sgt->orig_nents, pgoffset)
+	for_each_sg_page((sgt)->sgl, piter, (sgt)->orig_nents, pgoffset)
 
 /**
  * for_each_sgtable_dma_page - iterate over the DMA mapped sg_table object
@@ -465,7 +465,7 @@ sg_page_iter_dma_address(struct sg_dma_page_iter *dma_iter)
  * unit.
  */
 #define for_each_sgtable_dma_page(sgt, dma_iter, pgoffset)	\
-	for_each_sg_dma_page(sgt->sgl, dma_iter, sgt->nents, pgoffset)
+	for_each_sg_dma_page((sgt)->sgl, dma_iter, (sgt)->nents, pgoffset)
 
 
 /*
-- 
2.17.1

