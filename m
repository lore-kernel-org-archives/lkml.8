Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A05C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A96F24689
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686292;
	bh=zYDV+DzgznF8XWGcA4+Or3jo+J0QkqJlxyQIv1Ow33o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m23bepqEcgkOsgZ6V6wodXGqD3DGiClg+6dhKu+UEvvOV0HSIbSHShp4gOq7lET3G
	 /eGckp/aHjZlRtv5FpqN7gOj4Nj7sb7su5txrWNEYQnbLuH3hrMAAIx7uXu3IEmwB9
	 kinxWvMBFymbADcockDdt+t6IKgppmxBGZKYExso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbgAVJov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:44:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388108AbgAVJot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:44:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2012C24689;
        Wed, 22 Jan 2020 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686288;
        bh=zYDV+DzgznF8XWGcA4+Or3jo+J0QkqJlxyQIv1Ow33o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAAq1on3RQSkZ/z96eO4sIo6iOQc8KTCd1DUlHITulou3rghv0al8ja3y/KaP/HDp
         PXx9VFYYuMtVM110OYVTKf+ukBgPexG3L5akLSKc0MJWJbq0g67ejaiXVC79zVIDUh
         S/Ga71TNJ44MvFYL7nDtHqITm1dqLmKAmL9XrA1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 017/222] ASoC: msm8916-wcd-analog: Fix MIC BIAS Internal1
Date:   Wed, 22 Jan 2020 10:26:43 +0100
Message-Id: <20200122092834.624598744@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

commit 057efcf9faea4769cf1020677d93d040db9b23f3 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/msm8916-wcd-analog.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -391,9 +391,6 @@ static int pm8916_wcd_analog_enable_micb
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
-				    MICB_1_INT_TX2_INT_RBIAS_EN_MASK,
-				    MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE);
 		snd_soc_component_update_bits(component, reg, MICB_1_EN_PULL_DOWN_EN_MASK, 0);
 		snd_soc_component_update_bits(component, CDC_A_MICB_1_EN,
 				    MICB_1_EN_OPA_STG2_TAIL_CURR_MASK,
@@ -443,6 +440,14 @@ static int pm8916_wcd_analog_enable_micb
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
@@ -553,6 +558,11 @@ static int pm8916_wcd_analog_enable_micb
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


