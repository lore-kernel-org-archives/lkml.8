Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CCCC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81AB221741
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="kurFb0HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgIHJEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:04:23 -0400
Received: from smtp1.axis.com ([195.60.68.17]:38349 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgIHJEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1123; q=dns/txt; s=axis-central1;
  t=1599555860; x=1631091860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DrCanfQPxJQAbiFoOiHCF5OHW6LGa9wQUs0Iobf1d1o=;
  b=kurFb0HHMCC1VvO+QSRQPgMVGqKRu5IsqOAYBzrdHSPgnf2aI3rqpDHw
   sLbVywTVMndtMOchvv9Mcmk2Tpcv14thPx2Gd0jvX7mV86/3hSVuCd3If
   IZeBx4nkP8LFXxkcN1q0eXOxMskoTQUj3RMjKIQ57wyQpGU89phle1POq
   8MKy45ybqEHO3ogRx1nHYmKBm5m16tJqFKgdB7GKEhlzjbqG0bQN9kS3U
   7JedqJ8IRCxoH22wSbXjLOafPmzcOmVttyukCF/4Nd8q9QTPWmsj4AuOX
   fgv3Wt1VBNQJ34b95PsyDcf6sZ8Nxj7OV92KxhAOSOEcNBZahBtWwSkO6
   A==;
IronPort-SDR: LZ6//p3kpV8zVpoMoHC+ooWQYFsULnU4r8sZttsxzkSV6gW1/Of08FhKWZSd7Mci3IxatP7TzT
 xou/zzbVQHyKGgq895AEmf1OL64oxcNw8iA2Xw67wV3x6KWN1EvuHwlYe0MCjgxbNxLfCzqDok
 4Hetrh3251T37zUBG0cnwfetDGeXUZkecvpJBpdhF1ynda/xeVr7AfG60Qu4etZu814Dz0DMHE
 ooHdL12oOAyJGhWaGAWsdjjAesLsM0pZskJ/xX6Thb5a7F4CWgJnd/bqb1/cDxZLveD+Jrd3w1
 W5A=
X-IronPort-AV: E=Sophos;i="5.76,405,1592863200"; 
   d="scan'208";a="12653857"
From:   Camel Guo <camel.guo@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
Subject: [PATCH] ASoC: tlv320adcx140: Fix digital gain range
Date:   Tue, 8 Sep 2020 11:04:17 +0200
Message-ID: <20200908090417.16695-1-camel.guo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camel Guo <camelg@axis.com>

According to its datasheet, the digital gain should be -100 dB when
CHx_DVOL is 1 and 27 dB when CHx_DVOL is 255. But with the current
dig_vol_tlv, "Digital CHx Out Volume" shows 27.5 dB if CHx_DVOL is 255
and -95.5 dB if CHx_DVOL is 1. This commit fixes this bug.

Fixes: 689c7655b50c ("ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family")
Signed-off-by: Camel Guo <camelg@axis.com>
---
 sound/soc/codecs/tlv320adcx140.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 6d456aa269ad..13ece039e9fe 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -161,7 +161,7 @@ static const struct regmap_config adcx140_i2c_regmap = {
 };
 
 /* Digital Volume control. From -100 to 27 dB in 0.5 dB steps */
-static DECLARE_TLV_DB_SCALE(dig_vol_tlv, -10000, 50, 0);
+static DECLARE_TLV_DB_SCALE(dig_vol_tlv, -10050, 50, 0);
 
 /* ADC gain. From 0 to 42 dB in 1 dB steps */
 static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 100, 0);
-- 
2.20.1

