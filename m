Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C44C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97C7214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnvkCkY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgDRIYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgDRIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:24:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB1EC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:24:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g12so5330701wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1HC5QHmx4EXeadD9fnXSlLAgiCvJSjtGg8AUlH5lh08=;
        b=qnvkCkY/hA7wDvs9TW0YW8eaHPmXfa6VUbTLKP0hPDIyzONqIx5KOTb6/L/bK0y1vz
         hs3FKSp49snDNYWxwfdIN0x1kJQbrulAcLNYSsPP03N8cxRFrGPth5Ox+rdYmXg3F5wB
         wLPiyUDMhjunVLvt9MxwAGIleHq5SbTDMSEJWlbdGQ4ydRqgerqgJkyouZcBHd67xQNq
         JnH6XEqJEVdKD7uVsR7pvVdVUy7Ka4R9KiN/hVyckAXq48XS55Ehj2QlZTrcbbU2uX+y
         6NVagdhgrlQszwRaAyktYBRFX7fX8S5qKSA55RhGBq1rwBn+EtAfaRmYgKcJ2QJ5eULU
         9Wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1HC5QHmx4EXeadD9fnXSlLAgiCvJSjtGg8AUlH5lh08=;
        b=OurP9W75f4N3HjbiPrZSN/tZPz1WTchR6iTk1zMd3oVKmOzQ3NeiqPgmS2D5oP+Whk
         fXM1XLcdqSAxqvCi0QMsV3gbe/dtZhIOx85RLiMVlYwQrzvMPt/DobiTU1D2LKOzkqmO
         n9loFZ3WaH1NcBvDNyjmmAS+OfsMA3uRXe+YrD3oPuawSFBLLYV5a+M1l6a5RIDeDBH6
         Okyhu4A9j49Jf1RLxVbiLt/bgjqBYzkXe4bQIceWt3cAtc7b4cti+HtKR4IVAziK/Dul
         RrQOIc+E4skm4o94BUU1qfii4KPNKXFU7RZ7CXj1iX5ED7ZN4QCnKHv3YPkxkWqVo6Bx
         kSGQ==
X-Gm-Message-State: AGi0PuboN3Gf0xoz65uytPCo7I7p//nRdf5C+iOCuXb+UDJCnzuP2pKX
        NCZS7jFWWS17xSkP+Ot5TActDhA4
X-Google-Smtp-Source: APiQypJBm7qjbdz1Slf4nlkt4a4Gf6QiLTlmbOFnMN+nQ3/+ook661xq4mUxVUZ5XYhoKjsCyiToyw==
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr7351248wmc.11.1587198286082;
        Sat, 18 Apr 2020 01:24:46 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c190sm10898087wme.4.2020.04.18.01.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 01:24:44 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/5] habanalabs: Add INFO IOCTL opcode for time sync information
Date:   Sat, 18 Apr 2020 11:24:36 +0300
Message-Id: <20200418082440.21277-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Add a new opcode to the INFO IOCTL that retrieves the device time
alongside the host time, to allow a user application that want to measure
device time together with host time (such as a profiler) to synchronize
these times.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c           | 10 +++-
 drivers/misc/habanalabs/goya/goyaP.h          |  1 +
 drivers/misc/habanalabs/habanalabs.h          |  2 +
 drivers/misc/habanalabs/habanalabs_ioctl.c    | 19 +++++++
 .../include/goya/asic_reg/goya_regs.h         |  1 +
 .../goya/asic_reg/psoc_timestamp_regs.h       | 56 +++++++++++++++++++
 include/uapi/misc/habanalabs.h                |  8 +++
 7 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_timestamp_regs.h

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 19c3bdf4c358..ddc506d74988 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5200,6 +5200,13 @@ static void goya_set_dma_mask_from_fw(struct hl_device *hdev)
 	}
 }
 
+u64 goya_get_device_time(struct hl_device *hdev)
+{
+	u64 device_time = ((u64) RREG32(mmPSOC_TIMESTAMP_CNTCVU)) << 32;
+
+	return device_time | RREG32(mmPSOC_TIMESTAMP_CNTCVL);
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5263,7 +5270,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_queue_id_for_cq = goya_get_queue_id_for_cq,
 	.read_device_fw_version = goya_read_device_fw_version,
 	.load_firmware_to_device = goya_load_firmware_to_device,
-	.set_dma_mask_from_fw = goya_set_dma_mask_from_fw
+	.set_dma_mask_from_fw = goya_set_dma_mask_from_fw,
+	.get_device_time = goya_get_device_time
 };
 
 /*
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 86857cdd36b1..d36f8d90c9c9 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -231,5 +231,6 @@ void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev);
 
 int goya_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 u32 goya_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx);
+u64 goya_get_device_time(struct hl_device *hdev);
 
 #endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 8db955485609..a8ee241b2fce 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -554,6 +554,7 @@ enum hl_pll_frequency {
  * @load_firmware_to_device: load the firmware to the device's memory
  * @set_dma_mask_from_fw: set the DMA mask in the driver according to the
  *                        firmware configuration
+ * @get_device_time: Get the device time.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -646,6 +647,7 @@ struct hl_asic_funcs {
 					enum hl_fw_component fwc);
 	int (*load_firmware_to_device)(struct hl_device *hdev);
 	void (*set_dma_mask_from_fw)(struct hl_device *hdev);
+	u64 (*get_device_time)(struct hl_device *hdev);
 };
 
 
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 6474b868ef27..f5993698d315 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -258,6 +258,22 @@ static int get_reset_count(struct hl_device *hdev, struct hl_info_args *args)
 		min((size_t) max_size, sizeof(reset_count))) ? -EFAULT : 0;
 }
 
+static int time_sync_info(struct hl_device *hdev, struct hl_info_args *args)
+{
+	struct hl_info_time_sync time_sync = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	time_sync.device_time = hdev->asic_funcs->get_device_time(hdev);
+	time_sync.host_time = ktime_get_raw_ns();
+
+	return copy_to_user(out, &time_sync,
+		min((size_t) max_size, sizeof(time_sync))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -315,6 +331,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 		rc = get_clk_rate(hdev, args);
 		break;
 
+	case HL_INFO_TIME_SYNC:
+		return time_sync_info(hdev, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
index fce490e6a231..ce65c9da5c60 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
@@ -18,6 +18,7 @@
 #include "psoc_mme_pll_regs.h"
 #include "psoc_pci_pll_regs.h"
 #include "psoc_emmc_pll_regs.h"
+#include "psoc_timestamp_regs.h"
 #include "cpu_if_regs.h"
 #include "cpu_ca53_cfg_regs.h"
 #include "cpu_pll_regs.h"
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/psoc_timestamp_regs.h b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_timestamp_regs.h
new file mode 100644
index 000000000000..9ce24597d4b0
--- /dev/null
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/psoc_timestamp_regs.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2018 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+/************************************
+ ** This is an auto-generated file **
+ **       DO NOT EDIT BELOW        **
+ ************************************/
+
+#ifndef ASIC_REG_PSOC_TIMESTAMP_REGS_H_
+#define ASIC_REG_PSOC_TIMESTAMP_REGS_H_
+
+/*
+ *****************************************
+ *   PSOC_TIMESTAMP (Prototype: TIMESTAMP)
+ *****************************************
+ */
+
+#define mmPSOC_TIMESTAMP_CNTCR                                       0xC49000
+
+#define mmPSOC_TIMESTAMP_CNTSR                                       0xC49004
+
+#define mmPSOC_TIMESTAMP_CNTCVL                                      0xC49008
+
+#define mmPSOC_TIMESTAMP_CNTCVU                                      0xC4900C
+
+#define mmPSOC_TIMESTAMP_CNTFID0                                     0xC49020
+
+#define mmPSOC_TIMESTAMP_PIDR4                                       0xC49FD0
+
+#define mmPSOC_TIMESTAMP_PIDR5                                       0xC49FD4
+
+#define mmPSOC_TIMESTAMP_PIDR6                                       0xC49FD8
+
+#define mmPSOC_TIMESTAMP_PIDR7                                       0xC49FDC
+
+#define mmPSOC_TIMESTAMP_PIDR0                                       0xC49FE0
+
+#define mmPSOC_TIMESTAMP_PIDR1                                       0xC49FE4
+
+#define mmPSOC_TIMESTAMP_PIDR2                                       0xC49FE8
+
+#define mmPSOC_TIMESTAMP_PIDR3                                       0xC49FEC
+
+#define mmPSOC_TIMESTAMP_CIDR0                                       0xC49FF0
+
+#define mmPSOC_TIMESTAMP_CIDR1                                       0xC49FF4
+
+#define mmPSOC_TIMESTAMP_CIDR2                                       0xC49FF8
+
+#define mmPSOC_TIMESTAMP_CIDR3                                       0xC49FFC
+
+#endif /* ASIC_REG_PSOC_TIMESTAMP_REGS_H_ */
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 4faa2c9767e5..4d593050c42b 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -101,6 +101,8 @@ enum hl_device_status {
  * HL_INFO_RESET_COUNT   - Retrieve the counts of the soft and hard reset
  *                         operations performed on the device since the last
  *                         time the driver was loaded.
+ * HL_INFO_TIME_SYNC     - Retrieve the device's time alongside the host's time
+ *                         for synchronization.
  */
 #define HL_INFO_HW_IP_INFO		0
 #define HL_INFO_HW_EVENTS		1
@@ -111,6 +113,7 @@ enum hl_device_status {
 #define HL_INFO_HW_EVENTS_AGGREGATE	7
 #define HL_INFO_CLK_RATE		8
 #define HL_INFO_RESET_COUNT		9
+#define HL_INFO_TIME_SYNC		10
 
 #define HL_INFO_VERSION_MAX_LEN	128
 #define HL_INFO_CARD_NAME_MAX_LEN	16
@@ -169,6 +172,11 @@ struct hl_info_reset_count {
 	__u32 soft_reset_cnt;
 };
 
+struct hl_info_time_sync {
+	__u64 device_time;
+	__u64 host_time;
+};
+
 struct hl_info_args {
 	/* Location of relevant struct in userspace */
 	__u64 return_pointer;
-- 
2.17.1

