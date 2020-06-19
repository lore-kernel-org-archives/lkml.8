Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5601C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C18206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392357AbgFSQve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:51:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:45046 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405893AbgFSQva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:51:30 -0400
IronPort-SDR: avhy3UrXdccRIw4UXF463hl29XWJLiW6/BIb1vM/wF3w50ZauXr2R24OzgmV1ZkJt0ARRb9MIn
 G91r09A2Xttw==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="130381936"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="130381936"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 09:51:29 -0700
IronPort-SDR: vDx/9AjKNDTgQSiYOJgpv7hgdtW+fU1at2UA2BIJsfZy2JGHoip1gqaT4ZT24fRtN4XWMAwSya
 5vnxcFr1a2Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="318165134"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2020 09:51:28 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 3/7] mei: me: make mei_me_fw_sku_sps_4() less cryptic
Date:   Fri, 19 Jun 2020 19:51:17 +0300
Message-Id: <20200619165121.2145330-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200619165121.2145330-1-tomas.winkler@intel.com>
References: <20200619165121.2145330-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last add mei_me_fw_sku_sps_4() kdoc and add descriptive defines
for register name and values.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me-regs.h |  2 ++
 drivers/misc/mei/hw-me.c      | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 01b1bf74f262..64823bdde6af 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -105,6 +105,8 @@
 /* Host Firmware Status Registers in PCI Config Space */
 #define PCI_CFG_HFS_1         0x40
 #  define PCI_CFG_HFS_1_D0I3_MSK     0x80000000
+#  define PCI_CFG_HFS_1_OPMODE_MSK 0xf0000 /* OP MODE Mask: SPS <= 4.0 */
+#  define PCI_CFG_HFS_1_OPMODE_SPS 0xf0000 /* SPS SKU : SPS <= 4.0 */
 #define PCI_CFG_HFS_2         0x48
 #define PCI_CFG_HFS_3         0x60
 #  define PCI_CFG_HFS_3_FW_SKU_MSK   0x00000070
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index b45143510912..6aa522c0d910 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1366,20 +1366,26 @@ static bool mei_me_fw_type_nm(const struct pci_dev *pdev)
 #define MEI_CFG_FW_NM                           \
 	.quirk_probe = mei_me_fw_type_nm
 
+/**
+ * mei_me_fw_sku_sps_4() - check for sps 4.0 sku
+ *
+ * Read ME FW Status register to check for SPS Firmware.
+ * The SPS FW is only signaled in the PCI function 0.
+ * __Note__: Deprecated by SPS 5.0 and newer.
+ *
+ * @pdev: pci device
+ *
+ * Return: true in case of SPS firmware
+ */
 static bool mei_me_fw_type_sps_4(const struct pci_dev *pdev)
 {
 	u32 reg;
 	unsigned int devfn;
 
-	/*
-	 * Read ME FW Status register to check for SPS Firmware
-	 * The SPS FW is only signaled in pci function 0
-	 */
 	devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), 0);
 	pci_bus_read_config_dword(pdev->bus, devfn, PCI_CFG_HFS_1, &reg);
 	trace_mei_pci_cfg_read(&pdev->dev, "PCI_CFG_HFS_1", PCI_CFG_HFS_1, reg);
-	/* if bits [19:16] = 15, running SPS Firmware */
-	return (reg & 0xf0000) == 0xf0000;
+	return (reg & PCI_CFG_HFS_1_OPMODE_MSK) == PCI_CFG_HFS_1_OPMODE_SPS;
 }
 
 #define MEI_CFG_FW_SPS_4                          \
-- 
2.25.4

