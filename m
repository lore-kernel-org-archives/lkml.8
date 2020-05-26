Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80A7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91CDA20849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IPEzv0tC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389033AbgEZRyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:54:08 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39202 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388586AbgEZRyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:54:07 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04QHrFmK035070;
        Tue, 26 May 2020 12:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590515595;
        bh=mTjyA08DkTl9/UxPwDQR7QnPE9aXKDpzBvfiE5znuqQ=;
        h=From:To:CC:Subject:Date;
        b=IPEzv0tCFFDQw7n4vfV24DixgLOT2M28LGIPOQM1DWeJ5vM/AzygY1sRE3XlZsPYY
         oUHugbWKcJlWoLzBXVYswhts2Ai4LtTYW/NaQzm7d4weVrQutaCcIR2iNGDlzC7AuX
         y6wwY5SBpSnCdr8XUXM9p2BpFTCU0LZ6M5r4AhA0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04QHrFKv094636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 12:53:15 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 May 2020 12:52:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 26 May 2020 12:52:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04QHqmCI095113;
        Tue, 26 May 2020 12:52:48 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] ASoC: tlv320adcx140: Fix warnings when using W=1
Date:   Tue, 26 May 2020 12:52:47 -0500
Message-ID: <20200526175247.15309-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warnings when using the W=1 compiler flag.

sound/soc/codecs/tlv320adcx140.c: In function ‘adcx140_reset’:
sound/soc/codecs/tlv320adcx140.c:570:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
  570 |  int ret = 0;
      |      ^~~

This was set but only used in case where the reset GPIO is not defined.
Have the function return the value of ret.

sound/soc/codecs/tlv320adcx140.c: In function ‘adcx140_codec_probe’:
sound/soc/codecs/tlv320adcx140.c:778:18: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  778 |  if (bias_source < ADCX140_MIC_BIAS_VAL_VREF ||
      |                  ^
sound/soc/codecs/tlv320adcx140.c:789:18: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  789 |  if (vref_source < ADCX140_MIC_BIAS_VREF_275V ||

This condition will not occur since if the dt property is not set then
the *_source variable is set to the default value.  So there is no way
that *_source can be less then 0.  Which is what each #define is set to.
The code just needs to make sure that the dt property is not out of the
upper bounds.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 472d759ba8a3..2fe0df3b7550 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -582,7 +582,7 @@ static int adcx140_reset(struct adcx140_priv *adcx140)
 	/* 8.4.2: wait >= 10 ms after entering sleep mode. */
 	usleep_range(10000, 100000);
 
-	return 0;
+	return ret;
 }
 
 static int adcx140_hw_params(struct snd_pcm_substream *substream,
@@ -772,8 +772,7 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	if (ret)
 		bias_source = ADCX140_MIC_BIAS_VAL_VREF;
 
-	if (bias_source < ADCX140_MIC_BIAS_VAL_VREF ||
-	    bias_source > ADCX140_MIC_BIAS_VAL_AVDD) {
+	if (bias_source > ADCX140_MIC_BIAS_VAL_AVDD) {
 		dev_err(adcx140->dev, "Mic Bias source value is invalid\n");
 		return -EINVAL;
 	}
@@ -783,8 +782,7 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	if (ret)
 		vref_source = ADCX140_MIC_BIAS_VREF_275V;
 
-	if (vref_source < ADCX140_MIC_BIAS_VREF_275V ||
-	    vref_source > ADCX140_MIC_BIAS_VREF_1375V) {
+	if (vref_source > ADCX140_MIC_BIAS_VREF_1375V) {
 		dev_err(adcx140->dev, "Mic Bias source value is invalid\n");
 		return -EINVAL;
 	}
-- 
2.26.2

