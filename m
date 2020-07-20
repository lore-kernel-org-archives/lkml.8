Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A0C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E1B722B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kMmJlhlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbgGTSNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:13:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48530 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgGTSNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:13:08 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06KICESd057699;
        Mon, 20 Jul 2020 13:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595268734;
        bh=7tyvgaL+fW83SAUmCUViLrsnXQp4Obzw1ixykaV8ISI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kMmJlhlJy1WGDQkBsH0rhk1gjbXR46eDnqxStJo9yR8e4XCwYmGToZAVzASCBP1ap
         Zwj8fcEuBSfB/3IQDcbdF9NkrjPeF52a626LqwoKSRehTDiA4uIhQBdUQaBVHwieZk
         VPR3y0MW1Qc98QUs6Vm/0vqk5piLefkipNQiQux0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06KICE8Q091024;
        Mon, 20 Jul 2020 13:12:14 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 20
 Jul 2020 13:12:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 20 Jul 2020 13:12:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06KICEuK064305;
        Mon, 20 Jul 2020 13:12:14 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 2/2] ASoC: tas2770: Fix reset gpio property name
Date:   Mon, 20 Jul 2020 13:12:02 -0500
Message-ID: <20200720181202.31000-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720181202.31000-1-dmurphy@ti.com>
References: <20200720181202.31000-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the reset property name when allocating the GPIO descriptor.
The gpiod_get_optional appends either the -gpio or -gpios suffix to the
name.

Fixes: 1a476abc723e6 ("tas2770: add tas2770 smart PA kernel driver")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 4538b2d0216f..1eb9b77439eb 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -759,8 +759,7 @@ static int tas2770_i2c_probe(struct i2c_client *client,
 		}
 	}
 
-	tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
-							  "reset-gpio",
+	tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev, "reset",
 						      GPIOD_OUT_HIGH);
 	if (IS_ERR(tas2770->reset_gpio)) {
 		if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
-- 
2.27.0

