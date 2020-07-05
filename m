Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D77C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5462082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjyTcrpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgGENNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgGENM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:12:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B41C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 06:12:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so38818959wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 06:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n7Y/zVdOKqLuno8Yixftnikfz4wKD43hZ0855z/7APQ=;
        b=HjyTcrponLlK3Kz6kAmXcE1pikP6mugoWsMLFhRzRdIxZMVDHiW+6ItxOBaIMnWV5I
         3K9kHGykLKEqmpG8k1ucO1317PhWkib9sS/T7/wwilCfsLiHvimlhFj8IBOhEXeCb0Bf
         RBDs/5NOLK0cOCHYxRWqf5vHLA7Q6P7vZMenwo3OBlAnG8CKrpDKYG66SCuUcz2GFsYO
         eNJPxktIT/UpYIwvCtH6TJcrBLKiDQH0QoLZC8sDztOxxhzUS3+GC2TLmW54iqXv8rtB
         Veg88mEhGF027Nx/jry7YY19unIZTu6tDmTA3spZgwANwPH0SK42Z3+CeFL79fy3BHyJ
         l7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n7Y/zVdOKqLuno8Yixftnikfz4wKD43hZ0855z/7APQ=;
        b=hXv5Q+XwUzrXdMIAVk4pEvQyCs7YDmNR18iFBDwDOL2Lc2kIIGbwDs8kSs/f4sscdq
         YU7y7oPoIKQ4/tu+FNWWOMhDe7fCa1yUKamfpF1JMMxtpuRjRU7XIRSTFEKVSxnvCrc3
         0lHI5hx2vGLss7l8rYDb4KjmKORSc1GgtwKrek+jlxrhRR9ESX39vPJNKom8cTespcGx
         k2bJe4nJIXstStukcfRvST5mnB/DzmEi7kkKS3ZtP4IlJbwGh0SzfQLeGTMOsV8ZDOZl
         OjR0tJqOXDxUFSMhcj79ujgyOhEgC9b9wpK0Yumtumvj5+p5eVt2agg9m2s/rVYgOR1b
         74/A==
X-Gm-Message-State: AOAM532pHkPSLWeuhRQNFMOYTlyP5zP3yoI7URKGnehoZMOIuDIWUFWf
        cbxdDlgal38Zl0wIMKRGBouMRQtf
X-Google-Smtp-Source: ABdhPJzIg2+gXyc84U6CaA9QKDlO7EBlbFAkO88U0lVcRBmEPgliZWXIbYRjQn7FyG6CCqxz4is8mg==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr43213565wmk.138.1593954774698;
        Sun, 05 Jul 2020 06:12:54 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 26sm19401809wmj.25.2020.07.05.06.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:12:53 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 6/9] habanalabs: PCIe iATU refactoring
Date:   Sun,  5 Jul 2020 16:12:42 +0300
Message-Id: <20200705131245.9368-6-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705131245.9368-1-oded.gabbay@gmail.com>
References: <20200705131245.9368-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Divide iATU initialization into inbound/outbound methods.
We must separate it in order to enable different match mode
per PCIe region.
In addition, added support for PCI address match mode.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c |  59 ++++++-----
 drivers/misc/habanalabs/goya/goya.c   |  37 ++++++-
 drivers/misc/habanalabs/habanalabs.h  |  52 +++++++++-
 drivers/misc/habanalabs/pci.c         | 136 ++++++++++++--------------
 4 files changed, 180 insertions(+), 104 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 888f42adee6a..a6e40dec3cd2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -465,6 +465,7 @@ static int gaudi_pci_bars_map(struct hl_device *hdev)
 static u64 gaudi_set_hbm_bar_base(struct hl_device *hdev, u64 addr)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
+	struct hl_inbound_pci_region pci_region;
 	u64 old_addr = addr;
 	int rc;
 
@@ -472,7 +473,10 @@ static u64 gaudi_set_hbm_bar_base(struct hl_device *hdev, u64 addr)
 		return old_addr;
 
 	/* Inbound Region 2 - Bar 4 - Point to HBM */
-	rc = hl_pci_set_dram_bar_base(hdev, 2, 4, addr);
+	pci_region.mode = PCI_BAR_MATCH_MODE;
+	pci_region.bar = HBM_BAR_ID;
+	pci_region.addr = addr;
+	rc = hl_pci_set_inbound_region(hdev, 2, &pci_region);
 	if (rc)
 		return U64_MAX;
 
@@ -486,22 +490,43 @@ static u64 gaudi_set_hbm_bar_base(struct hl_device *hdev, u64 addr)
 
 static int gaudi_init_iatu(struct hl_device *hdev)
 {
-	int rc = 0;
+	struct hl_inbound_pci_region inbound_region;
+	struct hl_outbound_pci_region outbound_region;
+	int rc;
+
+	/* Inbound Region 0 - Bar 0 - Point to SRAM + CFG */
+	inbound_region.mode = PCI_BAR_MATCH_MODE;
+	inbound_region.bar = SRAM_BAR_ID;
+	inbound_region.addr = SRAM_BASE_ADDR;
+	rc = hl_pci_set_inbound_region(hdev, 0, &inbound_region);
+	if (rc)
+		goto done;
 
 	/* Inbound Region 1 - Bar 2 - Point to SPI FLASH */
-	rc  = hl_pci_iatu_write(hdev, 0x314,
-				lower_32_bits(SPI_FLASH_BASE_ADDR));
-	rc |= hl_pci_iatu_write(hdev, 0x318,
-				upper_32_bits(SPI_FLASH_BASE_ADDR));
-	rc |= hl_pci_iatu_write(hdev, 0x300, 0);
-	/* Enable + Bar match + match enable */
-	rc |= hl_pci_iatu_write(hdev, 0x304, 0xC0080200);
+	inbound_region.mode = PCI_BAR_MATCH_MODE;
+	inbound_region.bar = CFG_BAR_ID;
+	inbound_region.addr = SPI_FLASH_BASE_ADDR;
+	rc = hl_pci_set_inbound_region(hdev, 1, &inbound_region);
+	if (rc)
+		goto done;
 
+	/* Inbound Region 2 - Bar 4 - Point to HBM */
+	inbound_region.mode = PCI_BAR_MATCH_MODE;
+	inbound_region.bar = HBM_BAR_ID;
+	inbound_region.addr = DRAM_PHYS_BASE;
+	rc = hl_pci_set_inbound_region(hdev, 2, &inbound_region);
 	if (rc)
-		return -EIO;
+		goto done;
+
+	hdev->asic_funcs->set_dma_mask_from_fw(hdev);
 
-	return hl_pci_init_iatu(hdev, SRAM_BASE_ADDR, DRAM_PHYS_BASE,
-				HOST_PHYS_BASE, HOST_PHYS_SIZE);
+	/* Outbound Region 0 - Point to Host */
+	outbound_region.addr = HOST_PHYS_BASE;
+	outbound_region.size = HOST_PHYS_SIZE;
+	rc = hl_pci_set_outbound_region(hdev, &outbound_region);
+
+done:
+	return rc;
 }
 
 static int gaudi_early_init(struct hl_device *hdev)
@@ -2884,16 +2909,6 @@ static int gaudi_hw_init(struct hl_device *hdev)
 
 	gaudi_init_hbm_dma_qmans(hdev);
 
-	/*
-	 * Before pushing u-boot/linux to device, need to set the hbm bar to
-	 * base address of dram
-	 */
-	if (gaudi_set_hbm_bar_base(hdev, DRAM_PHYS_BASE) == U64_MAX) {
-		dev_err(hdev->dev,
-			"failed to map HBM bar to DRAM base address\n");
-		return -EIO;
-	}
-
 	rc = gaudi_init_cpu(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize CPU\n");
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ff32a8fa7624..5839b5bc9ee3 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -458,6 +458,7 @@ static int goya_pci_bars_map(struct hl_device *hdev)
 static u64 goya_set_ddr_bar_base(struct hl_device *hdev, u64 addr)
 {
 	struct goya_device *goya = hdev->asic_specific;
+	struct hl_inbound_pci_region pci_region;
 	u64 old_addr = addr;
 	int rc;
 
@@ -465,7 +466,10 @@ static u64 goya_set_ddr_bar_base(struct hl_device *hdev, u64 addr)
 		return old_addr;
 
 	/* Inbound Region 1 - Bar 4 - Point to DDR */
-	rc = hl_pci_set_dram_bar_base(hdev, 1, 4, addr);
+	pci_region.mode = PCI_BAR_MATCH_MODE;
+	pci_region.bar = DDR_BAR_ID;
+	pci_region.addr = addr;
+	rc = hl_pci_set_inbound_region(hdev, 1, &pci_region);
 	if (rc)
 		return U64_MAX;
 
@@ -487,8 +491,35 @@ static u64 goya_set_ddr_bar_base(struct hl_device *hdev, u64 addr)
  */
 static int goya_init_iatu(struct hl_device *hdev)
 {
-	return hl_pci_init_iatu(hdev, SRAM_BASE_ADDR, DRAM_PHYS_BASE,
-				HOST_PHYS_BASE, HOST_PHYS_SIZE);
+	struct hl_inbound_pci_region inbound_region;
+	struct hl_outbound_pci_region outbound_region;
+	int rc;
+
+	/* Inbound Region 0 - Bar 0 - Point to SRAM and CFG */
+	inbound_region.mode = PCI_BAR_MATCH_MODE;
+	inbound_region.bar = SRAM_CFG_BAR_ID;
+	inbound_region.addr = SRAM_BASE_ADDR;
+	rc = hl_pci_set_inbound_region(hdev, 0, &inbound_region);
+	if (rc)
+		goto done;
+
+	/* Inbound Region 1 - Bar 4 - Point to DDR */
+	inbound_region.mode = PCI_BAR_MATCH_MODE;
+	inbound_region.bar = DDR_BAR_ID;
+	inbound_region.addr = DRAM_PHYS_BASE;
+	rc = hl_pci_set_inbound_region(hdev, 1, &inbound_region);
+	if (rc)
+		goto done;
+
+	hdev->asic_funcs->set_dma_mask_from_fw(hdev);
+
+	/* Outbound Region 0 - Point to Host  */
+	outbound_region.addr = HOST_PHYS_BASE;
+	outbound_region.size = HOST_PHYS_SIZE;
+	rc = hl_pci_set_outbound_region(hdev, &outbound_region);
+
+done:
+	return rc;
 }
 
 /*
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index ae781453a509..365236589bbf 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -66,6 +66,8 @@
 #define IS_POWER_OF_2(n)		(n != 0 && ((n & (n - 1)) == 0))
 #define IS_MAX_PENDING_CS_VALID(n)	(IS_POWER_OF_2(n) && (n > 1))
 
+#define HL_PCI_NUM_BARS			6
+
 /**
  * struct pgt_info - MMU hop page info.
  * @node: hash linked-list node for the pgts shadow hash of pgts.
@@ -90,6 +92,16 @@ struct pgt_info {
 struct hl_device;
 struct hl_fpriv;
 
+/**
+ * enum hl_pci_match_mode - pci match mode per region
+ * @PCI_ADDRESS_MATCH_MODE: address match mode
+ * @PCI_BAR_MATCH_MODE: bar match mode
+ */
+enum hl_pci_match_mode {
+	PCI_ADDRESS_MATCH_MODE,
+	PCI_BAR_MATCH_MODE
+};
+
 /**
  * enum hl_fw_component - F/W components to read version through registers.
  * @FW_COMP_UBOOT: u-boot.
@@ -125,6 +137,32 @@ enum hl_cs_type {
 	CS_TYPE_WAIT
 };
 
+/*
+ * struct hl_inbound_pci_region - inbound region descriptor
+ * @mode: pci match mode for this region
+ * @addr: region target address
+ * @size: region size in bytes
+ * @offset_in_bar: offset within bar (address match mode)
+ * @bar: bar id
+ */
+struct hl_inbound_pci_region {
+	enum hl_pci_match_mode	mode;
+	u64			addr;
+	u64			size;
+	u64			offset_in_bar;
+	u8			bar;
+};
+
+/*
+ * struct hl_outbound_pci_region - outbound region descriptor
+ * @addr: region target address
+ * @size: region size in bytes
+ */
+struct hl_outbound_pci_region {
+	u64	addr;
+	u64	size;
+};
+
 /*
  * struct hl_hw_sob - H/W SOB info.
  * @hdev: habanalabs device structure.
@@ -1347,7 +1385,9 @@ struct hl_device_idle_busy_ts {
 /**
  * struct hl_device - habanalabs device structure.
  * @pdev: pointer to PCI device, can be NULL in case of simulator device.
- * @pcie_bar: array of available PCIe bars.
+ * @pcie_bar_phys: array of available PCIe bars physical addresses.
+ *		   (required only for PCI address match mode)
+ * @pcie_bar: array of available PCIe bars virtual addresses.
  * @rmmio: configuration area address on SRAM.
  * @cdev: related char device.
  * @cdev_ctrl: char device for control operations only (INFO IOCTL)
@@ -1442,7 +1482,8 @@ struct hl_device_idle_busy_ts {
  */
 struct hl_device {
 	struct pci_dev			*pdev;
-	void __iomem			*pcie_bar[6];
+	u64				pcie_bar_phys[HL_PCI_NUM_BARS];
+	void __iomem			*pcie_bar[HL_PCI_NUM_BARS];
 	void __iomem			*rmmio;
 	struct cdev			cdev;
 	struct cdev			cdev_ctrl;
@@ -1767,9 +1808,10 @@ int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 int hl_pci_iatu_write(struct hl_device *hdev, u32 addr, u32 data);
 int hl_pci_set_dram_bar_base(struct hl_device *hdev, u8 inbound_region, u8 bar,
 				u64 addr);
-int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
-			u64 dram_base_address, u64 host_phys_base_address,
-			u64 host_phys_size);
+int hl_pci_set_inbound_region(struct hl_device *hdev, u8 region,
+		struct hl_inbound_pci_region *pci_region);
+int hl_pci_set_outbound_region(struct hl_device *hdev,
+		struct hl_outbound_pci_region *pci_region);
 int hl_pci_init(struct hl_device *hdev);
 void hl_pci_fini(struct hl_device *hdev);
 
diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
index 61a8bb07262c..1791f6623c69 100644
--- a/drivers/misc/habanalabs/pci.c
+++ b/drivers/misc/habanalabs/pci.c
@@ -9,9 +9,15 @@
 #include "include/hw_ip/pci/pci_general.h"
 
 #include <linux/pci.h>
+#include <linux/bitfield.h>
 
 #define HL_PLDM_PCI_ELBI_TIMEOUT_MSEC	(HL_PCI_ELBI_TIMEOUT_MSEC * 10)
 
+#define IATU_REGION_CTRL_REGION_EN_MASK		BIT(31)
+#define IATU_REGION_CTRL_MATCH_MODE_MASK	BIT(30)
+#define IATU_REGION_CTRL_NUM_MATCH_EN_MASK	BIT(19)
+#define IATU_REGION_CTRL_BAR_NUM_MASK		GENMASK(10, 8)
+
 /**
  * hl_pci_bars_map() - Map PCI BARs.
  * @hdev: Pointer to hl_device structure.
@@ -187,110 +193,94 @@ static void hl_pci_reset_link_through_bridge(struct hl_device *hdev)
 }
 
 /**
- * hl_pci_set_dram_bar_base() - Set DDR BAR to map specific device address.
+ * hl_pci_set_inbound_region() - Configure inbound region
  * @hdev: Pointer to hl_device structure.
- * @inbound_region: Inbound region number.
- * @bar: PCI BAR number.
- * @addr: Address in DRAM. Must be aligned to DRAM bar size.
+ * @region: Inbound region number.
+ * @pci_region: Inbound region parameters.
  *
- * Configure the iATU so that the DRAM bar will start at the specified address.
+ * Configure the iATU inbound region.
  *
  * Return: 0 on success, negative value for failure.
  */
-int hl_pci_set_dram_bar_base(struct hl_device *hdev, u8 inbound_region, u8 bar,
-				u64 addr)
+int hl_pci_set_inbound_region(struct hl_device *hdev, u8 region,
+		struct hl_inbound_pci_region *pci_region)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u32 offset;
-	int rc;
+	u64 bar_phys_base, region_base, region_end_address;
+	u32 offset, ctrl_reg_val;
+	int rc = 0;
 
-	switch (inbound_region) {
-	case 0:
-		offset = 0x100;
-		break;
-	case 1:
-		offset = 0x300;
-		break;
-	case 2:
-		offset = 0x500;
-		break;
-	default:
-		dev_err(hdev->dev, "Invalid inbound region %d\n",
-			inbound_region);
-		return -EINVAL;
-	}
+	/* region offset */
+	offset = (0x200 * region) + 0x100;
+
+	if (pci_region->mode == PCI_ADDRESS_MATCH_MODE) {
+		bar_phys_base = hdev->pcie_bar_phys[pci_region->bar];
+		region_base = bar_phys_base + pci_region->offset_in_bar;
+		region_end_address = region_base + pci_region->size - 1;
 
-	if (bar != 0 && bar != 2 && bar != 4) {
-		dev_err(hdev->dev, "Invalid PCI BAR %d\n", bar);
-		return -EINVAL;
+		rc |= hl_pci_iatu_write(hdev, offset + 0x8,
+				lower_32_bits(region_base));
+		rc |= hl_pci_iatu_write(hdev, offset + 0xC,
+				upper_32_bits(region_base));
+		rc |= hl_pci_iatu_write(hdev, offset + 0x10,
+				lower_32_bits(region_end_address));
 	}
 
 	/* Point to the specified address */
-	rc = hl_pci_iatu_write(hdev, offset + 0x14, lower_32_bits(addr));
-	rc |= hl_pci_iatu_write(hdev, offset + 0x18, upper_32_bits(addr));
+	rc = hl_pci_iatu_write(hdev, offset + 0x14,
+			lower_32_bits(pci_region->addr));
+	rc |= hl_pci_iatu_write(hdev, offset + 0x18,
+			upper_32_bits(pci_region->addr));
 	rc |= hl_pci_iatu_write(hdev, offset + 0x0, 0);
-	/* Enable + BAR match + match enable + BAR number */
-	rc |= hl_pci_iatu_write(hdev, offset + 0x4, 0xC0080000 | (bar << 8));
+
+	/* Enable + bar/address match + match enable + bar number */
+	ctrl_reg_val = FIELD_PREP(IATU_REGION_CTRL_REGION_EN_MASK, 1);
+	ctrl_reg_val |= FIELD_PREP(IATU_REGION_CTRL_MATCH_MODE_MASK,
+			pci_region->mode);
+	ctrl_reg_val |= FIELD_PREP(IATU_REGION_CTRL_NUM_MATCH_EN_MASK, 1);
+
+	if (pci_region->mode == PCI_BAR_MATCH_MODE)
+		ctrl_reg_val |= FIELD_PREP(IATU_REGION_CTRL_BAR_NUM_MASK,
+				pci_region->bar);
+
+	rc |= hl_pci_iatu_write(hdev, offset + 0x4, ctrl_reg_val);
 
 	/* Return the DBI window to the default location */
 	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0);
 	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr + 4, 0);
 
 	if (rc)
-		dev_err(hdev->dev, "failed to map DRAM bar to 0x%08llx\n",
-			addr);
+		dev_err(hdev->dev, "failed to map bar %u to 0x%08llx\n",
+				pci_region->bar, pci_region->addr);
 
 	return rc;
 }
 
 /**
- * hl_pci_init_iatu() - Initialize the iATU unit inside the PCI controller.
+ * hl_pci_set_outbound_region() - Configure outbound region 0
  * @hdev: Pointer to hl_device structure.
- * @sram_base_address: SRAM base address.
- * @dram_base_address: DRAM base address.
- * @host_phys_base_address: Base physical address of host memory for device
- *                          transactions.
- * @host_phys_size: Size of host memory for device transactions.
+ * @pci_region: Outbound region parameters.
  *
- * This is needed in case the firmware doesn't initialize the iATU.
+ * Configure the iATU outbound region 0.
  *
  * Return: 0 on success, negative value for failure.
  */
-int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
-			u64 dram_base_address, u64 host_phys_base_address,
-			u64 host_phys_size)
+int hl_pci_set_outbound_region(struct hl_device *hdev,
+		struct hl_outbound_pci_region *pci_region)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 host_phys_end_addr;
+	u64 outbound_region_end_address;
 	int rc = 0;
 
-	/* Inbound Region 0 - Bar 0 - Point to SRAM base address */
-	rc  = hl_pci_iatu_write(hdev, 0x114, lower_32_bits(sram_base_address));
-	rc |= hl_pci_iatu_write(hdev, 0x118, upper_32_bits(sram_base_address));
-	rc |= hl_pci_iatu_write(hdev, 0x100, 0);
-	/* Enable + Bar match + match enable */
-	rc |= hl_pci_iatu_write(hdev, 0x104, 0xC0080000);
-
-	/* Return the DBI window to the default location */
-	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0);
-	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr + 4, 0);
-
-	hdev->asic_funcs->set_dma_mask_from_fw(hdev);
-
-	/* Point to DRAM */
-	if (!hdev->asic_funcs->set_dram_bar_base)
-		return -EINVAL;
-	if (hdev->asic_funcs->set_dram_bar_base(hdev, dram_base_address) ==
-								U64_MAX)
-		return -EIO;
-
-	/* Outbound Region 0 - Point to Host */
-	host_phys_end_addr = host_phys_base_address + host_phys_size - 1;
+	/* Outbound Region 0 */
+	outbound_region_end_address =
+			pci_region->addr + pci_region->size - 1;
 	rc |= hl_pci_iatu_write(hdev, 0x008,
-				lower_32_bits(host_phys_base_address));
+				lower_32_bits(pci_region->addr));
 	rc |= hl_pci_iatu_write(hdev, 0x00C,
-				upper_32_bits(host_phys_base_address));
-	rc |= hl_pci_iatu_write(hdev, 0x010, lower_32_bits(host_phys_end_addr));
+				upper_32_bits(pci_region->addr));
+	rc |= hl_pci_iatu_write(hdev, 0x010,
+				lower_32_bits(outbound_region_end_address));
 	rc |= hl_pci_iatu_write(hdev, 0x014, 0);
 
 	if ((hdev->power9_64bit_dma_enable) && (hdev->dma_mask == 64))
@@ -298,7 +288,8 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 	else
 		rc |= hl_pci_iatu_write(hdev, 0x018, 0);
 
-	rc |= hl_pci_iatu_write(hdev, 0x020, upper_32_bits(host_phys_end_addr));
+	rc |= hl_pci_iatu_write(hdev, 0x020,
+				upper_32_bits(outbound_region_end_address));
 	/* Increase region size */
 	rc |= hl_pci_iatu_write(hdev, 0x000, 0x00002000);
 	/* Enable */
@@ -308,10 +299,7 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr, 0);
 	rc |= hl_pci_elbi_write(hdev, prop->pcie_aux_dbi_reg_addr + 4, 0);
 
-	if (rc)
-		return -EIO;
-
-	return 0;
+	return rc;
 }
 
 /**
-- 
2.17.1

