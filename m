Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045F5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04F62166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405919AbgFSQvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:51:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:45043 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405901AbgFSQvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:51:33 -0400
IronPort-SDR: cu1OcnDvWriFDTi6WeL/2XB94VEZ7JybmBRZfv8c5rG6W75P51At0GVv7Mj0jro6l/6KaZeqUI
 Pj16UoJwdg9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="130381948"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="130381948"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 09:51:33 -0700
IronPort-SDR: 7xwKCtCgbpkATrRdNEBmD1zNGvF2eAjbV6rx2GAQ1c5VDDmpLck/hUyuJ/UfsS1pjbNssG4RyE
 QGl/TArthixQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="318165152"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2020 09:51:31 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 5/7] mei: me: add MEI device for SPT with ITPS capability
Date:   Fri, 19 Jun 2020 19:51:19 +0300
Message-Id: <20200619165121.2145330-5-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200619165121.2145330-1-tomas.winkler@intel.com>
References: <20200619165121.2145330-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device ID for Intel Sunrise Point PCH (Skylake) which has
Intel Precise Touch & Stylus IPTS (iTouch).

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 1 +
 drivers/misc/mei/pci-me.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index 64823bdde6af..bf230c5b5eec 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -59,6 +59,7 @@
 
 #define MEI_DEV_ID_SPT        0x9D3A  /* Sunrise Point */
 #define MEI_DEV_ID_SPT_2      0x9D3B  /* Sunrise Point 2 */
+#define MEI_DEV_ID_SPT_3      0x9D3E  /* Sunrise Point 3 (iToutch) */
 #define MEI_DEV_ID_SPT_H      0xA13A  /* Sunrise Point H */
 #define MEI_DEV_ID_SPT_H_2    0xA13B  /* Sunrise Point H 2 */
 
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 1bcc724a18aa..e97abebc949c 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -68,6 +68,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_2, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_3, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H, MEI_ME_PCH8_SPS_4_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H_2, MEI_ME_PCH8_SPS_4_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_LBG, MEI_ME_PCH12_SPS_4_CFG)},
-- 
2.25.4

