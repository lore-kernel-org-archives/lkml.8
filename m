Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629B2C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3679E2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9ngXUrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgDJWNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:13:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32942 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgDJWNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 18:13:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so3913069wrd.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 15:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HV4uxU8XGvUxECd82k3CD/W1J1RbaS0e9zCergn8MI4=;
        b=a9ngXUrNUt7AiZ+5zUwxR0uT87ropKMeNAXC1eoLoQp619v3ASrMyus+iVrotpNRt6
         KyccFKtU+UpVDueWBivYe++GpNKuyV9Hf+aOyB7cW6PBRIIPJM6Qa5eiDQcoU/JHiigk
         Dg/mrh7YQjVr+vJRIcGxnUFCtJcx2bZbGwxmLy5dX0hxNtPPfM0hY0krCsKL9Nnavd8P
         FPOIt2Tsfpo0/FSLivtF+MMtKD6r9PBObZgpHZzjIS4qKooYoU7yEff2CH3tLVUJ+Ys3
         pS6QEQXkDivQvcnO08OauNGsZ/JnYl1B/Z5RzLXVfIWcuCe3n8XFOdLSk0XIA229LGTU
         5jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HV4uxU8XGvUxECd82k3CD/W1J1RbaS0e9zCergn8MI4=;
        b=HPce/+NtG/PLHfX/Hhg8W7uPx93lDIDq7tWJJog/O3HNveifv/frcJ+DBXrJrGN+6O
         ps3sm6h2zI51K95MAY9up3Fue8QM7be+zvQCA4cNRD8tXO0hy/ufVLtPlWIg1BaSIGIg
         auJSJYFQZQtihxPb73juBRNdIXwmmt0ictY/ytEl9Ooa/H+qe3eLCXGBB0DvO992ve+u
         YezZWaeE7l2iF2dszks469HgfNTQVr+WsLT5St9UmnMnO3BpVnL0KMeJGrPV5/DG3lnh
         a9gAACr2VGP9dFkjEYfYCntaHLb8rIEYOssh2iPh1bDQbnAxIYR3kEeMEUI3mmhQt5+9
         OYYw==
X-Gm-Message-State: AGi0PuYFncRfqqwGk+3JEVasVhmaaZzdQwYCOP5RxDzP4KIvDg1yV2Zh
        W/RgYe5SpStk+PqEUgvL1fCj0g==
X-Google-Smtp-Source: APiQypLbWxW37hLgL1D9TRx0HfjG4PrI3ABBsgwJvT4Tbi9Cc5C3TUklYD5szz5QD4O/qQcXuiODSg==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr6704254wru.317.1586556779513;
        Fri, 10 Apr 2020 15:12:59 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id b14sm4687952wrw.83.2020.04.10.15.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:12:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH 2/6] thermal: core: Move thermal_cdev_update next to updated=false
Date:   Sat, 11 Apr 2020 00:12:31 +0200
Message-Id: <20200410221236.6484-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410221236.6484-1-daniel.lezcano@linaro.org>
References: <20200410221236.6484-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to the thermal_cdev_update() function is done after browsing
the thermal instances which sets the updated flag by browsing them
again.

Instead of doing this, let's move the call right after setting the
cooling device 'updated' flag as it is done in the other governors.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_bang_bang.c | 10 +---------
 drivers/thermal/step_wise.c     | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 991a1c54296d..c292a69845bb 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -64,6 +64,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		mutex_lock(&instance->cdev->lock);
 		instance->cdev->updated = false; /* cdev needs update */
 		mutex_unlock(&instance->cdev->lock);
+		thermal_cdev_update(instance->cdev);
 	}
 
 	mutex_unlock(&tz->lock);
@@ -98,17 +99,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
  */
 static int bang_bang_control(struct thermal_zone_device *tz, int trip)
 {
-	struct thermal_instance *instance;
-
 	thermal_zone_trip_update(tz, trip);
 
-	mutex_lock(&tz->lock);
-
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		thermal_cdev_update(instance->cdev);
-
-	mutex_unlock(&tz->lock);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 2ae7198d3067..298eedac0293 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -167,6 +167,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		mutex_lock(&instance->cdev->lock);
 		instance->cdev->updated = false; /* cdev needs update */
 		mutex_unlock(&instance->cdev->lock);
+		thermal_cdev_update(instance->cdev);
 	}
 
 	mutex_unlock(&tz->lock);
@@ -185,20 +186,11 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
  */
 static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
 {
-	struct thermal_instance *instance;
-
 	thermal_zone_trip_update(tz, trip);
 
 	if (tz->forced_passive)
 		thermal_zone_trip_update(tz, THERMAL_TRIPS_NONE);
 
-	mutex_lock(&tz->lock);
-
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		thermal_cdev_update(instance->cdev);
-
-	mutex_unlock(&tz->lock);
-
 	return 0;
 }
 
-- 
2.17.1

