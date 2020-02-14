Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905CCC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2E124673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701115;
	bh=smEs9DZXB4IjMLlUyI3DmUCZLnk/s0uOHhPvWXcrfnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dBBxkkAQV52ZaziKnYQxYVYpnO5YutM40nsDAkIeW9DIB02406KqXSOPXT0aLNyJW
	 I2Yt6SvD3F1bfaYwyIP+LY8ddR3d/GOKYJ+Xd/i3xzSDPNSS9tu/8sWQh7TTKWIulf
	 wBl29WV85SzoNf40S01WGhicvJGz63oHac1cErpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391381AbgBNRZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391104AbgBNQIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:08:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AC3A22314;
        Fri, 14 Feb 2020 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696534;
        bh=smEs9DZXB4IjMLlUyI3DmUCZLnk/s0uOHhPvWXcrfnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+cSaa6WIGy+Gx2SUQ1YVWI2nFZMBobgWyIM/nM2e6/s1v2kbyUOokKI7cUmVat42
         oe58hBeJWlIWZq3FEC6HKc7ijgz+4JOwyDvhNCAwWZs8K8Es3cA0Wrn4GfGL9/ZWTh
         GYHHgocGwvYMSjDB6O2xntRde/yGGapAsyNnpmOY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Tsoy <alexander@tsoy.me>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 331/459] ALSA: usb-audio: add implicit fb quirk for MOTU M Series
Date:   Fri, 14 Feb 2020 10:59:41 -0500
Message-Id: <20200214160149.11681-331-sashal@kernel.org>
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
index fa24bd491cf6a..ad8f38380aa3e 100644
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

