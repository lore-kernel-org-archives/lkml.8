Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157E8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9DE2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgFIItQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:49:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:44005 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbgFIItN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:49:13 -0400
IronPort-SDR: q3nUWVIyUpAUA+j5eI/6TYAENX+97wO4BZVme6C5LKOfWUqJtZBNzOTMPyASBaJEvSzE+0/yf2
 pMqM3JNyFS8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 01:49:09 -0700
IronPort-SDR: TAuzf9FAVa0ej0iNgEXXXcNry8h+SH7RMisvAZTx+xjJ4/c4PGSguy8jvmorGan/6Rud/BLsYp
 3eyVDKqDhaxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="473001950"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2020 01:49:04 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 4/4] soundwire: bus: initialize bus clock base and scale registers
Date:   Tue,  9 Jun 2020 04:54:36 +0800
Message-Id: <20200608205436.2402-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608205436.2402-1-yung-chuan.liao@linux.intel.com>
References: <20200608205436.2402-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The SoundWire 1.2 specification adds new registers to allow for
seamless clock changes while audio transfers are on-going. Program
them following the specification.

Note that dynamic clock changes are not supported for now, this only
adds the register initialization.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c                 | 107 ++++++++++++++++++++++++
 include/linux/soundwire/sdw_registers.h |  10 +++
 2 files changed, 117 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 24ba77226376..83f9d7e0de80 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1059,12 +1059,119 @@ int sdw_configure_dpn_intr(struct sdw_slave *slave,
 	return ret;
 }
 
+static int sdw_slave_set_frequency(struct sdw_slave *slave)
+{
+	u32 mclk_freq = slave->bus->prop.mclk_freq;
+	u32 curr_freq = slave->bus->params.curr_dr_freq >> 1;
+	unsigned int scale;
+	u8 scale_index;
+	u8 base;
+	int ret;
+
+	/*
+	 * frequency base and scale registers are required for SDCA
+	 * devices. They may also be used for 1.2+/non-SDCA devices,
+	 * but we will need a DisCo property to cover this case
+	 */
+	if (!slave->id.class_id)
+		return 0;
+
+	if (!mclk_freq) {
+		dev_err(&slave->dev,
+			"no bus MCLK, cannot set SDW_SCP_BUS_CLOCK_BASE\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * map base frequency using Table 89 of SoundWire 1.2 spec.
+	 * The order of the tests just follows the specification, this
+	 * is not a selection between possible values or a search for
+	 * the best value but just a mapping.  Only one case per platform
+	 * is relevant.
+	 * Some BIOS have inconsistent values for mclk_freq but a
+	 * correct root so we force the mclk_freq to avoid variations.
+	 */
+	if (!(19200000 % mclk_freq)) {
+		mclk_freq = 19200000;
+		base = SDW_SCP_BASE_CLOCK_19200000_HZ;
+	} else if (!(24000000 % mclk_freq)) {
+		mclk_freq = 24000000;
+		base = SDW_SCP_BASE_CLOCK_24000000_HZ;
+	} else if (!(24576000 % mclk_freq)) {
+		mclk_freq = 24576000;
+		base = SDW_SCP_BASE_CLOCK_24576000_HZ;
+	} else if (!(22579200 % mclk_freq)) {
+		mclk_freq = 22579200;
+		base = SDW_SCP_BASE_CLOCK_22579200_HZ;
+	} else if (!(32000000 % mclk_freq)) {
+		mclk_freq = 32000000;
+		base = SDW_SCP_BASE_CLOCK_32000000_HZ;
+	} else {
+		dev_err(&slave->dev,
+			"Unsupported clock base, mclk %d\n",
+			mclk_freq);
+		return -EINVAL;
+	}
+
+	if (mclk_freq % curr_freq) {
+		dev_err(&slave->dev,
+			"mclk %d is not multiple of bus curr_freq %d\n",
+			mclk_freq, curr_freq);
+		return -EINVAL;
+	}
+
+	scale = mclk_freq / curr_freq;
+
+	/*
+	 * map scale to Table 90 of SoundWire 1.2 spec - and check
+	 * that the scale is a power of two and maximum 64
+	 */
+	scale_index = ilog2(scale);
+
+	if (BIT(scale_index) != scale || scale_index > 6) {
+		dev_err(&slave->dev,
+			"No match found for scale %d, bus mclk %d curr_freq %d\n",
+			scale, mclk_freq, curr_freq);
+		return -EINVAL;
+	}
+	scale_index++;
+
+	ret = sdw_write(slave, SDW_SCP_BUS_CLOCK_BASE, base);
+	if (ret < 0) {
+		dev_err(&slave->dev,
+			"SDW_SCP_BUS_CLOCK_BASE write failed:%d\n", ret);
+		return ret;
+	}
+
+	/* initialize scale for both banks */
+	ret = sdw_write(slave, SDW_SCP_BUSCLOCK_SCALE_B0, scale_index);
+	if (ret < 0) {
+		dev_err(&slave->dev,
+			"SDW_SCP_BUSCLOCK_SCALE_B0 write failed:%d\n", ret);
+		return ret;
+	}
+	ret = sdw_write(slave, SDW_SCP_BUSCLOCK_SCALE_B1, scale_index);
+	if (ret < 0)
+		dev_err(&slave->dev,
+			"SDW_SCP_BUSCLOCK_SCALE_B1 write failed:%d\n", ret);
+
+	dev_dbg(&slave->dev,
+		"Configured bus base %d, scale %d, mclk %d, curr_freq %d\n",
+		base, scale_index, mclk_freq, curr_freq);
+
+	return ret;
+}
+
 static int sdw_initialize_slave(struct sdw_slave *slave)
 {
 	struct sdw_slave_prop *prop = &slave->prop;
 	int ret;
 	u8 val;
 
+	ret = sdw_slave_set_frequency(slave);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * Set bus clash, parity and SCP implementation
 	 * defined interrupt mask
diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index 12f9ffc3eb3b..5d3c271af7d1 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -109,8 +109,18 @@
 #define SDW_SCP_KEEPEREN			0x4A
 #define SDW_SCP_BANKDELAY			0x4B
 #define SDW_SCP_COMMIT				0x4C
+
 #define SDW_SCP_BUS_CLOCK_BASE			0x4D
 #define SDW_SCP_BASE_CLOCK_FREQ			GENMASK(2, 0)
+#define SDW_SCP_BASE_CLOCK_UNKNOWN		0x0
+#define SDW_SCP_BASE_CLOCK_19200000_HZ		0x1
+#define SDW_SCP_BASE_CLOCK_24000000_HZ		0x2
+#define SDW_SCP_BASE_CLOCK_24576000_HZ		0x3
+#define SDW_SCP_BASE_CLOCK_22579200_HZ		0x4
+#define SDW_SCP_BASE_CLOCK_32000000_HZ		0x5
+#define SDW_SCP_BASE_CLOCK_RESERVED		0x6
+#define SDW_SCP_BASE_CLOCK_IMP_DEF		0x7
+
 /* 0x4E is not allocated in SoundWire specification 1.2 */
 #define SDW_SCP_TESTMODE			0x4F
 #define SDW_SCP_DEVID_0				0x50
-- 
2.17.1

