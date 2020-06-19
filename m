Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27CFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA497206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405907AbgFSQvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:51:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:45043 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405898AbgFSQvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:51:31 -0400
IronPort-SDR: YU1kQpY5+mDFCcNuuTCldN1RDemrRIQBdPg7J/jsEJsMho1a9jFQBK9iFIjopXeFpDCdKwnlHY
 kbj2JIT+ml7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="130381944"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="130381944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 09:51:31 -0700
IronPort-SDR: e919SKyENYxgRQllorO3cVkJQ+ppxOIFTxBy+M6GkFGSjleXR+Z7YqWi+7lv+SuGlZ9f5I8er7
 M1nmbeBYOkHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="318165145"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2020 09:51:29 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 4/7] mei: me: add kdoc for mei_me_fw_type_nm()
Date:   Fri, 19 Jun 2020 19:51:18 +0300
Message-Id: <20200619165121.2145330-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200619165121.2145330-1-tomas.winkler@intel.com>
References: <20200619165121.2145330-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kdoc for mei_me_fw_type_nm() function.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 6aa522c0d910..e476995e4c56 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1353,11 +1353,24 @@ static const struct mei_hw_ops mei_me_hw_ops = {
 	.read = mei_me_read_slots
 };
 
+/**
+ * mei_me_fw_type_nm() - check for nm sku
+ *
+ * Read ME FW Status register to check for the Node Manager (NM) Firmware.
+ * The NM FW is only signaled in PCI function 0.
+ * __Note__: Deprecated by PCH8 and newer.
+ *
+ * @pdev: pci device
+ *
+ * Return: true in case of NM firmware
+ */
 static bool mei_me_fw_type_nm(const struct pci_dev *pdev)
 {
 	u32 reg;
+	unsigned int devfn;
 
-	pci_read_config_dword(pdev, PCI_CFG_HFS_2, &reg);
+	devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), 0);
+	pci_bus_read_config_dword(pdev->bus, devfn, PCI_CFG_HFS_2, &reg);
 	trace_mei_pci_cfg_read(&pdev->dev, "PCI_CFG_HFS_2", PCI_CFG_HFS_2, reg);
 	/* make sure that bit 9 (NM) is up and bit 10 (DM) is down */
 	return (reg & 0x600) == 0x200;
-- 
2.25.4

