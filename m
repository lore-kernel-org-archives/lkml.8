Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B38C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BBC20842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgAJVqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:46:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:31425 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbgAJVq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:46:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 13:46:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="423729262"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.183.94])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2020 13:46:24 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 4/5] soundwire: intel: add sdw_stream_setup helper for .startup callback
Date:   Fri, 10 Jan 2020 15:46:07 -0600
Message-Id: <20200110214609.30356-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110214609.30356-1-pierre-louis.bossart@linux.intel.com>
References: <20200110214609.30356-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@linux.intel.com>

The sdw stream is allocated and stored in dai to share the sdw runtime
information.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 65 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index aa80c46156cb..f4554386d832 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -617,6 +617,69 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
  * DAI routines
  */
 
+static int sdw_stream_setup(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sdw_stream_runtime *sdw_stream = NULL;
+	char *name;
+	int i, ret;
+
+	name = kzalloc(32, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		snprintf(name, 32, "%s-Playback", dai->name);
+	else
+		snprintf(name, 32, "%s-Capture", dai->name);
+
+	sdw_stream = sdw_alloc_stream(name);
+	if (!sdw_stream) {
+		dev_err(dai->dev, "alloc stream failed for DAI %s", dai->name);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	/* Set stream pointer on CPU DAI */
+	ret = snd_soc_dai_set_sdw_stream(dai, sdw_stream, substream->stream);
+	if (ret < 0) {
+		dev_err(dai->dev, "failed to set stream pointer on cpu dai %s",
+			dai->name);
+		goto release_stream;
+	}
+
+	/* Set stream pointer on all CODEC DAIs */
+	for (i = 0; i < rtd->num_codecs; i++) {
+		ret = snd_soc_dai_set_sdw_stream(rtd->codec_dais[i], sdw_stream,
+						 substream->stream);
+		if (ret < 0) {
+			dev_err(dai->dev, "failed to set stream pointer on codec dai %s",
+				rtd->codec_dais[i]->name);
+			goto release_stream;
+		}
+	}
+
+	return 0;
+
+release_stream:
+	sdw_release_stream(sdw_stream);
+error:
+	kfree(name);
+	return ret;
+}
+
+static int intel_startup(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	/*
+	 * TODO: add pm_runtime support here, the startup callback
+	 * will make sure the IP is 'active'
+	 */
+
+	return sdw_stream_setup(substream, dai);
+}
+
 static int intel_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
@@ -796,6 +859,7 @@ static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
 }
 
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
+	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
 	.trigger = intel_trigger,
@@ -805,6 +869,7 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 };
 
 static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
+	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
 	.trigger = intel_trigger,
-- 
2.20.1

