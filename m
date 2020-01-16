Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C23C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B093424767
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196662;
	bh=iIaMfE0eCNktgZoozG23i7g4jsF5SYY3Xf5XpHger3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E5e/8RwLstTpScIs4PjFJ23lvMPN3lbfvIonA2B1RQrvP4De3Bwe+JmKWBL0A8Vqi
	 JbzOhsVP1lqsHgJTL1Tutq6IXD/mYIJoYutzwS7juzI2bReOqLGuChQys2OFIwfywE
	 Kp4E5k6p+K6sRnv9CbxVKsZAMWiS8mHb+MeQ584s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394132AbgAPRoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:44:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405805AbgAPRoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:44:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7686E24741;
        Thu, 16 Jan 2020 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196640;
        bh=iIaMfE0eCNktgZoozG23i7g4jsF5SYY3Xf5XpHger3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKxNNt5PL4JGnR2EcBs73IVTlp3TeDf3v6sNBdvrf0b6Tlvw8nW9TtSq4mSoO3YSc
         3peb1LCkSA4M30qcFJ7ToN9T2yfGOCX6jE07P/Xo7TQ+e5u4eRObYu1W42qj7FFVMN
         NfN1kZK8bSEd4z6mk/24NDLlYhaeV2nnrV8MhfKE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 052/174] clocksource/drivers/sun5i: Fail gracefully when clock rate is unavailable
Date:   Thu, 16 Jan 2020 12:40:49 -0500
Message-Id: <20200116174251.24326-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit e7e7e0d7beafebd11b0c065cd5fbc1e5759c5aab ]

If the clock tree is not fully populated when the timer-sun5i init code
is called, attempts to get the clock rate for the timer would fail and
return 0.

Make the init code for both clock events and clocksource check the
returned clock rate and fail gracefully if the result is 0, instead of
causing a divide by 0 exception later on.

Fixes: 4a59058f0b09 ("clocksource/drivers/sun5i: Refactor the current code")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-sun5i.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index bca9573e036a..32b2dab69fd7 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -201,6 +201,11 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
 	}
 
 	rate = clk_get_rate(clk);
+	if (!rate) {
+		pr_err("Couldn't get parent clock rate\n");
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
 
 	cs->timer.base = base;
 	cs->timer.clk = clk;
@@ -274,6 +279,11 @@ static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem
 	}
 
 	rate = clk_get_rate(clk);
+	if (!rate) {
+		pr_err("Couldn't get parent clock rate\n");
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
 
 	ce->timer.base = base;
 	ce->timer.ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
-- 
2.20.1

