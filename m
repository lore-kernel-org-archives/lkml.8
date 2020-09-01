Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D863C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D72462067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="aCznlRUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgIANMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:12:09 -0400
Received: from smtp2.axis.com ([195.60.68.18]:45874 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbgIANIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1083; q=dns/txt; s=axis-central1;
  t=1598965698; x=1630501698;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XM/YiO1AN+GvGSxUyxQbpOxOSqb3rPJ2qUV4jnebMHM=;
  b=aCznlRUIkbKvI3sryWZwlM5RabuvRLWGJqu1ojNNGX4J20qFDwYIYtYL
   txGIHYrol5zhwIq1jM2wMIZUsllRq8sIzwnAgW82lNYpCuyQQ85auakJO
   6A+szlrAu1cx7U/5M6ncMTtomd4ehdxxbc1wMoX/H+2VrO2Zmj1uAMjxx
   NCL3PDn73gE6wIvr2Nh68H+zIrp4NcGYMzsHu+AjNGpGWS8lkWaVZcHEj
   K6Q3JNgZ3WgWc1tHdwd8c/1CK9EMlKHhxyzFu/LxIeJCwIqb7gIvWbjUm
   X3/UNxscOSWxfdHM/iB5axVOtwlYUHwBhCEeoILoLJJKwj7p0yXCEVEsX
   Q==;
IronPort-SDR: urVlRcHZRIGbnH4AspnR2uVOcG06TA9Z0n8XexRq5uYKEEPHYbwJGmrq0Ioo5lxoG/KKgmyqo6
 BsjAEXKDGc8CFYzk/FNoVYj+qxJBhf8xeh/FF9+VLrER3BrxNJRlyPgscEIMY9cW9sSQTnWS+0
 0esfg9GrMu8aRpsgsUcc/lsVmNCooNQ+FwKZxVSkn2RK1qXs5VQZ/vASoOJK5w/gFCsWOc4Fi/
 e2970Rqug8IDPYt4/2Ns4Uv0cuRuuHVKJS1l9hTEktJJZJCgAuoOVmt6kbyn1OCNehCyMewJ07
 peE=
X-IronPort-AV: E=Sophos;i="5.76,379,1592863200"; 
   d="scan'208";a="12085624"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>,
        Camel Guo <camel.guo@axis.com>
Subject: [PATCH v3] ASoC: tlv320adcx140: Fix accessing uninitialized adcx140->dev
Date:   Tue, 1 Sep 2020 15:07:52 +0200
Message-ID: <20200901130753.27670-1-camel.guo@axis.com>
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
Signed-off-by: Camel Guo <camel.guo@axis.com>
---
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

