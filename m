Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A5CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB284206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FaaX0SbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbgEMUQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:16:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36020 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbgEMUQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:16:07 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DKFLkH015908;
        Wed, 13 May 2020 15:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589400921;
        bh=yY/LsSZIBi414qmKI1QeADfQF07kR8esflMsRRh0bLs=;
        h=From:To:CC:Subject:Date;
        b=FaaX0SbQyYh1lBlDz22Ns0G7rkkVgCoqrpx6rajaKu6Mwd2qYDsWPX5QyZeYTtCt7
         +zc9E1Vpp35WMPURlYoeYYjgdek2MM2s7N74izPNjVs9+b8E7DrmUTdiVxfRyJawbY
         Bl8lyl9Z896pH9v4LEqVenaYY0V1YJngbg6uJ5KA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DKFLAc052778
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 15:15:21 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 15:15:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 15:15:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DKFKuU096600;
        Wed, 13 May 2020 15:15:21 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 1/3] ASoC: tlv320adcx140: Add controls for PDM clk
Date:   Wed, 13 May 2020 15:05:47 -0500
Message-ID: <20200513200549.12213-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ALSA controls to configure the PDM clocks.
The clocks need to be configurable to accommodate various microphones
that use clocks for low power/low resolution modes to high power/high
resolution modes.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 0f713efde046..97634e0ca0ba 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -180,6 +180,17 @@ static const struct snd_kcontrol_new decimation_filter_controls[] = {
 	SOC_DAPM_ENUM("Decimation Filter", decimation_filter_enum),
 };
 
+static const char * const pdmclk_text[] = {
+	"2.8224 MHz", "1.4112 MHz", "705.6 kHz", "5.6448 MHz"
+};
+
+static SOC_ENUM_SINGLE_DECL(pdmclk_select_enum, ADCX140_PDMCLK_CFG, 0,
+			    pdmclk_text);
+
+static const struct snd_kcontrol_new pdmclk_div_controls[] = {
+	SOC_DAPM_ENUM("PDM Clk Divider Select", pdmclk_select_enum),
+};
+
 static const char * const resistor_text[] = {
 	"2.5 kOhm", "10 kOhm", "20 kOhm"
 };
@@ -416,6 +427,9 @@ static const struct snd_soc_dapm_widget adcx140_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("IN4 Analog Mic Resistor", SND_SOC_NOPM, 0, 0,
 			in4_resistor_controls),
 
+	SND_SOC_DAPM_MUX("PDM Clk Div Select", SND_SOC_NOPM, 0, 0,
+			pdmclk_div_controls),
+
 	SND_SOC_DAPM_MUX("Decimation Filter", SND_SOC_NOPM, 0, 0,
 			decimation_filter_controls),
 };
@@ -493,6 +507,11 @@ static const struct snd_soc_dapm_route adcx140_audio_map[] = {
 	{"IN4 Analog Mic Resistor", "10 kOhm", "MIC4M Input Mux"},
 	{"IN4 Analog Mic Resistor", "20 kOhm", "MIC4M Input Mux"},
 
+	{"PDM Clk Div Select", "2.8224 MHz", "MIC1P Input Mux"},
+	{"PDM Clk Div Select", "1.4112 MHz", "MIC1P Input Mux"},
+	{"PDM Clk Div Select", "705.6 kHz", "MIC1P Input Mux"},
+	{"PDM Clk Div Select", "5.6448 MHz", "MIC1P Input Mux"},
+
 	{"MIC1 Analog Mux", "Line In", "MIC1P"},
 	{"MIC2 Analog Mux", "Line In", "MIC2P"},
 	{"MIC3 Analog Mux", "Line In", "MIC3P"},
-- 
2.26.2

