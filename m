Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3DBC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93581214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAORH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:07:59 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:38836 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728963AbgAORH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:07:59 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 00FGN3ZW021573;
        Wed, 15 Jan 2020 18:23:03 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 5EDF16032E; Wed, 15 Jan 2020 18:23:03 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/4] spi: npcm-pspi: fix 16 bit send and receive support
Date:   Wed, 15 Jan 2020 18:22:58 +0200
Message-Id: <20200115162301.235926-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200115162301.235926-1-tmaimon77@gmail.com>
References: <20200115162301.235926-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing NPCM BMC Peripheral SPI controller 16 bit
send and receive support by writing and reading
the SPI data in the right order.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/spi/spi-npcm-pspi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index fe624731c74c..c74611abe2a9 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -195,6 +195,7 @@ static void npcm_pspi_setup_transfer(struct spi_device *spi,
 static void npcm_pspi_send(struct npcm_pspi *priv)
 {
 	int wsize;
+	u16 val;
 
 	wsize = min(bytes_per_word(priv->bits_per_word), priv->tx_bytes);
 	priv->tx_bytes -= wsize;
@@ -204,17 +205,18 @@ static void npcm_pspi_send(struct npcm_pspi *priv)
 
 	switch (wsize) {
 	case 1:
-		iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+		val = *priv->tx_buf++;
+		iowrite8(val, NPCM_PSPI_DATA + priv->base);
 		break;
 	case 2:
-		iowrite16(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+		val = *priv->tx_buf++;
+		val = *priv->tx_buf++ | (val << 8);
+		iowrite16(val, NPCM_PSPI_DATA + priv->base);
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		return;
 	}
-
-	priv->tx_buf += wsize;
 }
 
 static void npcm_pspi_recv(struct npcm_pspi *priv)
@@ -230,18 +232,17 @@ static void npcm_pspi_recv(struct npcm_pspi *priv)
 
 	switch (rsize) {
 	case 1:
-		val = ioread8(priv->base + NPCM_PSPI_DATA);
+		*priv->rx_buf++ = ioread8(priv->base + NPCM_PSPI_DATA);
 		break;
 	case 2:
 		val = ioread16(priv->base + NPCM_PSPI_DATA);
+		*priv->rx_buf++ = (val >> 8);
+		*priv->rx_buf++ = val & 0xff;
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		return;
 	}
-
-	*priv->rx_buf = val;
-	priv->rx_buf += rsize;
 }
 
 static int npcm_pspi_transfer_one(struct spi_master *master,
-- 
2.22.0

