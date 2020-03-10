Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194AFC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E572467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845142;
	bh=YD7v9zrFJtvaLsNrF546RSRmnm4uFXbq0n+c7ihwoqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kBONzubtxhc93hpqUqKRMCkdr/RhQDMV5sbkFkhZJuy/xuHkLJ/60ZjZcxjDTfVWL
	 Bd/s8u7gvgn6OxGLQCg03X0TshcRmTwQmFQ/go3mNU6MrMuY0tw2KknKJjhTF7i9sO
	 YvqPRbNKxL9DP0AVB1gltICySr2Qv6CeMbAoR/u0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgCJM7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729778AbgCJM65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:58:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6323B24693;
        Tue, 10 Mar 2020 12:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845136;
        bh=YD7v9zrFJtvaLsNrF546RSRmnm4uFXbq0n+c7ihwoqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aODiY3UxsEB0yEJ0fSHhl7AjWB+wL0eqHLvJK2BcFkmJSnsr33Wfyqj3UCUIXLA+C
         myQLrDN2gPWQGaO7MVuqg6qhWysUOaAsXgRt0BlQHMqk+eg5YuJBuoduR3Cfw+Bkc5
         Ozz0MriSRpT0yx5rLkSf0AoVj/uyuMjugtNl1O+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 037/189] watchdog: da9062: do not ping the hw during stop()
Date:   Tue, 10 Mar 2020 13:37:54 +0100
Message-Id: <20200310123643.238541097@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit e9a0e65eda3f78d0b04ec6136c591c000cbc3b76 ]

The da9062 hw has a minimum ping cool down phase of at least 200ms. The
driver takes that into account by setting the min_hw_heartbeat_ms to
300ms and the core guarantees that the hw limit is observed for the
ping() calls. But the core can't guarantee the required minimum ping
cool down phase if a stop() command is send immediately after the ping()
command. So it is not allowed to ping the watchdog within the stop()
command as the driver does. Remove the ping can be done without doubts
because the watchdog gets disabled anyway and a (re)start resets the
watchdog counter too.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20200120091729.16256-1-m.felsch@pengutronix.de
[groeck: Updated description]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/da9062_wdt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index e149e66a6ea9f..e92f38fcb7a4a 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -94,13 +94,6 @@ static int da9062_wdt_stop(struct watchdog_device *wdd)
 	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
 	int ret;
 
-	ret = da9062_reset_watchdog_timer(wdt);
-	if (ret) {
-		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err = %d)\n",
-			ret);
-		return ret;
-	}
-
 	ret = regmap_update_bits(wdt->hw->regmap,
 				 DA9062AA_CONTROL_D,
 				 DA9062AA_TWDSCALE_MASK,
-- 
2.20.1



