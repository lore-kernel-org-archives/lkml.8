Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0686EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02F720738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkaLrT2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHCLrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHCLoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:44:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490EEC061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 04:44:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a5so23931898wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wktAXltXvw+OcOM7RYbNsAn2eLrVA+oJrzBSiLVt/V0=;
        b=rkaLrT2R+413cMnXQSy3VNCm9Nq/WBVIhwd+EDbkxcmEJY4uUXRoP1RZ9+0ROn1AcK
         YQbElyabChQlEQ73N5zmCKTeNxPe4TlZULeCzZ2jl8OXePossA6Rq5ZJ1OVlmY5z9ET1
         orORHgh0b77urWJ6y7CbzJqkdbGb1e5kP3CSEsUY00v3c4XNBk5JzBL+2dmHS5TvSxYc
         MJ0elmZ6eIMiFXPLeGXV+T9B56fTO06/HHB+4hVj0j1f002EIMwIKmbXnujEISUzpOfH
         DqxovOKa8GVmmBrXg78TZyjVO1+/ODPZof+JHXpxDQUlS9WizZQ8Fxn834l7UTn9gHIA
         RImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wktAXltXvw+OcOM7RYbNsAn2eLrVA+oJrzBSiLVt/V0=;
        b=ntaq2Ga9k0qaHjWqwPwcJvE7MClfLLgb86MOB1pFc3RITJziCrKakvX+xwWPZfat5t
         lWrDCnFHQ9pBOEUMuePzeQfgfiaupPU268AxCMn36cZtzNVrXm5HoQ/DBdLqiaXxmQPt
         iFoegkrUr9K0N9t3oVgSNk6ago8HOrMxOsTuV9Zb3Nb4udhwwEx3FnyxevtHMPFrB/Wh
         iZ53xtkKhCc+36BIpWg8eKA+zOfkcavJcHxQBHxWOi6Vca70QeyOk2kNjSH/0XMMnQ9F
         0whSfQAs41buySbAsdueHezq05CeNZWvi3HT8mRaxgdQDpYmxFGZJdU23HDczb6AYmbU
         Mmlw==
X-Gm-Message-State: AOAM530bN1PFGhoUYmj/LX84gOA2onHxa6Da3VC90ZRQ6wGG28FlSG6v
        lsT0OLuC7wu5GJjEjTydEtqrJHVF
X-Google-Smtp-Source: ABdhPJzVqxe6f9eqD/c+WSr4c0lJ/wQR9BJw1a3ePbUWctwUz4KbcITx+v9/0j7vCQxjaKBHP6cVtg==
X-Received: by 2002:a5d:6348:: with SMTP id b8mr14646045wrw.362.1596455049138;
        Mon, 03 Aug 2020 04:44:09 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 128sm24155441wmz.43.2020.08.03.04.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 04:44:07 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH v2 2/2] habanalabs: add information about PCIe controller
Date:   Mon,  3 Aug 2020 14:44:02 +0300
Message-Id: <20200803114402.26013-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200803114402.26013-1-oded.gabbay@gmail.com>
References: <20200803114402.26013-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Update firmware header with new API for getting pcie info
such as tx/rx throughput and replay counter.
These counters are needed by customers for monitor and maintenance
of multiple devices.
Add new opcodes to the INFO ioctl to retrieve these counters.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
  - Properly cast message variables sent to device CPU when fetching
    PCI throughput counters

 drivers/misc/habanalabs/common/firmware_if.c  | 48 +++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  4 ++
 .../misc/habanalabs/common/habanalabs_ioctl.c | 41 ++++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudi.c         |  4 ++
 drivers/misc/habanalabs/goya/goya.c           |  4 ++
 .../misc/habanalabs/include/common/armcp_if.h | 10 ++++
 include/uapi/misc/habanalabs.h                | 27 +++++++++++
 7 files changed, 138 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index f70302cdab1b..0842c2211475 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -354,6 +354,54 @@ int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 	return rc;
 }
 
+int hl_fw_armcp_pci_counters_get(struct hl_device *hdev,
+		struct hl_info_pci_counters *counters)
+{
+	struct armcp_packet pkt = {};
+	long result;
+	int rc;
+
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_PCIE_THROUGHPUT_GET <<
+			ARMCP_PKT_CTL_OPCODE_SHIFT);
+
+	/* Fetch PCI rx counter */
+	pkt.index = cpu_to_le32(armcp_pcie_throughput_rx);
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					HL_ARMCP_INFO_TIMEOUT_USEC, &result);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to handle ArmCP PCI info pkt, error %d\n", rc);
+		return rc;
+	}
+	counters->rx_throughput = result;
+
+	/* Fetch PCI tx counter */
+	pkt.index = cpu_to_le32(armcp_pcie_throughput_tx);
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					HL_ARMCP_INFO_TIMEOUT_USEC, &result);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to handle ArmCP PCI info pkt, error %d\n", rc);
+		return rc;
+	}
+	counters->tx_throughput = result;
+
+	/* Fetch PCI replay counter */
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_PCIE_REPLAY_CNT_GET <<
+			ARMCP_PKT_CTL_OPCODE_SHIFT);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+			HL_ARMCP_INFO_TIMEOUT_USEC, &result);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to handle ArmCP PCI info pkt, error %d\n", rc);
+		return rc;
+	}
+	counters->replay_cnt = (u32) result;
+
+	return rc;
+}
+
 static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg)
 {
 	u32 err_val;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6df9db821a31..942f7e52f1a2 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1481,6 +1481,7 @@ struct hl_device_idle_busy_ts {
  * @soft_reset_cnt: number of soft reset since the driver was loaded.
  * @hard_reset_cnt: number of hard reset since the driver was loaded.
  * @idle_busy_ts_idx: index of current entry in idle_busy_ts_arr
+ * @clk_throttling_reason: bitmask represents the current clk throttling reasons
  * @id: device minor.
  * @id_control: minor of the control device
  * @cpu_pci_msb_addr: 50-bit extension bits for the device CPU's 40-bit
@@ -1584,6 +1585,7 @@ struct hl_device {
 	u32				soft_reset_cnt;
 	u32				hard_reset_cnt;
 	u32				idle_busy_ts_idx;
+	u32				clk_throttling_reason;
 	u16				id;
 	u16				id_control;
 	u16				cpu_pci_msb_addr;
@@ -1838,6 +1840,8 @@ void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 int hl_fw_send_heartbeat(struct hl_device *hdev);
 int hl_fw_armcp_info_get(struct hl_device *hdev);
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size);
+int hl_fw_armcp_pci_counters_get(struct hl_device *hdev,
+		struct hl_info_pci_counters *counters);
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
 			u32 boot_err0_reg, bool skip_bmc,
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 5af1c03da473..4d838b1a3bbe 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -276,6 +276,41 @@ static int time_sync_info(struct hl_device *hdev, struct hl_info_args *args)
 		min((size_t) max_size, sizeof(time_sync))) ? -EFAULT : 0;
 }
 
+static int pci_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_info_pci_counters pci_counters = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	int rc;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	rc = hl_fw_armcp_pci_counters_get(hdev, &pci_counters);
+	if (rc)
+		return rc;
+
+	return copy_to_user(out, &pci_counters,
+		min((size_t) max_size, sizeof(pci_counters))) ? -EFAULT : 0;
+}
+
+static int clk_throttle_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	struct hl_info_clk_throttle clk_throttle = {0};
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	clk_throttle.clk_throttling_reason = hdev->clk_throttling_reason;
+
+	return copy_to_user(out, &clk_throttle,
+		min((size_t) max_size, sizeof(clk_throttle))) ? -EFAULT : 0;
+}
+
 static int cs_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
@@ -360,6 +395,12 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_CS_COUNTERS:
 		return cs_counters_info(hpriv, args);
 
+	case HL_INFO_PCI_COUNTERS:
+		return pci_counters_info(hpriv, args);
+
+	case HL_INFO_CLK_THROTTLE_REASON:
+		return clk_throttle_info(hpriv, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 00a0a7238d81..41d55a5f7f83 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5620,21 +5620,25 @@ static void gaudi_print_clk_change_info(struct hl_device *hdev,
 {
 	switch (event_type) {
 	case GAUDI_EVENT_FIX_POWER_ENV_S:
+		hdev->clk_throttling_reason |= HL_CLK_THROTTLE_POWER;
 		dev_info_ratelimited(hdev->dev,
 			"Clock throttling due to power consumption\n");
 		break;
 
 	case GAUDI_EVENT_FIX_POWER_ENV_E:
+		hdev->clk_throttling_reason &= ~HL_CLK_THROTTLE_POWER;
 		dev_info_ratelimited(hdev->dev,
 			"Power envelop is safe, back to optimal clock\n");
 		break;
 
 	case GAUDI_EVENT_FIX_THERMAL_ENV_S:
+		hdev->clk_throttling_reason |= HL_CLK_THROTTLE_THERMAL;
 		dev_info_ratelimited(hdev->dev,
 			"Clock throttling due to overheating\n");
 		break;
 
 	case GAUDI_EVENT_FIX_THERMAL_ENV_E:
+		hdev->clk_throttling_reason &= ~HL_CLK_THROTTLE_THERMAL;
 		dev_info_ratelimited(hdev->dev,
 			"Thermal envelop is safe, back to optimal clock\n");
 		break;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 85030759b2af..c497ae25c331 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4549,18 +4549,22 @@ static void goya_print_clk_change_info(struct hl_device *hdev, u16 event_type)
 {
 	switch (event_type) {
 	case GOYA_ASYNC_EVENT_ID_FIX_POWER_ENV_S:
+		hdev->clk_throttling_reason |= HL_CLK_THROTTLE_POWER;
 		dev_info_ratelimited(hdev->dev,
 			"Clock throttling due to power consumption\n");
 		break;
 	case GOYA_ASYNC_EVENT_ID_FIX_POWER_ENV_E:
+		hdev->clk_throttling_reason &= ~HL_CLK_THROTTLE_POWER;
 		dev_info_ratelimited(hdev->dev,
 			"Power envelop is safe, back to optimal clock\n");
 		break;
 	case GOYA_ASYNC_EVENT_ID_FIX_THERMAL_ENV_S:
+		hdev->clk_throttling_reason |= HL_CLK_THROTTLE_THERMAL;
 		dev_info_ratelimited(hdev->dev,
 			"Clock throttling due to overheating\n");
 		break;
 	case GOYA_ASYNC_EVENT_ID_FIX_THERMAL_ENV_E:
+		hdev->clk_throttling_reason &= ~HL_CLK_THROTTLE_THERMAL;
 		dev_info_ratelimited(hdev->dev,
 			"Thermal envelop is safe, back to optimal clock\n");
 		break;
diff --git a/drivers/misc/habanalabs/include/common/armcp_if.h b/drivers/misc/habanalabs/include/common/armcp_if.h
index 07f9972db28d..1403c937253c 100644
--- a/drivers/misc/habanalabs/include/common/armcp_if.h
+++ b/drivers/misc/habanalabs/include/common/armcp_if.h
@@ -243,6 +243,8 @@ enum armcp_packet_id {
 	ARMCP_PACKET_TEMPERATURE_SET,		/* sysfs */
 	ARMCP_PACKET_VOLTAGE_SET,		/* sysfs */
 	ARMCP_PACKET_CURRENT_SET,		/* sysfs */
+	ARMCP_PACKET_PCIE_THROUGHPUT_GET,	/* internal */
+	ARMCP_PACKET_PCIE_REPLAY_CNT_GET,	/* internal */
 };
 
 #define ARMCP_PACKET_FENCE_VAL	0xFE8CE7A5
@@ -277,6 +279,9 @@ struct armcp_packet {
 			__u8 pad; /* unused */
 		};
 
+		/* For any general request */
+		__le32 index;
+
 		/* For frequency get/set */
 		__le32 pll_index;
 
@@ -344,6 +349,11 @@ enum armcp_pwm_attributes {
 	armcp_pwm_enable
 };
 
+enum armcp_pcie_throughput_attributes {
+	armcp_pcie_throughput_tx,
+	armcp_pcie_throughput_rx
+};
+
 /* Event Queue Packets */
 
 struct eq_generic_event {
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index d5c4f983b7a8..ee13b919db35 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -264,6 +264,8 @@ enum hl_device_status {
  * HL_INFO_TIME_SYNC     - Retrieve the device's time alongside the host's time
  *                         for synchronization.
  * HL_INFO_CS_COUNTERS   - Retrieve command submission counters
+ * HL_INFO_PCI_COUNTERS  - Retrieve PCI counters
+ * HL_INFO_CLK_THROTTLE_REASON - Retrieve clock throttling reason
  */
 #define HL_INFO_HW_IP_INFO		0
 #define HL_INFO_HW_EVENTS		1
@@ -276,6 +278,8 @@ enum hl_device_status {
 #define HL_INFO_RESET_COUNT		9
 #define HL_INFO_TIME_SYNC		10
 #define HL_INFO_CS_COUNTERS		11
+#define HL_INFO_PCI_COUNTERS		12
+#define HL_INFO_CLK_THROTTLE_REASON	13
 
 #define HL_INFO_VERSION_MAX_LEN	128
 #define HL_INFO_CARD_NAME_MAX_LEN	16
@@ -340,6 +344,29 @@ struct hl_info_time_sync {
 	__u64 host_time;
 };
 
+/**
+ * struct hl_info_pci_counters - pci counters
+ * @rx_throughput: PCI rx throughput KBps
+ * @tx_throughput: PCI tx throughput KBps
+ * @replay_cnt: PCI replay counter
+ */
+struct hl_info_pci_counters {
+	__u64 rx_throughput;
+	__u64 tx_throughput;
+	__u64 replay_cnt;
+};
+
+#define HL_CLK_THROTTLE_POWER	0x1
+#define HL_CLK_THROTTLE_THERMAL	0x2
+
+/**
+ * struct hl_info_clk_throttle - clock throttling reason
+ * @clk_throttling_reason: each bit represents a clk throttling reason
+ */
+struct hl_info_clk_throttle {
+	__u32 clk_throttling_reason;
+};
+
 /**
  * struct hl_info_cs_counters - command submission counters
  * @out_of_mem_drop_cnt: dropped due to memory allocation issue
-- 
2.17.1

