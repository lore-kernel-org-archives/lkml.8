Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05BCC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AD4206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgCQKvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:51:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:24457 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgCQKvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:51:47 -0400
IronPort-SDR: 9D9ya5ShjIs1mkOzTOAI+Wa7HVMrRc29UYKuAfXInqAZ9kgz8E2bl8/Sg6Sn9oJJ+IshE9/iSM
 Q478jX9WzbhQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 03:51:46 -0700
IronPort-SDR: KZ6MXAW7Wed2SNzKcd2mam6OirO0eshuzYwmIoVa3c3D4x/dkjUTfFVzfIM4PbIvTgvxq46orL
 4gYl46xoHlhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="236295330"
Received: from dasabhi1-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.35.148])
  by fmsmga007.fm.intel.com with ESMTP; 17 Mar 2020 03:51:44 -0700
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
Subject: [PATCH] soundwire: stream: only change state if needed
Date:   Tue, 17 Mar 2020 05:51:42 -0500
Message-Id: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a multi-cpu DAI context, the stream routines may be called from
multiple DAI callbacks. Make sure the stream state only changes for
the first call, and don't return error messages if the target state is
already reached.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/stream.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 1b43d03c79ea..3319121cd706 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1572,6 +1572,7 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
 	sdw_acquire_bus_lock(stream);
 
 	if (stream->state == SDW_STREAM_PREPARED) {
+		/* nothing to do */
 		ret = 0;
 		goto state_err;
 	}
@@ -1661,6 +1662,12 @@ int sdw_enable_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state == SDW_STREAM_ENABLED) {
+		/* nothing to do */
+		ret = 0;
+		goto state_err;
+	}
+
 	if (stream->state != SDW_STREAM_PREPARED &&
 	    stream->state != SDW_STREAM_DISABLED) {
 		pr_err("%s: %s: inconsistent state state %d\n",
@@ -1744,6 +1751,12 @@ int sdw_disable_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state == SDW_STREAM_DISABLED) {
+		/* nothing to do */
+		ret = 0;
+		goto state_err;
+	}
+
 	if (stream->state != SDW_STREAM_ENABLED) {
 		pr_err("%s: %s: inconsistent state state %d\n",
 		       __func__, stream->name, stream->state);
@@ -1809,6 +1822,12 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state == SDW_STREAM_DEPREPARED) {
+		/* nothing to do */
+		ret = 0;
+		goto state_err;
+	}
+
 	if (stream->state != SDW_STREAM_PREPARED &&
 	    stream->state != SDW_STREAM_DISABLED) {
 		pr_err("%s: %s: inconsistent state state %d\n",
-- 
2.20.1

