Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684D9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DC4207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgFLGuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:50:01 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:29074 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgFLGuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:50:00 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Jun 2020 23:50:00 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg05-sd.qualcomm.com with ESMTP; 11 Jun 2020 23:49:57 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 8D4322187F; Fri, 12 Jun 2020 12:19:55 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        peter.ujfalusi@ti.com, sivaprak@codeaurora.org,
        boris.brezillon@collabora.com, architt@codeaurora.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] mtd: rawnand: qcom: set BAM mode only if not set already
Date:   Fri, 12 Jun 2020 12:19:49 +0530
Message-Id: <1591944589-14357-3-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591944589-14357-1-git-send-email-sivaprak@codeaurora.org>
References: <1591944589-14357-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BAM is DMA controller on QCOM ipq platforms, BAM mode on NAND driver
is set by writing BAM_MODE_EN bit on NAND_CTRL register.

NAND_CTRL is an operational register and in BAM mode operational
registers are read only.

So, before writing into NAND_CTRL register check if BAM mode is already
enabled by bootloader, and set BAM mode only if it is not set already.

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
[V3]
 * Changed commit message to give a small info about BAM
 drivers/mtd/nand/raw/qcom_nandc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index e0c55bb..4827edd 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2784,7 +2784,14 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
 	/* enable ADM or BAM DMA */
 	if (nandc->props->is_bam) {
 		nand_ctrl = nandc_read(nandc, NAND_CTRL);
-		nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
+		/* NAND_CTRL is an operational registers, and CPU
+		 * access to operational registers are read only
+		 * in BAM mode. So update the NAND_CTRL register
+		 * only if it is not in BAM mode. In most cases BAM
+		 * mode will be enabled in bootloader
+		 */
+		if (!(nand_ctrl | BAM_MODE_EN))
+			nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
 	} else {
 		nandc_write(nandc, NAND_FLASH_CHIP_SELECT, DM_EN);
 	}
-- 
2.7.4

