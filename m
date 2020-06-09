Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6180C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98ECE207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgFILLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:11:14 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:10166 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbgFILLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:11:12 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Jun 2020 04:11:04 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg04-sd.qualcomm.com with ESMTP; 09 Jun 2020 04:11:02 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id BE69721801; Tue,  9 Jun 2020 16:41:00 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        peter.ujfalusi@ti.com, sivaprak@codeaurora.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] mtd: rawnand: qcom: remove write to unavailable register
Date:   Tue,  9 Jun 2020 16:40:55 +0530
Message-Id: <1591701056-3944-2-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591701056-3944-1-git-send-email-sivaprak@codeaurora.org>
References: <1591701056-3944-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SFLASHC_BURST_CFG register is not available on all ipq nand platforms,
it is available only on ipq8064 devices and the nand controller works
without configuring these registers in this platform, so register write
to this can be removed.

Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 5b11c70..e0afa2c 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -36,7 +36,6 @@
 #define	NAND_DEV_CMD1			0xa4
 #define	NAND_DEV_CMD2			0xa8
 #define	NAND_DEV_CMD_VLD		0xac
-#define	SFLASHC_BURST_CFG		0xe0
 #define	NAND_ERASED_CW_DETECT_CFG	0xe8
 #define	NAND_ERASED_CW_DETECT_STATUS	0xec
 #define	NAND_EBI2_ECC_BUF_CFG		0xf0
@@ -2774,7 +2773,6 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
 	u32 nand_ctrl;
 
 	/* kill onenand */
-	nandc_write(nandc, SFLASHC_BURST_CFG, 0);
 	nandc_write(nandc, dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD),
 		    NAND_DEV_CMD_VLD_VAL);
 
-- 
2.7.4

