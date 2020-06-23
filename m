Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A794DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9A220663
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946486;
	bh=DFXdzRhTHdHmCzFNW8bTdI0LuNeygZEnaF7Q50vLFUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VTD4dOvKJRjOSmbj6N7RpinrCd7pZZ1Z8Bsnr0WRVXWI59+V+eUlPMtz6Q1di2sRH
	 yv8kWxKcAycGnJaxetxTGpip8jTL3J1813gxaMrpF+cMXHISWyEdE37J5bd4XoqZ0X
	 aEx00APf9mf2JNu4y2tZzy2BtECMVVIGobqjvC8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391119AbgFWUe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403805AbgFWUeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:34:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE052206C3;
        Tue, 23 Jun 2020 20:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944486;
        bh=DFXdzRhTHdHmCzFNW8bTdI0LuNeygZEnaF7Q50vLFUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=joNaeOP3ZpX7yjkIVIyZJIbBouyyrx39JHRa/yzhxEWEGuf0DR0VtaO90bSuJvsNm
         7kEvO97T43rMs5uHimY3z61833bPQ5yxLRb9qTDgbGrS1/p6UAIPiQ1kV/i+UU4g99
         oTSnwJToMlRuGQ/HTsi/liMFlSXvbERXFbkYabhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 001/206] power: supply: bq24257_charger: Replace depends on REGMAP_I2C with select
Date:   Tue, 23 Jun 2020 21:55:29 +0200
Message-Id: <20200623195316.956736740@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index ff6dab0bf0ddc..76c699b5abdac 100644
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



