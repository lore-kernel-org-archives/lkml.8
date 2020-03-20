Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECEFC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E4820775
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJ662SXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgCTU4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:56:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40597 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbgCTU4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:56:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id j17so5649793lfe.7;
        Fri, 20 Mar 2020 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9oV0Jet7GMraR3xqtV0h+iLCecJI0XRcctkMuUHagA=;
        b=uJ662SXhR9zxkO088xiUitQhQMrirDeOS3TUScosTIg4zji4P6drAcNKY1fliPnOLy
         TC7gD8qUZrOf1kuPbaPvTabKzsGP3+LRRZmLE0lz5JSMe2wWs6GT1/UeTu/8K8YKM5m4
         QNZb+C04XDHdbjfO/nfKsjrFOVGlNAOS/9jFz5LPgWs5XULwEAd1K7SS0CJu4qR0hIUv
         JCHHsgdq+nftXyM2M0XI0YNoWXCN8k5JOVmv1ksoWcXG3XVNO5y3cZQmcnOXhKmfoqvb
         XeFq5/4B0ZHYZNQgch62LqTbYyHVxUMhRXFH9qnpo1VFSWMHdosYyFV0p96nS/DjKEUd
         vFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9oV0Jet7GMraR3xqtV0h+iLCecJI0XRcctkMuUHagA=;
        b=rmELD3X51vWb0PmNKDiNkdQjbAL2ergNv3krE+TRE0+lpP0e5YzSsKbd72Hzk+IVnq
         HJH93m8SGaJ2bxin128MBzdvnGcKd1Wk7gtMhqpUL1P3KFZ885WPSYnS0IQTL6U+VKD3
         WDfCLmwe9JHUvXMb5vTTZJ86IH+b57JzRVQCHGlt+RQnowfAFhQHFgspMCLZeg+Q5E07
         WePCwUSQ3K76d6UZUEXBnL6iuWpWgxt9M7MqRFPmUXD6VAfZWP9C0qfcR2suK0bXcbgV
         fTNaGhynFJdDhIEXFOlh18AmQP/WIm8PAKcfe0jxb3NTuuGd4DBdAnuzl1jhz1hNJXI4
         dmvQ==
X-Gm-Message-State: ANhLgQ1g63RP5p5g786iraOELTLQMZ089FsX/FIohyCHEYbltJcPKGrw
        mzgUUnsTnwNQQQFPOhr+Huk=
X-Google-Smtp-Source: ADFU+vsLajssmyb9pDEbtINGlaD8mIM0RtJt8T7pAoYMTjD1DsK8CE1iAEpQ1DTyU2ucTWgIXn+98g==
X-Received: by 2002:a05:6512:108a:: with SMTP id j10mr6566513lfg.35.1584737776522;
        Fri, 20 Mar 2020 13:56:16 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id 1sm3873356lft.47.2020.03.20.13.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:56:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ASoC: tegra: tegra_wm8903: Support DAPM events for built-in microphone
Date:   Fri, 20 Mar 2020 23:55:04 +0300
Message-Id: <20200320205504.30466-3-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320205504.30466-1-digetx@gmail.com>
References: <20200320205504.30466-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enable-GPIO needs to be toggled on a DAPM event in order to turn
microphone ON/OFF, otherwise microphone won't work.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra_wm8903.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
index f08d3489c3cf..071c7d2de77c 100644
--- a/sound/soc/tegra/tegra_wm8903.c
+++ b/sound/soc/tegra/tegra_wm8903.c
@@ -143,14 +143,32 @@ static int tegra_wm8903_event_hp(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int tegra_wm8903_event_int_mic(struct snd_soc_dapm_widget *w,
+				      struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(card);
+
+	if (!gpio_is_valid(machine->gpio_int_mic_en))
+		return 0;
+
+	gpio_set_value_cansleep(machine->gpio_int_mic_en,
+				SND_SOC_DAPM_EVENT_ON(event));
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget tegra_wm8903_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Int Spk", tegra_wm8903_event_int_spk),
 	SND_SOC_DAPM_HP("Headphone Jack", tegra_wm8903_event_hp),
 	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", tegra_wm8903_event_int_mic),
 };
 
 static const struct snd_kcontrol_new tegra_wm8903_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Int Spk"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
 };
 
 static int tegra_wm8903_init(struct snd_soc_pcm_runtime *rtd)
-- 
2.25.1

