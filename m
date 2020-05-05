Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764B3C4725E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB4121655
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kapv75gZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgEEIrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:47:07 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52106 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgEEIqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:46:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200505084637euoutp02846702cfefdf343954a1a54fa1cae91c~MFX2mrZ_-2636626366euoutp02g
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:46:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200505084637euoutp02846702cfefdf343954a1a54fa1cae91c~MFX2mrZ_-2636626366euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588668398;
        bh=wQWCLDgkzEAKWWbFtPWbi4gxIoOTq7jQENUDLHFuvtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kapv75gZCOgtgNo2UsnLWcby7LZDq1YkIaUIvkG4SkRAeRx0hENKEbOmSwxs0Wj8d
         yXS6G/4VWG1BKOJ4Fip+uZPUbjmo4GuWgs7fk8FFH0l6kr3RluWN8K1y0g9B7k+mzQ
         1BJ2a7n+91/IU+uLrtV9Sy8Ve7Fq7UGfvg1M3Cbg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200505084637eucas1p1297f42df3c287917c2c0544c7e16b4d6~MFX2SMuf32430724307eucas1p13;
        Tue,  5 May 2020 08:46:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8A.CF.61286.DE721BE5; Tue,  5
        May 2020 09:46:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200505084637eucas1p20390fa3c010bde00e438cce1b48d209c~MFX18i2791348613486eucas1p2o;
        Tue,  5 May 2020 08:46:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200505084637eusmtrp156559f615bad8ffc826c55f36f635cd2~MFX175TQi0969509695eusmtrp1C;
        Tue,  5 May 2020 08:46:37 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-ba-5eb127eda261
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.31.07950.DE721BE5; Tue,  5
        May 2020 09:46:37 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200505084636eusmtip1c82086af8bba62a51d3ac39d5c0e7684~MFX1WUA2u0521305213eusmtip1I;
        Tue,  5 May 2020 08:46:36 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 22/25] misc: fastrpc: fix common struct sg_table related
 issues
Date:   Tue,  5 May 2020 10:46:11 +0200
Message-Id: <20200505084614.30424-22-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505084614.30424-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUgTYRzHee52t/NlcZ2CTxZJgywl38joyJKiovOPMkzCiqyVhy+5KTu1
        lKSRGDVfMC0yUxnTpfk2nbLClPmSLl8xHdOYUWYYaqvwrTSyNi/tv8/v+8Lvx8NDoFQr5k7E
        ypJYuUwSL8YdBfru5UEf666GSH910Q46Z7AHoX/ndwvphkItRv/R30dp0+I3nM4o0+L0s+ou
        hFYZgugF0wRC6ybNGD3SXIzTta/eCen275+wwyKmprQGML9W8gHTuqQSMM+XPmCMoaRGyLzP
        MiJMY/ktxrI6iTIFYxWAeflWgTO5TVWAmddtP+183vFgFBsfm8LK/YIvO8Y0DCwLE6dEN/RD
        eagC9DgpgQMByUBoHnuIK4EjQZGVAE7OqgE/LABo6ez/N8wDqOivE6xXqnpqBbxRAeDnriXh
        RuVj/RSwp3AyACqtStzOrmQmgK9znO0hlJxBYGnxPcxuuJDhsP2NGrGzgNwJLT2GNV1EBsP2
        mWmMX+cBq+vbUDs72PTJ4fG1ayHZK4RzjzUIHzoGK0cXcJ5d4IyxScjzNthXkC3gCxkATgzW
        CvkhG8CR24WATwXB8cEVW5uw3ecFtc1+vHwEmr8OYXYZkpvgmHWzXUZtmK9/hPKyCN69Q/Fp
        T1hkrNtY2z40jPLMwPkWA8q/UBeAo1YNlgc8iv4vUwFQBdzYZE4azXIBMva6LyeRcsmyaN+r
        CVIdsH2qvlXj3AuwOHylA5AEEDuLIua1kRQmSeFSpR0AEqjYVfT0Z30kJYqSpKax8oRL8uR4
        lusAWwmB2E20Vz19kSKjJUnsNZZNZOXrLkI4uCtAGjeWHhcSUu49GuDQGxGqtezTeXqdKVP5
        6M3yLVl7xhOT+08eeuAv8w7jTilM1ZlhnmfVndWam+WNIZaBXKrDYmLJH+eCVko9oj32Bx6P
        qv1yYdVJ7d6G+CykU7O7E5+YjmpK/GZOaGRllFdSZoVVkq4Ut6jDVYYDPiY8NE4s4GIkAd6o
        nJP8BVF1RjhQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7pv1TfGGRz5zGXRe+4kk8XfScfY
        LTbOWM9q8X/bRGaLK1/fs1k0L17PZrFy9VEmiwX7rS2+XHnIZLHp8TVWi8u75rBZrD1yl93i
        4IcnrA68HmvmrWH0+P1rEqPH3m8LWDy2f3vA6rF/7hp2j/vdx5k8Ni+p97j97zGzx+Qbyxk9
        dt9sYPPo27KK0ePzJrkAnig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
        m5TUnMyy1CJ9uwS9jI1nf7IXPOOt2HZhAnMD40nuLkZODgkBE4lVJ9eydDFycQgJLGWU6Pux
        jBkiISNxcloDK4QtLPHnWhcbRNEnRokb33awgSTYBAwlut5CJEQEOhklpnV/ZAdxmAU+MUkc
        uXYarEpYIEji7NlzTCA2i4CqxO2T+8HG8grYSRx89RJqhbzE6g0HwFZzAsUfX7oD1iskUCjx
        4fx31gmMfAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExs22Yz+37GDsehd8iFGAg1GJ
        h3fD1/VxQqyJZcWVuYcYJTiYlUR4l/3YECfEm5JYWZValB9fVJqTWnyI0RToqInMUqLJ+cCY
        ziuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwNgu/CScU/HPrP+b
        8mJYTxhv/WifKa14eI5QTXGof8wdBSG1QCMd+8dKPHvnb1+fovBsCn/VWS5ZpSs7/JqrJ9j+
        PvxHT2aboU9au8LMulj2C5b/FeVDWnzf1B67zRXgbyE1+QU7g4ruTPXA7c8Wbtp83ePL6vo4
        i7A2uZAnb/feM7QImOznoMRSnJFoqMVcVJwIABoHAhCxAgAA
X-CMS-MailID: 20200505084637eucas1p20390fa3c010bde00e438cce1b48d209c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200505084637eucas1p20390fa3c010bde00e438cce1b48d209c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200505084637eucas1p20390fa3c010bde00e438cce1b48d209c
References: <20200505083926.28503-1-m.szyprowski@samsung.com>
        <20200505084614.30424-1-m.szyprowski@samsung.com>
        <CGME20200505084637eucas1p20390fa3c010bde00e438cce1b48d209c@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/DMA-API-HOWTO.txt states that dma_map_sg returns the
numer of the created entries in the DMA address space. However the
subsequent calls to dma_sync_sg_for_{device,cpu} and dma_unmap_sg must be
called with the original number of the entries passed to dma_map_sg. The
sg_table->nents in turn holds the result of the dma_map_sg call as stated
in include/linux/scatterlist.h. A common mistake was to ignore a result
of the dma_map_sg function and don't use the sg_table->orig_nents at all.

To avoid such issues, lets use common dma-mapping wrappers operating
directly on the struct sg_table objects and adjust references to the
nents and orig_nents respectively.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
For more information, see '[PATCH v3 00/25] DRM: fix struct sg_table nents
vs. orig_nents misuse' thread: https://lkml.org/lkml/2020/5/5/187
---
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index e3e085e..0a3e02aa 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -518,7 +518,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 
 	table = &a->sgt;
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents, dir))
+	if (!dma_map_sgtable(attachment->dev, table, dir))
 		return ERR_PTR(-ENOMEM);
 
 	return table;
@@ -528,7 +528,7 @@ static void fastrpc_unmap_dma_buf(struct dma_buf_attachment *attach,
 				  struct sg_table *table,
 				  enum dma_data_direction dir)
 {
-	dma_unmap_sg(attach->dev, table->sgl, table->nents, dir);
+	dma_unmap_sgtable(attach->dev, table, dir);
 }
 
 static void fastrpc_release(struct dma_buf *dmabuf)
-- 
1.9.1

