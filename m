Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165ADC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA09207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QhS++ITn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGISw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:52:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46850 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgGISw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:52:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 069IpeZp058636;
        Thu, 9 Jul 2020 13:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594320700;
        bh=GtWtWQHKdBXB3CLNnasO+bNWYTz+NerPnNTBio+tRkU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QhS++ITnV6S47j8LNZmwdw3dbtxLzP4GSKKOfA5cXwjYgSbCszdTooHYUWXpncK3W
         dqNm4Ok89JXwaT8iKBDYQsa9G3U2C60Ecff8u0pFRBqrMUijlnXWFLFq1aX7AxUCdZ
         Ei2cqFpe5MJ0aaV0iE/Ub7Wsjr2Pl7gSCnUtbKrI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 069IpeE8060318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Jul 2020 13:51:40 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 9 Jul
 2020 13:51:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 9 Jul 2020 13:51:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 069Ipdbw009667;
        Thu, 9 Jul 2020 13:51:40 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] ASoC: tlv320adcx140: Add tx offset slot programming
Date:   Thu, 9 Jul 2020 13:51:29 -0500
Message-ID: <20200709185129.10505-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709185129.10505-1-dmurphy@ti.com>
References: <20200709185129.10505-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the TX offset slot programming.  There is no RX offset slot
register.

Since there is no RX offset the check for slot symmetry can be removed.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 40 ++++++++------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index f884abdb576e..d900af967f8c 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -646,6 +646,8 @@ static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
 	u8 iface_reg1 = 0;
 	u8 iface_reg2 = 0;
+	int offset = 0;
+	int width = adcx140->slot_width;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -688,7 +690,10 @@ static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		iface_reg1 |= ADCX140_LEFT_JUST_BIT;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
+		offset += (adcx140->tdm_delay * width + 1);
+		break;
 	case SND_SOC_DAIFMT_DSP_B:
+		offset += adcx140->tdm_delay * width;
 		break;
 	default:
 		dev_err(component->dev, "Invalid DAI interface format\n");
@@ -705,6 +710,11 @@ static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	snd_soc_component_update_bits(component, ADCX140_MST_CFG0,
 				      ADCX140_BCLK_FSYNC_MASTER, iface_reg2);
 
+	/* Configure data offset */
+	snd_soc_component_update_bits(component, ADCX140_ASI_CFG1,
+				      ADCX140_TX_OFFSET_MASK, offset);
+
+
 	return 0;
 }
 
@@ -716,11 +726,6 @@ static int adcx140_set_dai_tdm_slot(struct snd_soc_dai *codec_dai,
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
@@ -745,34 +750,9 @@ static int adcx140_set_dai_tdm_slot(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static int adcx140_prepare(struct snd_pcm_substream *substream,
-			 struct snd_soc_dai *dai)
-{
-	struct snd_soc_component *component = dai->component;
-	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
-	int offset = 0;
-	int width = adcx140->slot_width;
-
-	if (!width)
-		width = substream->runtime->sample_bits;
-
-	/* TDM slot selection only valid in DSP_A/_B mode */
-	if (adcx140->dai_fmt == SND_SOC_DAIFMT_DSP_A)
-		offset += (adcx140->tdm_delay * width + 1);
-	else if (adcx140->dai_fmt == SND_SOC_DAIFMT_DSP_B)
-		offset += adcx140->tdm_delay * width;
-
-	/* Configure data offset */
-	snd_soc_component_update_bits(component, ADCX140_ASI_CFG1,
-				      ADCX140_TX_OFFSET_MASK, offset);
-
-	return 0;
-}
-
 static const struct snd_soc_dai_ops adcx140_dai_ops = {
 	.hw_params	= adcx140_hw_params,
 	.set_fmt	= adcx140_set_dai_fmt,
-	.prepare	= adcx140_prepare,
 	.set_tdm_slot	= adcx140_set_dai_tdm_slot,
 };
 
-- 
2.27.0

