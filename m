Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C51EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E865C207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgESH7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:59:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52642 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgESH7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:59:37 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04J7xPdnD029829, This message is accepted by code: ctaloc0852
Received: from RS-CAS01.realsil.com.cn (rsfs1.realsil.com.cn[172.29.17.2])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04J7xPdnD029829
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 19 May 2020 15:59:26 +0800
Received: from localhost (172.29.40.150) by RS-CAS01.realsil.com.cn
 (172.29.17.2) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 May 2020
 15:59:24 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, rui_feng <rui_feng@realsil.com.cn>
Subject: [PATCH] [V2] mmc: rtsx: Add SD Express mode support for RTS5261
Date:   Tue, 19 May 2020 15:59:23 +0800
Message-ID: <1589875163-3367-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: rui_feng <rui_feng@realsil.com.cn>

RTS5261 support legacy SD mode and SD Express mode.
In SD7.x, SD association introduce SD Express as a new mode.
SD Express mode is distinguished by CMD8.
Therefore, CMD8 has new bit for SD Express.
SD Express is based on PCIe/NVMe.
RTS5261 uses CMD8 to switch to SD Express mode.

Signed-off-by: rui_feng <rui_feng@realsil.com.cn>
---
v2: remove config option MISC_RTSX_PCI_SD_EXPRESS 
---

 drivers/misc/cardreader/rts5261.c  |  5 ++++
 drivers/misc/cardreader/rts5261.h  | 23 ----------------
 drivers/misc/cardreader/rtsx_pcr.c |  5 ++++
 drivers/mmc/core/sd_ops.c          |  9 ++++++-
 drivers/mmc/host/rtsx_pci_sdmmc.c  | 43 ++++++++++++++++++++++++++++++
 include/linux/mmc/host.h           |  1 +
 include/linux/rtsx_pci.h           | 27 +++++++++++++++++++
 7 files changed, 89 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 547db5ffd3f6..c6280bb7a67b 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -759,8 +759,12 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
 {
 	struct rtsx_cr_option *option = &pcr->option;
 	struct rtsx_hw_param *hw_param = &pcr->hw_param;
+	u8 val;
 
 	pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
+	rtsx_pci_read_register(pcr, RTS5261_FW_STATUS, &val);
+	if (!(val & RTS5261_EXPRESS_LINK_FAIL_MASK))
+		pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
 	pcr->num_slots = 1;
 	pcr->ops = &rts5261_pcr_ops;
 
@@ -791,6 +795,7 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
 	option->ltr_l1off_snooze_sspwrgate = 0x78;
 	option->dev_aspm_mode = DEV_ASPM_DYNAMIC;
 
+	hw_param->interrupt_en |= DELINK_INT_EN;
 	option->ocp_en = 1;
 	hw_param->interrupt_en |= SD_OC_INT_EN;
 	hw_param->ocp_glitch =  SD_OCP_GLITCH_800U;
diff --git a/drivers/misc/cardreader/rts5261.h b/drivers/misc/cardreader/rts5261.h
index ebfdd236a553..8d80f0d5d5d6 100644
--- a/drivers/misc/cardreader/rts5261.h
+++ b/drivers/misc/cardreader/rts5261.h
@@ -65,23 +65,6 @@
 #define RTS5261_FW_EXPRESS_TEST_MASK	(0x01<<0)
 #define RTS5261_FW_EA_MODE_MASK		(0x01<<5)
 
-/* FW config register */
-#define RTS5261_FW_CFG0			0xFF54
-#define RTS5261_FW_ENTER_EXPRESS	(0x01<<0)
-
-#define RTS5261_FW_CFG1			0xFF55
-#define RTS5261_SYS_CLK_SEL_MCU_CLK	(0x01<<7)
-#define RTS5261_CRC_CLK_SEL_MCU_CLK	(0x01<<6)
-#define RTS5261_FAKE_MCU_CLOCK_GATING	(0x01<<5)
-/*MCU_bus_mode_sel: 0=real 8051 1=fake mcu*/
-#define RTS5261_MCU_BUS_SEL_MASK	(0x01<<4)
-/*MCU_clock_sel:VerA 00=aux16M 01=aux400K 1x=REFCLK100M*/
-/*MCU_clock_sel:VerB 00=aux400K 01=aux16M 10=REFCLK100M*/
-#define RTS5261_MCU_CLOCK_SEL_MASK	(0x03<<2)
-#define RTS5261_MCU_CLOCK_SEL_16M	(0x01<<2)
-#define RTS5261_MCU_CLOCK_GATING	(0x01<<1)
-#define RTS5261_DRIVER_ENABLE_FW	(0x01<<0)
-
 /* FW status register */
 #define RTS5261_FW_STATUS		0xFF56
 #define RTS5261_EXPRESS_LINK_FAIL_MASK	(0x01<<7)
@@ -121,12 +104,6 @@
 #define RTS5261_DV3318_19		(0x04<<4)
 #define RTS5261_DV3318_33		(0x07<<4)
 
-#define RTS5261_LDO1_CFG0		0xFF72
-#define RTS5261_LDO1_OCP_THD_MASK	(0x07<<5)
-#define RTS5261_LDO1_OCP_EN		(0x01<<4)
-#define RTS5261_LDO1_OCP_LMT_THD_MASK	(0x03<<2)
-#define RTS5261_LDO1_OCP_LMT_EN		(0x01<<1)
-
 /* CRD6603-433 190319 request changed */
 #define RTS5261_LDO1_OCP_THD_740	(0x00<<5)
 #define RTS5261_LDO1_OCP_THD_800	(0x01<<5)
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 06038b325b02..4cdc45fdf9b8 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1026,6 +1026,11 @@ static irqreturn_t rtsx_pci_isr(int irq, void *dev_id)
 		} else {
 			pcr->card_removed |= SD_EXIST;
 			pcr->card_inserted &= ~SD_EXIST;
+			if (PCI_PID(pcr) == PID_5261) {
+				rtsx_pci_write_register(pcr, RTS5261_FW_STATUS,
+					RTS5261_EXPRESS_LINK_FAIL_MASK, 0);
+				pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
+			}
 		}
 		pcr->dma_error_count = 0;
 	}
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 22bf528294b9..7c70d267644b 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -171,7 +171,14 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
 	 * SD 1.0 cards.
 	 */
 	cmd.opcode = SD_SEND_IF_COND;
-	cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | test_pattern;
+	/*
+	 * Host asks card's PCIe availability
+	 * if PCIe interface is supported by host.
+	 */
+	if ((ocr & 0xFF8000) && (host->caps2 & MMC_CAP2_SD_EXPRESS))
+		cmd.arg = 0x31 << 8 | test_pattern;
+	else
+		cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | test_pattern;
 	cmd.flags = MMC_RSP_SPI_R7 | MMC_RSP_R7 | MMC_CMD_BCR;
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index bd50935dc37d..87ad75b253eb 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -219,6 +219,7 @@ static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
 	int rsp_type;
 	int stat_idx;
 	bool clock_toggled = false;
+	u32 relink_time, val;
 
 	dev_dbg(sdmmc_dev(host), "%s: SD/MMC CMD %d, arg = 0x%08x\n",
 			__func__, cmd_idx, arg);
@@ -322,6 +323,44 @@ static void sd_send_cmd_get_rsp(struct realtek_pci_sdmmc *host,
 	if (err && clock_toggled)
 		rtsx_pci_write_register(pcr, SD_BUS_STAT,
 				SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
+
+	/*
+	 * If card has PCIe availability and WP if off,
+	 * reader switch to PCIe mode.
+	 */
+	val = rtsx_pci_readl(pcr, RTSX_BIPR);
+	if (cmd->opcode == 8 && ((cmd->resp[0] >> 8) & 0x10)
+		&& !(val & SD_WRITE_PROTECT)) {
+		/* Set relink_time for changing to PCIe card */
+		relink_time = 0x8FFF;
+
+		rtsx_pci_write_register(pcr, 0xFF01, 0xFF, relink_time);
+		rtsx_pci_write_register(pcr, 0xFF02, 0xFF, relink_time >> 8);
+		rtsx_pci_write_register(pcr, 0xFF03, 0x01, relink_time >> 16);
+
+		rtsx_pci_write_register(pcr, PETXCFG, 0x80, 0x80);
+		rtsx_pci_write_register(pcr, LDO_VCC_CFG0,
+			RTS5261_LDO1_OCP_THD_MASK,
+			pcr->option.sd_800mA_ocp_thd);
+
+		if (pcr->ops->disable_auto_blink)
+			pcr->ops->disable_auto_blink(pcr);
+
+		/* For PCIe/NVMe mode can't enter delink issue */
+		pcr->hw_param.interrupt_en &= ~(SD_INT_EN);
+		rtsx_pci_writel(pcr, RTSX_BIER, pcr->hw_param.interrupt_en);
+
+		rtsx_pci_write_register(pcr, RTS5260_AUTOLOAD_CFG4,
+			RTS5261_AUX_CLK_16M_EN, RTS5261_AUX_CLK_16M_EN);
+		rtsx_pci_write_register(pcr, RTS5261_FW_CFG0,
+			RTS5261_FW_ENTER_EXPRESS, RTS5261_FW_ENTER_EXPRESS);
+		rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
+			RTS5261_MCU_BUS_SEL_MASK | RTS5261_MCU_CLOCK_SEL_MASK
+			| RTS5261_MCU_CLOCK_GATING | RTS5261_DRIVER_ENABLE_FW,
+			RTS5261_MCU_CLOCK_SEL_16M | RTS5261_MCU_CLOCK_GATING
+			| RTS5261_DRIVER_ENABLE_FW);
+		cmd->error = -EPERM;
+	}
 }
 
 static int sd_read_data(struct realtek_pci_sdmmc *host, struct mmc_command *cmd,
@@ -1123,6 +1162,8 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 	dev_dbg(sdmmc_dev(host), "%s: RTSX_BIPR = 0x%08x\n", __func__, val);
 	if (val & SD_EXIST)
 		cd = 1;
+	if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
+		mmc->caps2 |= MMC_CAP2_SD_EXPRESS;
 
 	mutex_unlock(&pcr->pcr_mutex);
 
@@ -1333,6 +1374,8 @@ static void init_extra_caps(struct realtek_pci_sdmmc *host)
 		mmc->caps |= MMC_CAP_1_8V_DDR;
 	if (pcr->extra_caps & EXTRA_CAPS_MMC_8BIT)
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
+	if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
+		mmc->caps2 |= MMC_CAP2_SD_EXPRESS;
 }
 
 static void realtek_init_host(struct realtek_pci_sdmmc *host)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba703384bea0..7c60998f4b91 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -369,6 +369,7 @@ struct mmc_host {
 #define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
 #define MMC_CAP2_AVOID_3_3V	(1 << 25)	/* Host must negotiate down from 3.3V */
 #define MMC_CAP2_MERGE_CAPABLE	(1 << 26)	/* Host can merge a segment over the segment size */
+#define MMC_CAP2_SD_EXPRESS	BIT(27)		/* Host support sd express card */
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
 
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 65b8142a7fed..a8e1a460645d 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -667,6 +667,24 @@
 #define   PM_WAKE_EN			0x01
 #define PM_CTRL4			0xFF47
 
+#define RTS5261_FW_CFG0			0xFF54
+#define   RTS5261_FW_ENTER_EXPRESS	(0x01 << 0)
+
+#define RTS5261_FW_CFG1			0xFF55
+#define   RTS5261_SYS_CLK_SEL_MCU_CLK	(0x01 << 7)
+#define   RTS5261_CRC_CLK_SEL_MCU_CLK	(0x01 << 6)
+#define   RTS5261_FAKE_MCU_CLOCK_GATING	(0x01 << 5)
+#define   RTS5261_MCU_BUS_SEL_MASK	(0x01 << 4)
+#define   RTS5261_MCU_BUS_SEL_MASK	(0x01 << 4)
+#define   RTS5261_MCU_CLOCK_SEL_MASK	(0x03 << 2)
+#define   RTS5261_MCU_CLOCK_SEL_16M	(0x01 << 2)
+#define   RTS5261_MCU_CLOCK_GATING	(0x01 << 1)
+#define   RTS5261_DRIVER_ENABLE_FW	(0x01 << 0)
+#define   RTS5261_MCU_CLOCK_SEL_MASK	(0x03 << 2)
+#define   RTS5261_MCU_CLOCK_SEL_16M	(0x01 << 2)
+#define   RTS5261_MCU_CLOCK_GATING	(0x01 << 1)
+#define   RTS5261_DRIVER_ENABLE_FW	(0x01 << 0)
+
 /* Memory mapping */
 #define SRAM_BASE			0xE600
 #define RBUF_BASE			0xF400
@@ -704,6 +722,12 @@
 /*RTS5260*/
 #define   RTS5260_DVCC_TUNE_MASK	0x70
 #define   RTS5260_DVCC_33		0x70
+/*RTS5261*/
+#define RTS5261_LDO1_CFG0		0xFF72
+#define   RTS5261_LDO1_OCP_THD_MASK	(0x07 << 5)
+#define   RTS5261_LDO1_OCP_EN		(0x01 << 4)
+#define   RTS5261_LDO1_OCP_LMT_THD_MASK	(0x03 << 2)
+#define   RTS5261_LDO1_OCP_LMT_EN	(0x01 << 1)
 
 #define LDO_VCC_CFG1			0xFF73
 #define   LDO_VCC_REF_TUNE_MASK		0x30
@@ -745,6 +769,8 @@
 
 #define RTS5260_AUTOLOAD_CFG4		0xFF7F
 #define   RTS5260_MIMO_DISABLE		0x8A
+/*RTS5261*/
+#define   RTS5261_AUX_CLK_16M_EN		(1 << 5)
 
 #define RTS5260_REG_GPIO_CTL0		0xFC1A
 #define   RTS5260_REG_GPIO_MASK		0x01
@@ -1217,6 +1243,7 @@ struct rtsx_pcr {
 #define EXTRA_CAPS_MMC_HSDDR		(1 << 3)
 #define EXTRA_CAPS_MMC_HS200		(1 << 4)
 #define EXTRA_CAPS_MMC_8BIT		(1 << 5)
+#define EXTRA_CAPS_SD_EXPRESS		(1 << 6)
 	u32				extra_caps;
 
 #define IC_VER_A			0
-- 
2.17.1

