Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B10EC4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E818F2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCTQaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:30:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:35562 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgCTQaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:30:06 -0400
IronPort-SDR: aQQ99C2CSyrbpVe15F+diDr7YEO2utKZ1NVc0fm9ICumWdnE9aguxgRIobrCDMacXMKHwAfgVL
 JvYRkvSgDcFQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 09:30:05 -0700
IronPort-SDR: bHWPirFfuFYtgMU59MmbNvzP61dZoKTzksjLxclgAiV7iNaeKV4yNZ16ocT2TZz07y/C009pf4
 p/Jot+7gEqLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="248930916"
Received: from manallet-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.34.12])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2020 09:30:02 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 2/5] soundwire: bus_type: protect cases where no driver name is provided
Date:   Fri, 20 Mar 2020 11:29:44 -0500
Message-Id: <20200320162947.17663-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320162947.17663-1-pierre-louis.bossart@linux.intel.com>
References: <20200320162947.17663-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the implementation only creates a sdw_master_device and does not
provide a master_name, we have a risk of kernel oopses with dereferences
of a NULL pointer.

Protect with explicit tests.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus_type.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 09a25075e770..c01d74c709d5 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -48,12 +48,14 @@ static int sdw_bus_match(struct device *dev, struct device_driver *ddrv)
 		md = dev_to_sdw_master_device(dev);
 		mdrv = drv_to_sdw_master_driver(ddrv);
 
-		/*
-		 * we don't have any hardware information so
-		 * match with a hopefully unique string
-		 */
-		ret = !strncmp(md->master_name, mdrv->driver.name,
-			       strlen(md->master_name));
+		if (md->master_name) {
+			/*
+			 * we don't have any hardware information so
+			 * match with a hopefully unique string
+			 */
+			ret = !strncmp(md->master_name, mdrv->driver.name,
+				       strlen(md->master_name));
+		}
 	}
 	return ret;
 }
@@ -71,9 +73,11 @@ static int sdw_master_modalias(const struct sdw_master_device *md,
 			       char *buf, size_t size)
 {
 	/* modalias is sdw:<string> since we don't have any hardware info */
-
-	return snprintf(buf, size, "sdw:%s\n",
-			md->master_name);
+	if (md->master_name)
+		return snprintf(buf, size, "sdw:%s\n",
+				md->master_name);
+	else
+		return snprintf(buf, size, "sdw:no_master_driver\n");
 }
 
 static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
-- 
2.20.1

