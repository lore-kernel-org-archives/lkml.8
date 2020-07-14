Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3204C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1E2206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgGOJcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:32:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:1641 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgGOJcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:32:04 -0400
IronPort-SDR: ZVf33af6Yd/4T4HYV7duZf2x0g75YcNqxC3a2Rjap8PrwOVSg9IAIDHKKZ0IZfl74OjtmJtNYs
 4lXo8U+XI5kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="147119284"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="147119284"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 02:32:04 -0700
IronPort-SDR: CGidmK//KfAqvtPF13ztwd8cu+OmxMBIBBmgxo9a42dlEeYtmG5VDpXqm/OPEfzLS+4v7xs+ec
 qmpW/HuM+PyA==
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="460006226"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 02:32:00 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/2] soundwire: sdw.h: fix PRBS/Static_1 swapped definitions
Date:   Wed, 15 Jul 2020 05:37:43 +0800
Message-Id: <20200714213744.24674-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714213744.24674-1-yung-chuan.liao@linux.intel.com>
References: <20200714213744.24674-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Table 110 "Port Data Modes" of the SoundWire 1.2 specification lists
PRBS as b01 and Static_1 as b11. The existing headers swapped the two
values, fix.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 4057adf7f049..6452bac957b3 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -152,19 +152,19 @@ enum sdw_data_direction {
  *
  * @SDW_PORT_DATA_MODE_NORMAL: Normal data mode where audio data is received
  * and transmitted.
+ * @SDW_PORT_DATA_MODE_PRBS: Test mode which uses a PRBS generator to produce
+ * a pseudo random data pattern that is transferred
+ * @SDW_PORT_DATA_MODE_STATIC_0: Simple test mode which uses static value of
+ * logic 0. The encoding will result in no signal transitions
  * @SDW_PORT_DATA_MODE_STATIC_1: Simple test mode which uses static value of
  * logic 1. The encoding will result in signal transitions at every bitslot
  * owned by this Port
- * @SDW_PORT_DATA_MODE_STATIC_0: Simple test mode which uses static value of
- * logic 0. The encoding will result in no signal transitions
- * @SDW_PORT_DATA_MODE_PRBS: Test mode which uses a PRBS generator to produce
- * a pseudo random data pattern that is transferred
  */
 enum sdw_port_data_mode {
 	SDW_PORT_DATA_MODE_NORMAL = 0,
-	SDW_PORT_DATA_MODE_STATIC_1 = 1,
+	SDW_PORT_DATA_MODE_PRBS = 1,
 	SDW_PORT_DATA_MODE_STATIC_0 = 2,
-	SDW_PORT_DATA_MODE_PRBS = 3,
+	SDW_PORT_DATA_MODE_STATIC_1 = 3,
 };
 
 /*
-- 
2.17.1

