Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACEBC4BA15
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34AA24670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tik595Gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBZQWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:22:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51372 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZQWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:22:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01QGLhUY077662;
        Wed, 26 Feb 2020 10:21:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582734103;
        bh=7PBDsbXxj4AX8n3D3XLYg0rJuiB68wdam0M5qbWaRh8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Tik595GhNchxiBpHFQRMneZll48OMlkT78PYfme5fF+OJUZsTlAQeu/JiYz2HQHSF
         Arpaqo9e+mrjSZxLt6rA1GgzcxLy22CMo7RrVBb1RE5AobYeF15ARXhNMcxGsvC0Tv
         umVAfPuQn04p4CIo/bgyZzGQ3v8KZrwF16SjCTuo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01QGLhGa060397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 10:21:43 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 10:21:42 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 10:21:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01QGLgpq068594;
        Wed, 26 Feb 2020 10:21:42 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [RESEND PATCH for-next 3/3] ASoC: tas2562: Add entries for the TAS2563 audio amplifier
Date:   Wed, 26 Feb 2020 10:16:28 -0600
Message-ID: <20200226161628.29960-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226161628.29960-1-dmurphy@ti.com>
References: <20200226161628.29960-1-dmurphy@ti.com>
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
index c7a4b3b74654..6b7f7a18da36 100644
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

