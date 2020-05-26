Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E944EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C867920899
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JXYQSpLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390886AbgEZUJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:09:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48224 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390817AbgEZUJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:09:35 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04QK9JVH011528;
        Tue, 26 May 2020 15:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590523759;
        bh=2bYRzoNasXrxZwvU3HuFMNtsN7HZlqtuvjscLs28zcU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JXYQSpLX1SkGipR5mxFS03Cv6i2j4W2RdAlM2ic2JxSb5p+3NfZg/9i2E7vWw/Nar
         zhLHpFy4vNHN/JkQ60Z1Y/v1dkQNBg6gDG3lDR6oRE0G7cA7jmTWfvkfnLhq4z1Nzs
         xF/tXoWt4tFv+AvgrIUIMS0YRzVwWQQ2hpk64QPc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04QK9JF0014651;
        Tue, 26 May 2020 15:09:19 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 May 2020 15:09:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 26 May 2020 15:09:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04QK9IgK107585;
        Tue, 26 May 2020 15:09:18 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] ASoC: tlv320adcx140: Add support for configuring GPI pins
Date:   Tue, 26 May 2020 15:09:17 -0500
Message-ID: <20200526200917.10385-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526200917.10385-1-dmurphy@ti.com>
References: <20200526200917.10385-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to configure the GPI pins to the specific configuration.
The pins can be disabled or be configured as data input for any of the
digital mic channels.  In addition the GPI can be used a a general
purpose input, a Master clock input or an ASI input for daisy chaining
devices.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 28 ++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320adcx140.h |  7 +++++++
 2 files changed, 35 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 2fe0df3b7550..35fe8ee5bce9 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -764,6 +764,9 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	int pdm_count;
 	u32 pdm_edges[ADCX140_NUM_PDM_EDGES];
 	u32 pdm_edge_val = 0;
+	int gpi_count;
+	u32 gpi_inputs[ADCX140_NUM_GPI_PINS];
+	u32 gpi_input_val = 0;
 	int i;
 	int ret;
 
@@ -807,6 +810,31 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 			return ret;
 	}
 
+	gpi_count = device_property_count_u32(adcx140->dev, "ti,gpi-config");
+	if (gpi_count <= ADCX140_NUM_GPI_PINS && gpi_count > 0) {
+		ret = device_property_read_u32_array(adcx140->dev,
+						     "ti,gpi-config",
+						     gpi_inputs, gpi_count);
+		if (ret)
+			return ret;
+
+		gpi_input_val = gpi_inputs[ADCX140_GPI1_INDEX] << ADCX140_GPI_SHIFT |
+				gpi_inputs[ADCX140_GPI2_INDEX];
+
+		ret = regmap_write(adcx140->regmap, ADCX140_GPI_CFG0,
+				   gpi_input_val);
+		if (ret)
+			return ret;
+
+		gpi_input_val = gpi_inputs[ADCX140_GPI3_INDEX] << ADCX140_GPI_SHIFT |
+				gpi_inputs[ADCX140_GPI4_INDEX];
+
+		ret = regmap_write(adcx140->regmap, ADCX140_GPI_CFG1,
+				   gpi_input_val);
+		if (ret)
+			return ret;
+	}
+
 	ret = adcx140_reset(adcx140);
 	if (ret)
 		goto out;
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index 247827f315f1..39206bf1af12 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -132,4 +132,11 @@
 #define ADCX140_NUM_PDM_EDGES		4
 #define ADCX140_PDM_EDGE_SHIFT		7
 
+#define ADCX140_NUM_GPI_PINS		4
+#define ADCX140_GPI_SHIFT		4
+#define ADCX140_GPI1_INDEX		0
+#define ADCX140_GPI2_INDEX		1
+#define ADCX140_GPI3_INDEX		2
+#define ADCX140_GPI4_INDEX		3
+
 #endif /* _TLV320ADCX140_ */
-- 
2.26.2

