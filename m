Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EE1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E289320675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGLdA5fB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgCaO4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:56:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38250 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbgCaO4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:56:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id c7so357448wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RotBY2/n7MqumxpiEiIUgwj/O+Jw9v6dfbvSaS8JkQM=;
        b=AGLdA5fBKrFo7a1CWVQEVN7BnOcF4R+IxBspD8Km+HuxoBzk3cRqtZRsV6pvMwEPjj
         ikZS0+c0DqEm3gpNZlWLJ4aPy/vkVeLxMCnYxMenj6eJ60JKtMJeLnlJnwiawtCE1AOy
         aqeE3+qnsOJ1RLR+wtMxwKOww/drqpTuO8mOO737aJ4HpqUbEpaiwa4ZwCzegBJXSgoH
         acRiTKYhgMO1ZDCXwZMU7sdVtoghetlBzCeacVBKm3fTbe6F0120CAIgIj1rs8j5Js2A
         Dc/0LDeGNSPQ3gEegZM5M3SPv05h4xXsa/u24V/2wxMwlP8oYNwJG1gjY9sGKA6vEv4M
         BPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RotBY2/n7MqumxpiEiIUgwj/O+Jw9v6dfbvSaS8JkQM=;
        b=KhfXW/WZsbVXykEeuHyHjMivHFRC34IgFSBzF7iPhSnQ5bwbfaxGIwvh2hUwE9fJDT
         8MnuJYwWKRxHaoqggfXfq6S529KUrXIWLMtCb1LjUV7x4jNsQCDXWOKzI8U+YSE3MQ4/
         MGnzY2ikG8Q72tfob0RTDfE4GmJ3BzVGzfROyCJjAPExrBfLXS8oJQfzqYZsamxTF1ty
         sEJnTi/uvRuIx4f+q18of/BS9HqT9AlgDkZwRka30razHCdUx4nUSwBcO8S56Q5l/Vyb
         7IlhoDyNY6A2lpRuTnYzcsshCIr8Z8XUTj7ZgYSxJzHWTDD8QbTUxDO2+L9+dxpOfMsO
         SDsA==
X-Gm-Message-State: ANhLgQ1Pw1grP3EHxCTZNirdAyjORmONNVBAoCkArjsAXJTbnWexmzmO
        GKUwCGrrsks3yZIZCyzEbRtlXbST
X-Google-Smtp-Source: ADFU+vu8SnlFhI8fh6lDdQf5r3qsyJ2R9NjhTeDcJCOFD3X09qbS3uceDVziHSivuEADxczr2Z9e/Q==
X-Received: by 2002:adf:e807:: with SMTP id o7mr21921937wrm.77.1585666563747;
        Tue, 31 Mar 2020 07:56:03 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r3sm27118507wrm.35.2020.03.31.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:56:02 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/2] habanalabs: retrieve DMA mask indication from firmware
Date:   Tue, 31 Mar 2020 17:55:59 +0300
Message-Id: <20200331145600.768-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retrieve from the firmware the DMA mask value we need to set according to
the device's PCI controller configuration. This is needed when working on
POWER9 machines, as the device's PCI controller is configured in a
different way in those machines.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c          | 19 +++++-
 drivers/misc/habanalabs/habanalabs.h         |  9 ++-
 drivers/misc/habanalabs/include/hl_boot_if.h |  1 +
 drivers/misc/habanalabs/pci.c                | 63 +++++++++-----------
 4 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index a0a96ca31757..85f29cb7d67b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -531,7 +531,7 @@ static int goya_early_init(struct hl_device *hdev)
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
 
-	rc = hl_pci_init(hdev, 48);
+	rc = hl_pci_init(hdev);
 	if (rc)
 		return rc;
 
@@ -5185,6 +5185,20 @@ u32 goya_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
 	return cq_idx;
 }
 
+static void goya_set_dma_mask_from_fw(struct hl_device *hdev)
+{
+	if (RREG32(mmPSOC_GLOBAL_CONF_NON_RST_FLOPS_0) ==
+							HL_POWER9_HOST_MAGIC) {
+		dev_dbg(hdev->dev, "Working in 64-bit DMA mode\n");
+		hdev->power9_64bit_dma_enable = 1;
+		hdev->dma_mask = 64;
+	} else {
+		dev_dbg(hdev->dev, "Working in 48-bit DMA mode\n");
+		hdev->power9_64bit_dma_enable = 0;
+		hdev->dma_mask = 48;
+	}
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5247,7 +5261,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_clk_rate = goya_get_clk_rate,
 	.get_queue_id_for_cq = goya_get_queue_id_for_cq,
 	.read_device_fw_version = goya_read_device_fw_version,
-	.load_firmware_to_device = goya_load_firmware_to_device
+	.load_firmware_to_device = goya_load_firmware_to_device,
+	.set_dma_mask_from_fw = goya_set_dma_mask_from_fw
 };
 
 /*
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 6c54d0ba0a1d..29b9767387af 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -552,6 +552,8 @@ enum hl_pll_frequency {
  * @read_device_fw_version: read the device's firmware versions that are
  *                          contained in registers
  * @load_firmware_to_device: load the firmware to the device's memory
+ * @set_dma_mask_from_fw: set the DMA mask in the driver according to the
+ *                        firmware configuration
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -642,6 +644,7 @@ struct hl_asic_funcs {
 	void (*read_device_fw_version)(struct hl_device *hdev,
 					enum hl_fw_component fwc);
 	int (*load_firmware_to_device)(struct hl_device *hdev);
+	void (*set_dma_mask_from_fw)(struct hl_device *hdev);
 };
 
 
@@ -1321,6 +1324,8 @@ struct hl_device_idle_busy_ts {
  * @dma_mask: the dma mask that was set for this device
  * @in_debug: is device under debug. This, together with fpriv_list, enforces
  *            that only a single user is configuring the debug infrastructure.
+ * @power9_64bit_dma_enable: true to enable 64-bit DMA mask support. Relevant
+ *                           only to POWER9 machines.
  * @cdev_sysfs_created: were char devices and sysfs nodes created.
  * @stop_on_err: true if engines should stop on error.
  */
@@ -1402,6 +1407,7 @@ struct hl_device {
 	u8				device_cpu_disabled;
 	u8				dma_mask;
 	u8				in_debug;
+	u8                              power9_64bit_dma_enable;
 	u8				cdev_sysfs_created;
 	u8				stop_on_err;
 
@@ -1632,9 +1638,8 @@ int hl_pci_set_dram_bar_base(struct hl_device *hdev, u8 inbound_region, u8 bar,
 int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 			u64 dram_base_address, u64 host_phys_base_address,
 			u64 host_phys_size);
-int hl_pci_init(struct hl_device *hdev, u8 dma_mask);
+int hl_pci_init(struct hl_device *hdev);
 void hl_pci_fini(struct hl_device *hdev);
-int hl_pci_set_dma_mask(struct hl_device *hdev, u8 dma_mask);
 
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
 void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq);
diff --git a/drivers/misc/habanalabs/include/hl_boot_if.h b/drivers/misc/habanalabs/include/hl_boot_if.h
index 660550604362..7106315fc92e 100644
--- a/drivers/misc/habanalabs/include/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/hl_boot_if.h
@@ -9,6 +9,7 @@
 #define HL_BOOT_IF_H
 
 #define LKD_HARD_RESET_MAGIC		0xED7BD694
+#define HL_POWER9_HOST_MAGIC		0x1DA30009
 
 /*
  * CPU error bits in BOOT_ERROR registers
diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
index c98d88c7a5c6..0aef4af9f5ec 100644
--- a/drivers/misc/habanalabs/pci.c
+++ b/drivers/misc/habanalabs/pci.c
@@ -267,6 +267,12 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 	/* Enable + Bar match + match enable */
 	rc |= hl_pci_iatu_write(hdev, 0x104, 0xC0080000);
 
+	/* Return the DBI window to the default location */
+	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0);
+	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr + 4, 0);
+
+	hdev->asic_funcs->set_dma_mask_from_fw(hdev);
+
 	/* Point to DRAM */
 	if (!hdev->asic_funcs->set_dram_bar_base)
 		return -EINVAL;
@@ -274,7 +280,6 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 								U64_MAX)
 		return -EIO;
 
-
 	/* Outbound Region 0 - Point to Host */
 	host_phys_end_addr = host_phys_base_address + host_phys_size - 1;
 	rc |= hl_pci_iatu_write(hdev, 0x008,
@@ -283,7 +288,12 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 				upper_32_bits(host_phys_base_address));
 	rc |= hl_pci_iatu_write(hdev, 0x010, lower_32_bits(host_phys_end_addr));
 	rc |= hl_pci_iatu_write(hdev, 0x014, 0);
-	rc |= hl_pci_iatu_write(hdev, 0x018, 0);
+
+	if ((hdev->power9_64bit_dma_enable) && (hdev->dma_mask == 64))
+		rc |= hl_pci_iatu_write(hdev, 0x018, 0x08000000);
+	else
+		rc |= hl_pci_iatu_write(hdev, 0x018, 0);
+
 	rc |= hl_pci_iatu_write(hdev, 0x020, upper_32_bits(host_phys_end_addr));
 	/* Increase region size */
 	rc |= hl_pci_iatu_write(hdev, 0x000, 0x00002000);
@@ -310,41 +320,25 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
  *
  * Return: 0 on success, non-zero for failure.
  */
-int hl_pci_set_dma_mask(struct hl_device *hdev, u8 dma_mask)
+int hl_pci_set_dma_mask(struct hl_device *hdev)
 {
 	struct pci_dev *pdev = hdev->pdev;
 	int rc;
 
 	/* set DMA mask */
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(dma_mask));
+	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(hdev->dma_mask));
 	if (rc) {
-		dev_warn(hdev->dev,
+		dev_err(hdev->dev,
 			"Failed to set pci dma mask to %d bits, error %d\n",
-			dma_mask, rc);
-
-		dma_mask = hdev->dma_mask;
-
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(dma_mask));
-		if (rc) {
-			dev_err(hdev->dev,
-				"Failed to set pci dma mask to %d bits, error %d\n",
-				dma_mask, rc);
-			return rc;
-		}
+			hdev->dma_mask, rc);
+		return rc;
 	}
 
-	/*
-	 * We managed to set the dma mask, so update the dma mask field. If
-	 * the set to the coherent mask will fail with that mask, we will
-	 * fail the entire function
-	 */
-	hdev->dma_mask = dma_mask;
-
-	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(dma_mask));
+	rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(hdev->dma_mask));
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to set pci consistent dma mask to %d bits, error %d\n",
-			dma_mask, rc);
+			hdev->dma_mask, rc);
 		return rc;
 	}
 
@@ -354,21 +348,16 @@ int hl_pci_set_dma_mask(struct hl_device *hdev, u8 dma_mask)
 /**
  * hl_pci_init() - PCI initialization code.
  * @hdev: Pointer to hl_device structure.
- * @dma_mask: number of bits for the requested dma mask.
  *
  * Set DMA masks, initialize the PCI controller and map the PCI BARs.
  *
  * Return: 0 on success, non-zero for failure.
  */
-int hl_pci_init(struct hl_device *hdev, u8 dma_mask)
+int hl_pci_init(struct hl_device *hdev)
 {
 	struct pci_dev *pdev = hdev->pdev;
 	int rc;
 
-	rc = hl_pci_set_dma_mask(hdev, dma_mask);
-	if (rc)
-		return rc;
-
 	if (hdev->reset_pcilink)
 		hl_pci_reset_link_through_bridge(hdev);
 
@@ -380,18 +369,22 @@ int hl_pci_init(struct hl_device *hdev, u8 dma_mask)
 
 	pci_set_master(pdev);
 
-	rc = hdev->asic_funcs->init_iatu(hdev);
+	rc = hdev->asic_funcs->pci_bars_map(hdev);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to initialize iATU\n");
+		dev_err(hdev->dev, "Failed to initialize PCI BARs\n");
 		goto disable_device;
 	}
 
-	rc = hdev->asic_funcs->pci_bars_map(hdev);
+	rc = hdev->asic_funcs->init_iatu(hdev);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to initialize PCI BARs\n");
+		dev_err(hdev->dev, "Failed to initialize iATU\n");
 		goto disable_device;
 	}
 
+	rc = hl_pci_set_dma_mask(hdev);
+	if (rc)
+		goto disable_device;
+
 	return 0;
 
 disable_device:
-- 
2.17.1

