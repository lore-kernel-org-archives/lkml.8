Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D248C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0DB2472C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697229;
	bh=09CLZHhNHNyqqmnT9B63fYO3RiBBKa0IUbToH8AhA4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BlFZt0Cd71utymZcfnNXru5kDaKfpBx+4TFL3FN1oCyJt5idTtvXTPFjDX+W1dKDt
	 jBYzY23tywF9bRvG76uCXCFuMeJ8K1JWn/LBE4hSrwo412QPu1X73FK1UIiuptJ9AK
	 muXbFxxgjjjV4pdxqdjHANbzKsW/yWOe+jwLx8PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392848AbgBNQU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404324AbgBNQTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:19:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB88F24702;
        Fri, 14 Feb 2020 16:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697161;
        bh=09CLZHhNHNyqqmnT9B63fYO3RiBBKa0IUbToH8AhA4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+Zev86rRxy20Eg8yT37x9fcglTqXDj71piP0GGRIjQTOxLpQXFsb5uguvkaPoitM
         3AxGHK3PbQMNFWeIcc4/PdfL8evMy4z2yUoo/2idCmyaOMwNfUinp1ZlJaHWJUX1kx
         KsbreSH3O4xJfR1aO3afUx5Uvq9SHhKQEpPyhofA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.14 098/186] ALSA: sh: Fix unused variable warnings
Date:   Fri, 14 Feb 2020 11:15:47 -0500
Message-Id: <20200214161715.18113-98-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
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
index 834b2574786f5..6251b5e1b64a2 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -190,7 +190,6 @@ static int snd_sh_dac_pcm_copy(struct snd_pcm_substream *substream,
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	if (copy_from_user_toio(chip->data_buffer + pos, src, count))
 		return -EFAULT;
@@ -210,7 +209,6 @@ static int snd_sh_dac_pcm_copy_kernel(struct snd_pcm_substream *substream,
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	memcpy_toio(chip->data_buffer + pos, src, count);
 	chip->buffer_end = chip->data_buffer + pos + count;
@@ -229,7 +227,6 @@ static int snd_sh_dac_pcm_silence(struct snd_pcm_substream *substream,
 {
 	/* channel is not used (interleaved data) */
 	struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	memset_io(chip->data_buffer + pos, 0, count);
 	chip->buffer_end = chip->data_buffer + pos + count;
-- 
2.20.1

