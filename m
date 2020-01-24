Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD4CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F05208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579875583;
	bh=iPMVL4crNxPbC1jQF3SB1zO7fOwWGK3uSOuPiijHZqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kWmfNDAKSSPSHXbOhPn0jxYRCh5/LS2wsNmWQN0iTm7DMvhYYaRzLPfaTEprwkiGB
	 fAIa41DA5sFgSO0Smql+QfYW1g6r1Gum6Ep4CJElLUp39Qn14a6bWildLMB99HHlEX
	 wRvSWhN1ZdHPiD0tqLmmM1hCBTC+9ZbQIrYqh6M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389445AbgAXOTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:19:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391575AbgAXOTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:19:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5FD214AF;
        Fri, 24 Jan 2020 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875563;
        bh=iPMVL4crNxPbC1jQF3SB1zO7fOwWGK3uSOuPiijHZqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdmZBD1p7wDQu+0NYME9NabsF5IKIuAS79tC8SaqpAaBJqdxXIXSe9aaSWlUYCMA+
         3aINDv75+qd6+AZ14RXUyrsby7dPS4k5tB9vWb3Zb3b+PfIK8gvWTTnFX1NPUW0Up0
         mnVsi8Chcs9RAQtww94Awv2tgZfAlfWvV6Ae01Gs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 057/107] ASoC: msm8916-wcd-analog: Fix MIC BIAS Internal1
Date:   Fri, 24 Jan 2020 09:17:27 -0500
Message-Id: <20200124141817.28793-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 057efcf9faea4769cf1020677d93d040db9b23f3 ]

MIC BIAS Internal1 is broken at the moment because we always
enable the internal rbias resistor to the TX2 line (connected to
the headset microphone), rather than enabling the resistor connected
to TX1.

Move the RBIAS code to pm8916_wcd_analog_enable_micbias_int1/2()
to fix this.

Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20200111164006.43074-3-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 08399a734be27..84289ebeae872 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -391,9 +391,6 @@ static int pm8916_wcd_analog_enable_micbias_int(struct snd_soc_component
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
-				    MICB_1_INT_TX2_INT_RBIAS_EN_MASK,
-				    MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE);
 		snd_soc_component_update_bits(component, reg, MICB_1_EN_PULL_DOWN_EN_MASK, 0);
 		snd_soc_component_update_bits(component, CDC_A_MICB_1_EN,
 				    MICB_1_EN_OPA_STG2_TAIL_CURR_MASK,
@@ -443,6 +440,14 @@ static int pm8916_wcd_analog_enable_micbias_int1(struct
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct pm8916_wcd_analog_priv *wcd = snd_soc_component_get_drvdata(component);
 
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
+				    MICB_1_INT_TX1_INT_RBIAS_EN_MASK,
+				    MICB_1_INT_TX1_INT_RBIAS_EN_ENABLE);
+		break;
+	}
+
 	return pm8916_wcd_analog_enable_micbias_int(component, event, w->reg,
 						     wcd->micbias1_cap_mode);
 }
@@ -553,6 +558,11 @@ static int pm8916_wcd_analog_enable_micbias_int2(struct
 	struct pm8916_wcd_analog_priv *wcd = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
+				    MICB_1_INT_TX2_INT_RBIAS_EN_MASK,
+				    MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE);
+		break;
 	case SND_SOC_DAPM_POST_PMU:
 		pm8916_mbhc_configure_bias(wcd, true);
 		break;
-- 
2.20.1

