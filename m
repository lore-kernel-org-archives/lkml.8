Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3805CC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16601206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgCLTfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:35:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:45900 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgCLTfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:35:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 12:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="243142723"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.241.169])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 12:35:13 -0700
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
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 08/10] ASoC: SOF: Intel: hda: add parameter to control SoundWire clock stop quirks
Date:   Thu, 12 Mar 2020 14:33:44 -0500
Message-Id: <20200312193346.3264-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
References: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add module parameter so that the different modes can be quickly tested.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index f7e5371789f2..32b02d3b6536 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -40,6 +40,16 @@
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
 
+/*
+ * The default for SoundWire clock stop quirks is to power gate the IP
+ * and do a Bus Reset, this will need to be modified when the DSP
+ * needs to remain in D0i3 so that the Master does not lose context
+ * and enumeration is not required on clock restart
+ */
+static int sdw_clock_stop_quirks = SDW_INTEL_CLK_STOP_BUS_RESET;
+module_param(sdw_clock_stop_quirks, int, 0444);
+MODULE_PARM_DESC(sdw_clock_stop_quirks, "SOF SoundWire clock stop quirks");
+
 static int sdw_params_stream(struct device *dev,
 			     struct sdw_intel_stream_params_data *params_data)
 {
@@ -149,6 +159,7 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 	res.parent = sdev->dev;
 	res.ops = &sdw_callback;
 	res.dev = sdev->dev;
+	res.clock_stop_quirks = sdw_clock_stop_quirks;
 
 	/*
 	 * ops and arg fields are not populated for now,
-- 
2.20.1

