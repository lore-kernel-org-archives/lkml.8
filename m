Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0AEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4132420784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCL/dJ+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbgCaQ5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:57:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33018 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbgCaQ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:57:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so26991862wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Y/abDyeAK7rGBvYDyizWyVwlF1sauFbaXbJ9R6MBx2w=;
        b=tCL/dJ+Wt5JYGy7iTzNg1GIRUfoWm7de+Xaha+6IB5H71tL8ayUKv+ZnqKlrlyjBrU
         /jGZDm1b0DSUeiDJQxSgIrDGOPBJlHgTpAOE5GrNI/yMSAYQysdD/39ThvKY7BPUvFrI
         Sk07stASDb4c8s2924NzVil3jcUBKY05PGQ/IwQ0Ne0OfjYRMxFD7A2UbZhTwaeHkKSI
         /j3HAY5BChzX5mET9uMaIS7dHTaG7xphLcXMgoR8orOXRHhijJBxGk/8nAvhxfBmS3di
         S8G6zDjIMbF88UugwnHg6Zs4faAcUQTK9zoCtfAO2XSVhM9CedAyS5EzP9aJ9LUs3Q8d
         QTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y/abDyeAK7rGBvYDyizWyVwlF1sauFbaXbJ9R6MBx2w=;
        b=LXJQVcAxQHZiENVnyFksnb3DrIFlwDub3rgt3DzFzuT68KGOdlsRsP8PbNIXnuwLQI
         rNf0ul7+2tTsXJl0+BfzmLPrDSf57NvGdMRQDde/dDzSGvRLwPlC03xr7IzuzJDgimJd
         Q7Kteiy1Ls/Yp+avVSamQMlDwII7r6tNAhRNN7u+Q3V2ZzNSkoHJSPmu0hfrYpCCTFC1
         gVzYCiI54fgTIrFFjd1tzVlescKvGImlDVsC98Zll3ilz+oCw8dkj68ez5HHUbyPYpV5
         ENSaAttJmWoWFxNy8aBOt5BJWnMswcXVyzIciAGSVbN9b5DlYT1gyEBj9UKSDzlrePLU
         BRCA==
X-Gm-Message-State: ANhLgQ2z043qqd5fq3A3q1PLtqzSMblb/LUnMwWc5Sv9Lj/HQSIPPL/7
        VQLLfsUea6o2gChk74+pB/aKXg==
X-Google-Smtp-Source: ADFU+vux8QM/2sxcYlqspl3JXz6luUGkH5emuSBHHZxomPcWFLW+MC2/DvbE2r9M9MtiL4J/aMZ4MA==
X-Received: by 2002:a05:6000:11c6:: with SMTP id i6mr22412859wrx.115.1585673819466;
        Tue, 31 Mar 2020 09:56:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:497e:e6a9:b3eb:fcac])
        by smtp.gmail.com with ESMTPSA id d7sm12925648wrr.77.2020.03.31.09.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 09:56:58 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] thermal: core: Make thermal_zone_set_trips private
Date:   Tue, 31 Mar 2020 18:54:48 +0200
Message-Id: <20200331165449.30355-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function thermal_zone_set_trips() is used by the thermal core code
in order to update the next trip points, there are no other users.

Move the function definition in the thermal_core.h, remove the
EXPORT_SYMBOL_GPL and document the function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h    |  3 +++
 drivers/thermal/thermal_helpers.c | 13 ++++++++++++-
 include/linux/thermal.h           |  3 ---
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index a9bf00e91d64..37cd4e2bead2 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -69,6 +69,9 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *,
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 int thermal_build_list_of_policies(char *buf);
 
+/* Helpers */
+void thermal_zone_set_trips(struct thermal_zone_device *tz);
+
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
 void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 2ba756af76b7..59eaf2d0fdb3 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -113,6 +113,18 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
+/**
+ * thermal_zone_set_trips - Computes the next trip points for the driver
+ * @tz: a pointer to a thermal zone device structure
+ *
+ * The function computes the next temperature boundaries by browsing
+ * the trip points. The result is the closer low and high trip points
+ * to the current temperature. These values are passed to the backend
+ * driver to let it set its own notification mechanism (usually an
+ * interrupt).
+ *
+ * It does not return a value
+ */
 void thermal_zone_set_trips(struct thermal_zone_device *tz)
 {
 	int low = -INT_MAX;
@@ -161,7 +173,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 exit:
 	mutex_unlock(&tz->lock);
 }
-EXPORT_SYMBOL_GPL(thermal_zone_set_trips);
 
 void thermal_cdev_update(struct thermal_cooling_device *cdev)
 {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c91b1e344d56..448841ab0dca 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -439,7 +439,6 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *,
 				enum thermal_notify_event);
-void thermal_zone_set_trips(struct thermal_zone_device *);
 
 struct thermal_cooling_device *thermal_cooling_device_register(const char *,
 		void *, const struct thermal_cooling_device_ops *);
@@ -497,8 +496,6 @@ static inline int thermal_zone_unbind_cooling_device(
 static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
 					      enum thermal_notify_event event)
 { }
-static inline void thermal_zone_set_trips(struct thermal_zone_device *tz)
-{ }
 static inline struct thermal_cooling_device *
 thermal_cooling_device_register(char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
-- 
2.17.1

