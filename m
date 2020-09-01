Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E14C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D39320684
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974170;
	bh=/DpnsDYOTLifmkSR22WSm4c/WFR7d9XLBURUx2xMS8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h9jWf3bNHsbNnRFcOlcQfVhMyx6AesMv8epXEYIpGtiMhvGT02gEI6T60X5q9teeF
	 drnGPwygBt61MyZcDmLF9v5o3lU6SB2t3zCNe4dTq260BhRDyv+VGoViJyREIXc+kL
	 cKHuI2tM0174bIYXWSiP4czrkRPkxoPdB8sMrIYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgIAP31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729573AbgIAP0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:26:15 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FBF920BED;
        Tue,  1 Sep 2020 15:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973974;
        bh=/DpnsDYOTLifmkSR22WSm4c/WFR7d9XLBURUx2xMS8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKnX93uve3XqlI73tLoimAVhdyiQqbIfv9Xq9suG++RS6/kho7f1H4fsbKhV/KDEU
         WsYaHF6hQLc60mijBJdmrBPWkk5itKOpxsACHbcH6uMgZOyS5RRNG9mTPivi9Imn28
         868exXUwQ+zIu0c3PjbP1XZ/e9YV+n/GSpj2/5zQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Han Xu <han.xu@nxp.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/6] mtd: rawnand: marvell: Fix and update kerneldoc
Date:   Tue,  1 Sep 2020 16:25:34 +0200
Message-Id: <20200901142535.12819-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901142535.12819-1-krzk@kernel.org>
References: <20200901142535.12819-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kerneldoc comments and add missing documentation for members to fix
W=1 compile warnings like:

  drivers/mtd/nand/raw/marvell_nand.c:251: warning:
    cannot understand function prototype: 'struct marvell_hw_ecc_layout '

  drivers/mtd/nand/raw/marvell_nand.c:342: warning:
    Function parameter or member 'layout' not described in 'marvell_nand_chip'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mtd/nand/raw/marvell_nand.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 52cb7da2fc02..fbffbb3fcc1c 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -227,6 +227,8 @@
 #define XTYPE_MASK		7
 
 /**
+ * struct marvell_hw_ecc_layout - layout of Marvell ECC
+ *
  * Marvell ECC engine works differently than the others, in order to limit the
  * size of the IP, hardware engineers chose to set a fixed strength at 16 bits
  * per subpage, and depending on a the desired strength needed by the NAND chip,
@@ -292,6 +294,8 @@ static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] = {
 };
 
 /**
+ * struct marvell_nand_chip_sel - CS line description
+ *
  * The Nand Flash Controller has up to 4 CE and 2 RB pins. The CE selection
  * is made by a field in NDCB0 register, and in another field in NDCB2 register.
  * The datasheet describes the logic with an error: ADDR5 field is once
@@ -312,14 +316,15 @@ struct marvell_nand_chip_sel {
 };
 
 /**
- * NAND chip structure: stores NAND chip device related information
+ * struct marvell_nand_chip - stores NAND chip device related information
  *
  * @chip:		Base NAND chip structure
  * @node:		Used to store NAND chips into a list
- * @layout		NAND layout when using hardware ECC
+ * @layout:		NAND layout when using hardware ECC
  * @ndcr:		Controller register value for this NAND chip
  * @ndtr0:		Timing registers 0 value for this NAND chip
  * @ndtr1:		Timing registers 1 value for this NAND chip
+ * @addr_cyc:		Amount of cycles needed to pass column address
  * @selected_die:	Current active CS
  * @nsels:		Number of CS lines required by the NAND chip
  * @sels:		Array of CS lines descriptions
@@ -349,7 +354,8 @@ static inline struct marvell_nand_chip_sel *to_nand_sel(struct marvell_nand_chip
 }
 
 /**
- * NAND controller capabilities for distinction between compatible strings
+ * struct marvell_nfc_caps - NAND controller capabilities for distinction
+ *                           between compatible strings
  *
  * @max_cs_nb:		Number of Chip Select lines available
  * @max_rb_nb:		Number of Ready/Busy lines available
@@ -372,7 +378,7 @@ struct marvell_nfc_caps {
 };
 
 /**
- * NAND controller structure: stores Marvell NAND controller information
+ * struct marvell_nfc - stores Marvell NAND controller information
  *
  * @controller:		Base controller structure
  * @dev:		Parent device (used to print error messages)
@@ -383,7 +389,9 @@ struct marvell_nfc_caps {
  * @assigned_cs:	Bitmask describing already assigned CS lines
  * @chips:		List containing all the NAND chips attached to
  *			this NAND controller
+ * @selected_chip:	Currently selected target chip
  * @caps:		NAND controller capabilities for each compatible string
+ * @use_dma:		Whetner DMA is used
  * @dma_chan:		DMA channel (NFCv1 only)
  * @dma_buf:		32-bit aligned buffer for DMA transfers (NFCv1 only)
  */
@@ -411,7 +419,8 @@ static inline struct marvell_nfc *to_marvell_nfc(struct nand_controller *ctrl)
 }
 
 /**
- * NAND controller timings expressed in NAND Controller clock cycles
+ * struct marvell_nfc_timings - NAND controller timings expressed in NAND
+ *                              Controller clock cycles
  *
  * @tRP:		ND_nRE pulse width
  * @tRH:		ND_nRE high duration
@@ -455,8 +464,8 @@ struct marvell_nfc_timings {
 						     period_ns))
 
 /**
- * NAND driver structure filled during the parsing of the ->exec_op() subop
- * subset of instructions.
+ * struct marvell_nfc_op - filled during the parsing of the ->exec_op()
+ *                         subop subset of instructions.
  *
  * @ndcb:		Array of values written to NDCBx registers
  * @cle_ale_delay_ns:	Optional delay after the last CMD or ADDR cycle
-- 
2.17.1

