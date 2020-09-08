Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9227C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98AA021973
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgIIBj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:39:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:57650 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbgIIBjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:39:21 -0400
IronPort-SDR: NM7sbK7Qf/hItOfNgWUKUc4Oo5ckzI7dZ/pazCwk4j4VtnC2FwCqk2h9FAhxaNOdlHbynU9T2K
 bxIEvWPAO7tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="137770897"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="137770897"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 18:39:20 -0700
IronPort-SDR: 2Cjzn6LLgBB1at3OexRotIdOKNihHUHrIkcNjzsIWQ3ZxUl7HrdH7Abad1U+Hq+elZ5BrW1BOf
 rNlGltVS5uEw==
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="449018106"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 18:39:17 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 4/7] soundwire: bus: use quirk to filter out invalid parity errors
Date:   Tue,  8 Sep 2020 21:45:18 +0800
Message-Id: <20200908134521.6781-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
References: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
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
index 30b0bed16630..09185e5cfd70 100644
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
index 2b93a8ef7fad..790823d2d33b 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -358,6 +358,7 @@ struct sdw_dpn_prop {
  * @src_dpn_prop: Source Data Port N properties
  * @sink_dpn_prop: Sink Data Port N properties
  * @scp_int1_mask: SCP_INT1_MASK desired settings
+ * @quirks: bitmask identifying deltas from the MIPI specification
  */
 struct sdw_slave_prop {
 	u32 mipi_revision;
@@ -380,8 +381,11 @@ struct sdw_slave_prop {
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

