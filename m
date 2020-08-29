Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B334C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04DB207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0rHrglH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgH2K0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgH2K0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:26:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE30C061239
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 03:26:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so1440989wrw.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 03:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Tb4+DFMdH9dr7CSg+2LVwWHLyenV1pIbrnLGu1SS8lU=;
        b=r0rHrglHPM+ztqv1C6E2HRzO54sYeespbMu9HvQgMJdaRqh0NNDkdY3VlioSrJiljp
         RqHg2Xk4CHtQy/EL+gGHFs07oFhAwOZA76h7GHoTpMHT7i5ag7rD4epTKuwTA5fQMSRp
         05cK+Ys8DffKCp0kXI0f9WBE7Ss0guK7k80vJ3GLaeQyP6RePIdhE7Gmp5tO6NBHUO1A
         HZepmmXezDJhChRY3xWDaykimqbh3XfpEosrNqoXB63Vyg5ujIYeCcHiWwjyYi6MLjb/
         L918PYAl8AuylYCkC5zZ66AMVHtDyqRu+PEA/KAZK4ea22m06Dq6r0BQaU5HHSd44mT2
         q03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tb4+DFMdH9dr7CSg+2LVwWHLyenV1pIbrnLGu1SS8lU=;
        b=lgFHMznRQJ6MqH+wwzVVMF6DeqwtSgDBkUCIad4zA44Bn7B441y0lSrj4tl73fwA+8
         AvY5QdSBJoGgXXUnKZEJB/+VYtN+hqrxkUty/ERdPwWM+b4QLSh3hpRv5bFQ8HUfK6fb
         hx67OXP4jw6LKUWgujgOW5T8qIP757aZI2nQvoUjf8vf3KGouKBhjtFj8cEZavz2mnu3
         JNzgKLCOCu9bHtLR0xngtZRRtYAcWVo36ILwhY9xQSIbjaxB/B/PFa8a/lBQgFn9SafZ
         Cfp1REe4zkPYAlqRq8GFuQ9hhT1PTIguiN4cNeH8iqLbL0iWdT7/QqbOec1MTsDlyZQu
         nSdA==
X-Gm-Message-State: AOAM5325cwX/DHzGNE3xy78TONCcOwB4M41qmw+QO6aaIt+YjukVjN1a
        1RqF2VsJy2zARpF3hSS4NFMu6anii4Q=
X-Google-Smtp-Source: ABdhPJzbw4kLlG/8vvDdfLNtHnHbjfx3Qy1FewFuZ5nJVZyNSdW2xdlm/dz3/NQy3GoPo+UsIu1gmw==
X-Received: by 2002:adf:e610:: with SMTP id p16mr3207027wrm.71.1598696760571;
        Sat, 29 Aug 2020 03:26:00 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id l9sm2796162wmh.1.2020.08.29.03.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 03:25:59 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 1/2] habanalabs: replace armcp with the generic cpucp
Date:   Sat, 29 Aug 2020 13:25:55 +0300
Message-Id: <20200829102556.21895-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ArmCP mandates that the device CPU is always an ARM processor, which might
be wrong in the future.

Most of this change is an internal renaming of variables, functions and
defines but there are two entries in sysfs which have armcp in their
names. Add identical cpucp entries but don't remove yet the armcp entries.
Those will be deprecated next year. Add the documentation about it in sysfs
documentation.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../ABI/testing/sysfs-driver-habanalabs       |  18 +-
 drivers/misc/habanalabs/common/debugfs.c      |  18 +-
 drivers/misc/habanalabs/common/device.c       |   2 +-
 drivers/misc/habanalabs/common/firmware_if.c  | 127 ++++----
 drivers/misc/habanalabs/common/habanalabs.h   |  20 +-
 .../misc/habanalabs/common/habanalabs_ioctl.c |  12 +-
 drivers/misc/habanalabs/common/hwmon.c        |  60 ++--
 drivers/misc/habanalabs/common/irq.c          |   2 +-
 drivers/misc/habanalabs/common/sysfs.c        |  60 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c         |  30 +-
 drivers/misc/habanalabs/gaudi/gaudiP.h        |   4 +-
 drivers/misc/habanalabs/goya/goya.c           |  34 +--
 drivers/misc/habanalabs/goya/goyaP.h          |   2 +-
 .../include/common/{armcp_if.h => cpucp_if.h} | 273 +++++++++---------
 include/uapi/misc/habanalabs.h                |   4 +-
 15 files changed, 350 insertions(+), 316 deletions(-)
 rename drivers/misc/habanalabs/include/common/{armcp_if.h => cpucp_if.h} (63%)

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index 1a14bf9b22ba..169ae4b2a180 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -2,13 +2,17 @@ What:           /sys/class/habanalabs/hl<n>/armcp_kernel_ver
 Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
-Description:    Version of the Linux kernel running on the device's CPU
+Description:    Version of the Linux kernel running on the device's CPU.
+                Will be DEPRECATED in Linux kernel version 5.10, and be
+                replaced with cpucp_kernel_ver
 
 What:           /sys/class/habanalabs/hl<n>/armcp_ver
 Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
 Description:    Version of the application running on the device's CPU
+                Will be DEPRECATED in Linux kernel version 5.10, and be
+                replaced with cpucp_ver
 
 What:           /sys/class/habanalabs/hl<n>/clk_max_freq_mhz
 Date:           Jun 2019
@@ -33,6 +37,18 @@ KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
 Description:    Version of the Device's CPLD F/W
 
+What:           /sys/class/habanalabs/hl<n>/cpucp_kernel_ver
+Date:           Oct 2020
+KernelVersion:  5.10
+Contact:        oded.gabbay@gmail.com
+Description:    Version of the Linux kernel running on the device's CPU
+
+What:           /sys/class/habanalabs/hl<n>/cpucp_ver
+Date:           Oct 2020
+KernelVersion:  5.10
+Contact:        oded.gabbay@gmail.com
+Description:    Version of the application running on the device's CPU
+
 What:           /sys/class/habanalabs/hl<n>/device_type
 Date:           Jan 2019
 KernelVersion:  5.1
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index ded1bd3482c2..9398a21e0398 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -21,7 +21,7 @@ static struct dentry *hl_debug_root;
 static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 				u8 i2c_reg, long *val)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	if (hl_device_disabled_or_in_reset(hdev))
@@ -29,8 +29,8 @@ static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_I2C_RD <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_I2C_RD <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.i2c_bus = i2c_bus;
 	pkt.i2c_addr = i2c_addr;
 	pkt.i2c_reg = i2c_reg;
@@ -47,7 +47,7 @@ static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 static int hl_debugfs_i2c_write(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 				u8 i2c_reg, u32 val)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	if (hl_device_disabled_or_in_reset(hdev))
@@ -55,8 +55,8 @@ static int hl_debugfs_i2c_write(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_I2C_WR <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_I2C_WR <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.i2c_bus = i2c_bus;
 	pkt.i2c_addr = i2c_addr;
 	pkt.i2c_reg = i2c_reg;
@@ -73,7 +73,7 @@ static int hl_debugfs_i2c_write(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 
 static void hl_debugfs_led_set(struct hl_device *hdev, u8 led, u8 state)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	if (hl_device_disabled_or_in_reset(hdev))
@@ -81,8 +81,8 @@ static void hl_debugfs_led_set(struct hl_device *hdev, u8 led, u8 state)
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_LED_SET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_LED_SET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.led_index = cpu_to_le32(led);
 	pkt.value = cpu_to_le64(state);
 
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index dcb7f9ca7a67..6e916cc22a4c 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -871,7 +871,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 			 * so this message won't be sent
 			 */
 			if (hl_fw_send_pci_access_msg(hdev,
-					ARMCP_PACKET_DISABLE_PCI_ACCESS))
+					CPUCP_PACKET_DISABLE_PCI_ACCESS))
 				dev_warn(hdev->dev,
 					"Failed to disable PCI access by F/W\n");
 		}
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index eb66ff532c6a..f2a38e95359a 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -68,9 +68,9 @@ int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 
 int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
 {
-	struct armcp_packet pkt = {};
+	struct cpucp_packet pkt = {};
 
-	pkt.ctl = cpu_to_le32(opcode << ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(opcode << CPUCP_PKT_CTL_OPCODE_SHIFT);
 
 	return hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt,
 						sizeof(pkt), 0, NULL);
@@ -79,7 +79,7 @@ int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
 int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 				u16 len, u32 timeout, long *result)
 {
-	struct armcp_packet *pkt;
+	struct cpucp_packet *pkt;
 	dma_addr_t pkt_dma_addr;
 	u32 tmp;
 	int rc = 0;
@@ -111,7 +111,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 	}
 
 	rc = hl_poll_timeout_memory(hdev, &pkt->fence, tmp,
-				(tmp == ARMCP_PACKET_FENCE_VAL), 1000,
+				(tmp == CPUCP_PACKET_FENCE_VAL), 1000,
 				timeout, true);
 
 	hl_hw_queue_inc_ci_kernel(hdev, hw_queue_id);
@@ -124,12 +124,12 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 
 	tmp = le32_to_cpu(pkt->ctl);
 
-	rc = (tmp & ARMCP_PKT_CTL_RC_MASK) >> ARMCP_PKT_CTL_RC_SHIFT;
+	rc = (tmp & CPUCP_PKT_CTL_RC_MASK) >> CPUCP_PKT_CTL_RC_SHIFT;
 	if (rc) {
 		dev_err(hdev->dev, "F/W ERROR %d for CPU packet %d\n",
 			rc,
-			(tmp & ARMCP_PKT_CTL_OPCODE_MASK)
-						>> ARMCP_PKT_CTL_OPCODE_SHIFT);
+			(tmp & CPUCP_PKT_CTL_OPCODE_MASK)
+						>> CPUCP_PKT_CTL_OPCODE_SHIFT);
 		rc = -EIO;
 	} else if (result) {
 		*result = (long) le64_to_cpu(pkt->result);
@@ -145,14 +145,14 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 
 int hl_fw_unmask_irq(struct hl_device *hdev, u16 event_type)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	long result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_UNMASK_RAZWI_IRQ <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.value = cpu_to_le64(event_type);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
@@ -167,12 +167,12 @@ int hl_fw_unmask_irq(struct hl_device *hdev, u16 event_type)
 int hl_fw_unmask_irq_arr(struct hl_device *hdev, const u32 *irq_arr,
 		size_t irq_arr_size)
 {
-	struct armcp_unmask_irq_arr_packet *pkt;
+	struct cpucp_unmask_irq_arr_packet *pkt;
 	size_t total_pkt_size;
 	long result;
 	int rc;
 
-	total_pkt_size = sizeof(struct armcp_unmask_irq_arr_packet) +
+	total_pkt_size = sizeof(struct cpucp_unmask_irq_arr_packet) +
 			irq_arr_size;
 
 	/* data should be aligned to 8 bytes in order to ArmCP to copy it */
@@ -191,8 +191,8 @@ int hl_fw_unmask_irq_arr(struct hl_device *hdev, const u32 *irq_arr,
 	pkt->length = cpu_to_le32(irq_arr_size / sizeof(irq_arr[0]));
 	memcpy(&pkt->irqs, irq_arr, irq_arr_size);
 
-	pkt->armcp_pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
-						ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt->cpucp_pkt.ctl = cpu_to_le32(CPUCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
+						CPUCP_PKT_CTL_OPCODE_SHIFT);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) pkt,
 						total_pkt_size, 0, &result);
@@ -207,19 +207,19 @@ int hl_fw_unmask_irq_arr(struct hl_device *hdev, const u32 *irq_arr,
 
 int hl_fw_test_cpu_queue(struct hl_device *hdev)
 {
-	struct armcp_packet test_pkt = {};
+	struct cpucp_packet test_pkt = {};
 	long result;
 	int rc;
 
-	test_pkt.ctl = cpu_to_le32(ARMCP_PACKET_TEST <<
-					ARMCP_PKT_CTL_OPCODE_SHIFT);
-	test_pkt.value = cpu_to_le64(ARMCP_PACKET_FENCE_VAL);
+	test_pkt.ctl = cpu_to_le32(CPUCP_PACKET_TEST <<
+					CPUCP_PKT_CTL_OPCODE_SHIFT);
+	test_pkt.value = cpu_to_le64(CPUCP_PACKET_FENCE_VAL);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &test_pkt,
 						sizeof(test_pkt), 0, &result);
 
 	if (!rc) {
-		if (result != ARMCP_PACKET_FENCE_VAL)
+		if (result != CPUCP_PACKET_FENCE_VAL)
 			dev_err(hdev->dev,
 				"CPU queue test failed (0x%08lX)\n", result);
 	} else {
@@ -251,61 +251,61 @@ void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 
 int hl_fw_send_heartbeat(struct hl_device *hdev)
 {
-	struct armcp_packet hb_pkt = {};
+	struct cpucp_packet hb_pkt = {};
 	long result;
 	int rc;
 
-	hb_pkt.ctl = cpu_to_le32(ARMCP_PACKET_TEST <<
-					ARMCP_PKT_CTL_OPCODE_SHIFT);
-	hb_pkt.value = cpu_to_le64(ARMCP_PACKET_FENCE_VAL);
+	hb_pkt.ctl = cpu_to_le32(CPUCP_PACKET_TEST <<
+					CPUCP_PKT_CTL_OPCODE_SHIFT);
+	hb_pkt.value = cpu_to_le64(CPUCP_PACKET_FENCE_VAL);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &hb_pkt,
 						sizeof(hb_pkt), 0, &result);
 
-	if ((rc) || (result != ARMCP_PACKET_FENCE_VAL))
+	if ((rc) || (result != CPUCP_PACKET_FENCE_VAL))
 		rc = -EIO;
 
 	return rc;
 }
 
-int hl_fw_armcp_info_get(struct hl_device *hdev)
+int hl_fw_cpucp_info_get(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct armcp_packet pkt = {};
-	void *armcp_info_cpu_addr;
-	dma_addr_t armcp_info_dma_addr;
+	struct cpucp_packet pkt = {};
+	void *cpucp_info_cpu_addr;
+	dma_addr_t cpucp_info_dma_addr;
 	long result;
 	int rc;
 
-	armcp_info_cpu_addr =
+	cpucp_info_cpu_addr =
 			hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
-					sizeof(struct armcp_info),
-					&armcp_info_dma_addr);
-	if (!armcp_info_cpu_addr) {
+					sizeof(struct cpucp_info),
+					&cpucp_info_dma_addr);
+	if (!cpucp_info_cpu_addr) {
 		dev_err(hdev->dev,
 			"Failed to allocate DMA memory for ArmCP info packet\n");
 		return -ENOMEM;
 	}
 
-	memset(armcp_info_cpu_addr, 0, sizeof(struct armcp_info));
+	memset(cpucp_info_cpu_addr, 0, sizeof(struct cpucp_info));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_INFO_GET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.addr = cpu_to_le64(armcp_info_dma_addr);
-	pkt.data_max_size = cpu_to_le32(sizeof(struct armcp_info));
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_INFO_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.addr = cpu_to_le64(cpucp_info_dma_addr);
+	pkt.data_max_size = cpu_to_le32(sizeof(struct cpucp_info));
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					HL_ARMCP_INFO_TIMEOUT_USEC, &result);
+					HL_CPUCP_INFO_TIMEOUT_USEC, &result);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to handle ArmCP info pkt, error %d\n", rc);
 		goto out;
 	}
 
-	memcpy(&prop->armcp_info, armcp_info_cpu_addr,
-			sizeof(prop->armcp_info));
+	memcpy(&prop->cpucp_info, cpucp_info_cpu_addr,
+			sizeof(prop->cpucp_info));
 
-	rc = hl_build_hwmon_channel_info(hdev, prop->armcp_info.sensors);
+	rc = hl_build_hwmon_channel_info(hdev, prop->cpucp_info.sensors);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to build hwmon channel info, error %d\n", rc);
@@ -315,14 +315,14 @@ int hl_fw_armcp_info_get(struct hl_device *hdev)
 
 out:
 	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
-			sizeof(struct armcp_info), armcp_info_cpu_addr);
+			sizeof(struct cpucp_info), cpucp_info_cpu_addr);
 
 	return rc;
 }
 
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 {
-	struct armcp_packet pkt = {};
+	struct cpucp_packet pkt = {};
 	void *eeprom_info_cpu_addr;
 	dma_addr_t eeprom_info_dma_addr;
 	long result;
@@ -339,13 +339,13 @@ int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 
 	memset(eeprom_info_cpu_addr, 0, max_size);
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_EEPROM_DATA_GET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_EEPROM_DATA_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.addr = cpu_to_le64(eeprom_info_dma_addr);
 	pkt.data_max_size = cpu_to_le32(max_size);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-			HL_ARMCP_EEPROM_TIMEOUT_USEC, &result);
+			HL_CPUCP_EEPROM_TIMEOUT_USEC, &result);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -363,20 +363,20 @@ int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 	return rc;
 }
 
-int hl_fw_armcp_pci_counters_get(struct hl_device *hdev,
+int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters)
 {
-	struct armcp_packet pkt = {};
+	struct cpucp_packet pkt = {};
 	long result;
 	int rc;
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_PCIE_THROUGHPUT_GET <<
-			ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_PCIE_THROUGHPUT_GET <<
+			CPUCP_PKT_CTL_OPCODE_SHIFT);
 
 	/* Fetch PCI rx counter */
-	pkt.index = cpu_to_le32(armcp_pcie_throughput_rx);
+	pkt.index = cpu_to_le32(cpucp_pcie_throughput_rx);
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					HL_ARMCP_INFO_TIMEOUT_USEC, &result);
+					HL_CPUCP_INFO_TIMEOUT_USEC, &result);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to handle ArmCP PCI info pkt, error %d\n", rc);
@@ -385,9 +385,9 @@ int hl_fw_armcp_pci_counters_get(struct hl_device *hdev,
 	counters->rx_throughput = result;
 
 	/* Fetch PCI tx counter */
-	pkt.index = cpu_to_le32(armcp_pcie_throughput_tx);
+	pkt.index = cpu_to_le32(cpucp_pcie_throughput_tx);
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					HL_ARMCP_INFO_TIMEOUT_USEC, &result);
+					HL_CPUCP_INFO_TIMEOUT_USEC, &result);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to handle ArmCP PCI info pkt, error %d\n", rc);
@@ -396,11 +396,11 @@ int hl_fw_armcp_pci_counters_get(struct hl_device *hdev,
 	counters->tx_throughput = result;
 
 	/* Fetch PCI replay counter */
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_PCIE_REPLAY_CNT_GET <<
-			ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_PCIE_REPLAY_CNT_GET <<
+			CPUCP_PKT_CTL_OPCODE_SHIFT);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-			HL_ARMCP_INFO_TIMEOUT_USEC, &result);
+			HL_CPUCP_INFO_TIMEOUT_USEC, &result);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to handle ArmCP PCI info pkt, error %d\n", rc);
@@ -411,21 +411,20 @@ int hl_fw_armcp_pci_counters_get(struct hl_device *hdev,
 	return rc;
 }
 
-int hl_fw_armcp_total_energy_get(struct hl_device *hdev,
-			u64 *total_energy)
+int hl_fw_cpucp_total_energy_get(struct hl_device *hdev, u64 *total_energy)
 {
-	struct armcp_packet pkt = {};
+	struct cpucp_packet pkt = {};
 	long result;
 	int rc;
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_TOTAL_ENERGY_GET <<
-			ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_TOTAL_ENERGY_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					HL_ARMCP_INFO_TIMEOUT_USEC, &result);
+					HL_CPUCP_INFO_TIMEOUT_USEC, &result);
 	if (rc) {
 		dev_err(hdev->dev,
-			"Failed to handle ArmCP total energy pkt, error %d\n",
+			"Failed to handle CpuCP total energy pkt, error %d\n",
 				rc);
 		return rc;
 	}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6577a73e3227..6912f88a4b01 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -8,7 +8,7 @@
 #ifndef HABANALABSP_H_
 #define HABANALABSP_H_
 
-#include "../include/common/armcp_if.h"
+#include "../include/common/cpucp_if.h"
 #include "../include/common/qman_if.h"
 #include <uapi/misc/habanalabs.h>
 
@@ -34,8 +34,8 @@
 
 #define HL_PLL_LOW_JOB_FREQ_USEC	5000000 /* 5 s */
 
-#define HL_ARMCP_INFO_TIMEOUT_USEC	10000000 /* 10s */
-#define HL_ARMCP_EEPROM_TIMEOUT_USEC	10000000 /* 10s */
+#define HL_CPUCP_INFO_TIMEOUT_USEC	10000000 /* 10s */
+#define HL_CPUCP_EEPROM_TIMEOUT_USEC	10000000 /* 10s */
 
 #define HL_PCI_ELBI_TIMEOUT_MSEC	10 /* 10ms */
 
@@ -250,7 +250,7 @@ struct hl_mmu_properties {
 /**
  * struct asic_fixed_properties - ASIC specific immutable properties.
  * @hw_queues_props: H/W queues properties.
- * @armcp_info: received various information from ArmCP regarding the H/W, e.g.
+ * @cpucp_info: received various information from CPU-CP regarding the H/W, e.g.
  *		available sensors.
  * @uboot_ver: F/W U-boot version.
  * @preboot_ver: F/W Preboot version.
@@ -301,7 +301,7 @@ struct hl_mmu_properties {
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
-	struct armcp_info		armcp_info;
+	struct cpucp_info		cpucp_info;
 	char				uboot_ver[VERSION_MAX_LEN];
 	char				preboot_ver[VERSION_MAX_LEN];
 	struct hl_mmu_properties	dmmu;
@@ -1588,7 +1588,7 @@ struct hl_device {
 	u64				clock_gating_mask;
 	atomic_t			in_reset;
 	enum hl_pll_frequency		curr_pll_profile;
-	enum armcp_card_types		card_type;
+	enum cpucp_card_types		card_type;
 	int				cs_active_cnt;
 	u32				major;
 	u32				high_pll;
@@ -1776,7 +1776,7 @@ int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq);
 uint32_t hl_device_utilization(struct hl_device *hdev, uint32_t period_ms);
 
 int hl_build_hwmon_channel_info(struct hl_device *hdev,
-		struct armcp_sensor *sensors_arr);
+		struct cpucp_sensor *sensors_arr);
 
 int hl_sysfs_init(struct hl_device *hdev);
 void hl_sysfs_fini(struct hl_device *hdev);
@@ -1848,11 +1848,11 @@ void *hl_fw_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size,
 void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 					void *vaddr);
 int hl_fw_send_heartbeat(struct hl_device *hdev);
-int hl_fw_armcp_info_get(struct hl_device *hdev);
+int hl_fw_cpucp_info_get(struct hl_device *hdev);
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size);
-int hl_fw_armcp_pci_counters_get(struct hl_device *hdev,
+int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters);
-int hl_fw_armcp_total_energy_get(struct hl_device *hdev,
+int hl_fw_cpucp_total_energy_get(struct hl_device *hdev,
 			u64 *total_energy);
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 18ee14b4b0e1..07317ea49129 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -65,14 +65,14 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 		hw_ip.dram_enabled = 1;
 	hw_ip.num_of_events = prop->num_of_events;
 
-	memcpy(hw_ip.armcp_version, prop->armcp_info.armcp_version,
+	memcpy(hw_ip.cpucp_version, prop->cpucp_info.cpucp_version,
 		min(VERSION_MAX_LEN, HL_INFO_VERSION_MAX_LEN));
 
-	memcpy(hw_ip.card_name, prop->armcp_info.card_name,
+	memcpy(hw_ip.card_name, prop->cpucp_info.card_name,
 		min(CARD_NAME_MAX_LEN, HL_INFO_CARD_NAME_MAX_LEN));
 
-	hw_ip.armcp_cpld_version = le32_to_cpu(prop->armcp_info.cpld_version);
-	hw_ip.module_id = le32_to_cpu(prop->armcp_info.card_location);
+	hw_ip.cpld_version = le32_to_cpu(prop->cpucp_info.cpld_version);
+	hw_ip.module_id = le32_to_cpu(prop->cpucp_info.card_location);
 
 	hw_ip.psoc_pci_pll_nr = prop->psoc_pci_pll_nr;
 	hw_ip.psoc_pci_pll_nf = prop->psoc_pci_pll_nf;
@@ -288,7 +288,7 @@ static int pci_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	rc = hl_fw_armcp_pci_counters_get(hdev, &pci_counters);
+	rc = hl_fw_cpucp_pci_counters_get(hdev, &pci_counters);
 	if (rc)
 		return rc;
 
@@ -369,7 +369,7 @@ static int total_energy_consumption_info(struct hl_fpriv *hpriv,
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	rc = hl_fw_armcp_total_energy_get(hdev,
+	rc = hl_fw_cpucp_total_energy_get(hdev,
 			&total_energy.total_energy_consumption);
 	if (rc)
 		return rc;
diff --git a/drivers/misc/habanalabs/common/hwmon.c b/drivers/misc/habanalabs/common/hwmon.c
index b997336fa75f..2ac29cb2fe61 100644
--- a/drivers/misc/habanalabs/common/hwmon.c
+++ b/drivers/misc/habanalabs/common/hwmon.c
@@ -13,7 +13,7 @@
 #define HWMON_NR_SENSOR_TYPES		(hwmon_pwm + 1)
 
 int hl_build_hwmon_channel_info(struct hl_device *hdev,
-				struct armcp_sensor *sensors_arr)
+				struct cpucp_sensor *sensors_arr)
 {
 	u32 counts[HWMON_NR_SENSOR_TYPES] = {0};
 	u32 *sensors_by_type[HWMON_NR_SENSOR_TYPES] = {NULL};
@@ -24,7 +24,7 @@ int hl_build_hwmon_channel_info(struct hl_device *hdev,
 	enum hwmon_sensor_types type;
 	int rc, i, j;
 
-	for (i = 0 ; i < ARMCP_MAX_SENSORS ; i++) {
+	for (i = 0 ; i < CPUCP_MAX_SENSORS ; i++) {
 		type = le32_to_cpu(sensors_arr[i].type);
 
 		if ((type == 0) && (sensors_arr[i].flags == 0))
@@ -311,13 +311,13 @@ static const struct hwmon_ops hl_hwmon_ops = {
 int hl_get_temperature(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_TEMPERATURE_GET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_TEMPERATURE_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
 
@@ -337,13 +337,13 @@ int hl_get_temperature(struct hl_device *hdev,
 int hl_set_temperature(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_TEMPERATURE_SET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_TEMPERATURE_SET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
 	pkt.value = __cpu_to_le64(value);
@@ -362,13 +362,13 @@ int hl_set_temperature(struct hl_device *hdev,
 int hl_get_voltage(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_VOLTAGE_GET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_VOLTAGE_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
 
@@ -388,13 +388,13 @@ int hl_get_voltage(struct hl_device *hdev,
 int hl_get_current(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_CURRENT_GET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_CURRENT_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
 
@@ -414,13 +414,13 @@ int hl_get_current(struct hl_device *hdev,
 int hl_get_fan_speed(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_FAN_SPEED_GET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_FAN_SPEED_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
 
@@ -440,13 +440,13 @@ int hl_get_fan_speed(struct hl_device *hdev,
 int hl_get_pwm_info(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_PWM_GET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_PWM_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
 
@@ -466,13 +466,13 @@ int hl_get_pwm_info(struct hl_device *hdev,
 void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 			long value)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_PWM_SET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_PWM_SET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
 	pkt.value = cpu_to_le64(value);
@@ -489,13 +489,13 @@ void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 int hl_set_voltage(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_VOLTAGE_SET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_VOLTAGE_SET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
 	pkt.value = __cpu_to_le64(value);
@@ -514,13 +514,13 @@ int hl_set_voltage(struct hl_device *hdev,
 int hl_set_current(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_CURRENT_SET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_CURRENT_SET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.sensor_index = __cpu_to_le16(sensor_index);
 	pkt.type = __cpu_to_le16(attr);
 	pkt.value = __cpu_to_le64(value);
@@ -549,7 +549,7 @@ int hl_hwmon_init(struct hl_device *hdev)
 		hdev->hl_chip_info->ops = &hl_hwmon_ops;
 
 		hdev->hwmon_dev = hwmon_device_register_with_info(dev,
-					prop->armcp_info.card_name, hdev,
+					prop->cpucp_info.card_name, hdev,
 					hdev->hl_chip_info, NULL);
 		if (IS_ERR(hdev->hwmon_dev)) {
 			rc = PTR_ERR(hdev->hwmon_dev);
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index c8db717023f5..d20e40a53d70 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -11,7 +11,7 @@
 
 /**
  * struct hl_eqe_work - This structure is used to schedule work of EQ
- *                      entry and armcp_reset event
+ *                      entry and cpucp_reset event
  *
  * @eq_work:          workqueue object to run when EQ entry is received
  * @hdev:             pointer to device structure
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 5ae484cc84cd..3ceae87016b1 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -11,18 +11,18 @@
 
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	long result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
 	if (curr)
-		pkt.ctl = cpu_to_le32(ARMCP_PACKET_FREQUENCY_CURR_GET <<
-						ARMCP_PKT_CTL_OPCODE_SHIFT);
+		pkt.ctl = cpu_to_le32(CPUCP_PACKET_FREQUENCY_CURR_GET <<
+						CPUCP_PKT_CTL_OPCODE_SHIFT);
 	else
-		pkt.ctl = cpu_to_le32(ARMCP_PACKET_FREQUENCY_GET <<
-						ARMCP_PKT_CTL_OPCODE_SHIFT);
+		pkt.ctl = cpu_to_le32(CPUCP_PACKET_FREQUENCY_GET <<
+						CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.pll_index = cpu_to_le32(pll_index);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
@@ -40,13 +40,13 @@ long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
 
 void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_FREQUENCY_SET <<
-					ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_FREQUENCY_SET <<
+					CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.pll_index = cpu_to_le32(pll_index);
 	pkt.value = cpu_to_le64(freq);
 
@@ -61,14 +61,14 @@ void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
 
 u64 hl_get_max_power(struct hl_device *hdev)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	long result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_MAX_POWER_GET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_MAX_POWER_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 						0, &result);
@@ -83,13 +83,13 @@ u64 hl_get_max_power(struct hl_device *hdev)
 
 void hl_set_max_power(struct hl_device *hdev)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_MAX_POWER_SET <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_MAX_POWER_SET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.value = cpu_to_le64(hdev->max_power);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
@@ -112,7 +112,7 @@ static ssize_t armcp_kernel_ver_show(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%s", hdev->asic_prop.armcp_info.kernel_version);
+	return sprintf(buf, "%s", hdev->asic_prop.cpucp_info.kernel_version);
 }
 
 static ssize_t armcp_ver_show(struct device *dev, struct device_attribute *attr,
@@ -120,7 +120,7 @@ static ssize_t armcp_ver_show(struct device *dev, struct device_attribute *attr,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%s\n", hdev->asic_prop.armcp_info.armcp_version);
+	return sprintf(buf, "%s\n", hdev->asic_prop.cpucp_info.cpucp_version);
 }
 
 static ssize_t cpld_ver_show(struct device *dev, struct device_attribute *attr,
@@ -129,7 +129,23 @@ static ssize_t cpld_ver_show(struct device *dev, struct device_attribute *attr,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
 	return sprintf(buf, "0x%08x\n",
-			hdev->asic_prop.armcp_info.cpld_version);
+			hdev->asic_prop.cpucp_info.cpld_version);
+}
+
+static ssize_t cpucp_kernel_ver_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s", hdev->asic_prop.cpucp_info.kernel_version);
+}
+
+static ssize_t cpucp_ver_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", hdev->asic_prop.cpucp_info.cpucp_version);
 }
 
 static ssize_t infineon_ver_show(struct device *dev,
@@ -138,7 +154,7 @@ static ssize_t infineon_ver_show(struct device *dev,
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
 	return sprintf(buf, "0x%04x\n",
-			hdev->asic_prop.armcp_info.infineon_version);
+			hdev->asic_prop.cpucp_info.infineon_version);
 }
 
 static ssize_t fuse_ver_show(struct device *dev, struct device_attribute *attr,
@@ -146,7 +162,7 @@ static ssize_t fuse_ver_show(struct device *dev, struct device_attribute *attr,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%s\n", hdev->asic_prop.armcp_info.fuse_version);
+	return sprintf(buf, "%s\n", hdev->asic_prop.cpucp_info.fuse_version);
 }
 
 static ssize_t thermal_ver_show(struct device *dev,
@@ -154,7 +170,7 @@ static ssize_t thermal_ver_show(struct device *dev,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%s", hdev->asic_prop.armcp_info.thermal_version);
+	return sprintf(buf, "%s", hdev->asic_prop.cpucp_info.thermal_version);
 }
 
 static ssize_t preboot_btl_ver_show(struct device *dev,
@@ -356,6 +372,8 @@ static ssize_t eeprom_read_handler(struct file *filp, struct kobject *kobj,
 static DEVICE_ATTR_RO(armcp_kernel_ver);
 static DEVICE_ATTR_RO(armcp_ver);
 static DEVICE_ATTR_RO(cpld_ver);
+static DEVICE_ATTR_RO(cpucp_kernel_ver);
+static DEVICE_ATTR_RO(cpucp_ver);
 static DEVICE_ATTR_RO(device_type);
 static DEVICE_ATTR_RO(fuse_ver);
 static DEVICE_ATTR_WO(hard_reset);
@@ -380,6 +398,8 @@ static struct attribute *hl_dev_attrs[] = {
 	&dev_attr_armcp_kernel_ver.attr,
 	&dev_attr_armcp_ver.attr,
 	&dev_attr_cpld_ver.attr,
+	&dev_attr_cpucp_kernel_ver.attr,
+	&dev_attr_cpucp_ver.attr,
 	&dev_attr_device_type.attr,
 	&dev_attr_fuse_ver.attr,
 	&dev_attr_hard_reset.attr,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 4a4327d9cbbf..076a7697f85d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -359,7 +359,7 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 static int gaudi_run_tpc_kernel(struct hl_device *hdev, u64 tpc_kernel,
 				u32 tpc_id);
 static int gaudi_mmu_clear_pgt_range(struct hl_device *hdev);
-static int gaudi_armcp_info_get(struct hl_device *hdev);
+static int gaudi_cpucp_info_get(struct hl_device *hdev);
 static void gaudi_disable_clock_gating(struct hl_device *hdev);
 static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid);
 
@@ -465,7 +465,7 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	prop->pcie_dbi_base_address = mmPCIE_DBI_BASE;
 	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
 
-	strncpy(prop->armcp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
+	strncpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
 					CARD_NAME_MAX_LEN);
 
 	prop->max_pending_cs = GAUDI_MAX_PENDING_CS;
@@ -786,13 +786,13 @@ static int gaudi_late_init(struct hl_device *hdev)
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	int rc;
 
-	rc = gaudi->armcp_info_get(hdev);
+	rc = gaudi->cpucp_info_get(hdev);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to get armcp info\n");
+		dev_err(hdev->dev, "Failed to get cpucp info\n");
 		return rc;
 	}
 
-	rc = hl_fw_send_pci_access_msg(hdev, ARMCP_PACKET_ENABLE_PCI_ACCESS);
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to enable PCI access from CPU\n");
 		return rc;
@@ -817,7 +817,7 @@ static int gaudi_late_init(struct hl_device *hdev)
 	return 0;
 
 disable_pci_access:
-	hl_fw_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
+	hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS);
 
 	return rc;
 }
@@ -987,7 +987,7 @@ static int gaudi_sw_init(struct hl_device *hdev)
 		}
 	}
 
-	gaudi->armcp_info_get = gaudi_armcp_info_get;
+	gaudi->cpucp_info_get = gaudi_cpucp_info_get;
 
 	gaudi->max_freq_value = GAUDI_MAX_CLK_FREQ;
 
@@ -3078,7 +3078,7 @@ static int gaudi_suspend(struct hl_device *hdev)
 {
 	int rc;
 
-	rc = hl_fw_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS);
 	if (rc)
 		dev_err(hdev->dev, "Failed to disable PCI access from CPU\n");
 
@@ -6053,7 +6053,7 @@ static int gaudi_send_heartbeat(struct hl_device *hdev)
 	return hl_fw_send_heartbeat(hdev);
 }
 
-static int gaudi_armcp_info_get(struct hl_device *hdev)
+static int gaudi_cpucp_info_get(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -6062,19 +6062,19 @@ static int gaudi_armcp_info_get(struct hl_device *hdev)
 	if (!(gaudi->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	rc = hl_fw_armcp_info_get(hdev);
+	rc = hl_fw_cpucp_info_get(hdev);
 	if (rc)
 		return rc;
 
-	if (!strlen(prop->armcp_info.card_name))
-		strncpy(prop->armcp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
+	if (!strlen(prop->cpucp_info.card_name))
+		strncpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
 				CARD_NAME_MAX_LEN);
 
-	hdev->card_type = le32_to_cpu(hdev->asic_prop.armcp_info.card_type);
+	hdev->card_type = le32_to_cpu(hdev->asic_prop.cpucp_info.card_type);
 
-	if (hdev->card_type == armcp_card_type_pci)
+	if (hdev->card_type == cpucp_card_type_pci)
 		prop->max_power_default = MAX_POWER_DEFAULT_PCI;
-	else if (hdev->card_type == armcp_card_type_pmc)
+	else if (hdev->card_type == cpucp_card_type_pmc)
 		prop->max_power_default = MAX_POWER_DEFAULT_PMC;
 
 	hdev->max_power = prop->max_power_default;
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 1368f6298c80..b86eb98b145c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -216,7 +216,7 @@ struct gaudi_internal_qman_info {
 
 /**
  * struct gaudi_device - ASIC specific manage structure.
- * @armcp_info_get: get information on device from ArmCP
+ * @cpucp_info_get: get information on device from CPU-CP
  * @hw_queues_lock: protects the H/W queues from concurrent access.
  * @clk_gate_mutex: protects code areas that require clock gating to be disabled
  *                  temporarily
@@ -239,7 +239,7 @@ struct gaudi_internal_qman_info {
  *                    8-bit value so use u8.
  */
 struct gaudi_device {
-	int (*armcp_info_get)(struct hl_device *hdev);
+	int (*cpucp_info_get)(struct hl_device *hdev);
 
 	/* TODO: remove hw_queues_lock after moving to scheduler code */
 	spinlock_t			hw_queues_lock;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5fb3565c80c5..c41f2917863b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -449,7 +449,7 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 	prop->pcie_dbi_base_address = mmPCIE_DBI_BASE;
 	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
 
-	strncpy(prop->armcp_info.card_name, GOYA_DEFAULT_CARD_NAME,
+	strncpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
 		CARD_NAME_MAX_LEN);
 
 	prop->max_pending_cs = GOYA_MAX_PENDING_CS;
@@ -727,9 +727,9 @@ int goya_late_init(struct hl_device *hdev)
 	if (rc)
 		return rc;
 
-	rc = goya_armcp_info_get(hdev);
+	rc = goya_cpucp_info_get(hdev);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to get armcp info %d\n", rc);
+		dev_err(hdev->dev, "Failed to get cpucp info %d\n", rc);
 		return rc;
 	}
 
@@ -739,7 +739,7 @@ int goya_late_init(struct hl_device *hdev)
 	 */
 	WREG32(mmMMU_LOG2_DDR_SIZE, ilog2(prop->dram_size));
 
-	rc = hl_fw_send_pci_access_msg(hdev, ARMCP_PACKET_ENABLE_PCI_ACCESS);
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to enable PCI access from CPU %d\n", rc);
@@ -2648,7 +2648,7 @@ int goya_suspend(struct hl_device *hdev)
 {
 	int rc;
 
-	rc = hl_fw_send_pci_access_msg(hdev, ARMCP_PACKET_DISABLE_PCI_ACCESS);
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS);
 	if (rc)
 		dev_err(hdev->dev, "Failed to disable PCI access from CPU\n");
 
@@ -4500,14 +4500,14 @@ static void goya_print_irq_info(struct hl_device *hdev, u16 event_type,
 static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
 		size_t irq_arr_size)
 {
-	struct armcp_unmask_irq_arr_packet *pkt;
+	struct cpucp_unmask_irq_arr_packet *pkt;
 	size_t total_pkt_size;
 	long result;
 	int rc;
 	int irq_num_entries, irq_arr_index;
 	__le32 *goya_irq_arr;
 
-	total_pkt_size = sizeof(struct armcp_unmask_irq_arr_packet) +
+	total_pkt_size = sizeof(struct cpucp_unmask_irq_arr_packet) +
 			irq_arr_size;
 
 	/* data should be aligned to 8 bytes in order to ArmCP to copy it */
@@ -4534,8 +4534,8 @@ static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
 		goya_irq_arr[irq_arr_index] =
 				cpu_to_le32(irq_arr[irq_arr_index]);
 
-	pkt->armcp_pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
-						ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt->cpucp_pkt.ctl = cpu_to_le32(CPUCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
+						CPUCP_PKT_CTL_OPCODE_SHIFT);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) pkt,
 						total_pkt_size,	0, &result);
@@ -4560,14 +4560,14 @@ static int goya_soft_reset_late_init(struct hl_device *hdev)
 
 static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
 {
-	struct armcp_packet pkt;
+	struct cpucp_packet pkt;
 	long result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-	pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ <<
-				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_UNMASK_RAZWI_IRQ <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.value = cpu_to_le64(event_type);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
@@ -5103,7 +5103,7 @@ int goya_send_heartbeat(struct hl_device *hdev)
 	return hl_fw_send_heartbeat(hdev);
 }
 
-int goya_armcp_info_get(struct hl_device *hdev)
+int goya_cpucp_info_get(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -5113,11 +5113,11 @@ int goya_armcp_info_get(struct hl_device *hdev)
 	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	rc = hl_fw_armcp_info_get(hdev);
+	rc = hl_fw_cpucp_info_get(hdev);
 	if (rc)
 		return rc;
 
-	dram_size = le64_to_cpu(prop->armcp_info.dram_size);
+	dram_size = le64_to_cpu(prop->cpucp_info.dram_size);
 	if (dram_size) {
 		if ((!is_power_of_2(dram_size)) ||
 				(dram_size < DRAM_PHYS_DEFAULT_SIZE)) {
@@ -5131,8 +5131,8 @@ int goya_armcp_info_get(struct hl_device *hdev)
 		prop->dram_end_address = prop->dram_base_address + dram_size;
 	}
 
-	if (!strlen(prop->armcp_info.card_name))
-		strncpy(prop->armcp_info.card_name, GOYA_DEFAULT_CARD_NAME,
+	if (!strlen(prop->cpucp_info.card_name))
+		strncpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
 				CARD_NAME_MAX_LEN);
 
 	return 0;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index bb7474ee9784..09b4006d4dc3 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -207,7 +207,7 @@ void goya_set_max_power(struct hl_device *hdev, u64 value);
 void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
 void goya_add_device_attr(struct hl_device *hdev,
 			struct attribute_group *dev_attr_grp);
-int goya_armcp_info_get(struct hl_device *hdev);
+int goya_cpucp_info_get(struct hl_device *hdev);
 int goya_debug_coresight(struct hl_device *hdev, void *data);
 void goya_halt_coresight(struct hl_device *hdev);
 
diff --git a/drivers/misc/habanalabs/include/common/armcp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
similarity index 63%
rename from drivers/misc/habanalabs/include/common/armcp_if.h
rename to drivers/misc/habanalabs/include/common/cpucp_if.h
index 4d78898524e9..1e8480e978e2 100644
--- a/drivers/misc/habanalabs/include/common/armcp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2016-2020 HabanaLabs, Ltd.
+ * Copyright 2020 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
 
-#ifndef ARMCP_IF_H
-#define ARMCP_IF_H
+#ifndef CPUCP_IF_H
+#define CPUCP_IF_H
 
 #include <linux/types.h>
 
@@ -50,16 +50,16 @@ enum pq_init_status {
 };
 
 /*
- * ArmCP Primary Queue Packets
+ * CpuCP Primary Queue Packets
  *
  * During normal operation, the host's kernel driver needs to send various
- * messages to ArmCP, usually either to SET some value into a H/W periphery or
+ * messages to CpuCP, usually either to SET some value into a H/W periphery or
  * to GET the current value of some H/W periphery. For example, SET the
  * frequency of MME/TPC and GET the value of the thermal sensor.
  *
  * These messages can be initiated either by the User application or by the
  * host's driver itself, e.g. power management code. In either case, the
- * communication from the host's driver to ArmCP will *always* be in
+ * communication from the host's driver to CpuCP will *always* be in
  * synchronous mode, meaning that the host will send a single message and poll
  * until the message was acknowledged and the results are ready (if results are
  * needed).
@@ -73,21 +73,20 @@ enum pq_init_status {
  *
  * The message, inputs/outputs (if relevant) and fence object will be located
  * on the device DDR at an address that will be determined by the host's driver.
- * During device initialization phase, the host will pass to ArmCP that address.
+ * During device initialization phase, the host will pass to CpuCP that address.
  * Most of the message types will contain inputs/outputs inside the message
  * itself. The common part of each message will contain the opcode of the
  * message (its type) and a field representing a fence object.
  *
- * When the host's driver wishes to send a message to ArmCP, it will write the
- * message contents to the device DDR, clear the fence object and then write the
- * value 484 to the mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR register to issue
- * the 484 interrupt-id to the ARM core.
+ * When the host's driver wishes to send a message to CPU CP, it will write the
+ * message contents to the device DDR, clear the fence object and then write to
+ * the PSOC_ARC1_AUX_SW_INTR, to issue interrupt 121 to ARC Management CPU.
  *
- * Upon receiving the 484 interrupt-id, ArmCP will read the message from the
- * DDR. In case the message is a SET operation, ArmCP will first perform the
+ * Upon receiving the interrupt (#121), CpuCP will read the message from the
+ * DDR. In case the message is a SET operation, CpuCP will first perform the
  * operation and then write to the fence object on the device DDR. In case the
- * message is a GET operation, ArmCP will first fill the results section on the
- * device DDR and then write to the fence object. If an error occurred, ArmCP
+ * message is a GET operation, CpuCP will first fill the results section on the
+ * device DDR and then write to the fence object. If an error occurred, CpuCP
  * will fill the rc field with the right error code.
  *
  * In the meantime, the host's driver will poll on the fence object. Once the
@@ -96,167 +95,167 @@ enum pq_init_status {
  * driver.
  *
  * To use QMAN packets, the opcode must be the QMAN opcode, shifted by 8
- * so the value being put by the host's driver matches the value read by ArmCP
+ * so the value being put by the host's driver matches the value read by CpuCP
  *
  * Non-QMAN packets should be limited to values 1 through (2^8 - 1)
  *
  * Detailed description:
  *
- * ARMCP_PACKET_DISABLE_PCI_ACCESS -
+ * CPUCP_PACKET_DISABLE_PCI_ACCESS -
  *       After receiving this packet the embedded CPU must NOT issue PCI
  *       transactions (read/write) towards the Host CPU. This also include
  *       sending MSI-X interrupts.
  *       This packet is usually sent before the device is moved to D3Hot state.
  *
- * ARMCP_PACKET_ENABLE_PCI_ACCESS -
+ * CPUCP_PACKET_ENABLE_PCI_ACCESS -
  *       After receiving this packet the embedded CPU is allowed to issue PCI
  *       transactions towards the Host CPU, including sending MSI-X interrupts.
  *       This packet is usually send after the device is moved to D0 state.
  *
- * ARMCP_PACKET_TEMPERATURE_GET -
+ * CPUCP_PACKET_TEMPERATURE_GET -
  *       Fetch the current temperature / Max / Max Hyst / Critical /
  *       Critical Hyst of a specified thermal sensor. The packet's
  *       arguments specify the desired sensor and the field to get.
  *
- * ARMCP_PACKET_VOLTAGE_GET -
+ * CPUCP_PACKET_VOLTAGE_GET -
  *       Fetch the voltage / Max / Min of a specified sensor. The packet's
  *       arguments specify the sensor and type.
  *
- * ARMCP_PACKET_CURRENT_GET -
+ * CPUCP_PACKET_CURRENT_GET -
  *       Fetch the current / Max / Min of a specified sensor. The packet's
  *       arguments specify the sensor and type.
  *
- * ARMCP_PACKET_FAN_SPEED_GET -
+ * CPUCP_PACKET_FAN_SPEED_GET -
  *       Fetch the speed / Max / Min of a specified fan. The packet's
  *       arguments specify the sensor and type.
  *
- * ARMCP_PACKET_PWM_GET -
+ * CPUCP_PACKET_PWM_GET -
  *       Fetch the pwm value / mode of a specified pwm. The packet's
  *       arguments specify the sensor and type.
  *
- * ARMCP_PACKET_PWM_SET -
+ * CPUCP_PACKET_PWM_SET -
  *       Set the pwm value / mode of a specified pwm. The packet's
  *       arguments specify the sensor, type and value.
  *
- * ARMCP_PACKET_FREQUENCY_SET -
+ * CPUCP_PACKET_FREQUENCY_SET -
  *       Set the frequency of a specified PLL. The packet's arguments specify
  *       the PLL and the desired frequency. The actual frequency in the device
  *       might differ from the requested frequency.
  *
- * ARMCP_PACKET_FREQUENCY_GET -
+ * CPUCP_PACKET_FREQUENCY_GET -
  *       Fetch the frequency of a specified PLL. The packet's arguments specify
  *       the PLL.
  *
- * ARMCP_PACKET_LED_SET -
+ * CPUCP_PACKET_LED_SET -
  *       Set the state of a specified led. The packet's arguments
  *       specify the led and the desired state.
  *
- * ARMCP_PACKET_I2C_WR -
+ * CPUCP_PACKET_I2C_WR -
  *       Write 32-bit value to I2C device. The packet's arguments specify the
  *       I2C bus, address and value.
  *
- * ARMCP_PACKET_I2C_RD -
+ * CPUCP_PACKET_I2C_RD -
  *       Read 32-bit value from I2C device. The packet's arguments specify the
  *       I2C bus and address.
  *
- * ARMCP_PACKET_INFO_GET -
+ * CPUCP_PACKET_INFO_GET -
  *       Fetch information from the device as specified in the packet's
- *       structure. The host's driver passes the max size it allows the ArmCP to
+ *       structure. The host's driver passes the max size it allows the CpuCP to
  *       write to the structure, to prevent data corruption in case of
  *       mismatched driver/FW versions.
  *
- * ARMCP_PACKET_FLASH_PROGRAM_REMOVED - this packet was removed
+ * CPUCP_PACKET_FLASH_PROGRAM_REMOVED - this packet was removed
  *
- * ARMCP_PACKET_UNMASK_RAZWI_IRQ -
+ * CPUCP_PACKET_UNMASK_RAZWI_IRQ -
  *       Unmask the given IRQ. The IRQ number is specified in the value field.
  *       The packet is sent after receiving an interrupt and printing its
  *       relevant information.
  *
- * ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY -
+ * CPUCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY -
  *       Unmask the given IRQs. The IRQs numbers are specified in an array right
- *       after the armcp_packet structure, where its first element is the array
+ *       after the cpucp_packet structure, where its first element is the array
  *       length. The packet is sent after a soft reset was done in order to
  *       handle any interrupts that were sent during the reset process.
  *
- * ARMCP_PACKET_TEST -
- *       Test packet for ArmCP connectivity. The CPU will put the fence value
+ * CPUCP_PACKET_TEST -
+ *       Test packet for CpuCP connectivity. The CPU will put the fence value
  *       in the result field.
  *
- * ARMCP_PACKET_FREQUENCY_CURR_GET -
+ * CPUCP_PACKET_FREQUENCY_CURR_GET -
  *       Fetch the current frequency of a specified PLL. The packet's arguments
  *       specify the PLL.
  *
- * ARMCP_PACKET_MAX_POWER_GET -
+ * CPUCP_PACKET_MAX_POWER_GET -
  *       Fetch the maximal power of the device.
  *
- * ARMCP_PACKET_MAX_POWER_SET -
+ * CPUCP_PACKET_MAX_POWER_SET -
  *       Set the maximal power of the device. The packet's arguments specify
  *       the power.
  *
- * ARMCP_PACKET_EEPROM_DATA_GET -
- *       Get EEPROM data from the ArmCP kernel. The buffer is specified in the
+ * CPUCP_PACKET_EEPROM_DATA_GET -
+ *       Get EEPROM data from the CpuCP kernel. The buffer is specified in the
  *       addr field. The CPU will put the returned data size in the result
  *       field. In addition, the host's driver passes the max size it allows the
- *       ArmCP to write to the structure, to prevent data corruption in case of
+ *       CpuCP to write to the structure, to prevent data corruption in case of
  *       mismatched driver/FW versions.
  *
- * ARMCP_PACKET_TEMPERATURE_SET -
+ * CPUCP_PACKET_TEMPERATURE_SET -
  *       Set the value of the offset property of a specified thermal sensor.
  *       The packet's arguments specify the desired sensor and the field to
  *       set.
  *
- * ARMCP_PACKET_VOLTAGE_SET -
+ * CPUCP_PACKET_VOLTAGE_SET -
  *       Trigger the reset_history property of a specified voltage sensor.
  *       The packet's arguments specify the desired sensor and the field to
  *       set.
  *
- * ARMCP_PACKET_CURRENT_SET -
+ * CPUCP_PACKET_CURRENT_SET -
  *       Trigger the reset_history property of a specified current sensor.
  *       The packet's arguments specify the desired sensor and the field to
  *       set.
  */
 
-enum armcp_packet_id {
-	ARMCP_PACKET_DISABLE_PCI_ACCESS = 1,	/* internal */
-	ARMCP_PACKET_ENABLE_PCI_ACCESS,		/* internal */
-	ARMCP_PACKET_TEMPERATURE_GET,		/* sysfs */
-	ARMCP_PACKET_VOLTAGE_GET,		/* sysfs */
-	ARMCP_PACKET_CURRENT_GET,		/* sysfs */
-	ARMCP_PACKET_FAN_SPEED_GET,		/* sysfs */
-	ARMCP_PACKET_PWM_GET,			/* sysfs */
-	ARMCP_PACKET_PWM_SET,			/* sysfs */
-	ARMCP_PACKET_FREQUENCY_SET,		/* sysfs */
-	ARMCP_PACKET_FREQUENCY_GET,		/* sysfs */
-	ARMCP_PACKET_LED_SET,			/* debugfs */
-	ARMCP_PACKET_I2C_WR,			/* debugfs */
-	ARMCP_PACKET_I2C_RD,			/* debugfs */
-	ARMCP_PACKET_INFO_GET,			/* IOCTL */
-	ARMCP_PACKET_FLASH_PROGRAM_REMOVED,
-	ARMCP_PACKET_UNMASK_RAZWI_IRQ,		/* internal */
-	ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY,	/* internal */
-	ARMCP_PACKET_TEST,			/* internal */
-	ARMCP_PACKET_FREQUENCY_CURR_GET,	/* sysfs */
-	ARMCP_PACKET_MAX_POWER_GET,		/* sysfs */
-	ARMCP_PACKET_MAX_POWER_SET,		/* sysfs */
-	ARMCP_PACKET_EEPROM_DATA_GET,		/* sysfs */
-	ARMCP_RESERVED,
-	ARMCP_PACKET_TEMPERATURE_SET,		/* sysfs */
-	ARMCP_PACKET_VOLTAGE_SET,		/* sysfs */
-	ARMCP_PACKET_CURRENT_SET,		/* sysfs */
-	ARMCP_PACKET_PCIE_THROUGHPUT_GET,	/* internal */
-	ARMCP_PACKET_PCIE_REPLAY_CNT_GET,	/* internal */
-	ARMCP_PACKET_TOTAL_ENERGY_GET,		/* internal */
+enum cpucp_packet_id {
+	CPUCP_PACKET_DISABLE_PCI_ACCESS = 1,	/* internal */
+	CPUCP_PACKET_ENABLE_PCI_ACCESS,		/* internal */
+	CPUCP_PACKET_TEMPERATURE_GET,		/* sysfs */
+	CPUCP_PACKET_VOLTAGE_GET,		/* sysfs */
+	CPUCP_PACKET_CURRENT_GET,		/* sysfs */
+	CPUCP_PACKET_FAN_SPEED_GET,		/* sysfs */
+	CPUCP_PACKET_PWM_GET,			/* sysfs */
+	CPUCP_PACKET_PWM_SET,			/* sysfs */
+	CPUCP_PACKET_FREQUENCY_SET,		/* sysfs */
+	CPUCP_PACKET_FREQUENCY_GET,		/* sysfs */
+	CPUCP_PACKET_LED_SET,			/* debugfs */
+	CPUCP_PACKET_I2C_WR,			/* debugfs */
+	CPUCP_PACKET_I2C_RD,			/* debugfs */
+	CPUCP_PACKET_INFO_GET,			/* IOCTL */
+	CPUCP_PACKET_FLASH_PROGRAM_REMOVED,
+	CPUCP_PACKET_UNMASK_RAZWI_IRQ,		/* internal */
+	CPUCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY,	/* internal */
+	CPUCP_PACKET_TEST,			/* internal */
+	CPUCP_PACKET_FREQUENCY_CURR_GET,	/* sysfs */
+	CPUCP_PACKET_MAX_POWER_GET,		/* sysfs */
+	CPUCP_PACKET_MAX_POWER_SET,		/* sysfs */
+	CPUCP_PACKET_EEPROM_DATA_GET,		/* sysfs */
+	CPUCP_RESERVED,
+	CPUCP_PACKET_TEMPERATURE_SET,		/* sysfs */
+	CPUCP_PACKET_VOLTAGE_SET,		/* sysfs */
+	CPUCP_PACKET_CURRENT_SET,		/* sysfs */
+	CPUCP_PACKET_PCIE_THROUGHPUT_GET,		/* internal */
+	CPUCP_PACKET_PCIE_REPLAY_CNT_GET,		/* internal */
+	CPUCP_PACKET_TOTAL_ENERGY_GET,		/* internal */
 };
 
-#define ARMCP_PACKET_FENCE_VAL	0xFE8CE7A5
+#define CPUCP_PACKET_FENCE_VAL	0xFE8CE7A5
 
-#define ARMCP_PKT_CTL_RC_SHIFT		12
-#define ARMCP_PKT_CTL_RC_MASK		0x0000F000
+#define CPUCP_PKT_CTL_RC_SHIFT		12
+#define CPUCP_PKT_CTL_RC_MASK		0x0000F000
 
-#define ARMCP_PKT_CTL_OPCODE_SHIFT	16
-#define ARMCP_PKT_CTL_OPCODE_MASK	0x1FFF0000
+#define CPUCP_PKT_CTL_OPCODE_SHIFT	16
+#define CPUCP_PKT_CTL_OPCODE_MASK	0x1FFF0000
 
-struct armcp_packet {
+struct cpucp_packet {
 	union {
 		__le64 value;	/* For SET packets */
 		__le64 result;	/* For GET packets */
@@ -289,70 +288,70 @@ struct armcp_packet {
 		/* For led set */
 		__le32 led_index;
 
-		/* For get Armcp info/EEPROM data */
+		/* For get CpuCP info/EEPROM data */
 		__le32 data_max_size;
 	};
 
 	__le32 reserved;
 };
 
-struct armcp_unmask_irq_arr_packet {
-	struct armcp_packet armcp_pkt;
+struct cpucp_unmask_irq_arr_packet {
+	struct cpucp_packet cpucp_pkt;
 	__le32 length;
 	__le32 irqs[0];
 };
 
-enum armcp_packet_rc {
-	armcp_packet_success,
-	armcp_packet_invalid,
-	armcp_packet_fault
+enum cpucp_packet_rc {
+	cpucp_packet_success,
+	cpucp_packet_invalid,
+	cpucp_packet_fault
 };
 
 /*
- * armcp_temp_type should adhere to hwmon_temp_attributes
+ * cpucp_temp_type should adhere to hwmon_temp_attributes
  * defined in Linux kernel hwmon.h file
  */
-enum armcp_temp_type {
-	armcp_temp_input,
-	armcp_temp_max = 6,
-	armcp_temp_max_hyst,
-	armcp_temp_crit,
-	armcp_temp_crit_hyst,
-	armcp_temp_offset = 19,
-	armcp_temp_highest = 22,
-	armcp_temp_reset_history = 23
+enum cpucp_temp_type {
+	cpucp_temp_input,
+	cpucp_temp_max = 6,
+	cpucp_temp_max_hyst,
+	cpucp_temp_crit,
+	cpucp_temp_crit_hyst,
+	cpucp_temp_offset = 19,
+	cpucp_temp_highest = 22,
+	cpucp_temp_reset_history = 23
 };
 
-enum armcp_in_attributes {
-	armcp_in_input,
-	armcp_in_min,
-	armcp_in_max,
-	armcp_in_highest = 7,
-	armcp_in_reset_history
+enum cpucp_in_attributes {
+	cpucp_in_input,
+	cpucp_in_min,
+	cpucp_in_max,
+	cpucp_in_highest = 7,
+	cpucp_in_reset_history
 };
 
-enum armcp_curr_attributes {
-	armcp_curr_input,
-	armcp_curr_min,
-	armcp_curr_max,
-	armcp_curr_highest = 7,
-	armcp_curr_reset_history
+enum cpucp_curr_attributes {
+	cpucp_curr_input,
+	cpucp_curr_min,
+	cpucp_curr_max,
+	cpucp_curr_highest = 7,
+	cpucp_curr_reset_history
 };
 
-enum armcp_fan_attributes {
-	armcp_fan_input,
-	armcp_fan_min = 2,
-	armcp_fan_max
+enum cpucp_fan_attributes {
+	cpucp_fan_input,
+	cpucp_fan_min = 2,
+	cpucp_fan_max
 };
 
-enum armcp_pwm_attributes {
-	armcp_pwm_input,
-	armcp_pwm_enable
+enum cpucp_pwm_attributes {
+	cpucp_pwm_input,
+	cpucp_pwm_enable
 };
 
-enum armcp_pcie_throughput_attributes {
-	armcp_pcie_throughput_tx,
-	armcp_pcie_throughput_rx
+enum cpucp_pcie_throughput_attributes {
+	cpucp_pcie_throughput_tx,
+	cpucp_pcie_throughput_rx
 };
 
 /* Event Queue Packets */
@@ -362,32 +361,32 @@ struct eq_generic_event {
 };
 
 /*
- * ArmCP info
+ * CpuCP info
  */
 
 #define CARD_NAME_MAX_LEN		16
 #define VERSION_MAX_LEN			128
-#define ARMCP_MAX_SENSORS		128
+#define CPUCP_MAX_SENSORS		128
 
-struct armcp_sensor {
+struct cpucp_sensor {
 	__le32 type;
 	__le32 flags;
 };
 
 /**
- * struct armcp_card_types - ASIC card type.
- * @armcp_card_type_pci: PCI card.
- * @armcp_card_type_pmc: PCI Mezzanine Card.
+ * struct cpucp_card_types - ASIC card type.
+ * @cpucp_card_type_pci: PCI card.
+ * @cpucp_card_type_pmc: PCI Mezzanine Card.
  */
-enum armcp_card_types {
-	armcp_card_type_pci,
-	armcp_card_type_pmc
+enum cpucp_card_types {
+	cpucp_card_type_pci,
+	cpucp_card_type_pmc
 };
 
 /**
- * struct armcp_info - Info from ArmCP that is necessary to the host's driver
+ * struct cpucp_info - Info from CpuCP that is necessary to the host's driver
  * @sensors: available sensors description.
- * @kernel_version: ArmCP linux kernel version.
+ * @kernel_version: CpuCP linux kernel version.
  * @reserved: reserved field.
  * @card_type: card configuration type.
  * @card_location: in a server, each card has different connections topology
@@ -396,12 +395,12 @@ enum armcp_card_types {
  * @infineon_version: Infineon main DC-DC version.
  * @fuse_version: silicon production FUSE information.
  * @thermal_version: thermald S/W version.
- * @armcp_version: ArmCP S/W version.
+ * @cpucp_version: CpuCP S/W version.
  * @dram_size: available DRAM size.
  * @card_name: card name that will be displayed in HWMON subsystem on the host
  */
-struct armcp_info {
-	struct armcp_sensor sensors[ARMCP_MAX_SENSORS];
+struct cpucp_info {
+	struct cpucp_sensor sensors[CPUCP_MAX_SENSORS];
 	__u8 kernel_version[VERSION_MAX_LEN];
 	__le32 reserved;
 	__le32 card_type;
@@ -410,9 +409,9 @@ struct armcp_info {
 	__le32 infineon_version;
 	__u8 fuse_version[VERSION_MAX_LEN];
 	__u8 thermal_version[VERSION_MAX_LEN];
-	__u8 armcp_version[VERSION_MAX_LEN];
+	__u8 cpucp_version[VERSION_MAX_LEN];
 	__le64 dram_size;
 	char card_name[CARD_NAME_MAX_LEN];
 };
 
-#endif /* ARMCP_IF_H */
+#endif /* CPUCP_IF_H */
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 6803991726e8..a2dcad29340f 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -297,7 +297,7 @@ struct hl_info_hw_ip_info {
 	__u32 device_id; /* PCI Device ID */
 	__u32 module_id; /* For mezzanine cards in servers (From OCP spec.) */
 	__u32 reserved[2];
-	__u32 armcp_cpld_version;
+	__u32 cpld_version;
 	__u32 psoc_pci_pll_nr;
 	__u32 psoc_pci_pll_nf;
 	__u32 psoc_pci_pll_od;
@@ -305,7 +305,7 @@ struct hl_info_hw_ip_info {
 	__u8 tpc_enabled_mask;
 	__u8 dram_enabled;
 	__u8 pad[2];
-	__u8 armcp_version[HL_INFO_VERSION_MAX_LEN];
+	__u8 cpucp_version[HL_INFO_VERSION_MAX_LEN];
 	__u8 card_name[HL_INFO_CARD_NAME_MAX_LEN];
 };
 
-- 
2.17.1

