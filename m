Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C1EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8C82076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597249840;
	bh=bsQ15/usVZgLip99G+grCHhURaw6dBoohf5jYJRGiT0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tkqB5G5oCYOttFzahp+ON+uQ6l9T0NXO9GK2g6uRxW4CXcaIG5zaaEFtrssM+yASn
	 /t6ICMeh4eYygolOD/3XHx7zXZRBwMOy5Oy6lOtG5poLVEUlOz09dtbHOt8F/241cl
	 3KeTTGK4XI0eguehsPUnHxp5SsjmVfMXZnPDV4lo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHLQai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgHLQaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:30:23 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B36DB20771;
        Wed, 12 Aug 2020 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597249822;
        bh=bsQ15/usVZgLip99G+grCHhURaw6dBoohf5jYJRGiT0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tdYgQ5rDpTlLFIAq87wqjfr0pJWq/30I+UE9wPTaV5uTKswwQFFUSgZqWDTPq8+rr
         yi6YuZTUw20v0FUwpsq/bGGmimbi42IpY/2B7tVfBZ9uyektwEBpO3u7J8sQ9VqQyp
         hOV39uKtILK45i39Trpyy1NfMs3E7OvdeQGd0Sjc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 09/11] extcon: ptn5150: Make 'vbus-gpios' optional
Date:   Wed, 12 Aug 2020 18:29:56 +0200
Message-Id: <20200812162958.6180-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812162958.6180-1-krzk@kernel.org>
References: <20200812162958.6180-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PTN5150 chip can be used in hardware designs with only reporting of
USB Type-C connection, without the VBUS control.  The driver however
unconditionally expected 'vbus-gpios'.

Since all uses of the VBUS GPIO descriptor are NULL safe, the code can
accept missing GPIO and provide only extcon status reporting.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index bbb185378e4b..9daf45118ffd 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -239,8 +239,14 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 	info->i2c = i2c;
 	info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_OUT_LOW);
 	if (IS_ERR(info->vbus_gpiod)) {
-		dev_err(dev, "failed to get VBUS GPIO\n");
-		return PTR_ERR(info->vbus_gpiod);
+		ret = PTR_ERR(info->vbus_gpiod);
+		if (ret == -ENOENT) {
+			dev_info(dev, "No VBUS GPIO, ignoring VBUS control\n");
+			info->vbus_gpiod = NULL;
+		} else {
+			dev_err(dev, "failed to get VBUS GPIO\n");
+			return ret;
+		}
 	}
 
 	mutex_init(&info->mutex);
-- 
2.17.1

