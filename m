Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE8C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD247217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc+5j7+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgBGIQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:16:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52442 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGIQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:16:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so1585324wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 00:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iVAUb0rvplQHuTS8/Vg1kE2b2vKYHCDiedndogkZP/Q=;
        b=kc+5j7+WZ/ClnAkYQVPHA9NrZ0i+eqs0Gqr0erVkNzP90YVWIhj6QD+OqnImXn/ROG
         NXWoohVsDt9uDnk4BUSudl6AZJEdwdbzcONRFbUYiIW7ZMqUn6ArNkn8+3WKchZxmmia
         hDOcsKrj5Lyhpb5JIbl3pIuSACbJRd3XGdiuA7jQKtP9I1MlUep+MCYJY7miJvehyevk
         5j2Tx9PA2gLOeDEcMgtsoKeFDkm/4grZHQ7eEDcjQ2SRwpxG0zk6VsoVJ5C+7YWlW6pp
         MpIqixzE6gjoNYQ7Tjly+Ny6TIfCgM5iRAfKWfhjAWCUcwwqJphbSWopZDpkJINTWpOG
         0emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iVAUb0rvplQHuTS8/Vg1kE2b2vKYHCDiedndogkZP/Q=;
        b=CY36+5atqnDM+GIljWx3smlxK+9D7b0uX2cGqorBGnSPLzI3sMOZ/Ea9hBUwYgMEmm
         lFTI7IlUcVPKLwKVzdi/HTc85fV6VGszPWpDxb3VAExMv08bnHoBGkVkvoFi7pK96w/D
         sJlTx3MUfRkzeVzaHGF5bR0qVuHdB7IsUz9fAXUBL3dUmgGwKc+1tkrX3BXBKic3QH02
         8FqZtlbZLreHKOdS/Nc4ig66jXAAUFXQ54546cvVjsQalYEB6E7YlDZ6uWEwhxGvN4qv
         KeSlSHGk+Wup9+XVsbUX5xUGDCPyjoZRNzG7UsL0tgq/Wn47RE+XpmPUC3PRKat2gtON
         EY9w==
X-Gm-Message-State: APjAAAX6uFCRCOSBaxf2rB9sAjF4vn/YaIpyNNruY3oSKzfg0WRNJPwt
        MZGhScD/rWCeiSStKMAIRzbiu8ew94Q=
X-Google-Smtp-Source: APXvYqwio79k2x5b1Bbw3Va/uh/Ai+WgbreuQ4XEB4Fwrivz3ApcQyRj0FIu4YOrM7PaH366uyAtNQ==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr2913288wmi.58.1581063366750;
        Fri, 07 Feb 2020 00:16:06 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o4sm2466182wrx.25.2020.02.07.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 00:16:05 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 1/5] habanalabs: add debugfs write64/read64
Date:   Fri,  7 Feb 2020 10:15:16 +0200
Message-Id: <20200207081520.5368-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

Allow debug user to write/read 64-bit data through debugfs.
This will expedite the dump process of the (large) internal
memories of the device done during debug.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../ABI/testing/debugfs-driver-habanalabs     | 14 +++
 drivers/misc/habanalabs/debugfs.c             | 71 ++++++++++++++
 drivers/misc/habanalabs/goya/goya.c           | 92 +++++++++++++++++++
 drivers/misc/habanalabs/habanalabs.h          |  2 +
 4 files changed, 179 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index f0ac14b70ecb..a73601c5121e 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -43,6 +43,20 @@ Description:    Allows the root user to read or write directly through the
                 If the IOMMU is disabled, it also allows the root user to read
                 or write from the host a device VA of a host mapped memory
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/data64
+Date:           Jan 2020
+KernelVersion:  5.6
+Contact:        oded.gabbay@gmail.com
+Description:    Allows the root user to read or write 64 bit data directly
+                through the device's PCI bar. Writing to this file generates a
+                write transaction while reading from the file generates a read
+                transaction. This custom interface is needed (instead of using
+                the generic Linux user-space PCI mapping) because the DDR bar
+                is very small compared to the DDR memory and only the driver can
+                move the bar before and after the transaction.
+                If the IOMMU is disabled, it also allows the root user to read
+                or write from the host a device VA of a host mapped memory
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/device
 Date:           Jan 2019
 KernelVersion:  5.1
diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index 599d17dfd542..756d36ed5d95 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -710,6 +710,65 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
 	return count;
 }
 
+static ssize_t hl_data_read64(struct file *f, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	char tmp_buf[32];
+	u64 addr = entry->addr;
+	u64 val;
+	ssize_t rc;
+
+	if (*ppos)
+		return 0;
+
+	if (hl_is_device_va(hdev, addr)) {
+		rc = device_va_to_pa(hdev, addr, &addr);
+		if (rc)
+			return rc;
+	}
+
+	rc = hdev->asic_funcs->debugfs_read64(hdev, addr, &val);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to read from 0x%010llx\n", addr);
+		return rc;
+	}
+
+	sprintf(tmp_buf, "0x%016llx\n", val);
+	return simple_read_from_buffer(buf, count, ppos, tmp_buf,
+			strlen(tmp_buf));
+}
+
+static ssize_t hl_data_write64(struct file *f, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u64 addr = entry->addr;
+	u64 value;
+	ssize_t rc;
+
+	rc = kstrtoull_from_user(buf, count, 16, &value);
+	if (rc)
+		return rc;
+
+	if (hl_is_device_va(hdev, addr)) {
+		rc = device_va_to_pa(hdev, addr, &addr);
+		if (rc)
+			return rc;
+	}
+
+	rc = hdev->asic_funcs->debugfs_write64(hdev, addr, value);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to write 0x%016llx to 0x%010llx\n",
+			value, addr);
+		return rc;
+	}
+
+	return count;
+}
+
 static ssize_t hl_get_power_state(struct file *f, char __user *buf,
 		size_t count, loff_t *ppos)
 {
@@ -917,6 +976,12 @@ static const struct file_operations hl_data32b_fops = {
 	.write = hl_data_write32
 };
 
+static const struct file_operations hl_data64b_fops = {
+	.owner = THIS_MODULE,
+	.read = hl_data_read64,
+	.write = hl_data_write64
+};
+
 static const struct file_operations hl_i2c_data_fops = {
 	.owner = THIS_MODULE,
 	.read = hl_i2c_data_read,
@@ -1030,6 +1095,12 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 				dev_entry,
 				&hl_data32b_fops);
 
+	debugfs_create_file("data64",
+				0644,
+				dev_entry->root,
+				dev_entry,
+				&hl_data64b_fops);
+
 	debugfs_create_file("set_power_state",
 				0200,
 				dev_entry->root,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index f634e9c5cad9..0b6567b48622 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4180,6 +4180,96 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
 	return rc;
 }
 
+static int goya_debugfs_read64(struct hl_device *hdev, u64 addr, u64 *val)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 ddr_bar_addr;
+	int rc = 0;
+
+	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
+		u32 val_l = RREG32(addr - CFG_BASE);
+		u32 val_h = RREG32(addr + sizeof(u32) - CFG_BASE);
+
+		*val = (((u64) val_h) << 32) | val_l;
+
+	} else if ((addr >= SRAM_BASE_ADDR) &&
+			(addr <= SRAM_BASE_ADDR + SRAM_SIZE - sizeof(u64))) {
+
+		*val = readq(hdev->pcie_bar[SRAM_CFG_BAR_ID] +
+				(addr - SRAM_BASE_ADDR));
+
+	} else if ((addr >= DRAM_PHYS_BASE) &&
+		   (addr <=
+		    DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64))) {
+
+		u64 bar_base_addr = DRAM_PHYS_BASE +
+				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
+
+		ddr_bar_addr = goya_set_ddr_bar_base(hdev, bar_base_addr);
+		if (ddr_bar_addr != U64_MAX) {
+			*val = readq(hdev->pcie_bar[DDR_BAR_ID] +
+						(addr - bar_base_addr));
+
+			ddr_bar_addr = goya_set_ddr_bar_base(hdev,
+							ddr_bar_addr);
+		}
+		if (ddr_bar_addr == U64_MAX)
+			rc = -EIO;
+
+	} else if (addr >= HOST_PHYS_BASE && !iommu_present(&pci_bus_type)) {
+		*val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
+
+	} else {
+		rc = -EFAULT;
+	}
+
+	return rc;
+}
+
+static int goya_debugfs_write64(struct hl_device *hdev, u64 addr, u64 val)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 ddr_bar_addr;
+	int rc = 0;
+
+	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
+		WREG32(addr - CFG_BASE, lower_32_bits(val));
+		WREG32(addr + sizeof(u32) - CFG_BASE, upper_32_bits(val));
+
+	} else if ((addr >= SRAM_BASE_ADDR) &&
+			(addr <= SRAM_BASE_ADDR + SRAM_SIZE - sizeof(u64))) {
+
+		writeq(val, hdev->pcie_bar[SRAM_CFG_BAR_ID] +
+					(addr - SRAM_BASE_ADDR));
+
+	} else if ((addr >= DRAM_PHYS_BASE) &&
+		   (addr <=
+		    DRAM_PHYS_BASE + hdev->asic_prop.dram_size - sizeof(u64))) {
+
+		u64 bar_base_addr = DRAM_PHYS_BASE +
+				(addr & ~(prop->dram_pci_bar_size - 0x1ull));
+
+		ddr_bar_addr = goya_set_ddr_bar_base(hdev, bar_base_addr);
+		if (ddr_bar_addr != U64_MAX) {
+			writeq(val, hdev->pcie_bar[DDR_BAR_ID] +
+						(addr - bar_base_addr));
+
+			ddr_bar_addr = goya_set_ddr_bar_base(hdev,
+							ddr_bar_addr);
+		}
+		if (ddr_bar_addr == U64_MAX)
+			rc = -EIO;
+
+	} else if (addr >= HOST_PHYS_BASE && !iommu_present(&pci_bus_type)) {
+		*(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
+
+	} else {
+		rc = -EFAULT;
+	}
+
+	return rc;
+}
+
 static u64 goya_read_pte(struct hl_device *hdev, u64 addr)
 {
 	struct goya_device *goya = hdev->asic_specific;
@@ -5186,6 +5276,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.restore_phase_topology = goya_restore_phase_topology,
 	.debugfs_read32 = goya_debugfs_read32,
 	.debugfs_write32 = goya_debugfs_write32,
+	.debugfs_read64 = goya_debugfs_read64,
+	.debugfs_write64 = goya_debugfs_write64,
 	.add_device_attr = goya_add_device_attr,
 	.handle_eqe = goya_handle_eqe,
 	.set_pll_profile = goya_set_pll_profile,
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 954906292c00..4ef8cf23d099 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -582,6 +582,8 @@ struct hl_asic_funcs {
 	void (*restore_phase_topology)(struct hl_device *hdev);
 	int (*debugfs_read32)(struct hl_device *hdev, u64 addr, u32 *val);
 	int (*debugfs_write32)(struct hl_device *hdev, u64 addr, u32 val);
+	int (*debugfs_read64)(struct hl_device *hdev, u64 addr, u64 *val);
+	int (*debugfs_write64)(struct hl_device *hdev, u64 addr, u64 val);
 	void (*add_device_attr)(struct hl_device *hdev,
 				struct attribute_group *dev_attr_grp);
 	void (*handle_eqe)(struct hl_device *hdev,
-- 
2.17.1

