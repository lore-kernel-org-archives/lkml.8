Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A178C3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC59422314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696523;
	bh=zAa2uEgQbd2JoS7G+0gTzPTd/qwhQJyo3d9rW0gWzZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SJRX2A3rfZoQVrMgQyZpnEqmxQ0y6Y+6sEcjHTL5JAlexx/X4QsthbutF5TjJ2KZv
	 35fZCodu61b41mCJp1pyAoNYy+l4CvF+UCELv6mui8nM7wgDWQpYpna9v4yMNSv+Q0
	 akBLh2Jbz+k00qIMyldI5Xg7ivHYvGySUWiZ7QpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389856AbgBNQIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390826AbgBNQIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:08:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CEF124676;
        Fri, 14 Feb 2020 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696479;
        bh=zAa2uEgQbd2JoS7G+0gTzPTd/qwhQJyo3d9rW0gWzZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rmhx07QPbs4PBL3IlJvtuxWst8d6JeVonf0VSCxeW4BAB0fZFU3OwN8QRsR1UkCkQ
         vcVZBYOxo5eXscYEAyoNyYUpcLda6pyLmp9TEAIAjerbpR5sB6QNHn9M+EZBrwipY0
         d0CrtZVZ0Ixo4IIB4Bi8qTTgfAMBXZd75ggJ2BDA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 287/459] clocksource: davinci: only enable clockevents once tim34 is initialized
Date:   Fri, 14 Feb 2020 10:58:57 -0500
Message-Id: <20200214160149.11681-287-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

[ Upstream commit cea931c25104e6bddc42eb067f58193f355dbdd7 ]

The DM365 platform has a strange quirk (only present when using ancient
u-boot - mainline u-boot v2013.01 and later works fine) where if we
enable the second half of the timer in periodic mode before we do its
initialization - the time won't start flowing and we can't boot.

When using more recent u-boot, we can enable the timer, then reinitialize
it and all works fine.

To work around this issue only enable clockevents once tim34 is
initialized i.e. move clockevents_config_and_register() below tim34
initialization.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-davinci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index 62745c9620498..e421946a91c5a 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -302,10 +302,6 @@ int __init davinci_timer_register(struct clk *clk,
 		return rv;
 	}
 
-	clockevents_config_and_register(&clockevent->dev, tick_rate,
-					DAVINCI_TIMER_MIN_DELTA,
-					DAVINCI_TIMER_MAX_DELTA);
-
 	davinci_clocksource.dev.rating = 300;
 	davinci_clocksource.dev.read = davinci_clocksource_read;
 	davinci_clocksource.dev.mask =
@@ -323,6 +319,10 @@ int __init davinci_timer_register(struct clk *clk,
 		davinci_clocksource_init_tim34(base);
 	}
 
+	clockevents_config_and_register(&clockevent->dev, tick_rate,
+					DAVINCI_TIMER_MIN_DELTA,
+					DAVINCI_TIMER_MAX_DELTA);
+
 	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
 	if (rv) {
 		pr_err("Unable to register clocksource");
-- 
2.20.1

