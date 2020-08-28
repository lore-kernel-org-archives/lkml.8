Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E052C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B102075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qWvhfPBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgH1La1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:30:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53360 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgH1L3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:29:52 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07SBSubY057960;
        Fri, 28 Aug 2020 06:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598614136;
        bh=K6J1dxqpyjkqrS/MebKa8sgd6/5VHr1CiLNX3jpx7pw=;
        h=From:To:CC:Subject:Date;
        b=qWvhfPBPFpUdwKJGs7+w7SHCWETcn124eVl+LPdMUmLNya2liW/NM8mAwMbM1wprG
         zioL7jtMPyJ7cbuhOP2ENK+lBv1rtBfTcZjwrlZhgyaujt/wxgFfNi5F5t4yLn33Xu
         jnCNEN0QFrpeySO3fchJ9ljMo9zkedIF7AjfY0E4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07SBSuas117700
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 06:28:56 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 28
 Aug 2020 06:28:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 28 Aug 2020 06:28:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07SBStBb116292;
        Fri, 28 Aug 2020 06:28:55 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] ASoC: tlv320adcx140: Add digital mic channel enable routing
Date:   Fri, 28 Aug 2020 06:28:55 -0500
Message-ID: <20200828112855.10112-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the audio routing map to enable the digital mic paths when the
analog mic paths are not enabled.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 37 ++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 5cd50d841177..5d1b2a03f0ac 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -412,6 +412,16 @@ static const struct snd_soc_dapm_widget adcx140_dapm_widgets[] = {
 	SND_SOC_DAPM_ADC("CH3_ADC", "CH3 Capture", ADCX140_IN_CH_EN, 5, 0),
 	SND_SOC_DAPM_ADC("CH4_ADC", "CH4 Capture", ADCX140_IN_CH_EN, 4, 0),
 
+	SND_SOC_DAPM_ADC("CH1_DIG", "CH1 Capture", ADCX140_IN_CH_EN, 7, 0),
+	SND_SOC_DAPM_ADC("CH2_DIG", "CH2 Capture", ADCX140_IN_CH_EN, 6, 0),
+	SND_SOC_DAPM_ADC("CH3_DIG", "CH3 Capture", ADCX140_IN_CH_EN, 5, 0),
+	SND_SOC_DAPM_ADC("CH4_DIG", "CH4 Capture", ADCX140_IN_CH_EN, 4, 0),
+	SND_SOC_DAPM_ADC("CH5_DIG", "CH5 Capture", ADCX140_IN_CH_EN, 3, 0),
+	SND_SOC_DAPM_ADC("CH6_DIG", "CH6 Capture", ADCX140_IN_CH_EN, 2, 0),
+	SND_SOC_DAPM_ADC("CH7_DIG", "CH7 Capture", ADCX140_IN_CH_EN, 1, 0),
+	SND_SOC_DAPM_ADC("CH8_DIG", "CH8 Capture", ADCX140_IN_CH_EN, 0, 0),
+
+
 	SND_SOC_DAPM_SWITCH("CH1_ASI_EN", SND_SOC_NOPM, 0, 0,
 			    &adcx140_dapm_ch1_en_switch),
 	SND_SOC_DAPM_SWITCH("CH2_ASI_EN", SND_SOC_NOPM, 0, 0,
@@ -470,6 +480,15 @@ static const struct snd_soc_dapm_route adcx140_audio_map[] = {
 	{"CH3_ASI_EN", "Switch", "CH3_ADC"},
 	{"CH4_ASI_EN", "Switch", "CH4_ADC"},
 
+	{"CH1_ASI_EN", "Switch", "CH1_DIG"},
+	{"CH2_ASI_EN", "Switch", "CH2_DIG"},
+	{"CH3_ASI_EN", "Switch", "CH3_DIG"},
+	{"CH4_ASI_EN", "Switch", "CH4_DIG"},
+	{"CH5_ASI_EN", "Switch", "CH5_DIG"},
+	{"CH6_ASI_EN", "Switch", "CH6_DIG"},
+	{"CH7_ASI_EN", "Switch", "CH7_DIG"},
+	{"CH8_ASI_EN", "Switch", "CH8_DIG"},
+
 	{"CH5_ASI_EN", "Switch", "CH5_OUT"},
 	{"CH6_ASI_EN", "Switch", "CH6_OUT"},
 	{"CH7_ASI_EN", "Switch", "CH7_OUT"},
@@ -541,6 +560,15 @@ static const struct snd_soc_dapm_route adcx140_audio_map[] = {
 	{"PDM Clk Div Select", "705.6 kHz", "MIC1P Input Mux"},
 	{"PDM Clk Div Select", "5.6448 MHz", "MIC1P Input Mux"},
 
+	{"MIC1P Input Mux", NULL, "CH1_DIG"},
+	{"MIC1M Input Mux", NULL, "CH2_DIG"},
+	{"MIC2P Input Mux", NULL, "CH3_DIG"},
+	{"MIC2M Input Mux", NULL, "CH4_DIG"},
+	{"MIC3P Input Mux", NULL, "CH5_DIG"},
+	{"MIC3M Input Mux", NULL, "CH6_DIG"},
+	{"MIC4P Input Mux", NULL, "CH7_DIG"},
+	{"MIC4M Input Mux", NULL, "CH8_DIG"},
+
 	{"MIC1 Analog Mux", "Line In", "MIC1P"},
 	{"MIC2 Analog Mux", "Line In", "MIC2P"},
 	{"MIC3 Analog Mux", "Line In", "MIC3P"},
@@ -554,6 +582,15 @@ static const struct snd_soc_dapm_route adcx140_audio_map[] = {
 	{"MIC3M Input Mux", "Analog", "MIC3M"},
 	{"MIC4P Input Mux", "Analog", "MIC4P"},
 	{"MIC4M Input Mux", "Analog", "MIC4M"},
+
+	{"MIC1P Input Mux", "Digital", "MIC1P"},
+	{"MIC1M Input Mux", "Digital", "MIC1M"},
+	{"MIC2P Input Mux", "Digital", "MIC2P"},
+	{"MIC2M Input Mux", "Digital", "MIC2M"},
+	{"MIC3P Input Mux", "Digital", "MIC3P"},
+	{"MIC3M Input Mux", "Digital", "MIC3M"},
+	{"MIC4P Input Mux", "Digital", "MIC4P"},
+	{"MIC4M Input Mux", "Digital", "MIC4M"},
 };
 
 static const struct snd_kcontrol_new adcx140_snd_controls[] = {
-- 
2.28.0

