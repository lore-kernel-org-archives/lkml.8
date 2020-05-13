Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BFDC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9CC206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U14KrHHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389029AbgEMOiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:38:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48776 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgEMOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:38:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DEbZsx007038;
        Wed, 13 May 2020 09:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589380655;
        bh=y/YaegT2DGD/8Lmf/IfgyqvQ89iKHw+Iptrkg/MbCp8=;
        h=From:To:CC:Subject:Date;
        b=U14KrHHUWdqyXt9cQFRAWWnBCTwWA3fq1gBPyh6YvsRL/TQ8LZHwL39ZpFxTepJ2x
         mQRD+DuxYXLhuWxqp3cvq6KkUKbw5Tp/DmZV5c4k+G5O58YdpMHd4BAw+cPU6oefGn
         CdqyoXHULLcn46pyVoZx12+YCgkMesPkjM+PO3DI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DEbYoG129497
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 09:37:34 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 09:37:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 09:37:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DEbYNx077984;
        Wed, 13 May 2020 09:37:34 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] ASoC: tlv320adcx140: Fix bias config values
Date:   Wed, 13 May 2020 09:28:07 -0500
Message-ID: <20200513142807.11802-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree binding declares the ti,mic-bias-source and the
ti,vref-source properties as u32.  The code reads them as u8 which is
incorrect.  Since the device tree binding indicates them as u32 the
conde needs to be updated to read u32.

In addition the bias source needs to be shifted 4 bits to
correctly write the register.

Fixes: 37bde5acf040 ("ASoC: tlv320adcx140: Add the tlv320adcx140 codec
driver family")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 13 +++++++------
 sound/soc/codecs/tlv320adcx140.h |  1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 0f713efde046..1d7d7b34a46e 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -739,11 +739,12 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 {
 	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
 	int sleep_cfg_val = ADCX140_WAKE_DEV;
-	u8 bias_source;
-	u8 vref_source;
+	u32 bias_source;
+	u32 vref_source;
+	u8 bias_cfg;
 	int ret;
 
-	ret = device_property_read_u8(adcx140->dev, "ti,mic-bias-source",
+	ret = device_property_read_u32(adcx140->dev, "ti,mic-bias-source",
 				      &bias_source);
 	if (ret)
 		bias_source = ADCX140_MIC_BIAS_VAL_VREF;
@@ -754,7 +755,7 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 		return -EINVAL;
 	}
 
-	ret = device_property_read_u8(adcx140->dev, "ti,vref-source",
+	ret = device_property_read_u32(adcx140->dev, "ti,vref-source",
 				      &vref_source);
 	if (ret)
 		vref_source = ADCX140_MIC_BIAS_VREF_275V;
@@ -765,7 +766,7 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 		return -EINVAL;
 	}
 
-	bias_source |= vref_source;
+	bias_cfg = bias_source << ADCX140_MIC_BIAS_SHIFT | vref_source;
 
 	ret = adcx140_reset(adcx140);
 	if (ret)
@@ -785,7 +786,7 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 
 	ret = regmap_update_bits(adcx140->regmap, ADCX140_BIAS_CFG,
 				ADCX140_MIC_BIAS_VAL_MSK |
-				ADCX140_MIC_BIAS_VREF_MSK, bias_source);
+				ADCX140_MIC_BIAS_VREF_MSK, bias_cfg);
 	if (ret)
 		dev_err(adcx140->dev, "setting MIC bias failed %d\n", ret);
 out:
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index 6d055e55909e..69de52d473f4 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -116,6 +116,7 @@
 #define ADCX140_MIC_BIAS_VAL_VREF_1096	1
 #define ADCX140_MIC_BIAS_VAL_AVDD	6
 #define ADCX140_MIC_BIAS_VAL_MSK GENMASK(6, 4)
+#define ADCX140_MIC_BIAS_SHIFT		4
 
 #define ADCX140_MIC_BIAS_VREF_275V	0
 #define ADCX140_MIC_BIAS_VREF_25V	1
-- 
2.26.2

