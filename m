Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD6BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BFF20775
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2+XxG2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405489AbgFYOph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405447AbgFYOpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:45:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20AEC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:45:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so4732050wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OoOn6nS87ZidHX21sGTjERIvR6aejkwl1RkPRA8UQB0=;
        b=G2+XxG2KTvJLLLkYJ4JyN+CEHg8y0zLekzqE0jcco/ttYAolOWEQJFO1BiAsMnNM8r
         /QjE8YHD6lCKQYdi9pzY3sTr3ve83hnSexS0jisvtcyWQVVkQx15eilrsbCJAypiez08
         yDFn1StzRRntr1BetbaFswtJiniXghTb8d6r0yP4TQu+DSW99GJDa1mah/SJleK569HJ
         lMkasvtNugOxW68N6BsdpSW1gjIi/Z8VHHWkffc36WgLRUAMX5nKw6cXaqTkP8DIVCha
         Ml+AqdG+H67N5kbrVUBEVHI0i6KP9BrwQhM84METF2YK/0BfDyceWeJPmIK6cPfixF8g
         /Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OoOn6nS87ZidHX21sGTjERIvR6aejkwl1RkPRA8UQB0=;
        b=Kin57QpiX4DvyC2P/ITDwWs3t4sV7ONWtCWRRrhzE9fuYERXip8uwpTYamkpDlpTKv
         CiSApBzXdXVWZt19LESL+lEUYTxaE8MNBnuANLajpFZ/DDY4Kgi/aoVw+6VH6FGMXg3P
         gddoxL7cep+B/k51C97r9ArrNQDuZd34lG68MLvErGfjA/WQVES2XCMq2jNeE/LdM6p8
         SUGFPJ/sQqPsbBpQ+tLU5V7hYJhwSYnd4RTx3xCm0pccMcioUnNs4n+w+AypmuorCV8F
         fr6Xh3JmTzGi1J7205oZo+hg6dqja+0CZ7HAReWEMTfD++tytO8ZDfU8X2YsEpyPIuY7
         LL/Q==
X-Gm-Message-State: AOAM531m5RySKozjYVKbPWWJ5yavOjDE/fnAJeT1ClTWfjyn9lGSKdpq
        ZgpoCV5qqWua281ZtX5+zJTLPw==
X-Google-Smtp-Source: ABdhPJwKxnWPv1U71martk1kxU4/Tb0LCX7+Lf5k20be9/lZK1yet2K8Sse94XB6F5JdiTmjkIpF3Q==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr3673151wma.18.1593096329483;
        Thu, 25 Jun 2020 07:45:29 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id u186sm13062706wmu.10.2020.06.25.07.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 07:45:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] thermal: core: Add notifications call in the framework
Date:   Thu, 25 Jun 2020 16:45:09 +0200
Message-Id: <20200625144509.17918-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625144509.17918-1-daniel.lezcano@linaro.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic netlink protocol is implemented but the different
notification functions are not yet connected to the core code.

These changes add the notification calls in the different
corresponding places.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c    | 21 +++++++++++++++++++++
 drivers/thermal/thermal_helpers.c | 11 +++++++++--
 drivers/thermal/thermal_sysfs.c   | 15 ++++++++++++++-
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 58c95aeafb7f..1388c03d1190 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -215,6 +215,8 @@ int thermal_zone_device_set_policy(struct thermal_zone_device *tz,
 	mutex_unlock(&tz->lock);
 	mutex_unlock(&thermal_governor_lock);
 
+	thermal_notify_tz_gov_change(tz->id, policy);
+
 	return ret;
 }
 
@@ -406,12 +408,25 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 {
 	enum thermal_trip_type type;
+	int trip_temp, hyst = 0;
 
 	/* Ignore disabled trip points */
 	if (test_bit(trip, &tz->trips_disabled))
 		return;
 
+	tz->ops->get_trip_temp(tz, trip, &trip_temp);
 	tz->ops->get_trip_type(tz, trip, &type);
+	if (tz->ops->get_trip_hyst)
+		tz->ops->get_trip_hyst(tz, trip, &hyst);
+
+	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
+		if (tz->last_temperature < trip_temp &&
+		    tz->temperature >= trip_temp)
+			thermal_notify_tz_trip_up(tz->id, trip);
+		if (tz->last_temperature >= trip_temp &&
+		    tz->temperature < (trip_temp - hyst))
+			thermal_notify_tz_trip_down(tz->id, trip);
+	}
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
 		handle_critical_trips(tz, trip, type);
@@ -443,6 +458,8 @@ static void update_temperature(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 
 	trace_thermal_temperature(tz);
+
+	thermal_genl_sampling_temp(tz->id, temp);
 }
 
 static void thermal_zone_device_init(struct thermal_zone_device *tz)
@@ -1398,6 +1415,8 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	if (atomic_cmpxchg(&tz->need_update, 1, 0))
 		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
+	thermal_notify_tz_create(tz->id, tz->type);
+
 	return tz;
 
 unregister:
@@ -1469,6 +1488,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	ida_destroy(&tz->ida);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
+
+	thermal_notify_tz_delete(tz->id);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 6ed24b4e23d3..7893ace1d90f 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -175,6 +175,14 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 }
 
+void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev, int target)
+{
+	if (cdev->ops->set_cur_state(cdev, target))
+		return;
+	thermal_notify_cdev_update(cdev->id, target);
+	thermal_cooling_device_stats_update(cdev, target);
+}
+
 void thermal_cdev_update(struct thermal_cooling_device *cdev)
 {
 	struct thermal_instance *instance;
@@ -192,8 +200,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 			target = instance->target;
 	}
 
-	if (!cdev->ops->set_cur_state(cdev, target))
-		thermal_cooling_device_stats_update(cdev, target);
+	thermal_cdev_set_cur_state(cdev, target);
 
 	mutex_unlock(&cdev->lock);
 	trace_cdev_update(cdev, target);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa99edb4dff7..ff449943f757 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -124,7 +124,8 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int trip, ret;
-	int temperature;
+	int temperature, hyst = 0;
+	enum thermal_trip_type type;
 
 	if (!tz->ops->set_trip_temp)
 		return -EPERM;
@@ -139,6 +140,18 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
+	if (tz->ops->get_trip_hyst) {
+		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
+		if (ret)
+			return ret;
+	}
+
+	ret = tz->ops->get_trip_type(tz, trip, &type);
+	if (ret)
+		return ret;
+
+	thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
+
 	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
 	return count;
-- 
2.17.1

