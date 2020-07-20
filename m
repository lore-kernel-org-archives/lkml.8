Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90290C38159
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A42E206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281538;
	bh=o5c30dPBIoiKVvY7B/0EsgbYA7WNgUsTJDZEOAgANTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EQ34JdeoJBnpI/gLD29WS8IWgdd1AbNTnOBdHaLMJTmpuiPGfNkevVwqC8Qmzwfmz
	 67je2Wy0I4du54N88gZZboNH9JFAydpUxo9AutUGvU8EeM/pfxGeynTcNKIXdCFA5L
	 RZSqROpvB9QptbTjkeJD6Z5Ele5L6efDF7LR9jCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgGTVpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbgGTVhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:37:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9361D207FC;
        Mon, 20 Jul 2020 21:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281052;
        bh=o5c30dPBIoiKVvY7B/0EsgbYA7WNgUsTJDZEOAgANTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWxgtuCmGcXj+zstRYlAVZFAyjmsbB3dTAgTXmU/yw5tm6qiydMO/YYp1XOQTXkAS
         5gJud7JN0sypxCQEcBIQ6WnjkMgDAmkbOHHgDd7Qv/v2PimrMi/t9tTdPd1a6NHzv5
         fjqhtrsf3Ln0ARNS+zOGNXWCXhWTzdoCikb43/AI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "leilk.liu" <leilk.liu@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 13/40] spi: mediatek: use correct SPI_CFG2_REG MACRO
Date:   Mon, 20 Jul 2020 17:36:48 -0400
Message-Id: <20200720213715.406997-13-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213715.406997-1-sashal@kernel.org>
References: <20200720213715.406997-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "leilk.liu" <leilk.liu@mediatek.com>

[ Upstream commit 44b37eb79e16a56cb30ba55b2da452396b941e7a ]

this patch use correct SPI_CFG2_REG offset.

Signed-off-by: leilk.liu <leilk.liu@mediatek.com>
Link: https://lore.kernel.org/r/20200701090020.7935-1-leilk.liu@mediatek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 6783e12c40c22..a556795caeef4 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -36,7 +36,6 @@
 #define SPI_CFG0_SCK_LOW_OFFSET           8
 #define SPI_CFG0_CS_HOLD_OFFSET           16
 #define SPI_CFG0_CS_SETUP_OFFSET          24
-#define SPI_ADJUST_CFG0_SCK_LOW_OFFSET    16
 #define SPI_ADJUST_CFG0_CS_HOLD_OFFSET    0
 #define SPI_ADJUST_CFG0_CS_SETUP_OFFSET   16
 
@@ -48,6 +47,8 @@
 #define SPI_CFG1_CS_IDLE_MASK             0xff
 #define SPI_CFG1_PACKET_LOOP_MASK         0xff00
 #define SPI_CFG1_PACKET_LENGTH_MASK       0x3ff0000
+#define SPI_CFG2_SCK_HIGH_OFFSET          0
+#define SPI_CFG2_SCK_LOW_OFFSET           16
 
 #define SPI_CMD_ACT                  BIT(0)
 #define SPI_CMD_RESUME               BIT(1)
@@ -283,7 +284,7 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 static void mtk_spi_prepare_transfer(struct spi_master *master,
 				     struct spi_transfer *xfer)
 {
-	u32 spi_clk_hz, div, sck_time, cs_time, reg_val = 0;
+	u32 spi_clk_hz, div, sck_time, cs_time, reg_val;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 
 	spi_clk_hz = clk_get_rate(mdata->spi_clk);
@@ -296,18 +297,18 @@ static void mtk_spi_prepare_transfer(struct spi_master *master,
 	cs_time = sck_time * 2;
 
 	if (mdata->dev_comp->enhance_timing) {
+		reg_val = (((sck_time - 1) & 0xffff)
+			   << SPI_CFG2_SCK_HIGH_OFFSET);
 		reg_val |= (((sck_time - 1) & 0xffff)
-			   << SPI_CFG0_SCK_HIGH_OFFSET);
-		reg_val |= (((sck_time - 1) & 0xffff)
-			   << SPI_ADJUST_CFG0_SCK_LOW_OFFSET);
+			   << SPI_CFG2_SCK_LOW_OFFSET);
 		writel(reg_val, mdata->base + SPI_CFG2_REG);
-		reg_val |= (((cs_time - 1) & 0xffff)
+		reg_val = (((cs_time - 1) & 0xffff)
 			   << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
 		reg_val |= (((cs_time - 1) & 0xffff)
 			   << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
 		writel(reg_val, mdata->base + SPI_CFG0_REG);
 	} else {
-		reg_val |= (((sck_time - 1) & 0xff)
+		reg_val = (((sck_time - 1) & 0xff)
 			   << SPI_CFG0_SCK_HIGH_OFFSET);
 		reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
 		reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
-- 
2.25.1

