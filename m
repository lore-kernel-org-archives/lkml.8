Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5172DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C0220767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fzsXfH7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGISv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:51:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52144 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgGISv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:51:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 069IpZP8081572;
        Thu, 9 Jul 2020 13:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594320695;
        bh=kVHUj/pUhDJLhp9BWExKzyYt8MAbgZ/5AWHDTvmTgUk=;
        h=From:To:CC:Subject:Date;
        b=fzsXfH7dcMl1VpeFcbpPS0nXJIQ4lYEewH+0B3NOEV8MFc2IIY6onyw90xIYxw3lt
         M5qpLVI19goRAVff0xebiNhyO/lVJEXu6gwqehcGudDEaXVG3U7rvnXUZqMZVzJBl9
         hIIGQXrd2Jqh//sPCQiLRcJBhcmccQZ8yWdUytVw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 069IpZjh121764;
        Thu, 9 Jul 2020 13:51:35 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 9 Jul
 2020 13:51:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 9 Jul 2020 13:51:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 069IpYBB009610;
        Thu, 9 Jul 2020 13:51:34 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] ASoC: tlv320adcx140: Add ASI enable for channel 5-8
Date:   Thu, 9 Jul 2020 13:51:28 -0500
Message-ID: <20200709185129.10505-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ALSA controls to enable the ASI for channels 5-8

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 35fe8ee5bce9..f884abdb576e 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -313,6 +313,14 @@ static const struct snd_kcontrol_new adcx140_dapm_ch3_en_switch =
 	SOC_DAPM_SINGLE("Switch", ADCX140_ASI_OUT_CH_EN, 5, 1, 0);
 static const struct snd_kcontrol_new adcx140_dapm_ch4_en_switch =
 	SOC_DAPM_SINGLE("Switch", ADCX140_ASI_OUT_CH_EN, 4, 1, 0);
+static const struct snd_kcontrol_new adcx140_dapm_ch5_en_switch =
+	SOC_DAPM_SINGLE("Switch", ADCX140_ASI_OUT_CH_EN, 3, 1, 0);
+static const struct snd_kcontrol_new adcx140_dapm_ch6_en_switch =
+	SOC_DAPM_SINGLE("Switch", ADCX140_ASI_OUT_CH_EN, 2, 1, 0);
+static const struct snd_kcontrol_new adcx140_dapm_ch7_en_switch =
+	SOC_DAPM_SINGLE("Switch", ADCX140_ASI_OUT_CH_EN, 1, 1, 0);
+static const struct snd_kcontrol_new adcx140_dapm_ch8_en_switch =
+	SOC_DAPM_SINGLE("Switch", ADCX140_ASI_OUT_CH_EN, 0, 1, 0);
 
 static const struct snd_kcontrol_new adcx140_dapm_ch1_dre_en_switch =
 	SOC_DAPM_SINGLE("Switch", ADCX140_CH1_CFG0, 0, 1, 0);
@@ -406,6 +414,15 @@ static const struct snd_soc_dapm_widget adcx140_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("CH4_ASI_EN", SND_SOC_NOPM, 0, 0,
 			    &adcx140_dapm_ch4_en_switch),
 
+	SND_SOC_DAPM_SWITCH("CH5_ASI_EN", SND_SOC_NOPM, 0, 0,
+			    &adcx140_dapm_ch5_en_switch),
+	SND_SOC_DAPM_SWITCH("CH6_ASI_EN", SND_SOC_NOPM, 0, 0,
+			    &adcx140_dapm_ch6_en_switch),
+	SND_SOC_DAPM_SWITCH("CH7_ASI_EN", SND_SOC_NOPM, 0, 0,
+			    &adcx140_dapm_ch7_en_switch),
+	SND_SOC_DAPM_SWITCH("CH8_ASI_EN", SND_SOC_NOPM, 0, 0,
+			    &adcx140_dapm_ch8_en_switch),
+
 	SND_SOC_DAPM_SWITCH("DRE_ENABLE", SND_SOC_NOPM, 0, 0,
 			    &adcx140_dapm_dre_en_switch),
 
@@ -446,6 +463,11 @@ static const struct snd_soc_dapm_route adcx140_audio_map[] = {
 	{"CH3_ASI_EN", "Switch", "CH3_ADC"},
 	{"CH4_ASI_EN", "Switch", "CH4_ADC"},
 
+	{"CH5_ASI_EN", "Switch", "CH5_OUT"},
+	{"CH6_ASI_EN", "Switch", "CH6_OUT"},
+	{"CH7_ASI_EN", "Switch", "CH7_OUT"},
+	{"CH8_ASI_EN", "Switch", "CH8_OUT"},
+
 	{"Decimation Filter", "Linear Phase", "DRE_ENABLE"},
 	{"Decimation Filter", "Low Latency", "DRE_ENABLE"},
 	{"Decimation Filter", "Ultra-low Latency", "DRE_ENABLE"},
-- 
2.27.0

