Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C281EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8583207DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgHROfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:35:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:33372 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgHROfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:35:43 -0400
IronPort-SDR: x+BotgFK1/nT984Dxd5Hb1ukRWxPSisD0L12WPh8X/+7FoFaCI9f+Oyx9PzuD//DzjI0B8Ym+o
 nEGVaJkP4AFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154170530"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="154170530"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:42 -0700
IronPort-SDR: Rd01k4E1jz1u2BQBSB1sC9wDF7umGbQerY8BfBGLcnjFmedBi+OCudLNXRyt/hHE9lw3vAo90N
 SdR/JrgtV0Qg==
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="471830647"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 07:35:39 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 07/11] soundwire: intel: Only call sdw stream APIs for the first cpu_dai
Date:   Tue, 18 Aug 2020 10:41:16 +0800
Message-Id: <20200818024120.20721-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should call these APIs once per stream. So we can only call it
when the dai ops is invoked for the first cpu dai.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/intel.c | 45 +++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 89a8ad1f80e8..7c63581270fd 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -941,11 +941,13 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 static int intel_prepare(struct snd_pcm_substream *substream,
 			 struct snd_soc_dai *dai)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *first_cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_cdns_dma_data *dma;
 	int ch, dir;
-	int ret;
+	int ret = 0;
 
 	dma = snd_soc_dai_get_dma_data(dai, substream);
 	if (!dma) {
@@ -985,7 +987,13 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 			goto err;
 	}
 
-	ret = sdw_prepare_stream(dma->stream);
+	/*
+	 * All cpu dais belong to a stream. To ensure sdw_prepare_stream
+	 * is called once per stream, we should call it only when
+	 * dai = first_cpu_dai.
+	 */
+	if (first_cpu_dai == dai)
+		ret = sdw_prepare_stream(dma->stream);
 
 err:
 	return ret;
@@ -994,9 +1002,19 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 static int intel_trigger(struct snd_pcm_substream *substream, int cmd,
 			 struct snd_soc_dai *dai)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *first_cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct sdw_cdns_dma_data *dma;
 	int ret;
 
+	/*
+	 * All cpu dais belong to a stream. To ensure sdw_enable/disable_stream
+	 * are called once per stream, we should call them only when
+	 * dai = first_cpu_dai.
+	 */
+	if (first_cpu_dai != dai)
+		return 0;
+
 	dma = snd_soc_dai_get_dma_data(dai, substream);
 	if (!dma) {
 		dev_err(dai->dev, "failed to get dma data in %s", __func__);
@@ -1031,6 +1049,8 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd,
 static int
 intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *first_cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_cdns_dma_data *dma;
@@ -1040,12 +1060,25 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 	if (!dma)
 		return -EIO;
 
-	ret = sdw_deprepare_stream(dma->stream);
-	if (ret) {
-		dev_err(dai->dev, "sdw_deprepare_stream: failed %d", ret);
-		return ret;
+	/*
+	 * All cpu dais belong to a stream. To ensure sdw_deprepare_stream
+	 * is called once per stream, we should call it only when
+	 * dai = first_cpu_dai.
+	 */
+	if (first_cpu_dai == dai) {
+		ret = sdw_deprepare_stream(dma->stream);
+		if (ret) {
+			dev_err(dai->dev, "sdw_deprepare_stream: failed %d", ret);
+			return ret;
+		}
 	}
 
+	/*
+	 * The sdw stream state will transition to RELEASED when stream->
+	 * master_list is empty. So the stream state will transition to
+	 * DEPREPARED for the first cpu-dai and to RELEASED for the last
+	 * cpu-dai.
+	 */
 	ret = sdw_stream_remove_master(&cdns->bus, dma->stream);
 	if (ret < 0) {
 		dev_err(dai->dev, "remove master from stream %s failed: %d\n",
-- 
2.17.1

