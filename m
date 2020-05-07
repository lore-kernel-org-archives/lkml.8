Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B66CC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F68F2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgEGGdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:33:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3832 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgEGGdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:33:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4C5D4A87EB3CBC1BFCE0;
        Thu,  7 May 2020 14:33:21 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 14:33:14 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] ASoC: amd: acp3x-pcm-dma: Use bitwise instead of arithmetic operator for flags
Date:   Thu, 7 May 2020 14:39:22 +0800
Message-ID: <1588833562-14417-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccinelle warnings:

sound/soc/amd/raven/acp3x-pcm-dma.c:161:39-40: WARNING: sum of probable bitmasks, consider |
sound/soc/amd/raven/acp3x-pcm-dma.c:172:39-40: WARNING: sum of probable bitmasks, consider |
sound/soc/amd/raven/acp3x-pcm-dma.c:183:39-40: WARNING: sum of probable bitmasks, consider |
sound/soc/amd/raven/acp3x-pcm-dma.c:194:39-40: WARNING: sum of probable bitmasks, consider |

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index e362f0b..b0cc0fe 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -158,7 +158,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 		switch (rtd->i2s_instance) {
 		case I2S_BT_INSTANCE:
 			reg_dma_size = mmACP_BT_TX_DMA_SIZE;
-			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
+			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
 						BT_PB_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = mmACP_BT_TX_FIFOADDR;
 			reg_fifo_size = mmACP_BT_TX_FIFOSIZE;
@@ -169,7 +169,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 		case I2S_SP_INSTANCE:
 		default:
 			reg_dma_size = mmACP_I2S_TX_DMA_SIZE;
-			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
+			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
 						SP_PB_FIFO_ADDR_OFFSET;
 			reg_fifo_addr =	mmACP_I2S_TX_FIFOADDR;
 			reg_fifo_size = mmACP_I2S_TX_FIFOSIZE;
@@ -180,7 +180,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 		switch (rtd->i2s_instance) {
 		case I2S_BT_INSTANCE:
 			reg_dma_size = mmACP_BT_RX_DMA_SIZE;
-			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
+			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
 						BT_CAPT_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = mmACP_BT_RX_FIFOADDR;
 			reg_fifo_size = mmACP_BT_RX_FIFOSIZE;
@@ -191,7 +191,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 		case I2S_SP_INSTANCE:
 		default:
 			reg_dma_size = mmACP_I2S_RX_DMA_SIZE;
-			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
+			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
 						SP_CAPT_FIFO_ADDR_OFFSET;
 			reg_fifo_addr = mmACP_I2S_RX_FIFOADDR;
 			reg_fifo_size = mmACP_I2S_RX_FIFOSIZE;
-- 
2.6.2

