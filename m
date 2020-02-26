Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321C2C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AEF2467F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qYpHFfAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBZNIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:08:38 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57226 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgBZNIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:08:36 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QD8KDq026097;
        Wed, 26 Feb 2020 07:08:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582722500;
        bh=d8zidl/dWA5daRtdqdUI0IcTVlC1FTBnu1YV5N+kDIM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qYpHFfAEroVYTzVAolOxuarisbqOPJ4azI7FfwZsT/g1qHzBuZHgs+6AAe4rVgZN9
         XuBecHYUEGF/cH80XWVAr8n0SMN6mqF3YR+d9usz2ArXGLWauV+UeRPVLBP8yk0lAd
         pAFUN7u4jcHAuxl+T1wlvPUaFyLf6MEyX21QHr4c=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01QD8KbM032740
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 07:08:20 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 07:08:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 07:08:19 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QD8JdB105926;
        Wed, 26 Feb 2020 07:08:19 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH for-next 2/3] ASoC: tas2562: Add entries for the TAS2563 audio amplifier
Date:   Wed, 26 Feb 2020 07:03:04 -0600
Message-ID: <20200226130305.12043-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226130305.12043-1-dmurphy@ti.com>
References: <20200226130305.12043-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TAS2563 is register compatible with the TAS2562.  The main
difference is the TAS2563 has a programmable DSP to manage different
audio profiles.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2562.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index d5e04030a0c1..79c3c3d79766 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -55,6 +55,11 @@ struct tas2562_data {
 	int volume_lvl;
 };
 
+enum tas256x_model {
+	TAS2562,
+	TAS2563,
+};
+
 static int tas2562_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
@@ -664,13 +669,15 @@ static int tas2562_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id tas2562_id[] = {
-	{ "tas2562", 0 },
+	{ "tas2562", TAS2562 },
+	{ "tas2563", TAS2563 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tas2562_id);
 
 static const struct of_device_id tas2562_of_match[] = {
 	{ .compatible = "ti,tas2562", },
+	{ .compatible = "ti,tas2563", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tas2562_of_match);
-- 
2.25.0

