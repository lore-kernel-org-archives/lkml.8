Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D8FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A604A20773
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgGAGin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:38:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:38228 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbgGAGif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:38:35 -0400
IronPort-SDR: fzx/+uI+E+3KklU+xWEX+gFlTF7/95KocohTaxbQxSx2eETvgmy3DKkik8giw0BW1iTb1CrU0o
 BkxDu/bxdiZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="146485955"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="146485955"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 23:38:28 -0700
IronPort-SDR: SHw6+uoHKHZ5v7CGKl/FWFPQ18ipJibKiHpsikzRbPagOtRVkyMWPTxgArqPMQ04HAtPSQHB9J
 1YrPaFTfLiFQ==
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="454946744"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 23:38:24 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 2/5] soundwire: stream: add helper to startup/shutdown streams
Date:   Wed,  1 Jul 2020 02:43:53 +0800
Message-Id: <20200630184356.24939-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630184356.24939-1-yung-chuan.liao@linux.intel.com>
References: <20200630184356.24939-1-yung-chuan.liao@linux.intel.com>
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
 Documentation/driver-api/soundwire/stream.rst | 11 ++-
 drivers/soundwire/stream.c                    | 98 +++++++++++++++++++
 include/linux/soundwire/sdw.h                 |  2 +
 3 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
index 1b386076402c..8858cea7bfe0 100644
--- a/Documentation/driver-api/soundwire/stream.rst
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -293,6 +293,10 @@ per stream. From ASoC DPCM framework, this stream state maybe linked to
 
   int sdw_alloc_stream(char * stream_name);
 
+The SoundWire core provides a sdw_startup_stream() helper function,
+typically called during a dailink .startup() callback, which performs
+stream allocation and sets the stream pointer for all DAIs
+connected to a stream.
 
 SDW_STREAM_CONFIGURED
 ~~~~~~~~~~~~~~~~~~~~~
@@ -509,7 +513,12 @@ In .shutdown() the data structure maintaining stream state are freed up.
 
   void sdw_release_stream(struct sdw_stream_runtime * stream);
 
-Not Supported
+The SoundWire core provides a sdw_shutdown_stream() helper function,
+typically called during a dailink .shutdown() callback, which clears
+the stream pointer for all DAIS connected to a stream and releases the
+memory allocated for the stream.
+
+  Not Supported
 =============
 
 1. A single port with multiple channels supported cannot be used between two
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a9a72574b34a..6bc2ff29c202 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/soundwire/sdw_registers.h>
 #include <linux/soundwire/sdw.h>
+#include <sound/soc.h>
 #include "bus.h"
 
 /*
@@ -1826,3 +1827,100 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
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
+		ret = snd_soc_dai_set_sdw_stream(dai, sdw_stream, substream->stream);
+		if (ret < 0) {
+			dev_err(rtd->dev, "failed to set stream pointer on dai %s", dai->name);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * sdw_startup_stream() - Startup SoundWire stream
+ *
+ * @stream: Soundwire stream
+ *
+ * Documentation/driver-api/soundwire/stream.rst explains this API in detail
+ */
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
+		dev_err(rtd->dev, "alloc stream failed for substream DAI %s", substream->name);
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
+/**
+ * sdw_shutdown_stream() - Shutdown SoundWire stream
+ *
+ * @stream: Soundwire stream
+ *
+ * Documentation/driver-api/soundwire/stream.rst explains this API in detail
+ */
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

