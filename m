Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD33C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1389D20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 22:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnkOKzUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgDJWNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:13:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38972 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgDJWNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 18:13:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so3869319wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fxaTwkHtjzC50vJJAtVceJtgHQwtXeZqJh88iIfXOtk=;
        b=LnkOKzUc57woc+efoOdWiBC76HgkeeWvVHT8utSyv4y4uF/vGGV+76MatJbZaG5xOK
         7eG3fFoeF6UJfxp6G9Qfme6y+811y2k3jXR8LqNuNtK+wroOdIE0vuGhIf87Qq1jd6b2
         Yi+mP9KtwPMl5aTcmTDsDZPNHtJydfZv0f301L5YddAEhFVPf2URdVAFMzDcFHDU+POU
         sGcQEfxNlLSMGqyHvmuxmX+jUymb+n70labUzE2R/pXSYpEWVaDrcoBShqBwDsWR98f0
         Hix3Ob7EkD9gwOHgxZQCdQwsY+iGkOcv8kAUI/vzRfi7XpHM1AL7yyfDQi4tXjg9hvup
         lV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fxaTwkHtjzC50vJJAtVceJtgHQwtXeZqJh88iIfXOtk=;
        b=g24ZRIg1DP/gVy+VxQANbkrRXlXv4c3KUaBkadmuAGOey6Cdmq3n/hlkBgxj4hBxqY
         l5FCMdAMamSfW5kSBPmgf1kZ/d+oaG09wpdwvwpva9pWPf56uVBQEreLwzrIyonxQrFa
         9cIRUGorSAoX0ligehxAjJbLEScN8uJnViJLnitpJUjUeW6cBzvi2w3th8sSKMmc07yR
         J0n1MNt+CEFkDkL3zF63VYGE9d0Hqyxy7JoEjgSFwasS/vZRg1lcn92XvVAP3eQzlJ9a
         AVWSK8ENHowhd/NHlXutstF/kpknKugcdCFckHg8F1WtTREkzWry/qwcDQJXOPBDnsxh
         dpvg==
X-Gm-Message-State: AGi0PuYEdOZtXgsKo+Viyjhf77HDLYwWlo+AnEoh83n1RWVgjGJ1sbCu
        rPosozFUw1mCZ7oxTFUwZFgoAg==
X-Google-Smtp-Source: APiQypL3k7Xms3q1e2VlI7EhK1FEiuXF36sTNcFUnL6N6T04029IelnALYNh/iFMvpS4NCovtiUgDg==
X-Received: by 2002:adf:97ce:: with SMTP id t14mr4408871wrb.263.1586556786788;
        Fri, 10 Apr 2020 15:13:06 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id b14sm4687952wrw.83.2020.04.10.15.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:13:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH 6/6] thermal: core: Make thermal_cdev_update private
Date:   Sat, 11 Apr 2020 00:12:35 +0200
Message-Id: <20200410221236.6484-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200410221236.6484-1-daniel.lezcano@linaro.org>
References: <20200410221236.6484-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the function thermal_cdev_update as an internal thermal function
instead of leaking it around.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 1 +
 include/linux/thermal.h        | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c95689586e19..4e271016b7a9 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -120,6 +120,7 @@ int thermal_build_list_of_policies(char *buf);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
+void thermal_cdev_update(struct thermal_cooling_device *cdev);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 08969f0be6a0..faf7ad031e42 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -413,7 +413,6 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
 
-void thermal_cdev_update(struct thermal_cooling_device *);
 void thermal_notify_framework(struct thermal_zone_device *, int);
 #else
 static inline struct thermal_zone_device *thermal_zone_device_register(
@@ -457,8 +456,6 @@ static inline int thermal_zone_get_offset(
 		struct thermal_zone_device *tz)
 { return -ENODEV; }
 
-static inline void thermal_cdev_update(struct thermal_cooling_device *cdev)
-{ }
 static inline void thermal_notify_framework(struct thermal_zone_device *tz,
 	int trip)
 { }
-- 
2.17.1

