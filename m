Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE5FC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988F02067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="TG49cmr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgIANK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:10:27 -0400
Received: from smtp1.axis.com ([195.60.68.17]:42489 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbgIANIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1083; q=dns/txt; s=axis-central1;
  t=1598965698; x=1630501698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XM/YiO1AN+GvGSxUyxQbpOxOSqb3rPJ2qUV4jnebMHM=;
  b=TG49cmr5xGTWothO2DnT16JGI8wtshMGF+WPcGdS9wuKLTp/EPVnl3EG
   JH+WJPBlx/oxUA0M6CgjSCxi4AY2vdafpphIogpQYMKDVOV5ixGMaUrUR
   LbN22hCV7Qt5+z7xyheMIHknXRCV338sha5dCaF+S9k9dNVrRJaIbM5Gb
   TqnfTHm+mbYbjqNZiSFZlsOwIFTMcZwwa6JEUdgg2ltbaIm7ht+2jjFWb
   R7m+4xvbLWkCx5BMETNqY+pnpdDKTtjMVumKef1/QEhmaZd2oIkqB730N
   FmunBtW7ipdWX+PfCfn5wh6KVq38SwnYUzV2KT4/cNDHa/YdhG8Oud5E2
   w==;
IronPort-SDR: JSWorGGGlbfcZbzI5fleFnnnHVRJWrr9awe3/ZTkPFcjNndKis4aT3mf4kLCBRg7CLgBsNQsP/
 VmhwplkhScCG1ZsWDV/6cO89BonM6vV9ZUtnMj8DXa2IRWh9XgyAoP76bgaEYFl7MaENAci8vF
 ZU7yzW/TQ5fJhjJhuvzhic6Aylqj3I8DXEzh3jvoMS5VhSKPIB8purSKuRkWRW/QQoSE4pPFkP
 VJOf7CF6q1h2rrGIQW8M8YLths3IIjNRtqgSFY3sExQDZG+XZSAdbfx8+fODezYDqcer8jq4/Z
 mEg=
X-IronPort-AV: E=Sophos;i="5.76,379,1592863200"; 
   d="scan'208";a="12435719"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>,
        Camel Guo <camel.guo@axis.com>
Subject: [PATCH] ASoC: tlv320adcx140: Fix accessing uninitialized adcx140->dev
Date:   Tue, 1 Sep 2020 15:07:53 +0200
Message-ID: <20200901130753.27670-2-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901130753.27670-1-camel.guo@axis.com>
References: <20200901130753.27670-1-camel.guo@axis.com>
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

