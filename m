Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC71AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899C9214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197886;
	bh=2cz7rdrQ0iVoEAqo7Qg7xczrfHpYE2OTUaaqrwLkRrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vll/XUqReBCImOtCtmBgDwLexTtPt+NOtdRmEwqLB8Gsuh0P/kXm2hz4GwfiMatoP
	 nL4pjuqed5YXTeiqg+MQZeMuMfXocWc0tTqET6S89tZpluPi3RvWsikWQsKulOYjbz
	 HoBkzF7nE8lIbAUvgQvdd78QT0Suhvw9A8UbwFlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406454AbgAPSEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:04:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390445AbgAPRkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:40:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A17AA2471C;
        Thu, 16 Jan 2020 17:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196420;
        bh=2cz7rdrQ0iVoEAqo7Qg7xczrfHpYE2OTUaaqrwLkRrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2049zDoSrBIZrHGF3wDVVu52CMeXVp0d/GsY/fSUg/WRLgmDsMVExoG2DCL6HaEX
         db7gAl1V959zPg7YOmDZVg4Uc8wyKuhAlNovmPGKheYlmgQGYYeP9Ag51Lho5AAmkH
         fUXLNENg3B4lhxCi46MlSZA2VoCuqTMVZa9xH2ww=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Iker Perez del Palomar Sustatxa 
        <iker.perez@codethink.co.uk>, Sasha Levin <sashal@kernel.org>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 190/251] hwmon: (lm75) Fix write operations for negative temperatures
Date:   Thu, 16 Jan 2020 12:35:39 -0500
Message-Id: <20200116173641.22137-150-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 7d82fcc9d9e81241778aaa22fda7be753e237d86 ]

Writes into limit registers fail if the temperature written is negative.
The regmap write operation checks the value range, regmap_write accepts
an unsigned int as parameter, and the temperature value passed to
regmap_write is kept in a variable declared as long. Negative values
are converted large unsigned integers, which fails the range check.
Fix by type casting the temperature to u16 when calling regmap_write().

Cc: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>
Fixes: e65365fed87f ("hwmon: (lm75) Convert to use regmap")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/lm75.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index eff3b24d8473..fc31669a86ba 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -164,7 +164,7 @@ static int lm75_write(struct device *dev, enum hwmon_sensor_types type,
 	temp = DIV_ROUND_CLOSEST(temp  << (resolution - 8),
 				 1000) << (16 - resolution);
 
-	return regmap_write(data->regmap, reg, temp);
+	return regmap_write(data->regmap, reg, (u16)temp);
 }
 
 static umode_t lm75_is_visible(const void *data, enum hwmon_sensor_types type,
-- 
2.20.1

