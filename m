Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB350C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE3D2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgE2Hg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:36:58 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:24680 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgE2Hg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:36:56 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id 04T7aHq3067318;
        Fri, 29 May 2020 15:36:23 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com
Cc:     p.yadav@ti.com, juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v4 7/7] mtd: spi-nor: macronix: Add Octal 8D-8D-8D supports for Macronix mx25uw51245g
Date:   Fri, 29 May 2020 15:36:15 +0800
Message-Id: <1590737775-4798-8-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com 04T7aHq3067318
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macronix mx25uw51245g is a SPI NOR that supports 1-1-1/8-8-8 mode.

Correct the dummy cycles to device for various frequencies
after xSPI profile 1.0 table parsed.

Enable mx25uw51245g to Octal DTR mode by executing the command sequences
to change to octal DTR mode.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/spi-nor/macronix.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 96735d8..6c9a24c 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -8,6 +8,57 @@
 
 #include "core.h"
 
+#define MXIC_CR2_DUMMY_SET_ADDR 0x300
+
+/* Fixup the dummy cycles to device and setup octa_dtr_enable() */
+static void mx25uw51245g_post_sfdp_fixups(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = nor->params;
+	int ret;
+	u8 rdc, wdc;
+
+	ret = spi_nor_read_cr2(nor, MXIC_CR2_DUMMY_SET_ADDR, &rdc);
+	if (ret)
+		return;
+
+	/* Refer to dummy cycle and frequency table(MHz) */
+	switch (params->dummy_cycles) {
+	case 10:	/* 10 dummy cycles for 104 MHz */
+		wdc = 5;
+		break;
+	case 12:	/* 12 dummy cycles for 133 MHz */
+		wdc = 4;
+		break;
+	case 16:	/* 16 dummy cycles for 166 MHz */
+		wdc = 2;
+		break;
+	case 18:	/* 18 dummy cycles for 173 MHz */
+		wdc = 1;
+		break;
+	case 20:	/* 20 dummy cycles for 200 MHz */
+	default:
+		wdc = 0;
+	}
+
+	if (rdc != wdc)
+		spi_nor_write_cr2(nor, MXIC_CR2_DUMMY_SET_ADDR, &wdc);
+
+	if (params->cmd_seq[0].len) {
+		params->octal_dtr_enable = spi_nor_cmd_seq_octal_dtr;
+		params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
+		params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
+
+	} else {
+		params->octal_dtr_enable = NULL;
+		params->hwcaps.mask &= ~SNOR_HWCAPS_READ_8_8_8_DTR;
+		params->hwcaps.mask &= ~SNOR_HWCAPS_PP_8_8_8_DTR;
+	}
+}
+
+static struct spi_nor_fixups mx25uw51245g_fixups = {
+	.post_sfdp = mx25uw51245g_post_sfdp_fixups,
+};
+
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
@@ -84,6 +135,10 @@
 			      SPI_NOR_QUAD_READ) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048,
 			      SPI_NOR_QUAD_READ) },
+	{ "mx25uw51245g", INFO(0xc2813a, 0, 64 * 1024, 1024,
+			      SECT_4K | SPI_NOR_4B_OPCODES |
+			      SPI_NOR_OCTAL_DTR_READ)
+			      .fixups = &mx25uw51245g_fixups },
 };
 
 static void macronix_default_init(struct spi_nor *nor)
-- 
1.9.1

