Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861D9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58859206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="cUZYoXMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgIAMxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:53:48 -0400
Received: from smtp1.axis.com ([195.60.68.17]:41044 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgIAMvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=995; q=dns/txt; s=axis-central1;
  t=1598964699; x=1630500699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bZ/H5Fs/QMbb9e+PlCCs4RRk8UF5csgy4VmwPELJui4=;
  b=cUZYoXMlxm6lDiWHdVC1l96lWCtLOKDF2RsOeMIa4q9SF4L0/7A4Xaoa
   UjZSfQnfSGcRoxjCBWSSe3hW1605qK0+d67VIGgJK4Dt9ql/eSlIfQO0E
   XyqwllIcX4oXYtHBAbcSVZOWW/cGoP2TdL1c4RpPsKi5wAN10gDcJo4RR
   4VGSbVmOUxWi23T48EEnFZjifzvo8n6XXRMHme65JFek9yHX63paURQqn
   PRIGrk4RBNp7LS1SjUbDnqkY3Tw9O0lQETfwVDLTkNC2GzRsqC10bTEej
   MI2Uwr0n/WBf8rIxZsTzdyQr2eSN++w66UOZzcJF+Lx2TTK06RuIt1qH+
   A==;
IronPort-SDR: gzHzlcmCoOgPoBKEljhCVaeIS9elkzWwIBKSsDR/9WI5kwrKUMgd6HhCVlab82xpz/0rYuKNbt
 XpylXJpQ0UDBcx2N2o8ygWoWviWgQzyYD5NvaN7qgWri1aWcDPHNf9Gx0W1VtUoRRtNR7F7QUw
 YGgbkjXETCHMybezzxJ13U8h3l5j8cr5HfaQTNapkBL9E1DDR9o9cmB6B/otRSellwxM4ijL3b
 R3MNdr8kYCBAvyzqsg7hVLf3FBFge2rULdnuSpzxYNDeDi/aQwHCxRHbee1NriFWVqTOy4rldP
 K7A=
X-IronPort-AV: E=Sophos;i="5.76,379,1592863200"; 
   d="scan'208";a="12434794"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>,
        Camel Guo <camel.guo@axis.com>
Subject: [PATCH v2] ASoC: tlv320adcx140: Fix accessing uninitialized adcx140->dev
Date:   Tue, 1 Sep 2020 14:51:22 +0200
Message-ID: <20200901125123.25886-1-camel.guo@axis.com>
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

