Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EA4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5006720768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b0Tf4PR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404831AbgFXQQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:16:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50466 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405052AbgFXQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:16:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OGFMJC038562;
        Wed, 24 Jun 2020 11:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593015322;
        bh=Y5MdwCGXU77RAWVwX/WygJujeCPyLUiyCkJR3oQySLQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=b0Tf4PR1HtSIeUBiCHH1c4L6C++nPwuKH1nD4RmBvdwoK9GjKinpV1hJuquszow2i
         4NFo69/tYvk6j0xqcTWPBZuMJX5zc0joVtcGoQTjAAm39NpAys6GVP6+tSiVo99a60
         fQWfkb94FL+1WIRDI9iUld8s/r2f9qhNFoBVNRb8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OGFHew058586
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 11:15:17 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 11:15:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 11:15:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OGFGhm099160;
        Wed, 24 Jun 2020 11:15:16 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v5 4/7] ASoC: tas2562: Add rx and tx slot programming
Date:   Wed, 24 Jun 2020 11:14:56 -0500
Message-ID: <20200624161459.19248-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624161459.19248-1-dmurphy@ti.com>
References: <20200624161459.19248-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add programming for the tdm slots for both tx and rx offsets.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2562.c | 17 ++++++++++++++++-
 sound/soc/codecs/tas2562.h |  4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index d26e30a2948c..2f1d4b697f01 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -208,6 +208,22 @@ static int tas2562_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	if (ret < 0)
 		return ret;
 
+	if (tx_mask > TAS2562_TX_OFF_MAX) {
+		dev_err(tas2562->dev, "TX slot is larger then %d",
+			TAS2562_TX_OFF_MAX);
+		return -EINVAL;
+	}
+
+	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG1,
+					    TAS2562_RX_OFF_MASK, rx_mask << 1);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG4,
+					    TAS2562_TX_OFF_MASK, tx_mask << 1);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
@@ -327,7 +343,6 @@ static int tas2562_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG1,
 					    TAS2562_TDM_CFG1_RX_OFFSET_MASK,
 					    tdm_rx_start_slot);
-
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/soc/codecs/tas2562.h b/sound/soc/codecs/tas2562.h
index 28e75fc431d0..47e59c82eef3 100644
--- a/sound/soc/codecs/tas2562.h
+++ b/sound/soc/codecs/tas2562.h
@@ -34,6 +34,10 @@
 #define TAS2562_TDM_DET		TAS2562_REG(0, 0x11)
 #define TAS2562_REV_ID		TAS2562_REG(0, 0x7d)
 
+#define TAS2562_RX_OFF_MASK	GENMASK(5, 1)
+#define TAS2562_TX_OFF_MASK	GENMASK(3, 1)
+#define TAS2562_TX_OFF_MAX	7
+
 /* Page 2 */
 #define TAS2562_DVC_CFG1	TAS2562_REG(2, 0x0c)
 #define TAS2562_DVC_CFG2	TAS2562_REG(2, 0x0d)
-- 
2.26.2

