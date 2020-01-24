Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2604BC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E441922522
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579875573;
	bh=vTL/h1gi3FoWAFl5nz/8MJ9NXEUdN57OSiKbswk5IFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DX7xwcrpRFbtKgUKl7KWLa2/gKDAMGvCh9aRDjXImKtBhbUkLLywYSMDb+ryajsYC
	 /uvgVRQh9gJMR9KYpmewHHXPz4pON/+c+RulHOuTeVHONzJ82VKMRE7tK2fxBD+4nX
	 wZtiRMRYK/tF6LRLAlajfPrHp+f0JXfyQ4twUx/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391747AbgAXOTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391462AbgAXOTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:19:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 820F722527;
        Fri, 24 Jan 2020 14:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875561;
        bh=vTL/h1gi3FoWAFl5nz/8MJ9NXEUdN57OSiKbswk5IFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j178xOb9t8kOGtFfGYhswbUpRgRmUDECI1lk2fLXwCgL6M9oeipyG/ik3SZeLrGxA
         l0s+tu3GIqJe4Fdfy3n/KNVTkDXTTBA97be1XDf01y5z5TnWnpGKDgUlCaZBwClCdT
         QR5cLFIzEJbWmqmN8SGlmzmSgZMl1BZWYBIB8CT4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 055/107] ASoC: msm8916-wcd-analog: Fix selected events for MIC BIAS External1
Date:   Fri, 24 Jan 2020 09:17:25 -0500
Message-Id: <20200124141817.28793-55-sashal@kernel.org>
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

[ Upstream commit e0beec88397b163c7c4ea6fcfb67e8e07a2671dc ]

MIC BIAS External1 sets pm8916_wcd_analog_enable_micbias_ext1()
as event handler, which ends up in pm8916_wcd_analog_enable_micbias_ext().

But pm8916_wcd_analog_enable_micbias_ext() only handles the POST_PMU
event, which is not specified in the event flags for MIC BIAS External1.
This means that the code in the event handler is never actually run.

Set SND_SOC_DAPM_POST_PMU as the only event for the handler to fix this.

Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20200111164006.43074-2-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index e3d311fb510e0..08399a734be27 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -888,10 +888,10 @@ static const struct snd_soc_dapm_widget pm8916_wcd_analog_dapm_widgets[] = {
 
 	SND_SOC_DAPM_SUPPLY("MIC BIAS External1", CDC_A_MICB_1_EN, 7, 0,
 			    pm8916_wcd_analog_enable_micbias_ext1,
-			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+			    SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SUPPLY("MIC BIAS External2", CDC_A_MICB_2_EN, 7, 0,
 			    pm8916_wcd_analog_enable_micbias_ext2,
-			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+			    SND_SOC_DAPM_POST_PMU),
 
 	SND_SOC_DAPM_ADC_E("ADC1", NULL, CDC_A_TX_1_EN, 7, 0,
 			   pm8916_wcd_analog_enable_adc,
-- 
2.20.1

