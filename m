Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422B1C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3BF206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274595;
	bh=Blrkqpo0ttDNFxksJ/K85sjcbAzpjsltlkyUQBX/ffY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rWzOJHOewg90efBKXTF01X+wpjt2VJhiSxQRUTWaBoBBua8maSiSpz0/IREiUOdzE
	 3xqdsIUi4f53nWlhKwiHJiR6yPL9aeaW90yJH+sjVGr09fM35mVdWSky3ai3iT47Dp
	 I6M3ZJgrIyiWaPxYIXp6AUF0imne1O7UctjRz13Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgBUHxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:52276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729831AbgBUHxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:53:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C2E222C4;
        Fri, 21 Feb 2020 07:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271630;
        bh=Blrkqpo0ttDNFxksJ/K85sjcbAzpjsltlkyUQBX/ffY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thU5nkE3TrWsnaCISU6jCbroDK2NOVs6ni/SyUKS4sO7i0mUKYwlBC701jhrXVMXt
         cLZaR+28mAVpyfeAaiYVFgMCsgldv7zbSU0vRmRF6lTMHhCmWXUfpegGPCWiM/O96i
         4VD/FRGUouNl2TVwMxUAQPTRb7yzn+xAv68q3dQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 201/399] ALSA: sh: Fix unused variable warnings
Date:   Fri, 21 Feb 2020 08:38:46 +0100
Message-Id: <20200221072422.367785032@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index f9e36abc98ac7..725992937e8f1 100644
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



