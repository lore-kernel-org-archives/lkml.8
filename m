Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE689C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D382177B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453520;
	bh=tntjrE3W6ey1gnNn/IdbM92+VGhVTc834lTJ3ifNujs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OtpdFSv635zHmsU2UCW3jZ8Yi4WuJjlM4RwghPiCQCfNcRlAxBWEo5lpkWu4ciYpa
	 5FEagE4Ok0OtLTh4e6TTBnpxZk3hP2jg7Xa9T5H9kdq/FGKa/szoF2e3uqcH0+m1dv
	 T5shg5GILttYbTHvRSoLuehqTL7YTAc6CfyEwfqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHZOv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgHZOtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:49:15 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5259C22B47;
        Wed, 26 Aug 2020 14:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453354;
        bh=tntjrE3W6ey1gnNn/IdbM92+VGhVTc834lTJ3ifNujs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0DN4mAPsmz70MyK35VeOlHz8N424f2PxfrhWSox2+s62UMnLuGHg+ghFN1mFBaKJp
         j+y3d+x6ckYIkwByeLURJbwiKJKXE9tEVvUifew2ReF+NMjaBdxdsgmfbkrH2npvCe
         1EQfkF6O4OeTpbsh0aJ8v4LmlKf4erNp0KkU2Eio=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/5] power: supply: ingenic: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:48:57 +0200
Message-Id: <20200826144858.9584-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826144858.9584-1-krzk@kernel.org>
References: <20200826144858.9584-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/ingenic-battery.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index dd3d93dfe3eb..32dc77fd9a95 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -147,11 +147,9 @@ static int ingenic_battery_probe(struct platform_device *pdev)
 	psy_cfg.of_node = dev->of_node;
 
 	bat->battery = devm_power_supply_register(dev, desc, &psy_cfg);
-	if (IS_ERR(bat->battery)) {
-		if (PTR_ERR(bat->battery) != -EPROBE_DEFER)
-			dev_err(dev, "Unable to register battery\n");
-		return PTR_ERR(bat->battery);
-	}
+	if (IS_ERR(bat->battery))
+		return dev_err_probe(dev, PTR_ERR(bat->battery),
+				     "Unable to register battery\n");
 
 	ret = power_supply_get_battery_info(bat->battery, &bat->info);
 	if (ret) {
-- 
2.17.1

