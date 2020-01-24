Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC73C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5FE2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876014;
	bh=0uOWnKSh83fXudGqMAovmHVwNS2NZDD+nPINkoIHYG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v9JxXlwL31Kr6oGOUUlXbN6Y9tHL4SEHWvbaF1luQJNSMegof0t/EQhMMtm4JgGZh
	 tH5c1AOkNmEuRAVED1agdxTuW048D2+fKH5wrUEech1+l6LvhNZ9XQT+nyeZ2q8ZE0
	 XDpy2igaX180fnZJNKHH2X53AkVVFHXB84MuM7IM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390093AbgAXO0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:26:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405329AbgAXOVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B9A22464;
        Fri, 24 Jan 2020 14:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875694;
        bh=0uOWnKSh83fXudGqMAovmHVwNS2NZDD+nPINkoIHYG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ynLyuMnh93SZdlmlWXK10H1F1EcrxynLxRwZSGGVPtME0SkiIeAm24UrJjZfIlr+
         9IwDZkVCRuvnfRmUQIOs+oCz7CMchWCbsclBUThU+UonKya2Hc7pUmAEL6u9K30CzV
         3Ai7QeXV4d8SkD5tH37iXHLO7UvChgSYE364KsVc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.14 13/32] ASoC: sti: fix possible sleep-in-atomic
Date:   Fri, 24 Jan 2020 09:21:00 -0500
Message-Id: <20200124142119.30484-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142119.30484-1-sashal@kernel.org>
References: <20200124142119.30484-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

[ Upstream commit ce780a47c3c01e1e179d0792df6b853a913928f1 ]

Change mutex and spinlock management to avoid sleep
in atomic issue.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Link: https://lore.kernel.org/r/20200113100400.30472-1-arnaud.pouliquen@st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index d8b6936e544e3..908f13623f8cd 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -226,7 +226,6 @@ static void uni_player_set_channel_status(struct uniperif *player,
 	 * sampling frequency. If no sample rate is already specified, then
 	 * set one.
 	 */
-	mutex_lock(&player->ctrl_lock);
 	if (runtime) {
 		switch (runtime->rate) {
 		case 22050:
@@ -303,7 +302,6 @@ static void uni_player_set_channel_status(struct uniperif *player,
 		player->stream_settings.iec958.status[3 + (n * 4)] << 24;
 		SET_UNIPERIF_CHANNEL_STA_REGN(player, n, status);
 	}
-	mutex_unlock(&player->ctrl_lock);
 
 	/* Update the channel status */
 	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
@@ -365,8 +363,10 @@ static int uni_player_prepare_iec958(struct uniperif *player,
 
 	SET_UNIPERIF_CTRL_ZERO_STUFF_HW(player);
 
+	mutex_lock(&player->ctrl_lock);
 	/* Update the channel status */
 	uni_player_set_channel_status(player, runtime);
+	mutex_unlock(&player->ctrl_lock);
 
 	/* Clear the user validity user bits */
 	SET_UNIPERIF_USER_VALIDITY_VALIDITY_LR(player, 0);
@@ -598,7 +598,6 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
 	iec958->status[1] = ucontrol->value.iec958.status[1];
 	iec958->status[2] = ucontrol->value.iec958.status[2];
 	iec958->status[3] = ucontrol->value.iec958.status[3];
-	mutex_unlock(&player->ctrl_lock);
 
 	spin_lock_irqsave(&player->irq_lock, flags);
 	if (player->substream && player->substream->runtime)
@@ -608,6 +607,8 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
 		uni_player_set_channel_status(player, NULL);
 
 	spin_unlock_irqrestore(&player->irq_lock, flags);
+	mutex_unlock(&player->ctrl_lock);
+
 	return 0;
 }
 
-- 
2.20.1

