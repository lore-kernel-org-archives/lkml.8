Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B597C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C322166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405924AbgFSQvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:51:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:45053 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405905AbgFSQvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:51:35 -0400
IronPort-SDR: dZkUBhj5pqjWJIL4RYm3RTQkyJ7S0RY6aEAbO+YK/5gUV0rcZ6EgXesMpb8XA76DnzbMGx6QFE
 rtvkh1M/TZMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="130381954"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="130381954"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 09:51:34 -0700
IronPort-SDR: i+MqMjquuaYuqJAE/Hc2fByym8CVMayWqciKRqw7OO5QYtE1RbuvnO4jOQxlY0n6/ZRW2f46up
 Lv1NFOiudoZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="318165159"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2020 09:51:33 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 6/7] mei: me: add MEI device for KBP with ITPS capability
Date:   Fri, 19 Jun 2020 19:51:20 +0300
Message-Id: <20200619165121.2145330-6-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200619165121.2145330-1-tomas.winkler@intel.com>
References: <20200619165121.2145330-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device ID for Intel Kaby Point PCH (Kabylake) which has
Intel Precise Touch & Stylus IPTS (iTouch).

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 1 +
 drivers/misc/mei/pci-me.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index bf230c5b5eec..b86ce504fdd3 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -74,6 +74,7 @@
 
 #define MEI_DEV_ID_KBP        0xA2BA  /* Kaby Point */
 #define MEI_DEV_ID_KBP_2      0xA2BB  /* Kaby Point 2 */
+#define MEI_DEV_ID_KBP_3      0xA2BE  /* Kaby Point 3 (iTouch) */
 
 #define MEI_DEV_ID_CNP_LP     0x9DE0  /* Cannon Point LP */
 #define MEI_DEV_ID_CNP_LP_3   0x9DE4  /* Cannon Point LP 3 (iTouch) */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index e97abebc949c..188f59a94118 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -82,6 +82,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP_2, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP_3, MEI_ME_PCH8_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP, MEI_ME_PCH12_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CNP_LP_3, MEI_ME_PCH8_CFG)},
-- 
2.25.4

