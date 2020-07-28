Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634EFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 375C5207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GsxHbf/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbgG1Qoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:44:34 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44998 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgG1Qod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:44:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06SGhjX5011284;
        Tue, 28 Jul 2020 11:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595954625;
        bh=jdKE6zp5yHn3EXrC6YzjiSN2SMWcYzGzcRo94VExG04=;
        h=From:To:CC:Subject:Date;
        b=GsxHbf/Vhiz/kQkg7HJD+yIGBIyujCrnwfv30wckn2JXpWcLvTrhjHlapqqPm0RPV
         XbtIicT1OO1lDKqVMGwH84aowDsIrfjfSpTsNsVba7iLiJ8HzsB6TyVWDBLJMPPrCl
         wUfB/8qTLcaDtGKSPnyl/4daiW384d7IMJ1qRaOM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06SGhjmV065653
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 11:43:45 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 28
 Jul 2020 11:43:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 28 Jul 2020 11:43:45 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06SGhjQi011670;
        Tue, 28 Jul 2020 11:43:45 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] ASoC: tlv320adcx140: Fix various style errors and warnings
Date:   Tue, 28 Jul 2020 11:43:39 -0500
Message-ID: <20200728164339.16841-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix white space issues and remove else case where it was not needed.
Convert "static const char *" to "static const char * const"

Fixes: 689c7655b50 ("ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 49dcdd72e5c6..938c5ef17e61 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -218,8 +218,8 @@ static const struct snd_kcontrol_new in4_resistor_controls[] = {
 };
 
 /* Analog/Digital Selection */
-static const char *adcx140_mic_sel_text[] = {"Analog", "Line In", "Digital"};
-static const char *adcx140_analog_sel_text[] = {"Analog", "Line In"};
+static const char * const adcx140_mic_sel_text[] = {"Analog", "Line In", "Digital"};
+static const char * const adcx140_analog_sel_text[] = {"Analog", "Line In"};
 
 static SOC_ENUM_SINGLE_DECL(adcx140_mic1p_enum,
 			    ADCX140_CH1_CFG0, 5,
@@ -598,7 +598,7 @@ static int adcx140_reset(struct adcx140_priv *adcx140)
 		gpiod_direction_output(adcx140->gpio_reset, 1);
 	} else {
 		ret = regmap_write(adcx140->regmap, ADCX140_SW_RESET,
-		          ADCX140_RESET);
+				   ADCX140_RESET);
 	}
 
 	/* 8.4.2: wait >= 10 ms after entering sleep mode. */
@@ -841,7 +841,7 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	if (ret)
 		goto out;
 
-	if(adcx140->supply_areg == NULL)
+	if (adcx140->supply_areg == NULL)
 		sleep_cfg_val |= ADCX140_AREG_INTERNAL;
 
 	ret = regmap_write(adcx140->regmap, ADCX140_SLEEP_CFG, sleep_cfg_val);
@@ -942,8 +942,8 @@ static int adcx140_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(adcx140->supply_areg)) {
 		if (PTR_ERR(adcx140->supply_areg) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
-		else
-			adcx140->supply_areg = NULL;
+
+		adcx140->supply_areg = NULL;
 	} else {
 		ret = regulator_enable(adcx140->supply_areg);
 		if (ret) {
-- 
2.28.0

