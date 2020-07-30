Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5619C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2D420578
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OpFrdnzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgG3OZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:25:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40704 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3OZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:25:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06UEOU1u045357;
        Thu, 30 Jul 2020 09:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596119070;
        bh=4n4tczlb66rZ2sALZ2WA0y87szWgkh6JUgil+Oe8bG4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OpFrdnzIw7wxmHUPgpKtZ37mhzn5rW/q0d/QPd4pN9CXUTJ4hXb6bjnz0D2NGYr5N
         7qYpdMRtw5INaLMXh96vNv3rCRP87aY5HCsDTv/pCcMnN2t0Gl+84klcjPBXbwp4ks
         F7y3UBy6m4ov9kBPadPDKstBcPzDTqH0shvsfBDE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06UEOU9r002073
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 09:24:30 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Jul 2020 09:24:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Jul 2020 09:24:30 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UEOUbr023307;
        Thu, 30 Jul 2020 09:24:30 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] ASoC: tlv320adcx140: Move device reset to before programming
Date:   Thu, 30 Jul 2020 09:24:19 -0500
Message-ID: <20200730142419.28205-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730142419.28205-1-dmurphy@ti.com>
References: <20200730142419.28205-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the device before programming the registers or all programming
will be lost as the device resets registers to default settings.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index fc7616dcf9b5..5cd50d841177 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -838,6 +838,10 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 
 	bias_cfg = bias_source << ADCX140_MIC_BIAS_SHIFT | vref_source;
 
+	ret = adcx140_reset(adcx140);
+	if (ret)
+		goto out;
+
 	pdm_count = device_property_count_u32(adcx140->dev,
 					      "ti,pdm-edge-select");
 	if (pdm_count <= ADCX140_NUM_PDM_EDGES && pdm_count > 0) {
@@ -885,10 +889,6 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	if (ret)
 		goto out;
 
-	ret = adcx140_reset(adcx140);
-	if (ret)
-		goto out;
-
 	if (adcx140->supply_areg == NULL)
 		sleep_cfg_val |= ADCX140_AREG_INTERNAL;
 
-- 
2.28.0

