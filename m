Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A61C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4585420836
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VD1O0gZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFLROL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:14:11 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50770 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgFLROI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:14:08 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CHDnst022579;
        Fri, 12 Jun 2020 12:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591982029;
        bh=GG9bfFkMnnGI+ZtZozpFxp/t1KnmDeQXwtoe0ZVYcrk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VD1O0gZ9RR1+8esRq5D7M9dWeTQBn43Cw4GWsCT1oGUwLLSes5hd1rnK/r2gvYgOd
         pQFn/Q4+XPavYghv1mSOdeBt/ExVYVTkCoeNvLBVy5Nz1en9Vn26NnvqaQt0tWu9YX
         R5YmJA09o5zDhjOZq/qe0V362uc5lAoUlBPrs55Q=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05CHDnim081191
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 12:13:49 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 12:13:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 12:13:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CHDmIS039818;
        Fri, 12 Jun 2020 12:13:48 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh@kernel.org>, <shifu0704@thundersoft.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] ASoC: tas2770: Fix reset gpio property name
Date:   Fri, 12 Jun 2020 12:13:42 -0500
Message-ID: <20200612171342.25364-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612171342.25364-1-dmurphy@ti.com>
References: <20200612171342.25364-1-dmurphy@ti.com>
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
index 54c8135fe43c..cf071121c839 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -758,8 +758,7 @@ static int tas2770_i2c_probe(struct i2c_client *client,
 		}
 	}
 
-	tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
-							  "reset-gpio",
+	tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev, "reset",
 						      GPIOD_OUT_HIGH);
 	if (IS_ERR(tas2770->reset_gpio)) {
 		if (PTR_ERR(tas2770->reset_gpio) == -EPROBE_DEFER) {
-- 
2.26.2

