Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C591AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B7C20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgFWJR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:17:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:45826 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732016AbgFWJR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:17:56 -0400
IronPort-SDR: tyHuFsEvFl7S/18b4TnBCse6rsJXmQTMjwU48hWZ/jYWOLTchk0y9pw8I9Ajaw+/i+MOQA4bDx
 B2+Go8t8iQ8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="228682294"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="228682294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 02:17:53 -0700
IronPort-SDR: tfyBTA+OrLrVc1xPcJxkQzm1oxRhE9iotU3HGD3dUo0rECfJdeNpmMMgZxmHnfIvz7vnLF37rA
 9Ut8263okeog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="293141982"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2020 02:17:49 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/5] soundwire: stream: add helper to startup/shutdown streams
Date:   Tue, 23 Jun 2020 05:23:29 +0800
Message-Id: <20200622212332.16277-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622212332.16277-1-yung-chuan.liao@linux.intel.com>
References: <20200622212332.16277-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

To handle streams at the dailink level, expose two helpers that will
be called from machine drivers.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c    | 90 +++++++++++++++++++++++++++++++++++
 include/linux/soundwire/sdw.h |  2 +
 2 files changed, 92 insertions(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a9a72574b34a..48daf4b48f51 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -13,6 +13,9 @@
 #include <linux/slab.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
 #include "bus.h"
 
 /*
@@ -1826,3 +1829,90 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 	return ret;
 }
 EXPORT_SYMBOL(sdw_deprepare_stream);
+
+static int set_stream(struct snd_pcm_substream *substream,
+		      struct sdw_stream_runtime *sdw_stream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *dai;
+	int ret = 0;
+	int i;
+
+	/* Set stream pointer on all DAIs */
+	for_each_rtd_dais(rtd, i, dai) {
+		ret = snd_soc_dai_set_sdw_stream(dai, sdw_stream,
+						 substream->stream);
+		if (ret < 0) {
+			dev_err(rtd->dev,
+				"failed to set stream pointer on dai %s",
+				dai->name);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int sdw_startup_stream(void *sdw_substream)
+{
+	struct snd_pcm_substream *substream = sdw_substream;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sdw_stream_runtime *sdw_stream;
+	char *name;
+	int ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		name = kasprintf(GFP_KERNEL, "%s-Playback", substream->name);
+	else
+		name = kasprintf(GFP_KERNEL, "%s-Capture", substream->name);
+
+	if (!name)
+		return -ENOMEM;
+
+	sdw_stream = sdw_alloc_stream(name);
+	if (!sdw_stream) {
+		dev_err(rtd->dev, "alloc stream failed for substream DAI %s",
+			substream->name);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	ret = set_stream(substream, sdw_stream);
+	if (ret < 0)
+		goto release_stream;
+	return 0;
+
+release_stream:
+	sdw_release_stream(sdw_stream);
+	set_stream(substream, NULL);
+error:
+	kfree(name);
+	return ret;
+}
+EXPORT_SYMBOL(sdw_startup_stream);
+
+void sdw_shutdown_stream(void *sdw_substream)
+{
+	struct snd_pcm_substream *substream = sdw_substream;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct sdw_stream_runtime *sdw_stream;
+	struct snd_soc_dai *dai;
+
+	/* Find stream from first CPU DAI */
+	dai = asoc_rtd_to_cpu(rtd, 0);
+
+	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
+
+	if (!sdw_stream) {
+		dev_err(rtd->dev, "no stream found for DAI %s", dai->name);
+		return;
+	}
+
+	/* release memory */
+	kfree(sdw_stream->name);
+	sdw_release_stream(sdw_stream);
+
+	/* clear DAI data */
+	set_stream(substream, NULL);
+}
+EXPORT_SYMBOL(sdw_shutdown_stream);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 9c27a32df9bb..51ecbd8faa8c 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -952,10 +952,12 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
 		struct sdw_stream_runtime *stream);
 int sdw_stream_remove_slave(struct sdw_slave *slave,
 		struct sdw_stream_runtime *stream);
+int sdw_startup_stream(void *sdw_substream);
 int sdw_prepare_stream(struct sdw_stream_runtime *stream);
 int sdw_enable_stream(struct sdw_stream_runtime *stream);
 int sdw_disable_stream(struct sdw_stream_runtime *stream);
 int sdw_deprepare_stream(struct sdw_stream_runtime *stream);
+void sdw_shutdown_stream(void *sdw_substream);
 int sdw_bus_prep_clk_stop(struct sdw_bus *bus);
 int sdw_bus_clk_stop(struct sdw_bus *bus);
 int sdw_bus_exit_clk_stop(struct sdw_bus *bus);
-- 
2.17.1

