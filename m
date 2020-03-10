Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1203C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F1D2469C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844159;
	bh=PeHBr6dPrD0S0NEiWd3wlD5q13RzmQoY6W7P6aRl6YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TMBSr3AnY0ysbQ8V/tRZV86Ll45TXVjR+TsMChITpZxvRok93slFgUepPCUDo8c9H
	 mEPI46RfrOxUFzMmAuVsjYu0ZuIFLlga54Xb5AvAC8lin7p4dB9THdC8QMTH1wY0sK
	 Z9PaxeRKIDhEoWwa7RbvhafC9JkOoRIuJrObVdx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCJMmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbgCJMmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:42:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9684324686;
        Tue, 10 Mar 2020 12:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844151;
        bh=PeHBr6dPrD0S0NEiWd3wlD5q13RzmQoY6W7P6aRl6YY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NH/MPFBLS8DqWyv9H75gaF0Sf8Uf/8der9YR8Ylw6+fa856wJmVQp/JA7y85BnJIs
         +VcaT5ouYPMAdf+Fh8+Lc/B7Wf0vhbUARmar08DFPuJUIDRd/szs+s++IwREjIyiQy
         ieUoL92X6CVNmtQwvjiO4EiTONrx9T2IXQmUqY/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 48/72] watchdog: da9062: do not ping the hw during stop()
Date:   Tue, 10 Mar 2020 13:39:01 +0100
Message-Id: <20200310123613.207595539@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123601.053680753@linuxfoundation.org>
References: <20200310123601.053680753@linuxfoundation.org>
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
index 7386111220d58..daeb645fcea8a 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -126,13 +126,6 @@ static int da9062_wdt_stop(struct watchdog_device *wdd)
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



