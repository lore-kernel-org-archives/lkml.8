Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72987C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4508E20663
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946177;
	bh=Hpsh9cDCa8eylw5OZnQy4anD48i3R8tVNBdx07my5+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rR/xxDcWSNc5W1YRP7QeSVKA4ptc7uNem7oj4XN6r7DfT8DL0zsKnkQVOvhMTlUf9
	 yJBvq8YoQc8AJrG7/C8dMWMfg46meFuk7YrtoGiMVE7vObQlWuJskMnSTWB7TMgzyl
	 GiZr5+lZeks6+BodfDTpMUaHcC6AYoJ60YtTFeIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404255AbgFWVCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390619AbgFWUiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:38:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D2621531;
        Tue, 23 Jun 2020 20:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944735;
        bh=Hpsh9cDCa8eylw5OZnQy4anD48i3R8tVNBdx07my5+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6kvXktrSiehzCaRVHZKXv11UK2iyZepITXz4KGmOLwB3+tTU0KpweCT6drGC++1h
         eb8d1EAMVDAtcIyHFZP03uy7Xm5A5cFu5jz3Hr4v+GIso0mZnCWkDkdrv/NikzMlst
         KaBiKK9ao8oAXywYHSrxZCM0N5+WZ4H64G1wcc88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 105/206] watchdog: da9062: No need to ping manually before setting timeout
Date:   Tue, 23 Jun 2020 21:57:13 +0200
Message-Id: <20200623195322.108462444@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Riedmueller <s.riedmueller@phytec.de>

[ Upstream commit a0948ddba65f4f6d3cfb5e2b84685485d0452966 ]

There is actually no need to ping the watchdog before disabling it
during timeout change. Disabling the watchdog already takes care of
resetting the counter.

This fixes an issue during boot when the userspace watchdog handler takes
over and the watchdog is already running. Opening the watchdog in this case
leads to the first ping and directly after that without the required
heartbeat delay a second ping issued by the set_timeout call. Due to the
missing delay this resulted in a reset.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Link: https://lore.kernel.org/r/20200403130728.39260-3-s.riedmueller@phytec.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/da9062_wdt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 7f0a8e6352860..132d45d003ce4 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -60,11 +60,6 @@ static int da9062_wdt_update_timeout_register(struct da9062_watchdog *wdt,
 					      unsigned int regval)
 {
 	struct da9062 *chip = wdt->hw;
-	int ret;
-
-	ret = da9062_reset_watchdog_timer(wdt);
-	if (ret)
-		return ret;
 
 	regmap_update_bits(chip->regmap,
 				  DA9062AA_CONTROL_D,
-- 
2.25.1



