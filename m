Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9326C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B065820706
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fnVlztAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgFZPna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:43:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42740 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729850AbgFZPn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:43:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05QFgZOk078944;
        Fri, 26 Jun 2020 10:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593186155;
        bh=GG7iVTtH66CFQ0+sz3xhPwwA2xGTNJWkclGWewHyGf4=;
        h=From:To:CC:Subject:Date;
        b=fnVlztAXaTajtyS5dLlDODhRhfpgylx93bLHM3hdaZtiPXS0Zui18+i5EXb10qVJa
         /2XuVFOg+iQ4hc6v4MYLzisidZyjARrxjQesYNKrEgllSoq+6xJ/C/ULzQxNUgEqEn
         ZE6/4NldMpDVL+MJqBkXwn8pmecPxDDooCle1QL8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05QFgZSe020449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Jun 2020 10:42:35 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 26
 Jun 2020 10:42:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 26 Jun 2020 10:42:35 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05QFgYBX083829;
        Fri, 26 Jun 2020 10:42:34 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/4] ASoC: tas2562: Add right and left channel slot programming
Date:   Fri, 26 Jun 2020 10:41:40 -0500
Message-ID: <20200626154143.20351-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add programming for the tdm slots for the right and left. This also
requires configuring the RX/TX offsets for the DAI format type.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2562.c | 71 +++++++++++++++++++++++++++++---------
 sound/soc/codecs/tas2562.h |  5 ++-
 2 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index d26e30a2948c..1d3c381aeefe 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -175,7 +175,37 @@ static int tas2562_set_dai_tdm_slot(struct snd_soc_dai *dai,
 {
 	struct snd_soc_component *component = dai->component;
 	struct tas2562_data *tas2562 = snd_soc_component_get_drvdata(component);
-	int ret = 0;
+	int left_slot, right_slot;
+	int slots_cfg;
+	int ret;
+
+	if (!tx_mask) {
+		dev_err(component->dev, "tx masks must not be 0\n");
+		return -EINVAL;
+	}
+
+	if (slots == 1) {
+		if (tx_mask != 1)
+			return -EINVAL;
+
+		left_slot = 0;
+		right_slot = 0;
+	} else {
+		left_slot = __ffs(tx_mask);
+		tx_mask &= ~(1 << left_slot);
+		if (tx_mask == 0) {
+			right_slot = left_slot;
+		} else {
+			right_slot = __ffs(tx_mask);
+			tx_mask &= ~(1 << right_slot);
+		}
+	}
+
+	slots_cfg = (right_slot << TAS2562_RIGHT_SLOT_SHIFT) | left_slot;
+
+	ret = snd_soc_component_write(component, TAS2562_TDM_CFG3, slots_cfg);
+	if (ret < 0)
+		return ret;
 
 	switch (slot_width) {
 	case 16:
@@ -208,6 +238,18 @@ static int tas2562_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG5,
+					    TAS2562_TDM_CFG5_VSNS_SLOT_MASK,
+					    tas2562->v_sense_slot);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG6,
+					    TAS2562_TDM_CFG6_ISNS_SLOT_MASK,
+					    tas2562->i_sense_slot);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -285,7 +327,8 @@ static int tas2562_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
 	struct tas2562_data *tas2562 = snd_soc_component_get_drvdata(component);
-	u8 tdm_rx_start_slot = 0, asi_cfg_1 = 0;
+	u8 asi_cfg_1 = 0;
+	u8 tdm_rx_start_slot = 0;
 	int ret;
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -307,27 +350,23 @@ static int tas2562_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		dev_err(tas2562->dev, "Failed to set RX edge\n");
 		return ret;
 	}
-
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case (SND_SOC_DAIFMT_I2S):
-	case (SND_SOC_DAIFMT_DSP_A):
-	case (SND_SOC_DAIFMT_DSP_B):
-		tdm_rx_start_slot = BIT(1);
-		break;
-	case (SND_SOC_DAIFMT_LEFT_J):
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_DSP_B:
 		tdm_rx_start_slot = 0;
 		break;
-	default:
-		dev_err(tas2562->dev, "DAI Format is not found, fmt=0x%x\n",
-			fmt);
-		ret = -EINVAL;
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_DSP_A:
+		tdm_rx_start_slot = 1;
 		break;
+	default:
+		dev_err(tas2562->dev,
+			"DAI Format is not found, fmt=0x%x\n", fmt);
+		return -EINVAL;
 	}
 
 	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG1,
-					    TAS2562_TDM_CFG1_RX_OFFSET_MASK,
-					    tdm_rx_start_slot);
-
+				TAS2562_RX_OFF_MASK, (tdm_rx_start_slot << 1));
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/codecs/tas2562.h b/sound/soc/codecs/tas2562.h
index 28e75fc431d0..18209f397921 100644
--- a/sound/soc/codecs/tas2562.h
+++ b/sound/soc/codecs/tas2562.h
@@ -34,6 +34,10 @@
 #define TAS2562_TDM_DET		TAS2562_REG(0, 0x11)
 #define TAS2562_REV_ID		TAS2562_REG(0, 0x7d)
 
+#define TAS2562_RX_OFF_MASK	GENMASK(5, 1)
+#define TAS2562_TX_OFF_MASK	GENMASK(3, 1)
+#define TAS2562_RIGHT_SLOT_SHIFT 4
+
 /* Page 2 */
 #define TAS2562_DVC_CFG1	TAS2562_REG(2, 0x0c)
 #define TAS2562_DVC_CFG2	TAS2562_REG(2, 0x0d)
@@ -49,7 +53,6 @@
 
 #define TAS2562_TDM_CFG1_RX_EDGE_MASK	BIT(0)
 #define TAS2562_TDM_CFG1_RX_FALLING	1
-#define TAS2562_TDM_CFG1_RX_OFFSET_MASK	GENMASK(4, 0)
 
 #define TAS2562_TDM_CFG0_RAMPRATE_MASK		BIT(5)
 #define TAS2562_TDM_CFG0_RAMPRATE_44_1		BIT(5)
-- 
2.26.2

