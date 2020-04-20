Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12BDC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965F720B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXXxbecT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgDTNqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728496AbgDTNqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:46:31 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34B6C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:46:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d17so12202049wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QKgplVPQdfQcjzRB1sKoI8Hqbl0bABv2vB41UjfbcXI=;
        b=NXXxbecTDl09xrdYUb9UHNvkXHvfD0BPmfBJEVE5yJYRj14Gj0j7l86s6gz1zubHnx
         dQMwKBHFRugzwbc74sR4ZhP3o39fds6vaSL7TZ8T+FPSPGiA1WzH9vFrvQoa5VfYFp5W
         Sdwq+s5EfCS8IULw+SkYMvTJ+f9f4/eH3yJzMWz6VnKykS5ZUVn8242HYPOYpyEU8QxN
         2MkwiP7PGdyDHK2oqwAiKznFn3wiJLxyXZYrJ7qcNEBfCiRuE/jElXijuDaSSonSMLdr
         /KbiBLEKiCQLykixo9NIgK7y6r1OR8wQpZ87Fh5YGeYR0YDLtBs3FR28iOnSZnn+NcjC
         x58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QKgplVPQdfQcjzRB1sKoI8Hqbl0bABv2vB41UjfbcXI=;
        b=aEMHPaCV04yV90nsbgNwsXev+ti7jrmRBjqTTD+NNEiwJY3Q6hY2YKRWhqWQzTBzxI
         mri4kLcS8ktBcBEZagnemRTssUK6HjZlX/6oqG06edEZihWO3GYBKRdS6DBxpF9p6DEO
         WW9+vYOzz2ONEDBHP2LNy3wIdsK/L8btF2RuC3JEdPEdo/kNQzoYOcJMmBc8GTcP4Lv0
         D3KlhzVszgR+BtCIVW/0P6Ng2VsQmDiUSCufsDS7bf5O+kO32J10PleFDKocOtkU76tN
         mMJd8RTfrKu/5n4CXwtZytt06KMl93qN0fZ+yKKsNpl0cxofe2Ko4OomaYlWIV73bWV1
         r0QQ==
X-Gm-Message-State: AGi0PuaB8NEUnFB9qyON4+70Heyww/frB0nROWXaolkr61DGYBkoqwAI
        H9mTTlgbD1TT6WtEw11HVUq4Gnmx
X-Google-Smtp-Source: APiQypKKtGC/gkjzXGrhThAPOtIOiZyvZzpsLutsg1rr6wqT7tLYRuzZz67hV6sD798+0rYGZreQFw==
X-Received: by 2002:adf:f0cb:: with SMTP id x11mr19088449wro.266.1587390374537;
        Mon, 20 Apr 2020 06:46:14 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id p190sm1380393wmp.38.2020.04.20.06.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:46:13 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: load CPU device boot loader from host
Date:   Mon, 20 Apr 2020 16:46:10 +0300
Message-Id: <20200420134610.31909-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Load CPU device boot loader during driver boot time in order to avoid flash
write for every boot loader update.

To preserve backward-compatibility, skip the device boot load if the device
doesn't request it.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/firmware_if.c        | 22 +++++-
 drivers/misc/habanalabs/goya/goya.c          | 83 ++++----------------
 drivers/misc/habanalabs/habanalabs.h         |  4 +-
 drivers/misc/habanalabs/include/hl_boot_if.h |  3 +
 4 files changed, 44 insertions(+), 68 deletions(-)

diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index 99983822feeb..fb15a0ffb14d 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -329,7 +329,7 @@ static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg)
 
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 boot_err0_reg, bool skip_bmc,
-			u32 cpu_timeout)
+			u32 cpu_timeout, u32 boot_fit_timeout)
 {
 	u32 status;
 	int rc;
@@ -337,6 +337,26 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	dev_info(hdev->dev, "Going to wait for device boot (up to %lds)\n",
 		cpu_timeout / USEC_PER_SEC);
 
+	/* Wait for boot FIT request */
+	rc = hl_poll_timeout(
+		hdev,
+		cpu_boot_status_reg,
+		status,
+		status == CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT,
+		10000,
+		boot_fit_timeout);
+
+	if (rc) {
+		dev_dbg(hdev->dev,
+			"No boot fit request received, resuming boot\n");
+	} else {
+		rc = hdev->asic_funcs->load_boot_fit_to_device(hdev);
+		if (rc)
+			goto out;
+
+		WREG32(msg_to_cpu_reg, KMD_MSG_FIT_RDY);
+	}
+
 	/* Make sure CPU boot-loader is running */
 	rc = hl_poll_timeout(
 		hdev,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ddc506d74988..f969fe35f9ce 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -72,7 +72,7 @@
  *
  */
 
-#define GOYA_UBOOT_FW_FILE	"habanalabs/goya/goya-u-boot.bin"
+#define GOYA_BOOT_FIT_FILE	"habanalabs/goya/goya-boot-fit.itb"
 #define GOYA_LINUX_FW_FILE	"habanalabs/goya/goya-fit.itb"
 
 #define GOYA_MMU_REGS_NUM		63
@@ -87,6 +87,7 @@
 #define GOYA_TEST_QUEUE_WAIT_USEC	100000		/* 100ms */
 #define GOYA_PLDM_MMU_TIMEOUT_USEC	(MMU_CONFIG_TIMEOUT_USEC * 100)
 #define GOYA_PLDM_QMAN0_TIMEOUT_USEC	(HL_DEVICE_TIMEOUT_USEC * 30)
+#define GOYA_BOOT_FIT_REQ_TIMEOUT_USEC	1000000		/* 1s */
 
 #define GOYA_QMAN0_FENCE_VAL		0xD169B243
 
@@ -2210,80 +2211,37 @@ static void goya_halt_engines(struct hl_device *hdev, bool hard_reset)
 }
 
 /*
- * goya_push_uboot_to_device() - Push u-boot FW code to device.
+ * goya_load_firmware_to_device() - Load LINUX FW code to device.
  * @hdev: Pointer to hl_device structure.
  *
- * Copy u-boot fw code from firmware file to SRAM BAR.
+ * Copy LINUX fw code from firmware file to HBM BAR.
  *
  * Return: 0 on success, non-zero for failure.
  */
-static int goya_push_uboot_to_device(struct hl_device *hdev)
+static int goya_load_firmware_to_device(struct hl_device *hdev)
 {
 	void __iomem *dst;
 
-	dst = hdev->pcie_bar[SRAM_CFG_BAR_ID] + UBOOT_FW_OFFSET;
+	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
 
-	return hl_fw_load_fw_to_device(hdev, GOYA_UBOOT_FW_FILE, dst);
+	return hl_fw_load_fw_to_device(hdev, GOYA_LINUX_FW_FILE, dst);
 }
 
 /*
- * goya_load_firmware_to_device() - Load LINUX FW code to device.
+ * goya_load_boot_fit_to_device() - Load boot fit to device.
  * @hdev: Pointer to hl_device structure.
  *
- * Copy LINUX fw code from firmware file to HBM BAR.
+ * Copy boot fit file to SRAM BAR.
  *
  * Return: 0 on success, non-zero for failure.
  */
-static int goya_load_firmware_to_device(struct hl_device *hdev)
+static int goya_load_boot_fit_to_device(struct hl_device *hdev)
 {
 	void __iomem *dst;
 
-	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
-
-	return hl_fw_load_fw_to_device(hdev, GOYA_LINUX_FW_FILE, dst);
-}
-
-static int goya_pldm_init_cpu(struct hl_device *hdev)
-{
-	u32 unit_rst_val;
-	int rc;
-
-	/* Must initialize SRAM scrambler before pushing u-boot to SRAM */
-	goya_init_golden_registers(hdev);
-
-	/* Put ARM cores into reset */
-	WREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL, CPU_RESET_ASSERT);
-	RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
+	dst = hdev->pcie_bar[SRAM_CFG_BAR_ID] + BOOT_FIT_SRAM_OFFSET;
 
-	/* Reset the CA53 MACRO */
-	unit_rst_val = RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
-	WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, CA53_RESET);
-	RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
-	WREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N, unit_rst_val);
-	RREG32(mmPSOC_GLOBAL_CONF_UNIT_RST_N);
-
-	rc = goya_push_uboot_to_device(hdev);
-	if (rc)
-		return rc;
-
-	rc = goya_load_firmware_to_device(hdev);
-	if (rc)
-		return rc;
-
-	WREG32(mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, KMD_MSG_FIT_RDY);
-	WREG32(mmPSOC_GLOBAL_CONF_WARM_REBOOT, CPU_BOOT_STATUS_NA);
-
-	WREG32(mmCPU_CA53_CFG_RST_ADDR_LSB_0,
-		lower_32_bits(SRAM_BASE_ADDR + UBOOT_FW_OFFSET));
-	WREG32(mmCPU_CA53_CFG_RST_ADDR_MSB_0,
-		upper_32_bits(SRAM_BASE_ADDR + UBOOT_FW_OFFSET));
-
-	/* Release ARM core 0 from reset */
-	WREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL,
-					CPU_RESET_CORE0_DEASSERT);
-	RREG32(mmCPU_CA53_CFG_ARM_RST_CONTROL);
-
-	return 0;
+	return hl_fw_load_fw_to_device(hdev, GOYA_BOOT_FIT_FILE, dst);
 }
 
 /*
@@ -2325,7 +2283,7 @@ static void goya_read_device_fw_version(struct hl_device *hdev,
 	}
 }
 
-static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
+static int goya_init_cpu(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	int rc;
@@ -2346,22 +2304,14 @@ static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
 		return -EIO;
 	}
 
-	if (hdev->pldm) {
-		rc = goya_pldm_init_cpu(hdev);
-		if (rc)
-			return rc;
-
-		goto out;
-	}
-
 	rc = hl_fw_init_cpu(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
 			mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, mmCPU_BOOT_ERR0,
-			false, cpu_timeout);
+			false, GOYA_CPU_TIMEOUT_USEC,
+			GOYA_BOOT_FIT_REQ_TIMEOUT_USEC);
 
 	if (rc)
 		return rc;
 
-out:
 	goya->hw_cap_initialized |= HW_CAP_CPU;
 
 	return 0;
@@ -2476,7 +2426,7 @@ static int goya_hw_init(struct hl_device *hdev)
 	 */
 	WREG32(mmHW_STATE, HL_DEVICE_HW_STATE_DIRTY);
 
-	rc = goya_init_cpu(hdev, GOYA_CPU_TIMEOUT_USEC);
+	rc = goya_init_cpu(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize CPU\n");
 		return rc;
@@ -5270,6 +5220,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_queue_id_for_cq = goya_get_queue_id_for_cq,
 	.read_device_fw_version = goya_read_device_fw_version,
 	.load_firmware_to_device = goya_load_firmware_to_device,
+	.load_boot_fit_to_device = goya_load_boot_fit_to_device,
 	.set_dma_mask_from_fw = goya_set_dma_mask_from_fw,
 	.get_device_time = goya_get_device_time
 };
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 0d3d3c59ae2b..0def1e97bc1b 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -552,6 +552,7 @@ enum hl_pll_frequency {
  * @read_device_fw_version: read the device's firmware versions that are
  *                          contained in registers
  * @load_firmware_to_device: load the firmware to the device's memory
+ * @load_boot_fit_to_device: load boot fit to device's memory
  * @set_dma_mask_from_fw: set the DMA mask in the driver according to the
  *                        firmware configuration
  * @get_device_time: Get the device time.
@@ -646,6 +647,7 @@ struct hl_asic_funcs {
 	void (*read_device_fw_version)(struct hl_device *hdev,
 					enum hl_fw_component fwc);
 	int (*load_firmware_to_device)(struct hl_device *hdev);
+	int (*load_boot_fit_to_device)(struct hl_device *hdev);
 	void (*set_dma_mask_from_fw)(struct hl_device *hdev);
 	u64 (*get_device_time)(struct hl_device *hdev);
 };
@@ -1645,7 +1647,7 @@ int hl_fw_armcp_info_get(struct hl_device *hdev);
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size);
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 boot_err0_reg, bool skip_bmc,
-			u32 cpu_timeout);
+			u32 cpu_timeout, u32 boot_fit_timeout);
 
 int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 			bool is_wc[3]);
diff --git a/drivers/misc/habanalabs/include/hl_boot_if.h b/drivers/misc/habanalabs/include/hl_boot_if.h
index 7106315fc92e..c22d134e73af 100644
--- a/drivers/misc/habanalabs/include/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/hl_boot_if.h
@@ -11,6 +11,8 @@
 #define LKD_HARD_RESET_MAGIC		0xED7BD694
 #define HL_POWER9_HOST_MAGIC		0x1DA30009
 
+#define BOOT_FIT_SRAM_OFFSET		0x200000
+
 /*
  * CPU error bits in BOOT_ERROR registers
  *
@@ -77,6 +79,7 @@ enum cpu_boot_status {
 	CPU_BOOT_STATUS_BMC_WAITING_SKIPPED, /* deprecated - will be removed */
 	/* Last boot loader progress status, ready to receive commands */
 	CPU_BOOT_STATUS_READY_TO_BOOT = 15,
+	CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT = 16,
 };
 
 enum kmd_msg {
-- 
2.17.1

