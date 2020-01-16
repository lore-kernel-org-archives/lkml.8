Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0074C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8107320684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198654;
	bh=ph0/DmkLrU2MxmllNz6y/Cami81wqHmTZ91zEKci1+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YOBQwCM70K3WtYhIIvtvRSb7V7XKedjyAjN1k4SmpcDGJnuDth2tpNOM/P0MBhzo4
	 SbqHAvG1vijyz6eXQPo2vR3vJA0hW5YwHKmpT6kEvpPfLiCKgIoFkF8AAjCJMIeorA
	 91SCSP7UvFwegJjGfDShEHivBHt3tiepLKMv9HzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392853AbgAPSRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404275AbgAPR3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:29:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38E03246E3;
        Thu, 16 Jan 2020 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195746;
        bh=ph0/DmkLrU2MxmllNz6y/Cami81wqHmTZ91zEKci1+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRQnPVoLtvxtuLHOwGKMPcn53uhsSWbKomz1MwSbROxSY4cDUYhnYwgAMNUGGYL8Y
         BE7QD6S0Tr3ijymNHJmL2dOi4/O2NSAD18k0qR/Lg9x324WDZ215cb20IVVicr36fL
         Kfvt5deD9kitIBIDWVCUDIdPwMZOlajV3gof8poY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Iker Perez del Palomar Sustatxa 
        <iker.perez@codethink.co.uk>, Sasha Levin <sashal@kernel.org>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 280/371] hwmon: (lm75) Fix write operations for negative temperatures
Date:   Thu, 16 Jan 2020 12:22:32 -0500
Message-Id: <20200116172403.18149-223-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
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
index 005ffb5ffa92..1737bb5fbaaf 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -165,7 +165,7 @@ static int lm75_write(struct device *dev, enum hwmon_sensor_types type,
 	temp = DIV_ROUND_CLOSEST(temp  << (resolution - 8),
 				 1000) << (16 - resolution);
 
-	return regmap_write(data->regmap, reg, temp);
+	return regmap_write(data->regmap, reg, (u16)temp);
 }
 
 static umode_t lm75_is_visible(const void *data, enum hwmon_sensor_types type,
-- 
2.20.1

