Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E239C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55D320787
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLCIRIPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgEOOLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOOLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:11:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA4DC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:11:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so3770034wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RJ6XAk7W2stQGCvpULKUDc0FYaIKu2TAbXfun2Pkr3g=;
        b=SLCIRIPgLr81qFn7rCPeQwMQ8ryyFGrY2/HbUJTmnKVab0yEXJjD6YYun/KgxmHLfa
         iTZY5RxWXu/lKag4MbSRKfr8KHpZgny0vACzyjMaRXlXwR2wx9hlK4TzIIzI6CQwPW0t
         C9/T+hIi3zQqpW5KDpNm7YM4k+uUyjHI1g1MxgvxDHCqXH7kJBfQrcQtudhrXouZgFkO
         DZ5si5zjMelJhMBgWbqELsztELd6IYd9ohBo2+zZegUH4RlrUxeFWKUro2gRMbFKV/lB
         sM8OF1pMLTo9sOW/dyaYJu9vhScBU+jDkZ4dfwLIwSxGu3a3RMLIwI0Sw8pqCSm7Ox2A
         aDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RJ6XAk7W2stQGCvpULKUDc0FYaIKu2TAbXfun2Pkr3g=;
        b=n2fypx66PmwB9E7gXmChBxyfixeva3Olv7FDi+fD31sHNgfEErun5vgcF8No5HotyD
         cmPY+EJvVOAI7uuLVdlms2KgmCdCEaM0TAoL/R2hvsepDjftpr0D8wntWO5YrUM6FF1Z
         juWhP4kTkis1Mof4vNl2bt62Ra/rqF4Y9GjwuZf1Vaniqz4Wd7guuVkiRlz/dXJg3ujg
         RDfMG3Ms1518bKZs8kNPLdmF1C6V8SAoVYZF+CjSqsdBmdEiPBGnkw2BCYhvz1df39cp
         XQUU0s0hburFtydF1nfpbtvvbIJ7gcCB2CC/cqOiTyu5u95V2yDlDDSdhZZPDpNq8dpE
         0TWQ==
X-Gm-Message-State: AOAM53190LrzwNufcdnu0PLu6PeNqSK6jKjh+29Q2fLIosjVLMjMQF+L
        qqpgiyTTs4X+sXQpwSa1kWE2wfEq3jc=
X-Google-Smtp-Source: ABdhPJz9R9uK9GeGOjTdsp9/H/Wl11yJ61q+5QqH0Rh3c29OJGvxW6i6tnnxTCFR1Tjkrlpa3xXmuw==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr4512075wrq.14.1589551865810;
        Fri, 15 May 2020 07:11:05 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id d6sm4432438wra.63.2020.05.15.07.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 07:11:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, srinivas.pandruvada@linux.intel.com,
        arnd@arndb.de, rkumbako@codeaurora.org, ilina@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] thermal: core: Get thermal zone by id
Date:   Fri, 15 May 2020 16:10:31 +0200
Message-Id: <20200515141034.19154-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515141034.19154-1-daniel.lezcano@linaro.org>
References: <20200515141034.19154-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch will introduce the generic netlink protocol to handle
events, sampling and command from the thermal framework. In order to
deal with the thermal zone, it uses its unique identifier to
characterize it in the message. Passing an integer is more efficient
than passing an entire string.

This change provides a function returning back a thermal zone pointer
corresponding to the identifier passed as parameter.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 14 ++++++++++++++
 drivers/thermal/thermal_core.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 54208b6deb42..6f7a1a7ffd2a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -689,6 +689,20 @@ int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
 	return ret;
 }
 
+struct thermal_zone_device *thermal_zone_get_by_id(int id)
+{
+	struct thermal_zone_device *tz = NULL;
+
+	mutex_lock(&thermal_list_lock);
+	list_for_each_entry(tz, &thermal_tz_list, node) {
+		if (tz->id == id)
+			break;
+	}
+	mutex_unlock(&thermal_list_lock);
+
+	return tz;
+}
+
 void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
 					  const char *cdev_type, size_t size)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index bb8f8aee79eb..7e8f45db6bbf 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -50,6 +50,8 @@ int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 			      void *thermal_governor);
 
+struct thermal_zone_device *thermal_zone_get_by_id(int id);
+
 struct thermal_attr {
 	struct device_attribute attr;
 	char name[THERMAL_NAME_LENGTH];
-- 
2.17.1

