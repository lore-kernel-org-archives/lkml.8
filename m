Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5678CC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373672078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453461;
	bh=HmqM7R3r2SqMGJttHaUpwqTq3zLTi/LuDmgVEImBqN0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SIUTMtu/iWu8YnOaIfXGVoe0GSZmQEfKmg2Vu+2+NtVNZcde2Xo2RlJsEE/FvGCGd
	 57Cqd7iXDpzpYiIXiz1NFSttzgHbEB5VPcPxztDm7WkobIvxsxBx31FRsvZiaTojif
	 i0JFLqoLZNkid2Poh/RfCOtp0jkURaUTXLgZtimg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgHZOuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbgHZOuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:50:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 582732078D;
        Wed, 26 Aug 2020 14:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453419;
        bh=HmqM7R3r2SqMGJttHaUpwqTq3zLTi/LuDmgVEImBqN0=;
        h=From:To:Cc:Subject:Date:From;
        b=hoYgeJw+MKxcZ21NRRGgN4SgmK+Qzc9G3xiLTMkOdVGX1Vrc1GFDQoNPqjDO9Ia2E
         G9yxmL8JE2Ni43mBwN5kxebmcdQYDpe+iwO8gEAIsbC0lXId/Pem5hYlbo0RmOoh72
         x/37RoL+6H4n1QuQwLcn7EqhA34LZslgxUI0G1x4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/4] leds: lm3692x: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:50:10 +0200
Message-Id: <20200826145013.10230-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/leds-lm3692x.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index e1e2d2b64a56..1d7ea1b76a12 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -394,13 +394,10 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
 	led->regulator = devm_regulator_get_optional(&led->client->dev, "vled");
 	if (IS_ERR(led->regulator)) {
 		ret = PTR_ERR(led->regulator);
-		if (ret != -ENODEV) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&led->client->dev,
-					"Failed to get vled regulator: %d\n",
-					ret);
-			return ret;
-		}
+		if (ret != -ENODEV)
+			return dev_err_probe(&led->client->dev, ret,
+					     "Failed to get vled regulator\n");
+
 		led->regulator = NULL;
 	}
 
-- 
2.17.1

