Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D499AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84A82080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597249817;
	bh=3bfDu2rrgsQUUDMAmYFHILNOphrIGlyzCv66V1HnZQE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h4wKBDBn81tFBxamV4pPSBfP1QXMWM1H007KK7BnN/wtpkrA46XzWqjFcjd1Sk0kN
	 X+9eS8y/UkSrZw+V3kEb/psphJVSfFuTdUhxE4up0/2xFKwe58neU6gP/YPJ20XaeV
	 hAS+5rwUP5OteyiVRpp0gRaCg2vs4bHdpx8rAy5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHLQaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgHLQaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:30:15 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBBA207DA;
        Wed, 12 Aug 2020 16:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597249815;
        bh=3bfDu2rrgsQUUDMAmYFHILNOphrIGlyzCv66V1HnZQE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=zSfry3T7e/Ewv2iAWZrfjTEqQKBEqKo5VnEy1RiQCV/DpxJpREWSFaGh+LfG/LOt4
         gSerohMHaTHilgLn1haHAiJAyFd3ZpnFwvocG04UHnypTpQdPx7F5H98i8gvELTXi3
         qVy4IwPuGocLAr7jnCZH4Jswv9q6W3mTV2ZOX4sQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 06/11] extcon: ptn5150: Simplify getting vbus-gpios with flags
Date:   Wed, 12 Aug 2020 18:29:53 +0200
Message-Id: <20200812162958.6180-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812162958.6180-1-krzk@kernel.org>
References: <20200812162958.6180-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of obtaining GPIO as input and configuring it right after to
output-low, just use proper GPIOD_OUT_LOW flag.  Code is smaller and
simpler.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 12e52ddbd77e..3b99ad41b06e 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -239,16 +239,11 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 
 	info->dev = &i2c->dev;
 	info->i2c = i2c;
-	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_IN);
+	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_OUT_LOW);
 	if (IS_ERR(info->vbus_gpiod)) {
 		dev_err(dev, "failed to get VBUS GPIO\n");
 		return PTR_ERR(info->vbus_gpiod);
 	}
-	ret = gpiod_direction_output(info->vbus_gpiod, 0);
-	if (ret) {
-		dev_err(dev, "failed to set VBUS GPIO direction\n");
-		return -EINVAL;
-	}
 
 	mutex_init(&info->mutex);
 
-- 
2.17.1

