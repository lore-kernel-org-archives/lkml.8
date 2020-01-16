Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D6BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F9A20684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ioVjQXd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406216AbgAPSXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:23:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45536 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392079AbgAPSXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so20147121wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KoOAq8OaTgDys4/VWmzArQlHil0lOieh7oG6QVZBgkY=;
        b=ioVjQXd2Qo4Z301KWJyb2Jb4Z/XHp+7OAf3tiwA7n2BAZh6kjksZU5UHCS2ZaE6v3X
         EuEJe+dXrGD+21KcePZ6guomZqc3Ctap+EF8XVLdLE21L22b5w/8i7RM6MhCrqTUz8Oi
         B5K78zMZO8byPpBgfnAtI19SupqHiRJiTlQiIEhZunqhtmXeZCqFvPfEm6nn5TM/hmSw
         HEK8cjswH6AGw3PfdmBkCS6n/a7hLf1YF5wUre+DmzzBYMPKzyfhFCJGwfaJauO1fJGc
         2kpe5gHZunPAHCzkenLlhuq2ExQDdPgpVdpfZCtooIL9bTkCTdkrPgMG8PlFO4J2BdIb
         fqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KoOAq8OaTgDys4/VWmzArQlHil0lOieh7oG6QVZBgkY=;
        b=PTiOKZOPAdVvsLiAE5rTlaYjlDfAPQDwJQf5Qc9OwGFk6tH9SNZNUsB6YuqYOMh0/v
         cjd4GiI4Hd4O2kS5QIzVi8TcSz8mwzjCDNQAlskb+PAeSz2grJg5B22g8rOEcQAvftR2
         lboDS0GCsw4CnOY0pROVD2L6BdLqNiOY9LLuYeYtywFYhRNM4CiJTRXi9KZu3YhtE59D
         wEp+zrf/9Zlck12D7x3VQq62jfzWUEqK0iUZH3v4KSK3qYBo6w4Q0cAwIMnHt9hLzjJW
         2EIjO8otnWaLBW17eRtXkz6K60/mrV9g8orkVXSLKJy39QiV7F0MNvvj/eG5d7sQY0C8
         Ie1A==
X-Gm-Message-State: APjAAAXF9vrOAIRxbFtkvobSFPujE8MygEIwnPQDyblbLe3smtsjiErC
        +OKsXlY7RLjKKJIBj4Qv/v6AhQ==
X-Google-Smtp-Source: APXvYqzzv/jX890eYDuQ6QXKZfiVQoGyGTEDAu3RSAlyWgNJVDFz+3F7dM99QEcW2Eky/avpu3f0mg==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr4580596wrn.133.1579199023357;
        Thu, 16 Jan 2020 10:23:43 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:42 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 15/17] clocksource/drivers/timer-microchip-pit64b: Fix sparse warning
Date:   Thu, 16 Jan 2020 19:23:02 +0100
Message-Id: <20200116182304.4926-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Fix sparse warning:
"warning: Using plain integer as NULL pointer"

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1578304688-14882-1-git-send-email-claudiu.beznea@microchip.com
---
 drivers/clocksource/timer-microchip-pit64b.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index 27a389a7e078..bd63d3484838 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -248,6 +248,8 @@ static int __init mchp_pit64b_init_mode(struct mchp_pit64b_timer *timer,
 	if (!pclk_rate)
 		return -EINVAL;
 
+	timer->mode = 0;
+
 	/* Try using GCLK. */
 	gclk_round = clk_round_rate(timer->gclk, max_rate);
 	if (gclk_round < 0)
@@ -360,7 +362,7 @@ static int __init mchp_pit64b_dt_init_timer(struct device_node *node,
 					    bool clkevt)
 {
 	u32 freq = clkevt ? MCHP_PIT64B_DEF_CE_FREQ : MCHP_PIT64B_DEF_CS_FREQ;
-	struct mchp_pit64b_timer timer = { 0 };
+	struct mchp_pit64b_timer timer;
 	unsigned long clk_rate;
 	u32 irq = 0;
 	int ret;
-- 
2.17.1

