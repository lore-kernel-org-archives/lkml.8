Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A81C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6862063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255313;
	bh=3FxBxd6RbLR/y/VY5tEmtjodrdoYxlguQHxCm+Pu6lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zlo6cvN+Hksk8RJXogEHRqGz+UIXzbi0UlFioeHz7XJPKXkdtky1ZilZK6IVlSROh
	 tqsh9K1Ts+SeN3kk8nUYe/mtex20Zy8ddynQ1ypN3mqsnbdJLgrw/cC0gdzkkXRxwI
	 VmP4mHdm8Gwh7zL8dCw9aGbNWiGukp5VO6PBMU3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgD3OBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728813AbgD3Nxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:53:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1DD32072A;
        Thu, 30 Apr 2020 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254830;
        bh=3FxBxd6RbLR/y/VY5tEmtjodrdoYxlguQHxCm+Pu6lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2f/bvlayQVZ1Etvpx5ymYdaTk+rjBJ27ulf94oU15vJpVXPutUZ0k4uSQJCF55uS
         mwHwLMy4rr/d2YZEFl7SyUeEbTbm0rYGfeeiYc9MgGtUICjt2qGDJHiyyeWhV/tL2s
         2SCETs+HRjQrWNJ7/+7SpKib43E9euTIGWHIwU4w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 22/30] ASoC: wm8960: Fix wrong clock after suspend & resume
Date:   Thu, 30 Apr 2020 09:53:17 -0400
Message-Id: <20200430135325.20762-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135325.20762-1-sashal@kernel.org>
References: <20200430135325.20762-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 1e060a453c8604311fb45ae2f84f67ed673329b4 ]

After suspend & resume, wm8960_hw_params may be called when
bias_level is not SND_SOC_BIAS_ON, then wm8960_configure_clocking
is not called. But if sample rate is changed at that time, then
the output clock rate will be not correct.

So judgement of bias_level is SND_SOC_BIAS_ON in wm8960_hw_params
is not necessary and it causes above issue.

Fixes: 3176bf2d7ccd ("ASoC: wm8960: update pll and clock setting function")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/1587468525-27514-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8960.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 8dc1f3d6a988e..c4c00297ada6e 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -863,8 +863,7 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 
 	wm8960->is_stream_in_use[tx] = true;
 
-	if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_ON &&
-	    !wm8960->is_stream_in_use[!tx])
+	if (!wm8960->is_stream_in_use[!tx])
 		return wm8960_configure_clocking(component);
 
 	return 0;
-- 
2.20.1

