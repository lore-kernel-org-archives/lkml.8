Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A916DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788352078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453454;
	bh=hYmpse77FeS+EBcR36wkPeggezQprfRAztxgJRbgDMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PI7fyoOoO/Rv4JALHr7SDNHC2Jm+gqxorLF7DayOec8V9NI9xoEm/20RCCyeCl2GP
	 E0CQdtpwXC1wSxenaxBslRd1dKHZcOItGsIHBD+xm3QLVhh3Y4ZUYrxtzCbKJuiUrp
	 +R/FFqVDQKdhskD0r5XPMBR7BYIfCuE13KSOVOjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgHZOux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgHZOuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:50:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 618632177B;
        Wed, 26 Aug 2020 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453424;
        bh=hYmpse77FeS+EBcR36wkPeggezQprfRAztxgJRbgDMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cUPEd8i8eChq/x6xaKepI7J9w3XFS28759FRErtadof6D0/HjChrNSu7dSN86jmmx
         cC9vL8wEP5WM1vQfBiDKcLPAzysg5CYOXS6swEcubXV4JVHOxE90dThA9CoLnp8ugS
         JniYwYNzlHHW6vxhOhGENmwhW5DEcNQGIotDaiFo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/4] leds: tlc591xx: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:50:13 +0200
Message-Id: <20200826145013.10230-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826145013.10230-1-krzk@kernel.org>
References: <20200826145013.10230-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/leds-tlc591xx.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/leds-tlc591xx.c b/drivers/leds/leds-tlc591xx.c
index 0929f1275814..1dc14051639c 100644
--- a/drivers/leds/leds-tlc591xx.c
+++ b/drivers/leds/leds-tlc591xx.c
@@ -213,12 +213,10 @@ tlc591xx_probe(struct i2c_client *client,
 		led->ldev.max_brightness = TLC591XX_MAX_BRIGHTNESS;
 		err = devm_led_classdev_register_ext(dev, &led->ldev,
 						     &init_data);
-		if (err < 0) {
-			if (err != -EPROBE_DEFER)
-				dev_err(dev, "couldn't register LED %s\n",
-					led->ldev.name);
-			return err;
-		}
+		if (err < 0)
+			return dev_err_probe(dev, err,
+					     "couldn't register LED %s\n",
+					     led->ldev.name);
 	}
 	return 0;
 }
-- 
2.17.1

