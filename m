Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE95C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDB5206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598288261;
	bh=z7HQxv9VSgRcd7nBu9ujYpFT8TnEHBX4hITSL08r+ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ItThyM4u9YccC0hf6YP2KOXLUwsQv17jtHe80lxKDcYDLzQ45a1WzpEFPJuVKGXzh
	 mcv6Gjf9fpBK8UwjChf6FA0c9qL0v8ig9bYfL84BUXLgW5WkhmTEN5I6m9n834a7to
	 JWxwiFYW1gGJoEa5n/ZMDRA2A8w5blWN/pHgO2MI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHXQ5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgHXQjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:39:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD82D22DA7;
        Mon, 24 Aug 2020 16:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287140;
        bh=z7HQxv9VSgRcd7nBu9ujYpFT8TnEHBX4hITSL08r+ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjFHXrSnCSnLjtu77Wqh8xf3DzlWrWY4KIfKQfQSnIWMaqT+uGJktBdQ8v9BDMJzu
         hE9MzrHEMB6d2TUGH/ZwvNQEZQvtEpqRIMRxl6Ya8PaEIC5+3Lq3lcntc3KaZi/w60
         hRUQY3On1xa2q80cz31IJ8DUP/kCv+CGqMlWA6pI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 11/21] ASoC: wm8994: Avoid attempts to read unreadable registers
Date:   Mon, 24 Aug 2020 12:38:35 -0400
Message-Id: <20200824163845.606933-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163845.606933-1-sashal@kernel.org>
References: <20200824163845.606933-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

[ Upstream commit f082bb59b72039a2326ec1a44496899fb8aa6d0e ]

The driver supports WM1811, WM8994, WM8958 devices but according to
documentation and the regmap definitions the WM8958_DSP2_* registers
are only available on WM8958. In current code these registers are
being accessed as if they were available on all the three chips.

When starting playback on WM1811 CODEC multiple errors like:
"wm8994-codec wm8994-codec: ASoC: error at soc_component_read_no_lock on wm8994-codec: -5"
can be seen, which is caused by attempts to read an unavailable
WM8958_DSP2_PROGRAM register. The issue has been uncovered by recent
commit "e2329ee ASoC: soc-component: add soc_component_err()".

This patch adds a check in wm8958_aif_ev() callback so the DSP2 handling
is only done for WM8958.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20200731173834.23832-1-s.nawrocki@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8958-dsp2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 108e8bf42a346..f0a409504a13b 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -419,8 +419,12 @@ int wm8958_aif_ev(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm8994 *control = dev_get_drvdata(component->dev->parent);
 	int i;
 
+	if (control->type != WM8958)
+		return 0;
+
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 	case SND_SOC_DAPM_PRE_PMU:
-- 
2.25.1

