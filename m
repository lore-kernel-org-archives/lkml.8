Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5D8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D702E2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593100044;
	bh=IgCDJ/4NXHUUIMvtdNOkk30i4IMtWPYAHp9uh6q/7II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gfTMEuGEnCmNmST9E0xDVtBh0qVoNbx7hZRcLoTIaJI5/57UZHpb7FpNDN49kDOLR
	 gZBWRvbmNLqC+SG5IEiWDilf6eFTpmK9u6ruqmBLYFB3LwupQEOLO1/MlWnTc/3br6
	 JbwxkfjfVyH3S76u7NBU7dIB3VdqIVWCG68AWD8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406065AbgFYPrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406053AbgFYPrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:47:15 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47BB520836;
        Thu, 25 Jun 2020 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593100034;
        bh=IgCDJ/4NXHUUIMvtdNOkk30i4IMtWPYAHp9uh6q/7II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtWCfzOyrAUT8ZVl5yyPzzbekoxnU/i2wT7XzsMfHFK/69iJnys9T9xcrJ9RJjcwW
         2vV0hBG5e2qp0rfi9B24YzOQR96N2BFb6/BmFhRO0ku3Mw6KgtkBk/M3QnWwoacuV2
         5XDtWW9mj542HRoiC5zD7dMIv/nF91cbiha2xxjk=
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ALSA: compress: fix partial_drain completion state
Date:   Thu, 25 Jun 2020 21:16:51 +0530
Message-Id: <20200625154651.99758-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625154651.99758-1-vkoul@kernel.org>
References: <20200625154651.99758-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On partial_drain completion we should be in SNDRV_PCM_STATE_RUNNING
state, so set that for partially draining streams in
snd_compr_drain_notify() and use a flag for partially draining streams

While at it, add locks for stream state change in
snd_compr_drain_notify() as well.

Fixes: f44f2a5417b2 ("ALSA: compress: fix drain calls blocking other compress functions (v6)")
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/sound/compress_driver.h | 12 +++++++++++-
 sound/core/compress_offload.c   |  4 ++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 3df8d8c90191..93a5897201ea 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -66,6 +66,7 @@ struct snd_compr_runtime {
  * @direction: stream direction, playback/recording
  * @metadata_set: metadata set flag, true when set
  * @next_track: has userspace signal next track transition, true when set
+ * @partial_drain: undergoing partial_drain for stream, true when set
  * @private_data: pointer to DSP private data
  * @dma_buffer: allocated buffer if any
  */
@@ -78,6 +79,7 @@ struct snd_compr_stream {
 	enum snd_compr_direction direction;
 	bool metadata_set;
 	bool next_track;
+	bool partial_drain;
 	void *private_data;
 	struct snd_dma_buffer dma_buffer;
 };
@@ -187,7 +189,15 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
 	if (snd_BUG_ON(!stream))
 		return;
 
-	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+	mutex_lock(&stream->device->lock);
+	/* for partial_drain case we are back to running state on success */
+	if (stream->partial_drain) {
+		stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
+		stream->partial_drain = false; /* clear this flag as well */
+	} else {
+		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+	}
+	mutex_unlock(&stream->device->lock);
 
 	wake_up(&stream->runtime->sleep);
 }
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index e618580feac4..1c4b2cf450a0 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -803,6 +803,9 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
 
 	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_STOP);
 	if (!retval) {
+		/* clear flags and stop any drain wait */
+		stream->partial_drain = false;
+		stream->metadata_set = false;
 		snd_compr_drain_notify(stream);
 		stream->runtime->total_bytes_available = 0;
 		stream->runtime->total_bytes_transferred = 0;
@@ -960,6 +963,7 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
 	if (stream->next_track == false)
 		return -EPERM;
 
+	stream->partial_drain = true;
 	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_PARTIAL_DRAIN);
 	if (retval) {
 		pr_debug("Partial drain returned failure\n");
-- 
2.26.2

