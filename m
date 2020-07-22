Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D3C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53AA2065F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c7zvVHqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbgGVPsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:48:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58600 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgGVPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:48:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06MFlIF8110020;
        Wed, 22 Jul 2020 10:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595432838;
        bh=XJ+ytuhtkKd7PxGGLQoO++jTzbDtr8cHVrzy6/eyodU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=c7zvVHqazamxkG/ApE8+1P25eW3S2f2pqRoCasN3ZDxa50JlDEbRyN+KC43VmhI6F
         spFMVxwOAUS3eZPPjFMa51sU5UAKMTSBH7UwZ7k3Owh5sQet+4iufLXiwrAR1ihJRC
         LakTLixG1MOQaPwykB7/fwnUtG0ugS9Gy0LWbwKM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06MFlIWJ083089;
        Wed, 22 Jul 2020 10:47:18 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Jul 2020 10:47:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 22 Jul 2020 10:47:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06MFlHsk009607;
        Wed, 22 Jul 2020 10:47:17 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 2/2] ASoC: tas2562: Update shutdown GPIO property
Date:   Wed, 22 Jul 2020 10:47:06 -0500
Message-ID: <20200722154706.9657-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722154706.9657-1-dmurphy@ti.com>
References: <20200722154706.9657-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the shutdown GPIO property to be shutdown from shut-down.

Fixes: c173dba44c2d2 ("ASoC: tas2562: Introduce the TAS2562 amplifier")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Set sdz_gpio to NULL if gpio property not present.

 sound/soc/codecs/tas2562.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index e74628061040..8a53633a3853 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -680,12 +680,25 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 	struct device *dev = tas2562->dev;
 	int ret = 0;
 
-	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down",
-						    GPIOD_OUT_HIGH);
+	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown",
+						      GPIOD_OUT_HIGH);
 	if (IS_ERR(tas2562->sdz_gpio)) {
-		if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER) {
-			tas2562->sdz_gpio = NULL;
+		tas2562->sdz_gpio = NULL;
+		if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
+	}
+
+	/*
+	 * The shut-down property is deprecated but needs to be checked for
+	 * backwards compatibility.
+	 */
+	if (tas2562->sdz_gpio == NULL) {
+		tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down",
+							      GPIOD_OUT_HIGH);
+		if (IS_ERR(tas2562->sdz_gpio)) {
+			tas2562->sdz_gpio = NULL;
+			if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
 		}
 	}
 
-- 
2.27.0

