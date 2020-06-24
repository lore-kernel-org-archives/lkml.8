Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B762C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21214206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fox6jLpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405772AbgFXRud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:50:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57334 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405556AbgFXRub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:50:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OHnnEW029401;
        Wed, 24 Jun 2020 12:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593020989;
        bh=qUC2mpsw94iRI+GEjoOUWoy0avC1fy2ViW4yz+XKfrY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fox6jLpgHTle2yD1yFAMXCGlmhphEV2Pj+i/b8gVXIKvLvK82Xqei3ha1cUV9v8sM
         WHp8wEMVp5d2ElWmUFi8wCsOVG8VKowh5fTYbwwEMCtGQ3Jfw8uKoT/QprtRgGAGey
         j0/twIUAz7nGdzoEA/+YSzZbqEhYWq8n/4LGDZOs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHnnJr082068;
        Wed, 24 Jun 2020 12:49:49 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 12:49:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 12:49:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHnmij119276;
        Wed, 24 Jun 2020 12:49:48 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v6 2/7] ASoC: tas2562: Update shutdown GPIO property
Date:   Wed, 24 Jun 2020 12:49:27 -0500
Message-ID: <20200624174932.9604-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624174932.9604-1-dmurphy@ti.com>
References: <20200624174932.9604-1-dmurphy@ti.com>
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
 sound/soc/codecs/tas2562.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 7fae88655a0f..f6495426f562 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -619,8 +619,8 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 	struct device *dev = tas2562->dev;
 	int ret = 0;
 
-	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down-gpio",
-						      GPIOD_OUT_HIGH);
+	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down",
+						    GPIOD_OUT_HIGH);
 	if (IS_ERR(tas2562->sdz_gpio)) {
 		if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER) {
 			tas2562->sdz_gpio = NULL;
-- 
2.26.2

