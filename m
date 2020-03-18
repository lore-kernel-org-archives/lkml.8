Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBEBC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2471120757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tqr5awGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCRRnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:43:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50272 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCRRmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id z13so4456554wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SdyZ/iE1KuzKCZWd0UKsOK5F1hQIou+7IXJbWcjGLjU=;
        b=Tqr5awGLn/cvttCrMJ+rBzEmAKJiZ1bdhuqiXYXJzLZ4VYpj9b4luhpO1R5hquY3Nd
         XDB/KmGOjMUeB8emgkdv275ut8/fxhOII9ixOmXngHYoQ6FyvQGdLncAMI7LmMCLiK9C
         mRvIz6l+slrzfHPeJRzcwShtyGx3GILFkkalQvYSEWIlHa3M4aS/jBwsULuU3Eik9d94
         8WtDVocZrrOFW5vybSJ3xm8Qp3A3i9+oIZmzkE4nfhIGaid/xYFpF11cVR+d6qP3K/b9
         lsS0tEVvltekLgJB3WNueomouqcdb8cu56pCPfbnlMi1awb26VY1yld7Ww6hi0k025lF
         TF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SdyZ/iE1KuzKCZWd0UKsOK5F1hQIou+7IXJbWcjGLjU=;
        b=SaC8P3r7KkhN6V/18h7L8n/5Dq5Q7QT4tP85xpHqNsFURrydSHmPXbnDvlQ8vkDSm3
         WvZwO35Ng2a6F/85jBEu7AlYOL5DGHR9Bbdd8RT0pCYQ2wZdj5ObPGoYBvebpWPF8j5q
         pXJy5Ni+0RMp3v4xCqQSvo+oAcbZ8WfljRo8oWPLl2TxYJ5Zf4A/b90RQqfouL+swwjQ
         3ySR6AsXcU8UaMQds9xBWTYJ5xgdbBRo3QNKxoySr0JKx1R1KBKWhAkvfmvoZfPsOXQz
         tiJH6UcES3wcdUxWXKiJpCOta5oBsPPDovi11MhjtbzotXuuRoEtv+Ms2Q1ShSkPjYmD
         bs6g==
X-Gm-Message-State: ANhLgQ2PoIBXxzGd3RSjEh5L3RQwfS2uPiP9ANlf68j/DsvJNw7eHusv
        CaKFkUoAv4SaIrgpPQSxSr3I9g==
X-Google-Smtp-Source: ADFU+vsrcvs9OL0q0l1ZCsKFMY3BVvxBTTa8NhDzokqDTVCQUbDL3NOJCobtj5llTttmrSLWfWsCWA==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr6273526wmk.172.1584553366463;
        Wed, 18 Mar 2020 10:42:46 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 12/21] clocksource/drivers/timer-microchip-pit64b: Fix rate for gck
Date:   Wed, 18 Mar 2020 18:41:22 +0100
Message-Id: <20200318174131.20582-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Generic clock rate needs to be set in case it was selected as timer clock
source in mchp_pit64b_init_mode(). Otherwise it will be enabled with wrong
rate.

Fixes: 625022a5f160 ("clocksource/drivers/timer-microchip-pit64b: Add Microchip PIT64B support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1584352376-32585-1-git-send-email-claudiu.beznea@microchip.com
---
 drivers/clocksource/timer-microchip-pit64b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index bd63d3484838..59e11ca8ee73 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -264,6 +264,7 @@ static int __init mchp_pit64b_init_mode(struct mchp_pit64b_timer *timer,
 
 	if (!best_diff) {
 		timer->mode |= MCHP_PIT64B_MR_SGCLK;
+		clk_set_rate(timer->gclk, gclk_round);
 		goto done;
 	}
 
-- 
2.17.1

