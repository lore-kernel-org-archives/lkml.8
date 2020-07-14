Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAF9C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C2222AAA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752497;
	bh=UfXNsBsfnQgCDV33rI/M8yD/l2RhfKKPlSjWyT9d7M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dScKYUMAXLyS4F/zXOaNq8zhj18SS2qua9mLuuuW1sstoA2bb+qyQevh2mZr94TTF
	 Q/EiBrBalAmDYqPeEr2NCWtjDKxmHQrkUyCsRUCKt4HnGjDutcg9aBmnN0kWCXCH0I
	 DE87nK+zhuSe6d0c2gW8Erz7YmWejgegwp1ySepA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgGNSsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729891AbgGNSsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:48:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8511822AAA;
        Tue, 14 Jul 2020 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752489;
        bh=UfXNsBsfnQgCDV33rI/M8yD/l2RhfKKPlSjWyT9d7M8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQPwMzzZJB8xC60B5+8GXM/qml7dTD/30LhdEuRGIWVntqDbOnPwnjNVLVTD5TdT7
         KdxyH6+5232j+h2GmFVbYdYwv730k3K7aYv2/ElQEQ1WwWQUAvv2V0N5uVBEqIZTyl
         MsRNEl6r/GREignNqLaq+J7gTZ4Pt6Nf7JDfCx5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 31/58] ALSA: compress: fix partial_drain completion state
Date:   Tue, 14 Jul 2020 20:44:04 +0200
Message-Id: <20200714184057.680149937@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184056.149119318@linuxfoundation.org>
References: <20200714184056.149119318@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

[ Upstream commit f79a732a8325dfbd570d87f1435019d7e5501c6d ]

On partial_drain completion we should be in SNDRV_PCM_STATE_RUNNING
state, so set that for partially draining streams in
snd_compr_drain_notify() and use a flag for partially draining streams

While at it, add locks for stream state change in
snd_compr_drain_notify() as well.

Fixes: f44f2a5417b2 ("ALSA: compress: fix drain calls blocking other compress functions (v6)")
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20200629134737.105993-4-vkoul@kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/compress_driver.h | 10 +++++++++-
 sound/core/compress_offload.c   |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 127c2713b543a..99855d1c74766 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -57,6 +57,7 @@ struct snd_compr_runtime {
  * @direction: stream direction, playback/recording
  * @metadata_set: metadata set flag, true when set
  * @next_track: has userspace signal next track transition, true when set
+ * @partial_drain: undergoing partial_drain for stream, true when set
  * @private_data: pointer to DSP private data
  */
 struct snd_compr_stream {
@@ -68,6 +69,7 @@ struct snd_compr_stream {
 	enum snd_compr_direction direction;
 	bool metadata_set;
 	bool next_track;
+	bool partial_drain;
 	void *private_data;
 };
 
@@ -171,7 +173,13 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
 	if (snd_BUG_ON(!stream))
 		return;
 
-	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+	/* for partial_drain case we are back to running state on success */
+	if (stream->partial_drain) {
+		stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
+		stream->partial_drain = false; /* clear this flag as well */
+	} else {
+		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+	}
 
 	wake_up(&stream->runtime->sleep);
 }
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 509038d6bccdb..68f016e4929ac 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -723,6 +723,9 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
 
 	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_STOP);
 	if (!retval) {
+		/* clear flags and stop any drain wait */
+		stream->partial_drain = false;
+		stream->metadata_set = false;
 		snd_compr_drain_notify(stream);
 		stream->runtime->total_bytes_available = 0;
 		stream->runtime->total_bytes_transferred = 0;
@@ -880,6 +883,7 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
 	if (stream->next_track == false)
 		return -EPERM;
 
+	stream->partial_drain = true;
 	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_PARTIAL_DRAIN);
 	if (retval) {
 		pr_debug("Partial drain returned failure\n");
-- 
2.25.1



