Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06907C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7888A2065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w9MiBenm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390892AbgEMUQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:16:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55226 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbgEMUQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:16:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DKFWJl087999;
        Wed, 13 May 2020 15:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589400932;
        bh=e5oLHvSAcu1wID8AuM4YdTSx1fGtweYfUrxREiY/l9M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=w9MiBenm9D8ZHY+/L/57qgHSEKW48jrlzcJSJGtMMKcsRgqfR+e6KNViQ2ihpKt6+
         A3aTdp2RCgv/IY+jYENwdiDsihwnuA4zTYAjh7FG5L3CKLS4dqqvIr/M4FuF61ln3R
         Gj68e1c5zmu1VBoRLPcO6w6EqWQwlMeF5I5byF8E=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04DKFWf3084915
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 15:15:32 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 15:15:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 15:15:31 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DKFVsb096766;
        Wed, 13 May 2020 15:15:31 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 3/3] ASoC: tlv320adcx140: Configure PDM sampling edge
Date:   Wed, 13 May 2020 15:05:49 -0500
Message-ID: <20200513200549.12213-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513200549.12213-1-dmurphy@ti.com>
References: <20200513200549.12213-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the PDM sampling edges based on the values from the firmware.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 22 ++++++++++++++++++++++
 sound/soc/codecs/tlv320adcx140.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 97634e0ca0ba..140a5802a9a9 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -760,6 +760,10 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	int sleep_cfg_val = ADCX140_WAKE_DEV;
 	u8 bias_source;
 	u8 vref_source;
+	int pdm_count;
+	u32 pdm_edges[ADCX140_NUM_PDM_EDGES];
+	u32 pdm_edge_val = 0;
+	int i;
 	int ret;
 
 	ret = device_property_read_u8(adcx140->dev, "ti,mic-bias-source",
@@ -786,6 +790,24 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 
 	bias_source |= vref_source;
 
+	pdm_count = device_property_count_u32(adcx140->dev,
+					      "ti,pdm-edge-select");
+	if (pdm_count <= ADCX140_NUM_PDM_EDGES && pdm_count > 0) {
+		ret = device_property_read_u32_array(adcx140->dev,
+						     "ti,pdm-edge-select",
+						     pdm_edges, pdm_count);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < pdm_count; i++)
+			pdm_edge_val |= pdm_edges[i] << (ADCX140_PDM_EDGE_SHIFT - i);
+
+		ret = regmap_write(adcx140->regmap, ADCX140_PDM_CFG,
+				   pdm_edge_val);
+		if (ret)
+			return ret;
+	}
+
 	ret = adcx140_reset(adcx140);
 	if (ret)
 		goto out;
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index 6d055e55909e..432eaf25d1a7 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -128,4 +128,7 @@
 
 #define ADCX140_TX_OFFSET_MASK		GENMASK(4, 0)
 
+#define ADCX140_NUM_PDM_EDGES		4
+#define ADCX140_PDM_EDGE_SHIFT		7
+
 #endif /* _TLV320ADCX140_ */
-- 
2.26.2

