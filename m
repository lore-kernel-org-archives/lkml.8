Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882E5C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E509206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBWbqFHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgC1IxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:53:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38057 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1Iwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:52:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id f6so8670305wmj.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s99Sxt7Vl7Qm5DNFFjvXbi+1VQTeFQ8gAKNvU4YwgqQ=;
        b=VBWbqFHlhAqpIO7b7LvLV3luuLZHVrrGgfO0FdYg4xKpEKZ8Q8zr+oPrhLNnCHlNa2
         ZJOnW3loeejuesnhpVxQME02+KQHcRy1BQi2SibGVxE+QESatrF2qjnt7HvNvcypjcyY
         b4O7cXNG1QE67tIAlWAXpbFi17Kj2VnFx1S8oJziVxm+vCCVq+1I6VSy48uxooPVDMYG
         /oZ/q/5KnvBgOp9H5K/rn2nxmzAA4NqgY36ICJCIHwFzjqf66vv5ZqaeloLgr/X8FR/P
         H3VmXJ290hBFYP2SpBDUD7H/FJZR0ejIO4fLj9ALSadcQj8Qs/wEBp6S7j8LJ2jUh2Mt
         f+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s99Sxt7Vl7Qm5DNFFjvXbi+1VQTeFQ8gAKNvU4YwgqQ=;
        b=q7t7IpNr7Rv0WCLlq8pIBcxfXAD5g3EbuZxWuRJEiyNeAAJ+fiT7y6frLWYreptLOh
         5CAU+DP/mhAq5PuWXdQJPsKEKxFxugGCeeZL7X8c9JEZ//5j1B00TV+5wP+0b/Cvl9PE
         Dk1mkjc4VMZGGZy0C5WfVq8WKfcf0kx6N5wuCaF90Zg+cCAo2iqYJT3PnC9LptAhN+XG
         CnpbwxjHQ7qaH64W7BeNO+xQsLZs4b7jaXLfc+9MYugG60By7S8OxaM8B4YxjsyEAhlk
         sOeOtkcCD5NNQyrnj5LTIlqOb5LkU8LXloON5kPBPN14/cOUYnJpdz8CgXc3uzZf9cqV
         r/Rw==
X-Gm-Message-State: ANhLgQ0JBEh1Y44mo3uxckiZS/HQSbSR4yDZa6JWjrEvFOnMr9vdfqqo
        Fudst3gZVqzbvS/882d0nCA6ziko
X-Google-Smtp-Source: ADFU+vtjrXRAH76WB4BYuzWn3YuJVtMHDadCOa3rIpqXxbHZciE7MM82q4Qzd9GEWykpNt0P1Wj90g==
X-Received: by 2002:a05:600c:22c1:: with SMTP id 1mr2636318wmg.29.1585385568078;
        Sat, 28 Mar 2020 01:52:48 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k15sm11908683wrm.55.2020.03.28.01.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 01:52:47 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 4/6] habanalabs: unify and improve device cpu init
Date:   Sat, 28 Mar 2020 11:52:36 +0300
Message-Id: <20200328085238.3428-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200328085238.3428-1-oded.gabbay@gmail.com>
References: <20200328085238.3428-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code of device CPU initialization from being ASIC-Dependent to
common code. In addition, add support for the new error reporting feature
of the firmware boot code.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/firmware_if.c        | 188 ++++++++++++++++++-
 drivers/misc/habanalabs/goya/goya.c          | 116 ++----------
 drivers/misc/habanalabs/goya/goyaP.h         |   5 -
 drivers/misc/habanalabs/habanalabs.h         |  21 ++-
 drivers/misc/habanalabs/include/hl_boot_if.h |   3 +-
 5 files changed, 220 insertions(+), 113 deletions(-)

diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index f5bd03171dac..99983822feeb 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -6,20 +6,21 @@
  */
 
 #include "habanalabs.h"
+#include "include/hl_boot_if.h"
 
 #include <linux/firmware.h>
 #include <linux/genalloc.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 
 /**
- * hl_fw_push_fw_to_device() - Push FW code to device.
+ * hl_fw_load_fw_to_device() - Load F/W code to device's memory.
  * @hdev: pointer to hl_device structure.
  *
  * Copy fw code from firmware file to device memory.
  *
  * Return: 0 on success, non-zero for failure.
  */
-int hl_fw_push_fw_to_device(struct hl_device *hdev, const char *fw_name,
+int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 				void __iomem *dst)
 {
 	const struct firmware *fw;
@@ -286,3 +287,186 @@ int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 
 	return rc;
 }
+
+static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg)
+{
+	u32 err_val;
+
+	/* Some of the firmware status codes are deprecated in newer f/w
+	 * versions. In those versions, the errors are reported
+	 * in different registers. Therefore, we need to check those
+	 * registers and print the exact errors. Moreover, there
+	 * may be multiple errors, so we need to report on each error
+	 * separately. Some of the error codes might indicate a state
+	 * that is not an error per-se, but it is an error in production
+	 * environment
+	 */
+	err_val = RREG32(boot_err0_reg);
+	if (!(err_val & CPU_BOOT_ERR0_ENABLED))
+		return;
+
+	if (err_val & CPU_BOOT_ERR0_DRAM_INIT_FAIL)
+		dev_err(hdev->dev,
+			"Device boot error - DRAM initialization failed\n");
+	if (err_val & CPU_BOOT_ERR0_FIT_CORRUPTED)
+		dev_err(hdev->dev, "Device boot error - FIT image corrupted\n");
+	if (err_val & CPU_BOOT_ERR0_TS_INIT_FAIL)
+		dev_err(hdev->dev,
+			"Device boot error - Thermal Sensor initialization failed\n");
+	if (err_val & CPU_BOOT_ERR0_DRAM_SKIPPED)
+		dev_warn(hdev->dev,
+			"Device boot warning - Skipped DRAM initialization\n");
+	if (err_val & CPU_BOOT_ERR0_BMC_WAIT_SKIPPED)
+		dev_warn(hdev->dev,
+			"Device boot error - Skipped waiting for BMC\n");
+	if (err_val & CPU_BOOT_ERR0_NIC_DATA_NOT_RDY)
+		dev_err(hdev->dev,
+			"Device boot error - Serdes data from BMC not available\n");
+	if (err_val & CPU_BOOT_ERR0_NIC_FW_FAIL)
+		dev_err(hdev->dev,
+			"Device boot error - NIC F/W initialization failed\n");
+}
+
+int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
+			u32 msg_to_cpu_reg, u32 boot_err0_reg, bool skip_bmc,
+			u32 cpu_timeout)
+{
+	u32 status;
+	int rc;
+
+	dev_info(hdev->dev, "Going to wait for device boot (up to %lds)\n",
+		cpu_timeout / USEC_PER_SEC);
+
+	/* Make sure CPU boot-loader is running */
+	rc = hl_poll_timeout(
+		hdev,
+		cpu_boot_status_reg,
+		status,
+		(status == CPU_BOOT_STATUS_DRAM_RDY) ||
+		(status == CPU_BOOT_STATUS_NIC_FW_RDY) ||
+		(status == CPU_BOOT_STATUS_READY_TO_BOOT) ||
+		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
+		10000,
+		cpu_timeout);
+
+	/* Read U-Boot, preboot versions now in case we will later fail */
+	hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_UBOOT);
+	hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_PREBOOT);
+
+	/* Some of the status codes below are deprecated in newer f/w
+	 * versions but we keep them here for backward compatibility
+	 */
+	if (rc) {
+		switch (status) {
+		case CPU_BOOT_STATUS_NA:
+			dev_err(hdev->dev,
+				"Device boot error - BTL did NOT run\n");
+			break;
+		case CPU_BOOT_STATUS_IN_WFE:
+			dev_err(hdev->dev,
+				"Device boot error - Stuck inside WFE loop\n");
+			break;
+		case CPU_BOOT_STATUS_IN_BTL:
+			dev_err(hdev->dev,
+				"Device boot error - Stuck in BTL\n");
+			break;
+		case CPU_BOOT_STATUS_IN_PREBOOT:
+			dev_err(hdev->dev,
+				"Device boot error - Stuck in Preboot\n");
+			break;
+		case CPU_BOOT_STATUS_IN_SPL:
+			dev_err(hdev->dev,
+				"Device boot error - Stuck in SPL\n");
+			break;
+		case CPU_BOOT_STATUS_IN_UBOOT:
+			dev_err(hdev->dev,
+				"Device boot error - Stuck in u-boot\n");
+			break;
+		case CPU_BOOT_STATUS_DRAM_INIT_FAIL:
+			dev_err(hdev->dev,
+				"Device boot error - DRAM initialization failed\n");
+			break;
+		case CPU_BOOT_STATUS_UBOOT_NOT_READY:
+			dev_err(hdev->dev,
+				"Device boot error - u-boot stopped by user\n");
+			break;
+		case CPU_BOOT_STATUS_TS_INIT_FAIL:
+			dev_err(hdev->dev,
+				"Device boot error - Thermal Sensor initialization failed\n");
+			break;
+		default:
+			dev_err(hdev->dev,
+				"Device boot error - Invalid status code\n");
+			break;
+		}
+
+		rc = -EIO;
+		goto out;
+	}
+
+	if (!hdev->fw_loading) {
+		dev_info(hdev->dev, "Skip loading FW\n");
+		goto out;
+	}
+
+	if (status == CPU_BOOT_STATUS_SRAM_AVAIL)
+		goto out;
+
+	dev_info(hdev->dev,
+		"Loading firmware to device, may take some time...\n");
+
+	rc = hdev->asic_funcs->load_firmware_to_device(hdev);
+	if (rc)
+		goto out;
+
+	if (skip_bmc) {
+		WREG32(msg_to_cpu_reg, KMD_MSG_SKIP_BMC);
+
+		rc = hl_poll_timeout(
+			hdev,
+			cpu_boot_status_reg,
+			status,
+			(status == CPU_BOOT_STATUS_BMC_WAITING_SKIPPED),
+			10000,
+			cpu_timeout);
+
+		if (rc) {
+			dev_err(hdev->dev,
+				"Failed to get ACK on skipping BMC, %d\n",
+				status);
+			WREG32(msg_to_cpu_reg, KMD_MSG_NA);
+			rc = -EIO;
+			goto out;
+		}
+	}
+
+	WREG32(msg_to_cpu_reg, KMD_MSG_FIT_RDY);
+
+	rc = hl_poll_timeout(
+		hdev,
+		cpu_boot_status_reg,
+		status,
+		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
+		10000,
+		cpu_timeout);
+
+	if (rc) {
+		if (status == CPU_BOOT_STATUS_FIT_CORRUPTED)
+			dev_err(hdev->dev,
+				"Device reports FIT image is corrupted\n");
+		else
+			dev_err(hdev->dev,
+				"Device failed to load, %d\n", status);
+
+		WREG32(msg_to_cpu_reg, KMD_MSG_NA);
+		rc = -EIO;
+		goto out;
+	}
+
+	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
+
+out:
+	fw_read_errors(hdev, boot_err0_reg);
+
+	return rc;
+}
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index f7eb60f5f6f9..a0a96ca31757 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2223,24 +2223,24 @@ static int goya_push_uboot_to_device(struct hl_device *hdev)
 
 	dst = hdev->pcie_bar[SRAM_CFG_BAR_ID] + UBOOT_FW_OFFSET;
 
-	return hl_fw_push_fw_to_device(hdev, GOYA_UBOOT_FW_FILE, dst);
+	return hl_fw_load_fw_to_device(hdev, GOYA_UBOOT_FW_FILE, dst);
 }
 
 /*
- * goya_push_linux_to_device() - Push LINUX FW code to device.
+ * goya_load_firmware_to_device() - Load LINUX FW code to device.
  * @hdev: Pointer to hl_device structure.
  *
  * Copy LINUX fw code from firmware file to HBM BAR.
  *
  * Return: 0 on success, non-zero for failure.
  */
-static int goya_push_linux_to_device(struct hl_device *hdev)
+static int goya_load_firmware_to_device(struct hl_device *hdev)
 {
 	void __iomem *dst;
 
 	dst = hdev->pcie_bar[DDR_BAR_ID] + LINUX_FW_OFFSET;
 
-	return hl_fw_push_fw_to_device(hdev, GOYA_LINUX_FW_FILE, dst);
+	return hl_fw_load_fw_to_device(hdev, GOYA_LINUX_FW_FILE, dst);
 }
 
 static int goya_pldm_init_cpu(struct hl_device *hdev)
@@ -2266,7 +2266,7 @@ static int goya_pldm_init_cpu(struct hl_device *hdev)
 	if (rc)
 		return rc;
 
-	rc = goya_push_linux_to_device(hdev);
+	rc = goya_load_firmware_to_device(hdev);
 	if (rc)
 		return rc;
 
@@ -2291,7 +2291,7 @@ static int goya_pldm_init_cpu(struct hl_device *hdev)
  * The version string should be located by that offset.
  */
 static void goya_read_device_fw_version(struct hl_device *hdev,
-					enum goya_fw_component fwc)
+					enum hl_fw_component fwc)
 {
 	const char *name;
 	u32 ver_off;
@@ -2328,7 +2328,6 @@ static void goya_read_device_fw_version(struct hl_device *hdev,
 static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
 {
 	struct goya_device *goya = hdev->asic_specific;
-	u32 status;
 	int rc;
 
 	if (!hdev->cpu_enable)
@@ -2355,106 +2354,13 @@ static int goya_init_cpu(struct hl_device *hdev, u32 cpu_timeout)
 		goto out;
 	}
 
-	/* Make sure CPU boot-loader is running */
-	rc = hl_poll_timeout(
-		hdev,
-		mmPSOC_GLOBAL_CONF_WARM_REBOOT,
-		status,
-		(status == CPU_BOOT_STATUS_DRAM_RDY) ||
-		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
-		10000,
-		cpu_timeout);
-
-	/* Read U-Boot version now in case we will later fail */
-	goya_read_device_fw_version(hdev, FW_COMP_UBOOT);
-	goya_read_device_fw_version(hdev, FW_COMP_PREBOOT);
-
-	if (rc) {
-		dev_err(hdev->dev, "Error in ARM u-boot!");
-		switch (status) {
-		case CPU_BOOT_STATUS_NA:
-			dev_err(hdev->dev,
-				"ARM status %d - BTL did NOT run\n", status);
-			break;
-		case CPU_BOOT_STATUS_IN_WFE:
-			dev_err(hdev->dev,
-				"ARM status %d - Inside WFE loop\n", status);
-			break;
-		case CPU_BOOT_STATUS_IN_BTL:
-			dev_err(hdev->dev,
-				"ARM status %d - Stuck in BTL\n", status);
-			break;
-		case CPU_BOOT_STATUS_IN_PREBOOT:
-			dev_err(hdev->dev,
-				"ARM status %d - Stuck in Preboot\n", status);
-			break;
-		case CPU_BOOT_STATUS_IN_SPL:
-			dev_err(hdev->dev,
-				"ARM status %d - Stuck in SPL\n", status);
-			break;
-		case CPU_BOOT_STATUS_IN_UBOOT:
-			dev_err(hdev->dev,
-				"ARM status %d - Stuck in u-boot\n", status);
-			break;
-		case CPU_BOOT_STATUS_DRAM_INIT_FAIL:
-			dev_err(hdev->dev,
-				"ARM status %d - DDR initialization failed\n",
-				status);
-			break;
-		case CPU_BOOT_STATUS_UBOOT_NOT_READY:
-			dev_err(hdev->dev,
-				"ARM status %d - u-boot stopped by user\n",
-				status);
-			break;
-		case CPU_BOOT_STATUS_TS_INIT_FAIL:
-			dev_err(hdev->dev,
-				"ARM status %d - Thermal Sensor initialization failed\n",
-				status);
-			break;
-		default:
-			dev_err(hdev->dev,
-				"ARM status %d - Invalid status code\n",
-				status);
-			break;
-		}
-		return -EIO;
-	}
-
-	if (!hdev->fw_loading) {
-		dev_info(hdev->dev, "Skip loading FW\n");
-		goto out;
-	}
-
-	if (status == CPU_BOOT_STATUS_SRAM_AVAIL)
-		goto out;
+	rc = hl_fw_init_cpu(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
+			mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, mmCPU_BOOT_ERR0,
+			false, cpu_timeout);
 
-	rc = goya_push_linux_to_device(hdev);
 	if (rc)
 		return rc;
 
-	WREG32(mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, KMD_MSG_FIT_RDY);
-
-	rc = hl_poll_timeout(
-		hdev,
-		mmPSOC_GLOBAL_CONF_WARM_REBOOT,
-		status,
-		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
-		10000,
-		cpu_timeout);
-
-	if (rc) {
-		if (status == CPU_BOOT_STATUS_FIT_CORRUPTED)
-			dev_err(hdev->dev,
-				"ARM u-boot reports FIT image is corrupted\n");
-		else
-			dev_err(hdev->dev,
-				"ARM Linux failed to load, %d\n", status);
-		WREG32(mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, KMD_MSG_NA);
-		return -EIO;
-	}
-
-	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
-
 out:
 	goya->hw_cap_initialized |= HW_CAP_CPU;
 
@@ -5339,7 +5245,9 @@ static const struct hl_asic_funcs goya_funcs = {
 	.wreg = hl_wreg,
 	.halt_coresight = goya_halt_coresight,
 	.get_clk_rate = goya_get_clk_rate,
-	.get_queue_id_for_cq = goya_get_queue_id_for_cq
+	.get_queue_id_for_cq = goya_get_queue_id_for_cq,
+	.read_device_fw_version = goya_read_device_fw_version,
+	.load_firmware_to_device = goya_load_firmware_to_device
 };
 
 /*
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 5db5f6ea1d98..a05250e53175 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -149,11 +149,6 @@
 #define HW_CAP_GOLDEN		0x00000400
 #define HW_CAP_TPC		0x00000800
 
-enum goya_fw_component {
-	FW_COMP_UBOOT,
-	FW_COMP_PREBOOT
-};
-
 struct goya_device {
 	/* TODO: remove hw_queues_lock after moving to scheduler code */
 	spinlock_t	hw_queues_lock;
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 299add419e79..199f7835ae46 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -75,6 +75,16 @@ struct pgt_info {
 struct hl_device;
 struct hl_fpriv;
 
+/**
+ * enum hl_fw_component - F/W components to read version through registers.
+ * @FW_COMP_UBOOT: u-boot.
+ * @FW_COMP_PREBOOT: preboot.
+ */
+enum hl_fw_component {
+	FW_COMP_UBOOT,
+	FW_COMP_PREBOOT
+};
+
 /**
  * enum hl_queue_type - Supported QUEUE types.
  * @QUEUE_TYPE_NA: queue is not available.
@@ -539,6 +549,9 @@ enum hl_pll_frequency {
  * @halt_coresight: stop the ETF and ETR traces.
  * @get_clk_rate: Retrieve the ASIC current and maximum clock rate in MHz
  * @get_queue_id_for_cq: Get the H/W queue id related to the given CQ index.
+ * @read_device_fw_version: read the device's firmware versions that are
+ *                          contained in registers
+ * @load_firmware_to_device: load the firmware to the device's memory
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -626,6 +639,9 @@ struct hl_asic_funcs {
 	void (*halt_coresight)(struct hl_device *hdev);
 	int (*get_clk_rate)(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 	u32 (*get_queue_id_for_cq)(struct hl_device *hdev, u32 cq_idx);
+	void (*read_device_fw_version)(struct hl_device *hdev,
+					enum hl_fw_component fwc);
+	int (*load_firmware_to_device)(struct hl_device *hdev);
 };
 
 
@@ -1591,7 +1607,7 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size,
 void hl_mmu_swap_out(struct hl_ctx *ctx);
 void hl_mmu_swap_in(struct hl_ctx *ctx);
 
-int hl_fw_push_fw_to_device(struct hl_device *hdev, const char *fw_name,
+int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 				void __iomem *dst);
 int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode);
 int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
@@ -1604,6 +1620,9 @@ void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 int hl_fw_send_heartbeat(struct hl_device *hdev);
 int hl_fw_armcp_info_get(struct hl_device *hdev);
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size);
+int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
+			u32 msg_to_cpu_reg, u32 boot_err0_reg, bool skip_bmc,
+			u32 cpu_timeout);
 
 int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 			bool is_wc[3]);
diff --git a/drivers/misc/habanalabs/include/hl_boot_if.h b/drivers/misc/habanalabs/include/hl_boot_if.h
index f7992a69fd3a..107482fb45a4 100644
--- a/drivers/misc/habanalabs/include/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/hl_boot_if.h
@@ -42,7 +42,8 @@ enum cpu_boot_status {
 enum kmd_msg {
 	KMD_MSG_NA = 0,
 	KMD_MSG_GOTO_WFE,
-	KMD_MSG_FIT_RDY
+	KMD_MSG_FIT_RDY,
+	KMD_MSG_SKIP_BMC,
 };
 
 #endif /* HL_BOOT_IF_H */
-- 
2.17.1

