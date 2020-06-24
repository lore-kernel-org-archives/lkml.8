Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31322C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B56206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ynwewCyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405777AbgFXRug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:50:36 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33054 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405556AbgFXRud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:50:33 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OHnsQZ062662;
        Wed, 24 Jun 2020 12:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593020994;
        bh=e4c8HtBVunTIXDjsz5ID1fxiAatAsli/NNkAvswBlVQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ynwewCybshtrvVA0QUDM9/D6QwkAOfOTlHYUnPCXIq3iltzJyjxAlxIakNaNjXlXm
         tUPR6/1sybju7bdqbVqaUOqzqnOtrNt2SLiNHhun0Y26MkLKvNRtbffavfLnvN1WDX
         Xkhfmq4b2Ngy9CARWYJ7D1OnE8Xm8bGB8ARYFMXg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHns9H082161;
        Wed, 24 Jun 2020 12:49:54 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 12:49:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 12:49:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHnrEX119444;
        Wed, 24 Jun 2020 12:49:53 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v6 3/7] ASoC: tas2562: Fix format issue for extra space before a comma
Date:   Wed, 24 Jun 2020 12:49:28 -0500
Message-ID: <20200624174932.9604-4-dmurphy@ti.com>
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

Fix the issue found that there is an extra space before a comma in the
volume control.

Fixes: bf726b1c86f2c ("ASoC: tas2562: Add support for digital volume control")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2562.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index f6495426f562..d26e30a2948c 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -504,7 +504,7 @@ static const struct snd_kcontrol_new tas2562_snd_controls[] = {
 		.info = snd_soc_info_volsw,
 		.get = tas2562_volume_control_get,
 		.put = tas2562_volume_control_put,
-		.private_value = SOC_SINGLE_VALUE(TAS2562_DVC_CFG1, 0, 110, 0, 0) ,
+		.private_value = SOC_SINGLE_VALUE(TAS2562_DVC_CFG1, 0, 110, 0, 0),
 	},
 };
 
-- 
2.26.2

