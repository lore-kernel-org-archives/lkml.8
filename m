Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7171C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6FAC2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUjZzrQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgEOOLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOOLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:11:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A26C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:11:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id m12so2486864wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=A4+UkWcvLP2WT8CuakkXaohSADBdrjeeNAnbolDDe08=;
        b=NUjZzrQH7/8UPP7L24eoPhEPg6G8tZ2NntXz0lwP2s0+zSuswWa26LQVNl+OrxXnJo
         yudmQee/QQ6NO3s4BTkl/KR8DMF4HZ27qvEvCKr3mSJPwhznPRytkZk6IkZDqL+EJl6m
         cWqf5WDuVjEl6Jm4k1+seLdLsemn5kRPoBbpaTUWwot8wcWQ69n2b8K9k4LUsBKMziay
         4OZ7V9i574hixJhPtRi+84gxc/mEDA1aCqdpQxSS8LjVP9SoUAiHNIdCYLbi6hveqxgN
         C08vZZmrigL+fS+teNs/xXJxLoPmRO6GVbb9r/WY377bW5tJ+29fL0cS3gbrP4PcgPFh
         C5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A4+UkWcvLP2WT8CuakkXaohSADBdrjeeNAnbolDDe08=;
        b=sCykfZXJp0pAzZ+jWge6SX7ExyG7evQvJnc7t3tWxVmHcOgM3AQLe606/rrmUtPto3
         ysVaymuHmuRYEF/bb/eJyUV5ssxHrGpWNqf5Ky6s1INgMoGSmy17l1+Ee85XfJ/76ZB8
         WDR8KpJ3YCJ9f2harnbWGpSNdkJOUsE7V1MBnqtfu2iONK0oOCt8D49v3pKWBk4anUyd
         Ozr3n6bJndcHGL7BZ4/7TRZiA2Elt35cgUbEmAu7tpdp4VSiAEpx/wgARyDgJwFNMkWh
         KPhuBdRhvStSUFRWEcV06a/CpTv+S0VGMMYj3BKM9Bh1pCIprtCmkjcOK1hIOEDjh0BZ
         iHAA==
X-Gm-Message-State: AOAM5333Dsg9sdtS0Zosh/zmkk8ulBt/NYLhhVL318fvDJiMSjNOZzps
        81TY6aUIHTE1166b97VNGiX+9A==
X-Google-Smtp-Source: ABdhPJzcMZfZ6NXde6nZJ9Qrvuofbkk+4OFACM9BWBFB//xLPloqviY3hVReBzWCB1pZLgBNCIYCSw==
X-Received: by 2002:a7b:c413:: with SMTP id k19mr4243265wmi.124.1589551863052;
        Fri, 15 May 2020 07:11:03 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id d6sm4432438wra.63.2020.05.15.07.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 07:11:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, srinivas.pandruvada@linux.intel.com,
        arnd@arndb.de, rkumbako@codeaurora.org, ilina@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] thermal: core: Add helpers to browse the cdev, tz and governor list
Date:   Fri, 15 May 2020 16:10:30 +0200
Message-Id: <20200515141034.19154-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cdev, tz and governor list, as well as their respective locks are
statically defined in the thermal_core.c file.

In order to give a sane access to these list, like browsing all the
thermal zones or all the cooling devices, let's define a set of
helpers where we pass a callback as a parameter to be called for each
thermal entity.

We keep the self-encapsulation and ensure the locks are correctly
taken when looking at the list.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 51 ++++++++++++++++++++++++++++++++++
 drivers/thermal/thermal_core.h |  9 ++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a6b8c0240656..54208b6deb42 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -638,6 +638,57 @@ void thermal_zone_device_rebind_exception(struct thermal_zone_device *tz,
 	mutex_unlock(&thermal_list_lock);
 }
 
+int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
+			      void *data)
+{
+	struct thermal_governor *gov;
+	int ret = 0;
+
+	mutex_lock(&thermal_governor_lock);
+	list_for_each_entry(gov, &thermal_governor_list, governor_list) {
+		ret = cb(gov, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&thermal_governor_lock);
+
+	return ret;
+}
+
+int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
+					      void *), void *data)
+{
+	struct thermal_cooling_device *cdev;
+	int ret = 0;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(cdev, &thermal_cdev_list, node) {
+		ret = cb(cdev, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return ret;
+}
+
+int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
+			  void *data)
+{
+	struct thermal_zone_device *tz;
+	int ret = 0;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(tz, &thermal_tz_list, node) {
+		ret = cb(tz, data);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return ret;
+}
+
 void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 					  const char *cdev_type, size_t size)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 4e271016b7a9..bb8f8aee79eb 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -41,6 +41,15 @@ extern struct thermal_governor *__governor_thermal_table_end[];
 	     __governor < __governor_thermal_table_end;	\
 	     __governor++)
 
+int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
+			  void *);
+
+int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
+					      void *), void *);
+
+int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
+			      void *thermal_governor);
+
 struct thermal_attr {
 	struct device_attribute attr;
 	char name[THERMAL_NAME_LENGTH];
-- 
2.17.1

