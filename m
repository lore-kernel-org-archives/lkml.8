Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1A8C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40025222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TFnz+smq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgBUSTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:19:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54924 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBUSTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:19:22 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01LIJ7Av002930;
        Fri, 21 Feb 2020 12:19:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582309147;
        bh=bsI2HkrAS+Vu3v42QGL3/rnggOmg6lsHS1PaGjXsLps=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TFnz+smq5hJY4+vixyzlgEIaS8p/ZysyM3Cx6Jcq1EW7Y0OEdRzh9OWKtM3/IYcCk
         bjChMoF4f+RPotRrPd23fsQ9qT2e7INrBxeWS9ie2acFkfGEKvcBV5y0NHYfOrLFpp
         BBcS8jAGyJB5UnaVGNKEhPyTKjTkuKk8hAEw0npk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01LIJ7R2064973
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Feb 2020 12:19:07 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 21
 Feb 2020 12:19:07 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 21 Feb 2020 12:19:07 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01LIJ7TM047749;
        Fri, 21 Feb 2020 12:19:07 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH for-next 2/2] ASoC: tlv320adcx140: Add decimation filter support
Date:   Fri, 21 Feb 2020 12:13:58 -0600
Message-ID: <20200221181358.22526-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221181358.22526-1-dmurphy@ti.com>
References: <20200221181358.22526-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add decimation filter selection support.
Per Section 8.3.6.7 the Digital Decimation Filter is selectable between
a Linear Phase, Low Latency, and Ultra Low Latency filer.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 105e51be6fe6..93a0cb8e662c 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -169,6 +169,17 @@ static DECLARE_TLV_DB_SCALE(agc_thresh_tlv, -3600, 200, 0);
 /* AGC Max Gain. From 3 dB to 42 dB in 3 dB steps */
 static DECLARE_TLV_DB_SCALE(agc_gain_tlv, 300, 300, 0);
 
+static const char * const decimation_filter_text[] = {
+	"Linear Phase", "Low Latency", "Ultra-low Latency"
+};
+
+static SOC_ENUM_SINGLE_DECL(decimation_filter_enum, ADCX140_DSP_CFG0, 4,
+			    decimation_filter_text);
+
+static const struct snd_kcontrol_new decimation_filter_controls[] = {
+	SOC_DAPM_ENUM("Decimation Filter", decimation_filter_enum),
+};
+
 static const char * const resistor_text[] = {
 	"2.5 kOhm", "10 kOhm", "20 kOhm"
 };
@@ -404,6 +415,9 @@ static const struct snd_soc_dapm_widget adcx140_dapm_widgets[] = {
 			in3_resistor_controls),
 	SND_SOC_DAPM_MUX("IN4 Analog Mic Resistor", SND_SOC_NOPM, 0, 0,
 			in4_resistor_controls),
+
+	SND_SOC_DAPM_MUX("Decimation Filter", SND_SOC_NOPM, 0, 0,
+			decimation_filter_controls),
 };
 
 static const struct snd_soc_dapm_route adcx140_audio_map[] = {
@@ -418,6 +432,10 @@ static const struct snd_soc_dapm_route adcx140_audio_map[] = {
 	{"CH3_ASI_EN", "Switch", "CH3_ADC"},
 	{"CH4_ASI_EN", "Switch", "CH4_ADC"},
 
+	{"Decimation Filter", "Linear Phase", "DRE_ENABLE"},
+	{"Decimation Filter", "Low Latency", "DRE_ENABLE"},
+	{"Decimation Filter", "Ultra-low Latency", "DRE_ENABLE"},
+
 	{"DRE_ENABLE", "Switch", "CH1_DRE_EN"},
 	{"DRE_ENABLE", "Switch", "CH2_DRE_EN"},
 	{"DRE_ENABLE", "Switch", "CH3_DRE_EN"},
-- 
2.25.0

