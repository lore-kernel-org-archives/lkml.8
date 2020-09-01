Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD5BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B3A2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="RhK9zm4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgIAOHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:07:38 -0400
Received: from smtp2.axis.com ([195.60.68.18]:54792 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgIAN5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1199; q=dns/txt; s=axis-central1;
  t=1598968674; x=1630504674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SlWuRwEsUGOOrcOy4jOz87uO5umOVIDCT/hBp78/e1c=;
  b=RhK9zm4L1kXAss8MX9Mag92K9a3yaCoRaSMaIcy+uITkXV3cxRo7uyz9
   872TkVonIRlysbXkF0P9xHWczKma+rR1GDuB2PVDJkXdGxAHptFgdRRFv
   fO/NfPheixt2T34A9aYpQmYPXNvOatg2/t1NSwc/PHgOAh39TufPnmLSb
   pINMzz54BnGjfahJVws3Ml0gM0ICd0Mzsa/g1H2/fTuFIx2l7Lc7mI1di
   cgOIXbqBZBr8epLZj9G34puKj+odCezRQ/fTitLNBWZ5IaCXFcuqhAltN
   soVKGl/891P9E/CfIaXGjXrqQGU+eiYnv8e/dBTAYPtku+X39R12eXteh
   w==;
IronPort-SDR: FNOXj4xYEMBEdlzdI3cWvh4yLFmW7LQ/mba46vkxuXEnfZJXXUaKDzHTzbLhxPc/o9KBfJiH4j
 YYrTnkxSRTdZLmK+yk8IEzParOm9YsDNfuZP92z1rcK0vcHXUKVZ911an2Kd9jg8IAJf3YGvj+
 yduPs7lAvQA5fh+lnfUiuBb9UDH/y3GfakqW304En+sycjcXktfCVPF2qIa8Sf8d1gbH3hUBef
 IcBF4Zj2vP4/6Jjtw7KBpe86JReYGoTPAGwaGe1JDPAPpKL9cJnsFfmiOEIqxML5lZbAxyv/Fc
 xMY=
X-IronPort-AV: E=Sophos;i="5.76,379,1592863200"; 
   d="scan'208";a="12087816"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>,
        Camel Guo <camel.guo@axis.com>
Subject: [PATCH v4] ASoC: tlv320adcx140: Fix accessing uninitialized adcx140->dev
Date:   Tue, 1 Sep 2020 15:57:35 +0200
Message-ID: <20200901135736.32036-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

In adcx140_i2c_probe, adcx140->dev is accessed before its
initialization. This commit fixes this bug.

Fixes: 689c7655b50c ("ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family")
Acked-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Camel Guo <camel.guo@axis.com>
---
 v4:
   - Add Acked-By from Dan
 v3:
   - Add Fixes tag
 v2:
   - Fix typo

 sound/soc/codecs/tlv320adcx140.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 5cd50d841177..7ae6ec374be3 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -980,6 +980,8 @@ static int adcx140_i2c_probe(struct i2c_client *i2c,
 	if (!adcx140)
 		return -ENOMEM;
 
+	adcx140->dev = &i2c->dev;
+
 	adcx140->gpio_reset = devm_gpiod_get_optional(adcx140->dev,
 						      "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(adcx140->gpio_reset))
@@ -1007,7 +1009,7 @@ static int adcx140_i2c_probe(struct i2c_client *i2c,
 			ret);
 		return ret;
 	}
-	adcx140->dev = &i2c->dev;
+
 	i2c_set_clientdata(i2c, adcx140);
 
 	return devm_snd_soc_register_component(&i2c->dev,
-- 
2.20.1

