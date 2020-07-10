Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8150FC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C782207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFVDGDmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgGJNwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgGJNwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:52:00 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377A0C08E806
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:52:00 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m9so2567204qvx.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Hf2EQhK7szwaDYevZJPMqkaBsz8dSW+eokQabw43h0=;
        b=OFVDGDmDk2rsL22Q4OLH5sVL2ZMmlniVU/Ydrcah/Q7eV5oVyW+i2owNIXJhdUgzu4
         oJL8XGEIhQIMoMQKKk24I/CCznLtco1zHe/7pSq0RjsXKN7TUI3dW8OEs7hGHrHaE0w2
         gk4mkcdbZGQHm3gd8DYfTS3DKBkKfQuhlLQm3W3tAmhQ81D4Szi55btLM8eufONuYmBB
         Hc3g972A2kAj/pbdHNI06mO7dqcLMtyMo5MMFDwcMyYrghUJvMDovI2b200HTnqv/aPJ
         pj7VCHr2BRDkIQUVek+yXbOzYf8eUdWVo3SDjYkgjCuv/kLO1R5doaaaqyFYovc0wxYz
         ZtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Hf2EQhK7szwaDYevZJPMqkaBsz8dSW+eokQabw43h0=;
        b=jQxbgEvE2ZBfgmUPam+X8/5MefMutWQfAE06P+tXhw7zA00VyrkietV/4D3tPrM7HK
         SlBBgltHaBU82MVqYVB2QjlCdAwdLYC9FMAtkZVupRy9dZy2hREJGfbeIynhPmN0g0AG
         oMeEWrWN1F4ihRxL6lJmZ2jQ8UpUjjUVc2gVA2fh2XhBHMINJJMTeAn9i+QCMOmp3sQE
         NzlEOF+/MCd9rIDOIQHj/S5ErymlX2ldjO3gra5fPfFLs0HfWDi+UFPBJ3onsth6uw0J
         dw5PEv3YOxlyFB+iGyon9SizRnFdANZ0X0L9HYIeR68M8P4SY7AI1H6lGvB12z2C4xZ1
         d1/A==
X-Gm-Message-State: AOAM532Q6A2ACmi7aCG+ueSq21dB0uKotbwQJVbWHl1a+XffJQgdCR/D
        XMZXdfAmL4nZW+TkBSlaEIEH/A==
X-Google-Smtp-Source: ABdhPJyT7tn4WEZFeacs3EYP5s7Vp7u4rKrWmDOwEG+adxnG7MuVKgK6qtBxsQbVh5TyHGVe6O87UQ==
X-Received: by 2002:ad4:504a:: with SMTP id m10mr55427983qvq.172.1594389119450;
        Fri, 10 Jul 2020 06:51:59 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id h197sm7574059qke.51.2020.07.10.06.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:51:58 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] thermal:core:Add genetlink notifications for monitoring falling temperature
Date:   Fri, 10 Jul 2020 09:51:53 -0400
Message-Id: <20200710135154.181454-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710135154.181454-1-thara.gopinath@linaro.org>
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add notification calls for trip type THERMAL_TRIP_COLD when temperature
crosses the trip point in either direction.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/thermal_core.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 750a89f0c20a..e2302ca1cd3b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -429,12 +429,21 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 		tz->ops->get_trip_hyst(tz, trip, &hyst);
 
 	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
-		if (tz->last_temperature < trip_temp &&
-		    tz->temperature >= trip_temp)
-			thermal_notify_tz_trip_up(tz->id, trip);
-		if (tz->last_temperature >= trip_temp &&
-		    tz->temperature < (trip_temp - hyst))
-			thermal_notify_tz_trip_down(tz->id, trip);
+		if (type == THERMAL_TRIP_COLD) {
+			if (tz->last_temperature > trip_temp &&
+			    tz->temperature <= trip_temp)
+				thermal_notify_tz_trip_down(tz->id, trip);
+			if (tz->last_temperature <= trip_temp &&
+			    tz->temperature > (trip_temp + hyst))
+				thermal_notify_tz_trip_up(tz->id, trip);
+		} else {
+			if (tz->last_temperature < trip_temp &&
+			    tz->temperature >= trip_temp)
+				thermal_notify_tz_trip_up(tz->id, trip);
+			if (tz->last_temperature >= trip_temp &&
+			    tz->temperature < (trip_temp - hyst))
+				thermal_notify_tz_trip_down(tz->id, trip);
+		}
 	}
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
-- 
2.25.1

