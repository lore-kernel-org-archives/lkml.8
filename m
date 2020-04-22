Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275CDC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FB820784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549591;
	bh=/2XVAIVe8wVjZAqWWzOmKbk2XSQeGlcjzHmXAH4lmVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bqAwOINGYMjetWoAa3i6RCOsJ0uhWPLyEuX5XVEHMlFOTBrjhZwpdYc9cfegpdp8E
	 QYp7RxRXtTO1M+boe1KZHEXKjK9kYpVr+pGEO7Mw2Z7DC3ycRFuFEqvKFJUBMwpwja
	 NNpxJ0iLM3wr4VVtZ5nr5hkMpC89sg1qb5I/xeX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDVJ7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgDVJ7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:59:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8280C20735;
        Wed, 22 Apr 2020 09:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549585;
        bh=/2XVAIVe8wVjZAqWWzOmKbk2XSQeGlcjzHmXAH4lmVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4GYhqJLpnJdMsUAbLg4lZbz6jWGtuyufkYNw0zIPPK+0/kp3jd2kl3OVnXTkhPih
         hSWPG//Vp5zJ5uioNdCeJHElmr7xAQqX+E9rXeGs5ua5P/PZkKfLbcpenS7Nytz1wm
         +Muj2YAAaIj+PKg7kfxfHERxBhqA0XV5hEcn2t1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 016/100] ASoC: dpcm: allow start or stop during pause for backend
Date:   Wed, 22 Apr 2020 11:55:46 +0200
Message-Id: <20200422095025.822200592@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 이경택 <gt82.lee@samsung.com>

commit 21fca8bdbb64df1297e8c65a746c4c9f4a689751 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-pcm.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1951,7 +1951,8 @@ int dpcm_be_dai_trigger(struct snd_soc_p
 		switch (cmd) {
 		case SNDRV_PCM_TRIGGER_START:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
-			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				continue;
 
 			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
@@ -1981,7 +1982,8 @@ int dpcm_be_dai_trigger(struct snd_soc_p
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_STOP:
-			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
+			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				continue;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))


