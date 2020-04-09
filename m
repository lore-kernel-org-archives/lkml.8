Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5C5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60732074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="If7AtKpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgDIPPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:15:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39101 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgDIPP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:15:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so12323892wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HV4uxU8XGvUxECd82k3CD/W1J1RbaS0e9zCergn8MI4=;
        b=If7AtKpUCLVQ4oVvqt1MZBt5Hj+yAEyypmw17C/6TV7WaC9Bni6FamsBeMNa4hnmNB
         z8b/56UGcddje9ApwdmnDdCuC6kqwrqz9Pt2MEBvHq9lYcDC/SRImJBUlDBQOw8DwLnO
         iZYrWi1KDDP9j4x7eWCdPoK8VjQZK3SDKB8f22vQfB0NlDqfQ4e44MHI1Z6oDBx/NPdf
         TguC3UAC3pqldYmKCVRQe4vU4eUKkSZ/sJ18C5HinI32F9KoQGKSkTYUVjF69Xusj0vY
         AcyE/uBvtrlP7JrvAo7d1q2pt8JZLMumlL1U4CUTNO/0WuKqk8CwEjvIcfqD/hbQoQJO
         DQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HV4uxU8XGvUxECd82k3CD/W1J1RbaS0e9zCergn8MI4=;
        b=fUe+8nAOd/t1qosWt4/HeuUUYIFSV4a3wfghg1Kl4vB4oAk5xl97bvu0MkhyJOhnuY
         W2G/HNCQnk9ihunRkIgY7yHrTU12Dp/PBPW2bkJ1EoXONO3vkNIXgMwnXFIUKwcx/C5X
         9FbQviqyQCkiLmd3aS/H++a5FuW8JE1BIC+aS/Pu7hu6nu97gpsbnW3e/DOyOcbaDK4v
         cFEOIGO4jlZpI1kahcM5gECNofv+51jxMohJAQW8n00pcwb1sPb5ZjOPAX3b3e+S3Dzo
         4a2PgUMRQawm//2uLeuiNk+TvGYmaF8IF9vNm0SytzOxV7fDPOtFFdyJOAZabZx3yboQ
         wNJg==
X-Gm-Message-State: AGi0PuYtPuF+iIUkKkrWOaCJQaLiXnlJGpbvnta9kH0YE0HvgH8whMIZ
        UcvLLoHXLH9i4V4h1VIGLjX6Ow==
X-Google-Smtp-Source: APiQypJYRh1GysHl2LS25GQzepXWT+L+4U+dbpPejwKkTEGDtAZBi0sFiZobA1+WxV6tyD7VtVmZUw==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr15813636wrr.394.1586445326552;
        Thu, 09 Apr 2020 08:15:26 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id 19sm4051392wmi.32.2020.04.09.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 08:15:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH 1/2] thermal: core: Move thermal_cdev_update next to updated=false
Date:   Thu,  9 Apr 2020 17:15:14 +0200
Message-Id: <20200409151515.6607-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
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

