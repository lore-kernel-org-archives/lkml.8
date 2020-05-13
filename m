Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A73C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB2B2224B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IbwAF2Kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbgEMO6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:58:02 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38894 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbgEMO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:58:02 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DEvC93073229;
        Wed, 13 May 2020 09:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589381832;
        bh=qpEkRQbrTglM4OGE5pO1KzGtwrkuIchYg8+tGyQojOM=;
        h=From:To:CC:Subject:Date;
        b=IbwAF2KtmJegbkxmOIT5BbFbyLUU32EjTr2fYbhzHstnZRbmgynAEFoNzD8YdGycp
         ITBdDZOI5EUhRyGGg2KiugQW7q212pv5JG2msBYCYYisrcX88ENUL+D9+ymjZw7o0M
         oj248A+Ww/5dRYtEoXdGx7acn5KWAYgx8adHuD04=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DEvClg118794
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 09:57:12 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 09:57:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 09:57:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DEvCBu104959;
        Wed, 13 May 2020 09:57:12 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] ASoC: tlv320adcx140: Add controls for PDM clk and edge
Date:   Wed, 13 May 2020 09:47:46 -0500
Message-ID: <20200513144746.14337-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ALSA controls to configure the PDM clock and PDM input edges for the
4 digital mic inputs.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 74 +++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 0f713efde046..e860d3c62d64 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -180,6 +180,49 @@ static const struct snd_kcontrol_new decimation_filter_controls[] = {
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
+static const char * const pdm_edge_text[] = {
+	"Negative", "Positive"
+};
+
+static SOC_ENUM_SINGLE_DECL(pdm1edge_select_enum, ADCX140_PDM_CFG, 7,
+			    pdm_edge_text);
+
+static SOC_ENUM_SINGLE_DECL(pdm2edge_select_enum, ADCX140_PDM_CFG, 6,
+			    pdm_edge_text);
+
+static SOC_ENUM_SINGLE_DECL(pdm3edge_select_enum, ADCX140_PDM_CFG, 5,
+			    pdm_edge_text);
+
+static SOC_ENUM_SINGLE_DECL(pdm4edge_select_enum, ADCX140_PDM_CFG, 4,
+			    pdm_edge_text);
+
+static const struct snd_kcontrol_new pdmin1_edge_controls[] = {
+	SOC_DAPM_ENUM("PDMIN1 Edge Select", pdm1edge_select_enum),
+};
+
+static const struct snd_kcontrol_new pdmin2_edge_controls[] = {
+	SOC_DAPM_ENUM("PDMIN2 Edge Select", pdm2edge_select_enum),
+};
+
+static const struct snd_kcontrol_new pdmin3_edge_controls[] = {
+	SOC_DAPM_ENUM("PDMIN3 Edge Select", pdm3edge_select_enum),
+};
+
+static const struct snd_kcontrol_new pdmin4_edge_controls[] = {
+	SOC_DAPM_ENUM("PDMIN4 Edge Select", pdm4edge_select_enum),
+};
+
 static const char * const resistor_text[] = {
 	"2.5 kOhm", "10 kOhm", "20 kOhm"
 };
@@ -416,6 +459,18 @@ static const struct snd_soc_dapm_widget adcx140_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("IN4 Analog Mic Resistor", SND_SOC_NOPM, 0, 0,
 			in4_resistor_controls),
 
+	SND_SOC_DAPM_MUX("PDM Clk Div Select", SND_SOC_NOPM, 0, 0,
+			pdmclk_div_controls),
+
+	SND_SOC_DAPM_MUX("PDMIN1 Edge Select", SND_SOC_NOPM, 0, 0,
+			pdmin1_edge_controls),
+	SND_SOC_DAPM_MUX("PDMIN2 Edge Select", SND_SOC_NOPM, 0, 0,
+			pdmin2_edge_controls),
+	SND_SOC_DAPM_MUX("PDMIN3 Edge Select", SND_SOC_NOPM, 0, 0,
+			pdmin3_edge_controls),
+	SND_SOC_DAPM_MUX("PDMIN4 Edge Select", SND_SOC_NOPM, 0, 0,
+			pdmin4_edge_controls),
+
 	SND_SOC_DAPM_MUX("Decimation Filter", SND_SOC_NOPM, 0, 0,
 			decimation_filter_controls),
 };
@@ -493,6 +548,20 @@ static const struct snd_soc_dapm_route adcx140_audio_map[] = {
 	{"IN4 Analog Mic Resistor", "10 kOhm", "MIC4M Input Mux"},
 	{"IN4 Analog Mic Resistor", "20 kOhm", "MIC4M Input Mux"},
 
+	{"PDM Clk Div Select", "2.8224 MHz", "MIC1P Input Mux"},
+	{"PDM Clk Div Select", "1.4112 MHz", "MIC1P Input Mux"},
+	{"PDM Clk Div Select", "705.6 kHz", "MIC1P Input Mux"},
+	{"PDM Clk Div Select", "5.6448 MHz", "MIC1P Input Mux"},
+
+	{"PDMIN1 Edge Select", "Negative", "MIC1P Input Mux"},
+	{"PDMIN1 Edge Select", "Positive", "MIC1P Input Mux"},
+	{"PDMIN2 Edge Select", "Negative", "MIC2P Input Mux"},
+	{"PDMIN2 Edge Select", "Positive", "MIC2P Input Mux"},
+	{"PDMIN3 Edge Select", "Negative", "MIC3P Input Mux"},
+	{"PDMIN3 Edge Select", "Positive", "MIC3P Input Mux"},
+	{"PDMIN4 Edge Select", "Negative", "MIC4P Input Mux"},
+	{"PDMIN4 Edge Select", "Positive", "MIC4P Input Mux"},
+
 	{"MIC1 Analog Mux", "Line In", "MIC1P"},
 	{"MIC2 Analog Mux", "Line In", "MIC2P"},
 	{"MIC3 Analog Mux", "Line In", "MIC3P"},
@@ -675,11 +744,6 @@ static int adcx140_set_dai_tdm_slot(struct snd_soc_dai *codec_dai,
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
 	unsigned int lsb;
 
-	if (tx_mask != rx_mask) {
-		dev_err(component->dev, "tx and rx masks must be symmetric\n");
-		return -EINVAL;
-	}
-
 	/* TDM based on DSP mode requires slots to be adjacent */
 	lsb = __ffs(tx_mask);
 	if ((lsb + 1) != __fls(tx_mask)) {
-- 
2.26.2

