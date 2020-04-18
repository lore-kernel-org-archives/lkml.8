Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C115C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13C321D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587219235;
	bh=vKZF0TjOhUk4OB+KxnVUmgnDdTOjtlFrEOhbpErD2AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uGoITXOQoERRoWEap+2HTeV0l5jBELqpaq+i7R+ZFsQEdBJ4qfMaOgoOL/R8b0295
	 6+q1Lds4q8lHjZBluO1+uqUL3ZIbDrIIkWtZvJJIYfYOA5Awi280LIftpn9EHNpWgI
	 1SC6HrEEc1G0pU6zE5iUWpsq5VNsKPJeAa7dtr9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgDRONy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:13:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgDROJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:09:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 868872224F;
        Sat, 18 Apr 2020 14:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587218971;
        bh=vKZF0TjOhUk4OB+KxnVUmgnDdTOjtlFrEOhbpErD2AU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RC1fUYUyolEbYGroIE9D3Tf6ys3OEU4fXZw/HebESV0Q3TM3x4dhL2An5dHrK/TVk
         HTfPGDgGM3uaypxsoG+K9p/jp3ceJPGvaWIWmspWQbIeU1RWmRcE5utsvsO1ReES2q
         ynZDq2HLFPu/S59ZCLSQrXI6huYCZDPeqJQ/VGak=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?=EC=9D=B4=EA=B2=BD=ED=83=9D?= <gt82.lee@samsung.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.5 17/75] ASoC: dpcm: allow start or stop during pause for backend
Date:   Sat, 18 Apr 2020 10:08:12 -0400
Message-Id: <20200418140910.8280-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 이경택 <gt82.lee@samsung.com>

[ Upstream commit 21fca8bdbb64df1297e8c65a746c4c9f4a689751 ]

soc_compr_trigger_fe() allows start or stop after pause_push.
In dpcm_be_dai_trigger(), however, only pause_release is allowed
command after pause_push.
So, start or stop after pause in compress offload is always
returned as error if the compress offload is used with dpcm.
To fix the problem, SND_SOC_DPCM_STATE_PAUSED should be allowed
for start or stop command.

Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/004d01d607c1$7a3d5250$6eb7f6f0$@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8de29f48442f6..e4ff0796526c7 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2256,7 +2256,8 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 		switch (cmd) {
 		case SNDRV_PCM_TRIGGER_START:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
-			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				continue;
 
 			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
@@ -2286,7 +2287,8 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_STOP:
-			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
+			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				continue;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-- 
2.20.1

