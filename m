Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145E6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4ED920758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHQIFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:05:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:55984 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgHQIFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:05:09 -0400
IronPort-SDR: H9A560u1K9Pa474bB3FAZE4+jADHUAXx/U8wFQjYjQWHIk1Q6i2FFQQMBkYL5M7b0YLtuDCkhL
 oCRCo5JuGayg==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="153905736"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="153905736"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 01:05:09 -0700
IronPort-SDR: 64K6dnPNVKR9qvBU/y1LfCdzlj1GACHiyNuFquKD/3+mhTQV9q7pEe+eB1Xczq56HcUTpADT68
 Xcdds2NWTNDA==
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="279060308"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 01:05:06 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2] soundwire: SDCA: detect sdca_cascade interrupt
Date:   Mon, 17 Aug 2020 04:11:22 +0800
Message-Id: <20200816201122.9744-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The SoundWire 1.2 specification defines an "SDCA cascade" bit which
handles a logical OR of all SDCA interrupt sources (up to 30 defined).

Due to limitations of the addressing space, this bit is located in the
SDW_DP0_INT register when DP0 is used, or alternatively in the
DP0_SDCA_Support_INTSTAT register when DP0 is not used.

To allow for both cases to be handled, this bit will be checked in the
main device-level interrupt handling code. This will result in the
register being read twice if DP0 is enabled, but it's not clear how to
optimize this case. It's also more logical to deal with this interrupt
at the device than the port level, this bit is really not DP0 specific
and its location in the DP0_INTSTAT bit is only due to the lack of
free space in SCP_INTSTAT_1.

The SDCA_Cascade bit cannot be masked or cleared, so the interrupt
handling only forwards the detection to the Slave driver, which will
deal with reading the relevant SDCA status bits and clearing them. The
bus driver only signals the detection.

The communication with the Slave driver is based on the same interrupt
callback, with only an extension to provide the status of the
sdca_cascade bit.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---

Changelog:

v2:
 - Re-read SDW_DP0_INT while reading status again. 

---
 drivers/soundwire/bus.c       | 28 +++++++++++++++++++++++++++-
 include/linux/soundwire/sdw.h |  4 ++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index e6e0fb9a81b4..d254c23201b9 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1361,6 +1361,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	int port_num, stat, ret, count = 0;
 	unsigned long port;
 	bool slave_notify = false;
+	u8 sdca_cascade = 0;
 	u8 buf, buf2[2], _buf, _buf2[2];
 
 	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
@@ -1388,6 +1389,16 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		goto io_err;
 	}
 
+	if (slave->prop.is_sdca) {
+		ret = sdw_read(slave, SDW_DP0_INT);
+		if (ret < 0) {
+			dev_err(slave->bus->dev,
+				"SDW_DP0_INT read failed:%d\n", ret);
+			goto io_err;
+		}
+		sdca_cascade = ret & SDW_DP0_SDCA_CASCADE;
+	}
+
 	do {
 		/*
 		 * Check parity, bus clash and Slave (impl defined)
@@ -1416,6 +1427,10 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 			slave_notify = true;
 		}
 
+		/* the SDCA interrupts are cleared in the codec driver .interrupt_callback() */
+		if (sdca_cascade)
+			slave_notify = true;
+
 		/* Check port 0 - 3 interrupts */
 		port = buf & SDW_SCP_INT1_PORT0_3;
 
@@ -1453,6 +1468,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		/* Update the Slave driver */
 		if (slave_notify && slave->ops &&
 		    slave->ops->interrupt_callback) {
+			slave_intr.sdca_cascade = sdca_cascade;
 			slave_intr.control_port = clear;
 			memcpy(slave_intr.port, &port_status,
 			       sizeof(slave_intr.port));
@@ -1487,11 +1503,21 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 			goto io_err;
 		}
 
+		if (slave->prop.is_sdca) {
+			ret = sdw_read(slave, SDW_DP0_INT);
+			if (ret < 0) {
+				dev_err(slave->bus->dev,
+					"SDW_DP0_INT read failed:%d\n", ret);
+				goto io_err;
+			}
+			sdca_cascade = ret & SDW_DP0_SDCA_CASCADE;
+		}
+
 		/* Make sure no interrupts are pending */
 		buf &= _buf;
 		buf2[0] &= _buf2[0];
 		buf2[1] &= _buf2[1];
-		stat = buf || buf2[0] || buf2[1];
+		stat = buf || buf2[0] || buf2[1] || sdca_cascade;
 
 		/*
 		 * Exit loop if Slave is continuously in ALERT state even
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 76052f12c9f7..a51494646a2c 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -355,6 +355,7 @@ struct sdw_dpn_prop {
  * @dp0_prop: Data Port 0 properties
  * @src_dpn_prop: Source Data Port N properties
  * @sink_dpn_prop: Sink Data Port N properties
+ * @is_sdca: the Slave supports the SDCA specification
  */
 struct sdw_slave_prop {
 	u32 mipi_revision;
@@ -376,6 +377,7 @@ struct sdw_slave_prop {
 	struct sdw_dp0_prop *dp0_prop;
 	struct sdw_dpn_prop *src_dpn_prop;
 	struct sdw_dpn_prop *sink_dpn_prop;
+	bool is_sdca;
 };
 
 /**
@@ -465,10 +467,12 @@ struct sdw_slave_id {
 
 /**
  * struct sdw_slave_intr_status - Slave interrupt status
+ * @sdca_cascade: set if the Slave device reports an SDCA interrupt
  * @control_port: control port status
  * @port: data port status
  */
 struct sdw_slave_intr_status {
+	bool sdca_cascade;
 	u8 control_port;
 	u8 port[15];
 };
-- 
2.17.1

