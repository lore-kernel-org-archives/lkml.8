Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBF5C433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D44C206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgG1PZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:25:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:3762 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730701AbgG1PZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:25:51 -0400
IronPort-SDR: Ku7IxXp62Xzqa6F+mEI8vRl27uAUDUzhVusbPYbq6fRBEI4jtdvLigzUPCoP0WNgsKm9P40RfT
 EWAsxEFzRu+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="150409036"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="150409036"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 08:25:50 -0700
IronPort-SDR: S+NIIajoxSJJXxGOwb3/qiihL32pcIacRxoymHdUWL6h25o8xTRO8ka3FFFSrigEUXAoA6WUo5
 Dq2LloTeOeWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="272345281"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jul 2020 08:25:49 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] mei: add device type
Date:   Tue, 28 Jul 2020 18:25:46 +0300
Message-Id: <20200728152546.3041841-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Some of the device heads are not generic and have
specific purpose, we need to announce it to the user space
so it can detect and correct device node via matching
attributes.

Generic devices are marked as 'mei' while special
purpose their own names. Currently we are adding
'itouch' string for Intel IPTS devices.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.c   | 12 ++++++++++++
 drivers/misc/mei/hw-me.h   |  5 +++++
 drivers/misc/mei/hw-txe.c  |  1 +
 drivers/misc/mei/main.c    | 27 +++++++++++++++++++++++++++
 drivers/misc/mei/mei_dev.h |  4 ++++
 drivers/misc/mei/pci-me.c  |  8 ++++----
 6 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 7692b69abcb5..5c3aa35ba3f4 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1430,6 +1430,9 @@ static bool mei_me_fw_type_sps(const struct pci_dev *pdev)
 	return fw_type == PCI_CFG_HFS_3_FW_SKU_SPS;
 }
 
+#define MEI_CFG_TYPE_ITOUCH                     \
+	.type = "itouch"
+
 #define MEI_CFG_FW_SPS                          \
 	.quirk_probe = mei_me_fw_type_sps
 
@@ -1499,6 +1502,13 @@ static const struct mei_cfg mei_me_pch8_cfg = {
 	MEI_CFG_FW_VER_SUPP,
 };
 
+/* PCH8 Lynx Point and newer devices - iTouch */
+static const struct mei_cfg mei_me_pch8_itouch_cfg = {
+	MEI_CFG_TYPE_ITOUCH,
+	MEI_CFG_PCH8_HFS,
+	MEI_CFG_FW_VER_SUPP,
+};
+
 /* PCH8 Lynx Point with quirk for SPS Firmware exclusion */
 static const struct mei_cfg mei_me_pch8_sps_4_cfg = {
 	MEI_CFG_PCH8_HFS,
@@ -1566,6 +1576,7 @@ static const struct mei_cfg *const mei_cfg_list[] = {
 	[MEI_ME_PCH7_CFG] = &mei_me_pch7_cfg,
 	[MEI_ME_PCH_CPT_PBG_CFG] = &mei_me_pch_cpt_pbg_cfg,
 	[MEI_ME_PCH8_CFG] = &mei_me_pch8_cfg,
+	[MEI_ME_PCH8_ITOUCH_CFG] = &mei_me_pch8_itouch_cfg,
 	[MEI_ME_PCH8_SPS_4_CFG] = &mei_me_pch8_sps_4_cfg,
 	[MEI_ME_PCH12_CFG] = &mei_me_pch12_cfg,
 	[MEI_ME_PCH12_SPS_4_CFG] = &mei_me_pch12_sps_4_cfg,
@@ -1613,6 +1624,7 @@ struct mei_device *mei_me_dev_init(struct device *parent,
 	hw->cfg = cfg;
 
 	dev->fw_f_fw_ver_supported = cfg->fw_ver_supported;
+	dev->type = cfg->type;
 
 	return dev;
 }
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index 560c8ebb17be..fe231b06c449 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -19,6 +19,7 @@
  *
  * @fw_status: FW status
  * @quirk_probe: device exclusion quirk
+ * @type: MEI head type
  * @dma_size: device DMA buffers size
  * @fw_ver_supported: is fw version retrievable from FW
  * @hw_trc_supported: does the hw support trc register
@@ -26,6 +27,7 @@
 struct mei_cfg {
 	const struct mei_fw_status fw_status;
 	bool (*quirk_probe)(const struct pci_dev *pdev);
+	const char *type;
 	size_t dma_size[DMA_DSCR_NUM];
 	u32 fw_ver_supported:1;
 	u32 hw_trc_supported:1;
@@ -76,6 +78,8 @@ struct mei_me_hw {
  *                         with quirk for Node Manager exclusion.
  * @MEI_ME_PCH8_CFG:       Platform Controller Hub Gen8 and newer
  *                         client platforms.
+ * @MEI_ME_PCH8_ITOUCH_CFG:Platform Controller Hub Gen8 and newer
+ *                         client platforms (iTouch).
  * @MEI_ME_PCH8_SPS_4_CFG: Platform Controller Hub Gen8 and newer
  *                         servers platforms with quirk for
  *                         SPS firmware exclusion.
@@ -100,6 +104,7 @@ enum mei_cfg_idx {
 	MEI_ME_PCH7_CFG,
 	MEI_ME_PCH_CPT_PBG_CFG,
 	MEI_ME_PCH8_CFG,
+	MEI_ME_PCH8_ITOUCH_CFG,
 	MEI_ME_PCH8_SPS_4_CFG,
 	MEI_ME_PCH12_CFG,
 	MEI_ME_PCH12_SPS_4_CFG,
diff --git a/drivers/misc/mei/hw-txe.c b/drivers/misc/mei/hw-txe.c
index a4e854b9b9e6..6fe2810b2d43 100644
--- a/drivers/misc/mei/hw-txe.c
+++ b/drivers/misc/mei/hw-txe.c
@@ -1206,6 +1206,7 @@ struct mei_device *mei_txe_dev_init(struct pci_dev *pdev)
 		return NULL;
 
 	mei_device_init(dev, &pdev->dev, &mei_txe_hw_ops);
+	dev->type = "txe";
 
 	hw = to_txe_hw(dev);
 
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 05e6ad6d4d54..fc34c19c618d 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -885,6 +885,32 @@ void mei_set_devstate(struct mei_device *dev, enum mei_dev_state state)
 	}
 }
 
+/**
+ * type_show - display device type
+ *
+ * @device: device pointer
+ * @attr: attribute pointer
+ * @buf: char out buffer
+ *
+ * Return: number of the bytes printed into buf or error
+ */
+static ssize_t type_show(struct device *device,
+			 struct device_attribute *attr, char *buf)
+{
+	struct mei_device *dev = dev_get_drvdata(device);
+	ssize_t ret = 0;
+
+	mutex_lock(&dev->device_lock);
+	if (dev->type)
+		ret = sprintf(buf, "%s\n", dev->type);
+	else
+		ret = sprintf(buf, "%s\n", "mei");
+	mutex_unlock(&dev->device_lock);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(type);
+
 static struct attribute *mei_attrs[] = {
 	&dev_attr_fw_status.attr,
 	&dev_attr_hbm_ver.attr,
@@ -893,6 +919,7 @@ static struct attribute *mei_attrs[] = {
 	&dev_attr_fw_ver.attr,
 	&dev_attr_dev_state.attr,
 	&dev_attr_trc.attr,
+	&dev_attr_type.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(mei);
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 3a29db07211d..a2f901a11d5b 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -445,6 +445,8 @@ struct mei_fw_version {
  * @device_list : mei client bus list
  * @cl_bus_lock : client bus list lock
  *
+ * @type        : mei device type
+ *
  * @dbgfs_dir   : debugfs mei root directory
  *
  * @ops:        : hw specific operations
@@ -528,6 +530,8 @@ struct mei_device {
 	struct list_head device_list;
 	struct mutex cl_bus_lock;
 
+	const char *type;
+
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 	struct dentry *dbgfs_dir;
 #endif /* CONFIG_DEBUG_FS */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 159e40a2505d..62cfb14097a1 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -68,7 +68,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_2, MEI_ME_PCH8_CFG)},
-	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_3, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_3, MEI_ME_PCH8_ITOUCH_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H, MEI_ME_PCH8_SPS_4_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H_2, MEI_ME_PCH8_SPS_4_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_LBG, MEI_ME_PCH12_SPS_4_CFG)},
@@ -85,15 +85,15 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP_3, MEI_ME_PCH8_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP, MEI_ME_PCH12_CFG)},
-	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP_3, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP_3, MEI_ME_PCH8_ITOUCH_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H, MEI_ME_PCH12_SPS_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_H_3, MEI_ME_PCH12_SPS_NODMA_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_LP, MEI_ME_PCH12_CFG)},
-	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_LP_3, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_LP_3, MEI_ME_PCH8_ITOUCH_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_V, MEI_ME_PCH12_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_H, MEI_ME_PCH12_CFG)},
-	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_H_3, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_H_3, MEI_ME_PCH8_ITOUCH_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP, MEI_ME_PCH12_CFG)},
 
-- 
2.25.4

