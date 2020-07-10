Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1262DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB362078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gio0Yw0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgGJRgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJRgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:36:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F53C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:36:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so6957771wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=8ius2FrGbGFf4wMDOu6b1cRlUlaWfoyCD+orQvXLx/k=;
        b=gio0Yw0+ydVNgwun800mc1CGLVtcmWr9QmKqlltlnfS3OSTCOH8NpiMRS6IGi984FF
         Z83ID6N/z13xnj/OozOR606D5q6JtP7vLWG8uJ6pOGag130iNmZgcXDEjHHYBtAXDSvp
         qughB/b2wAPfUTfihMllGAsG1Jxqt7Pp6vBL1ud4n4jreaB2t7fwVq934O2/T+zeGlLR
         BSr9wIzTvEWzvqzHII6ue5phjnTcSFpe9qfzWvVkO2GwT73riVTnjQ1i/jpeCgrEdFYk
         NS6nLKEBuz9bXkTnoo5iC5oEf4SNrFOmze+zIS0d2gFSYHdkZur9vgTWJIjxbXKRieOl
         G8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=8ius2FrGbGFf4wMDOu6b1cRlUlaWfoyCD+orQvXLx/k=;
        b=uEHvdGkv8utPol0LvR2F+7EEoK+PKPL9WwhZWw2PjZ7RFCpG0ITTrM73QxuXkPkG+p
         ccpldyyPW+AkVpqFObLqIFLQoaF0J4oyBq+M8loqYT4lQxOue9+2BdjGHNlqsrl0y15A
         WsoShZQvkQFHReCShx0WPRwj3Snz11zLmsAL1RQh4TRL8GqYtu1XwXzx1/73W0ZZgHAP
         +Mh1546EbA2j3aMUlzk3wRo+fkdaGTbyQJSDUx6j39tpLDyFFLdo0COqDiFEDOQuf/vw
         8L3LA0026ICR+HZ0rdyi1meFgMGNzQS1slr+QbVCTlja/3MZVhHGUHF1P4fZG1P4l7kZ
         YCrQ==
X-Gm-Message-State: AOAM530i6NxBNmiArdTlqR9WXRvyh1eIAiuPZQl8sV0iVzpyyCObqKjZ
        Rhy8zlN0bS96vWbJ0f9XjV9m+WXK
X-Google-Smtp-Source: ABdhPJyZbm2BmAau9bf0Nn/s9H79XySWy+wot38O+u8jB1RtxI8yQhwAmZ2+LnjNYS8RI3UZ0JE5ww==
X-Received: by 2002:a05:600c:4109:: with SMTP id j9mr5980418wmi.157.1594402608055;
        Fri, 10 Jul 2020 10:36:48 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id n16sm9903857wmc.40.2020.07.10.10.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 10:36:47 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 1/4] habanalabs: halt device CPU only upon certain reset
Date:   Fri, 10 Jul 2020 20:36:49 +0300
Message-Id: <20200710173652.31039-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver halts the device CPU in the halt engines function,
which halts all the engines of the ASIC. The problem is that if later on we
stop the reset process (due to inability to clean memory mappings in time),
the CPU will remain in halt mode. This creates many issues, such as
thermal/power control and FLR handling.

Therefore, move the halting of the device CPU to the very end of the reset
process, just before writing to the registers to initiate the reset. In
addition, the driver now needs to send a message to the device F/W to
disable it from sending interrupts to the host machine because during halt
engines function the driver disables the MSI/MSI-X interrupts.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c              | 16 ++++++++
 drivers/misc/habanalabs/gaudi/gaudi.c         | 40 +++++++++++--------
 drivers/misc/habanalabs/goya/goya.c           | 38 +++++++++---------
 .../include/gaudi/asic_reg/gaudi_regs.h       |  1 +
 .../habanalabs/include/gaudi/gaudi_masks.h    |  3 ++
 5 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 65a5a5c52a48..df709767c7ea 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -838,6 +838,22 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		if (rc)
 			return 0;
 
+		if (hard_reset) {
+			/* Disable PCI access from device F/W so he won't send
+			 * us additional interrupts. We disable MSI/MSI-X at
+			 * the halt_engines function and we can't have the F/W
+			 * sending us interrupts after that. We need to disable
+			 * the access here because if the device is marked
+			 * disable, the message won't be send. Also, in case
+			 * of heartbeat, the device CPU is marked as disable
+			 * so this message won't be sent
+			 */
+			if (hl_fw_send_pci_access_msg(hdev,
+					ARMCP_PACKET_DISABLE_PCI_ACCESS))
+				dev_warn(hdev->dev,
+					"Failed to disable PCI access by F/W\n");
+		}
+
 		/* This also blocks future CS/VM/JOB completion operations */
 		hdev->disabled = true;
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 7eee4a10154b..a9fd3d352ef0 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2578,27 +2578,16 @@ static void gaudi_disable_timestamp(struct hl_device *hdev)
 
 static void gaudi_halt_engines(struct hl_device *hdev, bool hard_reset)
 {
-	u32 wait_timeout_ms, cpu_timeout_ms;
+	u32 wait_timeout_ms;
 
 	dev_info(hdev->dev,
 		"Halting compute engines and disabling interrupts\n");
 
-	if (hdev->pldm) {
+	if (hdev->pldm)
 		wait_timeout_ms = GAUDI_PLDM_RESET_WAIT_MSEC;
-		cpu_timeout_ms = GAUDI_PLDM_RESET_WAIT_MSEC;
-	} else {
+	else
 		wait_timeout_ms = GAUDI_RESET_WAIT_MSEC;
-		cpu_timeout_ms = GAUDI_CPU_RESET_WAIT_MSEC;
-	}
 
-	/*
-	 * I don't know what is the state of the CPU so make sure it is
-	 * stopped in any means necessary
-	 */
-	WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
-	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
-			GAUDI_EVENT_HALT_MACHINE);
-	msleep(cpu_timeout_ms);
 
 	gaudi_stop_mme_qmans(hdev);
 	gaudi_stop_tpc_qmans(hdev);
@@ -2966,17 +2955,34 @@ static int gaudi_hw_init(struct hl_device *hdev)
 static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u32 status, reset_timeout_ms, boot_strap = 0;
+	u32 status, reset_timeout_ms, cpu_timeout_ms, boot_strap = 0;
 
 	if (!hard_reset) {
 		dev_err(hdev->dev, "GAUDI doesn't support soft-reset\n");
 		return;
 	}
 
-	if (hdev->pldm)
+	if (hdev->pldm) {
 		reset_timeout_ms = GAUDI_PLDM_HRESET_TIMEOUT_MSEC;
-	else
+		cpu_timeout_ms = GAUDI_PLDM_RESET_WAIT_MSEC;
+	} else {
 		reset_timeout_ms = GAUDI_RESET_TIMEOUT_MSEC;
+		cpu_timeout_ms = GAUDI_CPU_RESET_WAIT_MSEC;
+	}
+
+	/* Set device to handle FLR by H/W as we will put the device CPU to
+	 * halt mode
+	 */
+	WREG32(mmPCIE_AUX_FLR_CTRL, (PCIE_AUX_FLR_CTRL_HW_CTRL_MASK |
+					PCIE_AUX_FLR_CTRL_INT_MASK_MASK));
+
+	/* I don't know what is the state of the CPU so make sure it is
+	 * stopped in any means necessary
+	 */
+	WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
+	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR, GAUDI_EVENT_HALT_MACHINE);
+
+	msleep(cpu_timeout_ms);
 
 	/* Tell ASIC not to re-initialize PCIe */
 	WREG32(mmPREBOOT_PCIE_EN, LKD_HARD_RESET_MAGIC);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 36db771f391c..2b0937d950c1 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2240,29 +2240,15 @@ static void goya_disable_timestamp(struct hl_device *hdev)
 
 static void goya_halt_engines(struct hl_device *hdev, bool hard_reset)
 {
-	u32 wait_timeout_ms, cpu_timeout_ms;
+	u32 wait_timeout_ms;
 
 	dev_info(hdev->dev,
 		"Halting compute engines and disabling interrupts\n");
 
-	if (hdev->pldm) {
+	if (hdev->pldm)
 		wait_timeout_ms = GOYA_PLDM_RESET_WAIT_MSEC;
-		cpu_timeout_ms = GOYA_PLDM_RESET_WAIT_MSEC;
-	} else {
+	else
 		wait_timeout_ms = GOYA_RESET_WAIT_MSEC;
-		cpu_timeout_ms = GOYA_CPU_RESET_WAIT_MSEC;
-	}
-
-	if (hard_reset) {
-		/*
-		 * I don't know what is the state of the CPU so make sure it is
-		 * stopped in any means necessary
-		 */
-		WREG32(mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, KMD_MSG_GOTO_WFE);
-		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
-			GOYA_ASYNC_EVENT_ID_HALT_MACHINE);
-		msleep(cpu_timeout_ms);
-	}
 
 	goya_stop_external_queues(hdev);
 	goya_stop_internal_queues(hdev);
@@ -2567,14 +2553,26 @@ static int goya_hw_init(struct hl_device *hdev)
 static void goya_hw_fini(struct hl_device *hdev, bool hard_reset)
 {
 	struct goya_device *goya = hdev->asic_specific;
-	u32 reset_timeout_ms, status;
+	u32 reset_timeout_ms, cpu_timeout_ms, status;
 
-	if (hdev->pldm)
+	if (hdev->pldm) {
 		reset_timeout_ms = GOYA_PLDM_RESET_TIMEOUT_MSEC;
-	else
+		cpu_timeout_ms = GOYA_PLDM_RESET_WAIT_MSEC;
+	} else {
 		reset_timeout_ms = GOYA_RESET_TIMEOUT_MSEC;
+		cpu_timeout_ms = GOYA_CPU_RESET_WAIT_MSEC;
+	}
 
 	if (hard_reset) {
+		/* I don't know what is the state of the CPU so make sure it is
+		 * stopped in any means necessary
+		 */
+		WREG32(mmPSOC_GLOBAL_CONF_UBOOT_MAGIC, KMD_MSG_GOTO_WFE);
+		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
+			GOYA_ASYNC_EVENT_ID_HALT_MACHINE);
+
+		msleep(cpu_timeout_ms);
+
 		goya_set_ddr_bar_base(hdev, DRAM_PHYS_BASE);
 		goya_disable_clk_rlx(hdev);
 		goya_set_pll_refclk(hdev);
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
index 0c75d43532bd..f92dc53af074 100644
--- a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
@@ -292,6 +292,7 @@
 
 #define mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG                           0xC02000
 
+#define mmPCIE_AUX_FLR_CTRL                                          0xC07394
 #define mmPCIE_AUX_DBI                                               0xC07490
 
 #endif /* ASIC_REG_GAUDI_REGS_H_ */
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
index 96f08050ef0f..13ef6b2887fd 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
@@ -455,4 +455,7 @@ enum axi_id {
 					QM_ARB_ERR_MSG_EN_CHOISE_WDT_MASK |\
 					QM_ARB_ERR_MSG_EN_AXI_LBW_ERR_MASK)
 
+#define PCIE_AUX_FLR_CTRL_HW_CTRL_MASK                               0x1
+#define PCIE_AUX_FLR_CTRL_INT_MASK_MASK                              0x2
+
 #endif /* GAUDI_MASKS_H_ */
-- 
2.17.1

