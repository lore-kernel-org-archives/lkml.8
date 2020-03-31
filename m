Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C29FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2205620784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJM0mi4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbgCaQ5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:57:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35573 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbgCaQ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:57:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id d5so27015015wrn.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cz8xjE9Meo7Y9lv5v8WZEBAwtkX0wnP43U65mZU6QGQ=;
        b=OJM0mi4I6J/aMEdCBdjcIDizEzs+VnS3yRZWeGD3RtLISVRjA1bzbiw8Mn+0nUTWOi
         P1ivQY+Ans0f9uRjG2yybRu1wiuZi02uCKNFt+iSjcZEHoaT6wkeKgVUmFQDqkh0qx+u
         9/gSDwf+dbzJHUjKpm8FBlm2S3qn3hfmTMox9qYBVwEp/pHAo4Kb3iWi1DErHd0PUUXx
         C7lCUZ56BTIJjU2lbV1GuqomutLeN7AGBbvULYbGVbpD5vhfbGCTUsbLrq5rEYaJvbmP
         93cVCGOf0+Yz20qqCcnlVdLqWGOdsGDzmKoKH47z1Z7PjWdWEO1TIfDSYR05ckXzfiZ6
         COUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cz8xjE9Meo7Y9lv5v8WZEBAwtkX0wnP43U65mZU6QGQ=;
        b=bAbF6C8vVm7dijNLNBwi2B2TFCEaAytRBQuRIzIP2Fhw9Yxbyz71EzViGoELo13OM9
         kJzXkr0ueIV8oMev1urqwbJWU29AuJx8FXBF/lJDsxTI3J6KpCpV7hRzLVba6M6k72Ca
         ooXZsvOnKZx/7iV/i8nYrpSmACt15F0kpRCp5rwS9KD/59MGgjczg+9U4Fmy/6jqMGGU
         4+bqV0kNQcQlrIO48DDNokGHV8A40erG5rOZKW7Rl5ichyiM1x1UvSeP6pYypSDwGHRF
         VcZtYgZN9Y2NCkPuzFi9O4mPxesavEnV1nLUmHC5sVQELsmavZOQWMoXWh89OwNaodQB
         C9qQ==
X-Gm-Message-State: ANhLgQ3DmHrleOzvvIC+tSnk67iYMjokGffrYCvG2QAdTNUfA1o9T8Ao
        iEkLQ8eytoMBAEIQntgsU1IwUQ==
X-Google-Smtp-Source: ADFU+vvXiktfnwinTBCN1IXFntzXTv3dPIXsn1xyesH3/byDXAmun4de70WWyrEu9DquRBiG6T4Xcg==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr22794927wrv.363.1585673821341;
        Tue, 31 Mar 2020 09:57:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:497e:e6a9:b3eb:fcac])
        by smtp.gmail.com with ESMTPSA id d7sm12925648wrr.77.2020.03.31.09.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 09:57:00 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] thermal: core: Remove pointless debug traces
Date:   Tue, 31 Mar 2020 18:54:49 +0200
Message-Id: <20200331165449.30355-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331165449.30355-1-daniel.lezcano@linaro.org>
References: <20200331165449.30355-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last temperature and the current temperature are show via a
dev_debug. The line before, those temperature are also traced.

It is pointless to duplicate the traces for the temperatures,
remove the dev_dbg traces.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9a321dc548c8..c06550930979 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -447,12 +447,6 @@ static void update_temperature(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 
 	trace_thermal_temperature(tz);
-	if (tz->last_temperature == THERMAL_TEMP_INVALID)
-		dev_dbg(&tz->device, "last_temperature N/A, current_temperature=%d\n",
-			tz->temperature);
-	else
-		dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
-			tz->last_temperature, tz->temperature);
 }
 
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
-- 
2.17.1

