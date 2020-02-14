Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E262AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10D52187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696463;
	bh=u3pylgW4mohWKVhQF3QxbtrbaX/Et8oD+zpRMptAa8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dhNhzjMcHviW9csY5DEYViItBKdq3JGNHN8YeneXwPwdbdGz/zwwZScsmSUI8JaJp
	 G0prycAlZ0CR0KZBS+u8juex9DfjWFMHa0mvO3Tb4Uq5yR+fwQM35H2kDnFzdOohEJ
	 +swWJbJZzIw2uDos0Z59XSmTd5etVLLAP1LP/ZVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390743AbgBNQHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:07:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390556AbgBNQHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:07:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F32924650;
        Fri, 14 Feb 2020 16:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696421;
        bh=u3pylgW4mohWKVhQF3QxbtrbaX/Et8oD+zpRMptAa8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J++B1s5//yjHHFMVs1Sgu/bN3YDrt5JKWUgBfHP2mwtu2OcSSB/rWSZF2ao4evO2G
         lZh9MtG5t+RbiWWzOMAKsVmqgvK40OF+zA7e/Vcjqm+ZCNs53vT34lbBjSx76+A+Bi
         lSjxGSkcJuEnHHiwOiINMV3WVRrod9NyDDhmtpkQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 242/459] ALSA: sh: Fix unused variable warnings
Date:   Fri, 14 Feb 2020 10:58:12 -0500
Message-Id: <20200214160149.11681-242-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 5da116f164ce265e397b8f59af5c39e4a61d61a5 ]

Remove unused variables that are left over after the conversion of new
PCM ops:
  sound/sh/sh_dac_audio.c:166:26: warning: unused variable 'runtime'
  sound/sh/sh_dac_audio.c:186:26: warning: unused variable 'runtime'
  sound/sh/sh_dac_audio.c:205:26: warning: unused variable 'runtime'

Fixes: 1cc2f8ba0b3e ("ALSA: sh: Convert to the new PCM ops")
Link: https://lore.kernel.org/r/20200104110057.13875-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/sh/sh_dac_audio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index ed877a138965d..7c46494466ff1 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -175,7 +175,6 @@ static int snd_sh_dac_pcm_copy(struct snd_pcm_substream *substream,
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	if (copy_from_user_toio(chip->data_buffer + pos, src, count))
 		return -EFAULT;
@@ -195,7 +194,6 @@ static int snd_sh_dac_pcm_copy_kernel(struct snd_pcm_substream *substream,
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	memcpy_toio(chip->data_buffer + pos, src, count);
 	chip->buffer_end = chip->data_buffer + pos + count;
@@ -214,7 +212,6 @@ static int snd_sh_dac_pcm_silence(struct snd_pcm_substream *substream,
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	memset_io(chip->data_buffer + pos, 0, count);
 	chip->buffer_end = chip->data_buffer + pos + count;
-- 
2.20.1

