Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3288DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A1E2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAPlaxkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgHVQXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgHVQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:23:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371B6C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:23:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w13so4335354wrk.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YBHQbz6tP7HMJI4IlagRQ30r9ZUCoJa8bvtTuA7LR0o=;
        b=BAPlaxkkA3lfeMFCsiMl1nWqJ3myz1uBazp6HIn5Ry1BZxbbMa1zzzpdiDinA+2yPK
         qcguT+WsDXlhv2foZLUsTVMtH7ID0viJmP1xY1naDjELsP8FWe2WQrlpeNuigXednQhG
         j/giza/TfTTQuIHvJPWEQMlJrx2qbY41OFCuPBwjR2bOHw5BItvc8HkkmhHpuXkEjMQj
         jR3A4+i/crYvz1Em0s5Sk8gUVwup1YOGZoD1rHsNuh4NCWPka7ymurcwzysqgYZ9usXl
         DHEFDCUvry1Cetpsd//eSd5EcFO6DCXgkScqv1qanIGDs6XI4BA4mqbn6VldV6/iIVdC
         N25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YBHQbz6tP7HMJI4IlagRQ30r9ZUCoJa8bvtTuA7LR0o=;
        b=awqgp35CFrmInBFbdZNRfJ/FvaxmWtKAE6JJFbtd4ywwu2K/qMczdy6gOkM4spVudT
         YtNrsWbWNedQinZwSu1k0Zq7rQw3eRIK/IgLwYsps5wvlAF/JhLFhLHTx+wsd6/OmOG0
         3kXCnxJ+hsF0h0xhctGcMZ7qjvUgOpzW06MkEmo1sW+kCrh8QrFDJyD82O0RterbcROT
         T79XGlq8JERYZWRrlEcLJZC/5UzIQFNfJIiPiJ9nq51So3Ibw03sswCmA7ayk4LblWeq
         GyO9jwgNWVzcLX+0cY/6jiGx6de4PN5TgNm/9CjbvPJGDHuwziCrAezaKADIWo3YHwOo
         77sw==
X-Gm-Message-State: AOAM532r2YWqwEjpHary4aJnjfxziqdnSj6FW93M9EQmN8Fzkdg4K2w5
        6WDziqKBeQSWBv7t6dBVTalLdxBXGls=
X-Google-Smtp-Source: ABdhPJzgkulwcO8f8EWI3hWUoiSlcja3bMBgA9gowkDMZQsYk2Kmoh4H8FElZ/okvkYMf33PB/V71g==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr7414762wrq.131.1598113418981;
        Sat, 22 Aug 2020 09:23:38 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id n205sm1359227wma.47.2020.08.22.09.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 09:23:37 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 1/2] habanalabs: add support for getting device total energy
Date:   Sat, 22 Aug 2020 19:23:34 +0300
Message-Id: <20200822162335.21295-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Add driver implementation for reading the total energy consumption
from the device ARM FW.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 24 +++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  2 ++
 .../misc/habanalabs/common/habanalabs_ioctl.c | 24 +++++++++++++++++++
 .../misc/habanalabs/include/common/armcp_if.h |  1 +
 include/uapi/misc/habanalabs.h                | 10 ++++++++
 5 files changed, 61 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 0842c2211475..d15db03c79a4 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -402,6 +402,30 @@ int hl_fw_armcp_pci_counters_get(struct hl_device *hdev,
 	return rc;
 }
 
+int hl_fw_armcp_total_energy_get(struct hl_device *hdev,
+			u64 *total_energy)
+{
+	struct armcp_packet pkt = {};
+	long result;
+	int rc;
+
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_TOTAL_ENERGY_GET <<
+			ARMCP_PKT_CTL_OPCODE_SHIFT);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					HL_ARMCP_INFO_TIMEOUT_USEC, &result);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to handle ArmCP total energy pkt, error %d\n",
+				rc);
+		return rc;
+	}
+
+	*total_energy = result;
+
+	return rc;
+}
+
 static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg)
 {
 	u32 err_val;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 0a422fd742e9..f912e344ed33 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1849,6 +1849,8 @@ int hl_fw_armcp_info_get(struct hl_device *hdev);
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size);
 int hl_fw_armcp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters);
+int hl_fw_armcp_total_energy_get(struct hl_device *hdev,
+			u64 *total_energy);
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
 			u32 boot_err0_reg, bool skip_bmc,
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index a94800014243..18ee14b4b0e1 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -357,6 +357,27 @@ static int sync_manager_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 			sizeof(sm_info))) ? -EFAULT : 0;
 }
 
+static int total_energy_consumption_info(struct hl_fpriv *hpriv,
+			struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_info_energy total_energy = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	int rc;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	rc = hl_fw_armcp_total_energy_get(hdev,
+			&total_energy.total_energy_consumption);
+	if (rc)
+		return rc;
+
+	return copy_to_user(out, &total_energy,
+		min((size_t) max_size, sizeof(total_energy))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -429,6 +450,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_SYNC_MANAGER:
 		return sync_manager_info(hpriv, args);
 
+	case HL_INFO_TOTAL_ENERGY:
+		return total_energy_consumption_info(hpriv, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/drivers/misc/habanalabs/include/common/armcp_if.h b/drivers/misc/habanalabs/include/common/armcp_if.h
index 1403c937253c..4d78898524e9 100644
--- a/drivers/misc/habanalabs/include/common/armcp_if.h
+++ b/drivers/misc/habanalabs/include/common/armcp_if.h
@@ -245,6 +245,7 @@ enum armcp_packet_id {
 	ARMCP_PACKET_CURRENT_SET,		/* sysfs */
 	ARMCP_PACKET_PCIE_THROUGHPUT_GET,	/* internal */
 	ARMCP_PACKET_PCIE_REPLAY_CNT_GET,	/* internal */
+	ARMCP_PACKET_TOTAL_ENERGY_GET,		/* internal */
 };
 
 #define ARMCP_PACKET_FENCE_VAL	0xFE8CE7A5
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 693081728ef3..6803991726e8 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -267,6 +267,7 @@ enum hl_device_status {
  * HL_INFO_PCI_COUNTERS  - Retrieve PCI counters
  * HL_INFO_CLK_THROTTLE_REASON - Retrieve clock throttling reason
  * HL_INFO_SYNC_MANAGER  - Retrieve sync manager info per dcore
+ * HL_INFO_TOTAL_ENERGY  - Retrieve total energy consumption
  */
 #define HL_INFO_HW_IP_INFO		0
 #define HL_INFO_HW_EVENTS		1
@@ -282,6 +283,7 @@ enum hl_device_status {
 #define HL_INFO_PCI_COUNTERS		12
 #define HL_INFO_CLK_THROTTLE_REASON	13
 #define HL_INFO_SYNC_MANAGER		14
+#define HL_INFO_TOTAL_ENERGY		15
 
 #define HL_INFO_VERSION_MAX_LEN	128
 #define HL_INFO_CARD_NAME_MAX_LEN	16
@@ -375,6 +377,14 @@ struct hl_info_clk_throttle {
 	__u32 clk_throttling_reason;
 };
 
+/**
+ * struct hl_info_energy - device energy information
+ * @total_energy_consumption: total device energy consumption
+ */
+struct hl_info_energy {
+	__u64 total_energy_consumption;
+};
+
 /**
  * struct hl_info_sync_manager - sync manager information
  * @first_available_sync_object: first available sob
-- 
2.17.1

