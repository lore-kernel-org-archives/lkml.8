Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902ABC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BDCF2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgHSCBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 22:01:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:3696 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgHSCA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:00:59 -0400
IronPort-SDR: BkX/w++riQHRGAjedTe4jJCIsfoA7kec5LtdaQtDHFJTYR7dJ7j94P/CfPQmDPtzFE3qhXz/Gi
 NdupHA8hSbTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152449459"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="152449459"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 19:00:59 -0700
IronPort-SDR: 8O9wl9OXXY3v7qbKIzVtJsDElyQFSs8nf7Iuv0+gLmQvvXHWl9WLzywcFtRIyoY7XF3WuzsiR+
 gBbt8hu6lQ9Q==
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="279565098"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 19:00:55 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 4/7] soundwire: bus: use quirk to filter out invalid parity errors
Date:   Tue, 18 Aug 2020 22:06:53 +0800
Message-Id: <20200818140656.29014-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

If a Slave device reports with a quirk that its initial parity check
may be incorrect, filter it but keep the parity checks active in
steady state.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c       | 8 +++++++-
 include/linux/soundwire/sdw.h | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index cddf39e3adfc..869290a8db40 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1362,6 +1362,8 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 	unsigned long port;
 	bool slave_notify = false;
 	u8 buf, buf2[2], _buf, _buf2[2];
+	bool parity_check;
+	bool parity_quirk;
 
 	sdw_modify_slave_status(slave, SDW_SLAVE_ALERT);
 
@@ -1394,7 +1396,11 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 		 * interrupt
 		 */
 		if (buf & SDW_SCP_INT1_PARITY) {
-			if (slave->prop.scp_int1_mask & SDW_SCP_INT1_PARITY)
+			parity_check = slave->prop.scp_int1_mask & SDW_SCP_INT1_PARITY;
+			parity_quirk = !slave->first_interrupt_done &&
+				(slave->prop.quirks & SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY);
+
+			if (parity_check && !parity_quirk)
 				dev_err(&slave->dev, "Parity error detected\n");
 			clear |= SDW_SCP_INT1_PARITY;
 		}
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 3550ab530c43..19bec6e4bbb6 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -356,6 +356,7 @@ struct sdw_dpn_prop {
  * @src_dpn_prop: Source Data Port N properties
  * @sink_dpn_prop: Sink Data Port N properties
  * @scp_int1_mask: SCP_INT1_MASK desired settings
+ * @quirks: bitmask identifying deltas from the MIPI specification
  */
 struct sdw_slave_prop {
 	u32 mipi_revision;
@@ -378,8 +379,11 @@ struct sdw_slave_prop {
 	struct sdw_dpn_prop *src_dpn_prop;
 	struct sdw_dpn_prop *sink_dpn_prop;
 	u8 scp_int1_mask;
+	u32 quirks;
 };
 
+#define SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY	BIT(0)
+
 /**
  * struct sdw_master_prop - Master properties
  * @revision: MIPI spec version of the implementation
-- 
2.17.1

