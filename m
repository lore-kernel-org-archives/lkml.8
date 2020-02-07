Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2327C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B833822464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgBGCpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:45:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbgBGCpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 21:45:20 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AED718E5DC33F6DCE212;
        Fri,  7 Feb 2020 10:45:17 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 7 Feb 2020
 10:45:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <mripard@kernel.org>, <wens@csie.org>, <stefan@olimex.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] dmaengine: sun4i: use 'linear_mode' in sun4i_dma_prep_dma_cyclic
Date:   Fri, 7 Feb 2020 10:44:45 +0800
Message-ID: <20200207024445.44600-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200205044247.32496-1-yuehaibing@huawei.com>
References: <20200205044247.32496-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/dma/sun4i-dma.c: In function sun4i_dma_prep_dma_cyclic:
drivers/dma/sun4i-dma.c:672:24: warning:
 variable linear_mode set but not used [-Wunused-but-set-variable]

commit ffc079a4accc ("dmaengine: sun4i: Add support for cyclic requests with dedicated DMA")
involved this, explicitly using the value makes the code more readable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: use 'linear_mode' instead of removing
---
 drivers/dma/sun4i-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index bbc2bda..e87fc7c4 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -698,10 +698,12 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 		endpoints = SUN4I_DMA_CFG_DST_DRQ_TYPE(vchan->endpoint) |
 			    SUN4I_DMA_CFG_DST_ADDR_MODE(io_mode) |
 			    SUN4I_DMA_CFG_SRC_DRQ_TYPE(ram_type);
+			    SUN4I_DMA_CFG_SRC_ADDR_MODE(linear_mode);
 	} else {
 		src = sconfig->src_addr;
 		dest = buf;
 		endpoints = SUN4I_DMA_CFG_DST_DRQ_TYPE(ram_type) |
+			    SUN4I_DMA_CFG_DST_ADDR_MODE(linear_mode) |
 			    SUN4I_DMA_CFG_SRC_DRQ_TYPE(vchan->endpoint) |
 			    SUN4I_DMA_CFG_SRC_ADDR_MODE(io_mode);
 	}
-- 
2.7.4


