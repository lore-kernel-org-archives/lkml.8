Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155E4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3FB206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702959;
	bh=i0ttOQxN0z0/Ta+VR+Huvh00r/qVH5VVQyPCyChB4BE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oF2Y/0ErZU89v83tNviOKWB+xVKNl8ihB2cdXiyWjR8EGrY8tMhn0Gj0vUqhVMl3o
	 oor3igTVBjvWctJOstzApdxzEB/G+rnd3ai2fH7u98Mky6um/RSd4KHydh8cB3+teE
	 V9chituvaYMFMzFKMPM/2vN9oqT9NQVWpcaaWy2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbgBNP5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:57:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388139AbgBNP5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:57:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1BF924676;
        Fri, 14 Feb 2020 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695827;
        bh=i0ttOQxN0z0/Ta+VR+Huvh00r/qVH5VVQyPCyChB4BE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0wvQ0IoQiPDNLGyHnUrjmE9VSi8XF9lj1T9PaTYnfuUFHkn83EvY7ujPJzu64agf
         Rx3jiKw4QSkuiRz1MuCertAsswJbk68KLLxz9vJ3Y5E4elq/l4rCD2E5nCbPbDiHNo
         oYNA5zwwO5BC0CBTg3d1B/Gnlcicn9zeN6HK7F78=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Tsoy <alexander@tsoy.me>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.5 381/542] ALSA: usb-audio: add implicit fb quirk for MOTU M Series
Date:   Fri, 14 Feb 2020 10:46:13 -0500
Message-Id: <20200214154854.6746-381-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Tsoy <alexander@tsoy.me>

[ Upstream commit c249177944b650816069f6c49b769baaa94339dc ]

This fixes crackling sound during playback.

Further note: MOTU is known for reusing Product IDs for different
devices or different generations of the device (e.g. MicroBook
I/II/IIc shares a single Product ID). This patch was only tested with
M4 audio interface, but the same Product ID is also used by M2. Hope
it will work for M2 as well.

Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
Link: https://lore.kernel.org/r/20200115151358.56672-1-alexander@tsoy.me
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/pcm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 0e4eab96e23e0..c9e1609296dff 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -348,6 +348,10 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 		ep = 0x84;
 		ifnum = 0;
 		goto add_sync_ep_from_ifnum;
+	case USB_ID(0x07fd, 0x0008): /* MOTU M Series */
+		ep = 0x81;
+		ifnum = 2;
+		goto add_sync_ep_from_ifnum;
 	case USB_ID(0x0582, 0x01d8): /* BOSS Katana */
 		/* BOSS Katana amplifiers do not need quirks */
 		return 0;
-- 
2.20.1

