Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A3BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7236E22B40
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MqR5dmPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgGWP1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgGWP1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:27:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7800DC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:04 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so5561420wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0JbtEzkpaP5eGicuhoxIx9QkzOY7wkk6qcai0tP1vY=;
        b=MqR5dmPJKZt5Lk2FpnBD7WSKUc64KVMlhC8TpRuuc1fCQVK+ljTQjWIpP4o/fpD4xf
         g2QN937wYa9dtz2D23TXK5UXLLgxEcUIhiiF9D8+R2QonAWwNa1YErbAM9LbX4uoVBd5
         bknzhLQfmWzQ+zM3iTrrBEQzlbZQjVa9f2Hhh3zN1r2PoGLM2qnRPlzGhkEJbZDnJukr
         CT4b6VRCt5Xjp1KwcFnxxLRDZqnGOaw2Bew9S9KMK8vrpe5gpDfpFq4EFIRal4MK6VDs
         cM2lmE5zK9LVDyWZJQRqQg/M+MoXpLnkdqy110RE/WpQXgfxIv2z8hV4l/D+OG8625Wm
         BbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0JbtEzkpaP5eGicuhoxIx9QkzOY7wkk6qcai0tP1vY=;
        b=MG3lDFJRnl/Nhnrz1NnXr90NR0B7pJrM04TSCqbmBg8HiufHUh/PKJGDgzuYhXZUEf
         GsKr6ccc8g1QbeEXJXNUDDrhUvL/VmmvGAEJzC1OVJJSttbuzIHwDTKXhkY5RVjPbMMa
         PZdWa1EFlL077HGCv1M5SgONroi1cNkJ+uLn9xZmnqRKJm2iGCDfu8bjFVk6s3IMAzMt
         +HCvz9bQ41asVuC/gsMA8vzKMt6iSxOaH/pEwxMKlRO7aXJ4TSdbuDliDa9GbOfrzWtz
         JEtLDAE0W4LzYaDuM7ZLTag+nDeAvxSsULSVx6wD+qerAQBm2oSk1B3+H17T1rL4TLDl
         u0Xg==
X-Gm-Message-State: AOAM533xeXWaWHS8zQdOSG+O4OCGwOpRn5FIZn7SCR3D1TrgJZotrhju
        1ifmqb6rIE5oViEvaeFqZXWsmQ==
X-Google-Smtp-Source: ABdhPJyqC+WdoaOrO38I8UGAoEbMymegflGpb1WsDygxY9WWLT9NW89KSD0qTRB+yk+7qRMD5LCbZw==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr4373612wrv.86.1595518023106;
        Thu, 23 Jul 2020 08:27:03 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:27:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support)
Subject: [PATCH 08/16] clocksource/drivers/timer-atmel-tcb: Allow selecting first divider
Date:   Thu, 23 Jul 2020 17:26:28 +0200
Message-Id: <20200723152639.639771-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723152639.639771-1-daniel.lezcano@linaro.org>
References: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
 <20200723152639.639771-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

The divider selection algorithm never allowed to get index 0. It was also
continuing to look for dividers, trying to find the slow clock selection.
This is not necessary anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-9-alexandre.belloni@bootlin.com
---
 drivers/clocksource/timer-atmel-tcb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 7a6474acc774..7fea134650fc 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -432,10 +432,8 @@ static int __init tcb_clksrc_init(struct device_node *node)
 
 		tmp = rate / divisor;
 		pr_debug("TC: %u / %-3u [%d] --> %u\n", rate, divisor, i, tmp);
-		if (best_divisor_idx > 0) {
-			if (tmp < 5 * 1000 * 1000)
-				continue;
-		}
+		if ((best_divisor_idx >= 0) && (tmp < 5 * 1000 * 1000))
+			break;
 		divided_rate = tmp;
 		best_divisor_idx = i;
 	}
-- 
2.25.1

