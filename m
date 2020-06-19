Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD60C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AABF20734
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405939AbgFSQv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:51:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:45043 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405892AbgFSQv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:51:28 -0400
IronPort-SDR: 2F22wEE2dA706uN30qFDsArsYySyknPCRwjaxcHGSnUrHFkxzrXbUG1J965UtM2fUqIOgMbILU
 1/bQh6rMQfKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="130381909"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="130381909"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 09:51:27 -0700
IronPort-SDR: 9fnLjzgCQrHjTsRiE2SA26mLSv8i3khQqfkYmfiUlgbaRC96DZsdfnVGS6aKiveVaLCKQlV/vr
 hBIoW1VqSH8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="318165121"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2020 09:51:26 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/7] mei: me: constify the device parameter to the probe quirk
Date:   Fri, 19 Jun 2020 19:51:16 +0300
Message-Id: <20200619165121.2145330-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200619165121.2145330-1-tomas.winkler@intel.com>
References: <20200619165121.2145330-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The quirk_probe there is no writing to pci device hence
we can constify the passed pci_dev pointer.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me.c | 6 +++---
 drivers/misc/mei/hw-me.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index f8155c1e811d..b45143510912 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1353,7 +1353,7 @@ static const struct mei_hw_ops mei_me_hw_ops = {
 	.read = mei_me_read_slots
 };
 
-static bool mei_me_fw_type_nm(struct pci_dev *pdev)
+static bool mei_me_fw_type_nm(const struct pci_dev *pdev)
 {
 	u32 reg;
 
@@ -1366,7 +1366,7 @@ static bool mei_me_fw_type_nm(struct pci_dev *pdev)
 #define MEI_CFG_FW_NM                           \
 	.quirk_probe = mei_me_fw_type_nm
 
-static bool mei_me_fw_type_sps_4(struct pci_dev *pdev)
+static bool mei_me_fw_type_sps_4(const struct pci_dev *pdev)
 {
 	u32 reg;
 	unsigned int devfn;
@@ -1395,7 +1395,7 @@ static bool mei_me_fw_type_sps_4(struct pci_dev *pdev)
  *
  * Return: true in case of SPS firmware
  */
-static bool mei_me_fw_type_sps(struct pci_dev *pdev)
+static bool mei_me_fw_type_sps(const struct pci_dev *pdev)
 {
 	u32 reg;
 	u32 fw_type;
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index 52e0c6d578f2..4df51cb8fa4b 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -25,7 +25,7 @@
  */
 struct mei_cfg {
 	const struct mei_fw_status fw_status;
-	bool (*quirk_probe)(struct pci_dev *pdev);
+	bool (*quirk_probe)(const struct pci_dev *pdev);
 	size_t dma_size[DMA_DSCR_NUM];
 	u32 fw_ver_supported:1;
 	u32 hw_trc_supported:1;
-- 
2.25.4

