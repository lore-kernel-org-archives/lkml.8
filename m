Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD27C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A23321D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446049;
	bh=pfMglipJmW2Nk/4AvOsxQl4v5eafwLNehc1TxMDPaGc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=F/UkmMjPjgji9g1nJqMPYtETN5BSqPknwnvaTSpDIhJSoJsRlWwVLpqBvJQzpCUEF
	 yx6OJ6dargZm22NFm0HpFQDZm4jUpotuvfaa+mWScCQlGyE6C3ymy2m4siJfrVv2kt
	 zYXgot/+ucRbWiVUd+gNWBe7TWbhruLW7hO44ljA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbgFRCH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730722AbgFRBWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:22:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F67D20776;
        Thu, 18 Jun 2020 01:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443340;
        bh=pfMglipJmW2Nk/4AvOsxQl4v5eafwLNehc1TxMDPaGc=;
        h=From:To:Cc:Subject:Date:From;
        b=qyX/v+ac8KpJ65td3K8RR4iowzQffrOErhcjeLFxOOO8tARssJI5Nf8+XBB52qLTC
         QRIKw5VpJI8Cxt0Y68wRAyHqJsN5GFwqaY64Hlvd/6jMYgUxfF36PTmeHmcd7UtnpM
         aSjhgtfuAON2URgUGMhersacODOuKc9DykXdC6hA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 001/172] power: supply: bq24257_charger: Replace depends on REGMAP_I2C with select
Date:   Wed, 17 Jun 2020 21:19:27 -0400
Message-Id: <20200618012218.607130-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

[ Upstream commit 87c3d579c8ed0eaea6b1567d529a8daa85a2bc6c ]

regmap is a library function that gets selected by drivers that need
it. No driver modules should depend on it. Depending on REGMAP_I2C makes
this driver only build if another driver already selected REGMAP_I2C,
as the symbol can't be selected through the menu kernel configuration.

Fixes: 2219a935963e ("power_supply: Add TI BQ24257 charger driver")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index ff6dab0bf0dd..76c699b5abda 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -555,7 +555,7 @@ config CHARGER_BQ24257
 	tristate "TI BQ24250/24251/24257 battery charger driver"
 	depends on I2C
 	depends on GPIOLIB || COMPILE_TEST
-	depends on REGMAP_I2C
+	select REGMAP_I2C
 	help
 	  Say Y to enable support for the TI BQ24250, BQ24251, and BQ24257 battery
 	  chargers.
-- 
2.25.1

