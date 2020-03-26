Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF888C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABE8208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265143;
	bh=jmFWny21xsnTOEOG9DY83c3Jc7v1c7S56O+7EUfbz/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fjKTFdiQqiGG/VJoIXu58j0xdjUMQEu+G8uCXTITh1h5OVTg4koUQ8234tM1MgPTb
	 ouzP5xff2N/+q5aAewyZifJJPrTmcxs0DyJD+VBZ3z0mn3uv+ZTmsl3cR1lT71jKKZ
	 He49ligoc8nwUEtEuYcfmkzflVEHE4KOznU0Sj5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgCZXZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbgCZXZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:25:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207CD20B1F;
        Thu, 26 Mar 2020 23:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265134;
        bh=jmFWny21xsnTOEOG9DY83c3Jc7v1c7S56O+7EUfbz/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0UML+U+gxy4tuE1Perk/urH4i98vYGBVdCnkrNHVovI3ZuAofX6lqbSiT7TpVYlmY
         MATaZ+93HhOb6SZOx8vxmwF1DNGOHRlVYphn7GjeVoWx4Nw4XWqgXwd2WfDJ9aPI9k
         VvAuLNGKcxJpHsNDwb+tq4yajXSICKY2+2eo+i9k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        syzbot+2a59ee7a9831b264f45e@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.9 7/7] ALSA: pcm: oss: Remove WARNING from snd_pcm_plug_alloc() checks
Date:   Thu, 26 Mar 2020 19:25:26 -0400
Message-Id: <20200326232526.8349-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232526.8349-1-sashal@kernel.org>
References: <20200326232526.8349-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 5461e0530c222129dfc941058be114b5cbc00837 ]

The return value checks in snd_pcm_plug_alloc() are covered with
snd_BUG_ON() macro that may trigger a kernel WARNING depending on the
kconfig.  But since the error condition can be triggered by a weird
user space parameter passed to OSS layer, we shouldn't give the kernel
stack trace just for that.  As it's a normal error condition, let's
remove snd_BUG_ON() macro usage there.

Reported-by: syzbot+2a59ee7a9831b264f45e@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200312155730.7520-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/oss/pcm_plugin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index b08b2d2d804bd..0e3dd6014ce55 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -111,7 +111,7 @@ int snd_pcm_plug_alloc(struct snd_pcm_substream *plug, snd_pcm_uframes_t frames)
 		while (plugin->next) {
 			if (plugin->dst_frames)
 				frames = plugin->dst_frames(plugin, frames);
-			if (snd_BUG_ON((snd_pcm_sframes_t)frames <= 0))
+			if ((snd_pcm_sframes_t)frames <= 0)
 				return -ENXIO;
 			plugin = plugin->next;
 			err = snd_pcm_plugin_alloc(plugin, frames);
@@ -123,7 +123,7 @@ int snd_pcm_plug_alloc(struct snd_pcm_substream *plug, snd_pcm_uframes_t frames)
 		while (plugin->prev) {
 			if (plugin->src_frames)
 				frames = plugin->src_frames(plugin, frames);
-			if (snd_BUG_ON((snd_pcm_sframes_t)frames <= 0))
+			if ((snd_pcm_sframes_t)frames <= 0)
 				return -ENXIO;
 			plugin = plugin->prev;
 			err = snd_pcm_plugin_alloc(plugin, frames);
-- 
2.20.1

