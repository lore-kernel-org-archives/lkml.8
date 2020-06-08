Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F1AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC00207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgFIIs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:48:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:43994 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbgFIIs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:48:59 -0400
IronPort-SDR: aNyLYwwLfW9Vl2AqFuEYwKcQ1c3kgDPChJYw4idHyMXgZT3NEFsz6ky1KnuA2OkQi46KZnoZh9
 +iePbt82Z3cA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 01:48:57 -0700
IronPort-SDR: 8HJEABwRbp8PbmsJaiz9pJMCjWLzgu01R4yJQS/Q5BTBoJIHUa663NQl073yd8rQC1wgCssRmK
 3KZCOOjP/W1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="473001837"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2020 01:48:52 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/4] soundwire: add definitions for 1.2 spec
Date:   Tue,  9 Jun 2020 04:54:33 +0800
Message-Id: <20200608205436.2402-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608205436.2402-1-yung-chuan.liao@linux.intel.com>
References: <20200608205436.2402-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add definitions for register offsets and bit fields from the MIPI
SoundWire 1.2 specification (available to MIPI members at
https://members.mipi.org/wg/All-Members/document/download/78371)

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_registers.h | 107 +++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index a686f7988156..12f9ffc3eb3b 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -12,7 +12,7 @@
 #define SDW_REG_SHIFT(n)			(ffs(n) - 1)
 
 /*
- * SDW registers as defined by MIPI 1.1 Spec
+ * SDW registers as defined by MIPI 1.2 Spec
  */
 #define SDW_REGADDR				GENMASK(14, 0)
 #define SDW_SCP_ADDRPAGE2_MASK			GENMASK(22, 15)
@@ -43,6 +43,8 @@
 #define SDW_DP0_INT_TEST_FAIL			BIT(0)
 #define SDW_DP0_INT_PORT_READY			BIT(1)
 #define SDW_DP0_INT_BRA_FAILURE			BIT(2)
+#define SDW_DP0_SDCA_CASCADE			BIT(3)
+/* BIT(4) not allocated in SoundWire specification 1.2 */
 #define SDW_DP0_INT_IMPDEF1			BIT(5)
 #define SDW_DP0_INT_IMPDEF2			BIT(6)
 #define SDW_DP0_INT_IMPDEF3			BIT(7)
@@ -106,6 +108,10 @@
 #define SDW_SCP_ADDRPAGE2			0x49
 #define SDW_SCP_KEEPEREN			0x4A
 #define SDW_SCP_BANKDELAY			0x4B
+#define SDW_SCP_COMMIT				0x4C
+#define SDW_SCP_BUS_CLOCK_BASE			0x4D
+#define SDW_SCP_BASE_CLOCK_FREQ			GENMASK(2, 0)
+/* 0x4E is not allocated in SoundWire specification 1.2 */
 #define SDW_SCP_TESTMODE			0x4F
 #define SDW_SCP_DEVID_0				0x50
 #define SDW_SCP_DEVID_1				0x51
@@ -114,12 +120,111 @@
 #define SDW_SCP_DEVID_4				0x54
 #define SDW_SCP_DEVID_5				0x55
 
+/* Both INT and STATUS register are same */
+#define SDW_SCP_SDCA_INT1			0x58
+#define SDW_SCP_SDCA_INT_SDCA_0			BIT(0)
+#define SDW_SCP_SDCA_INT_SDCA_1			BIT(1)
+#define SDW_SCP_SDCA_INT_SDCA_2			BIT(2)
+#define SDW_SCP_SDCA_INT_SDCA_3			BIT(3)
+#define SDW_SCP_SDCA_INT_SDCA_4			BIT(4)
+#define SDW_SCP_SDCA_INT_SDCA_5			BIT(5)
+#define SDW_SCP_SDCA_INT_SDCA_6			BIT(6)
+#define SDW_SCP_SDCA_INT_SDCA_7			BIT(7)
+
+#define SDW_SCP_SDCA_INT2			0x59
+#define SDW_SCP_SDCA_INT_SDCA_8			BIT(0)
+#define SDW_SCP_SDCA_INT_SDCA_9			BIT(1)
+#define SDW_SCP_SDCA_INT_SDCA_10		BIT(2)
+#define SDW_SCP_SDCA_INT_SDCA_11		BIT(3)
+#define SDW_SCP_SDCA_INT_SDCA_12		BIT(4)
+#define SDW_SCP_SDCA_INT_SDCA_13		BIT(5)
+#define SDW_SCP_SDCA_INT_SDCA_14		BIT(6)
+#define SDW_SCP_SDCA_INT_SDCA_15		BIT(7)
+
+#define SDW_SCP_SDCA_INT3			0x5A
+#define SDW_SCP_SDCA_INT_SDCA_16		BIT(0)
+#define SDW_SCP_SDCA_INT_SDCA_17		BIT(1)
+#define SDW_SCP_SDCA_INT_SDCA_18		BIT(2)
+#define SDW_SCP_SDCA_INT_SDCA_19		BIT(3)
+#define SDW_SCP_SDCA_INT_SDCA_20		BIT(4)
+#define SDW_SCP_SDCA_INT_SDCA_21		BIT(5)
+#define SDW_SCP_SDCA_INT_SDCA_22		BIT(6)
+#define SDW_SCP_SDCA_INT_SDCA_23		BIT(7)
+
+#define SDW_SCP_SDCA_INT4			0x5B
+#define SDW_SCP_SDCA_INT_SDCA_24		BIT(0)
+#define SDW_SCP_SDCA_INT_SDCA_25		BIT(1)
+#define SDW_SCP_SDCA_INT_SDCA_26		BIT(2)
+#define SDW_SCP_SDCA_INT_SDCA_27		BIT(3)
+#define SDW_SCP_SDCA_INT_SDCA_28		BIT(4)
+#define SDW_SCP_SDCA_INT_SDCA_29		BIT(5)
+#define SDW_SCP_SDCA_INT_SDCA_30		BIT(6)
+/* BIT(7) not allocated in SoundWire 1.2 specification */
+
+#define SDW_SCP_SDCA_INTMASK1			0x5C
+#define SDW_SCP_SDCA_INTMASK_SDCA_0		BIT(0)
+#define SDW_SCP_SDCA_INTMASK_SDCA_1		BIT(1)
+#define SDW_SCP_SDCA_INTMASK_SDCA_2		BIT(2)
+#define SDW_SCP_SDCA_INTMASK_SDCA_3		BIT(3)
+#define SDW_SCP_SDCA_INTMASK_SDCA_4		BIT(4)
+#define SDW_SCP_SDCA_INTMASK_SDCA_5		BIT(5)
+#define SDW_SCP_SDCA_INTMASK_SDCA_6		BIT(6)
+#define SDW_SCP_SDCA_INTMASK_SDCA_7		BIT(7)
+
+#define SDW_SCP_SDCA_INTMASK2			0x5D
+#define SDW_SCP_SDCA_INTMASK_SDCA_8		BIT(0)
+#define SDW_SCP_SDCA_INTMASK_SDCA_9		BIT(1)
+#define SDW_SCP_SDCA_INTMASK_SDCA_10		BIT(2)
+#define SDW_SCP_SDCA_INTMASK_SDCA_11		BIT(3)
+#define SDW_SCP_SDCA_INTMASK_SDCA_12		BIT(4)
+#define SDW_SCP_SDCA_INTMASK_SDCA_13		BIT(5)
+#define SDW_SCP_SDCA_INTMASK_SDCA_14		BIT(6)
+#define SDW_SCP_SDCA_INTMASK_SDCA_15		BIT(7)
+
+#define SDW_SCP_SDCA_INTMASK3			0x5E
+#define SDW_SCP_SDCA_INTMASK_SDCA_16		BIT(0)
+#define SDW_SCP_SDCA_INTMASK_SDCA_17		BIT(1)
+#define SDW_SCP_SDCA_INTMASK_SDCA_18		BIT(2)
+#define SDW_SCP_SDCA_INTMASK_SDCA_19		BIT(3)
+#define SDW_SCP_SDCA_INTMASK_SDCA_20		BIT(4)
+#define SDW_SCP_SDCA_INTMASK_SDCA_21		BIT(5)
+#define SDW_SCP_SDCA_INTMASK_SDCA_22		BIT(6)
+#define SDW_SCP_SDCA_INTMASK_SDCA_23		BIT(7)
+
+#define SDW_SCP_SDCA_INTMASK4			0x5F
+#define SDW_SCP_SDCA_INTMASK_SDCA_24		BIT(0)
+#define SDW_SCP_SDCA_INTMASK_SDCA_25		BIT(1)
+#define SDW_SCP_SDCA_INTMASK_SDCA_26		BIT(2)
+#define SDW_SCP_SDCA_INTMASK_SDCA_27		BIT(3)
+#define SDW_SCP_SDCA_INTMASK_SDCA_28		BIT(4)
+#define SDW_SCP_SDCA_INTMASK_SDCA_29		BIT(5)
+#define SDW_SCP_SDCA_INTMASK_SDCA_30		BIT(6)
+/* BIT(7) not allocated in SoundWire 1.2 specification */
+
 /* Banked Registers */
 #define SDW_SCP_FRAMECTRL_B0			0x60
 #define SDW_SCP_FRAMECTRL_B1			(0x60 + SDW_BANK1_OFFSET)
 #define SDW_SCP_NEXTFRAME_B0			0x61
 #define SDW_SCP_NEXTFRAME_B1			(0x61 + SDW_BANK1_OFFSET)
 
+#define SDW_SCP_BUSCLOCK_SCALE_B0		0x62
+#define SDW_SCP_BUSCLOCK_SCALE_B1		(0x62 + SDW_BANK1_OFFSET)
+#define SDW_SCP_CLOCK_SCALE			GENMASK(3, 0)
+
+/* PHY registers - CTRL and STAT are the same address */
+#define SDW_SCP_PHY_OUT_CTRL_0			0x80
+#define SDW_SCP_PHY_OUT_CTRL_1			0x81
+#define SDW_SCP_PHY_OUT_CTRL_2			0x82
+#define SDW_SCP_PHY_OUT_CTRL_3			0x83
+#define SDW_SCP_PHY_OUT_CTRL_4			0x84
+#define SDW_SCP_PHY_OUT_CTRL_5			0x85
+#define SDW_SCP_PHY_OUT_CTRL_6			0x86
+#define SDW_SCP_PHY_OUT_CTRL_7			0x87
+
+#define SDW_SCP_CAP_LOAD_CTRL			GENMASK(2, 0)
+#define SDW_SCP_DRIVE_STRENGTH_CTRL		GENMASK(5, 3)
+#define SDW_SCP_SLEW_TIME_CTRL			GENMASK(7, 6)
+
 /* Both INT and STATUS register is same */
 #define SDW_DPN_INT(n)				(0x0 + SDW_DPN_SIZE * (n))
 #define SDW_DPN_INTMASK(n)			(0x1 + SDW_DPN_SIZE * (n))
-- 
2.17.1

