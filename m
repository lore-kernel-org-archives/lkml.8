Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3199AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3E420663
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fwq8THI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405441AbgFYOp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405300AbgFYOp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:45:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EB3C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:45:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so6125348wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G8Wsf4BanCeOfla3xsfSnoOdB+NpmOPJTeCm4R9KGig=;
        b=Fwq8THI57Wfw2ppOhr0OfJ50ABPxeTq9Ds0kBm/j8fuq6iU29crIRFjtxbZW71YmeR
         FA78MHLPk0sPab/U8sGGUeHvsS5VAXrPYz9qenpqfdqWdnJ55rwPm7l0yfg3qYkBMwP6
         4SxQDGQmXzu/IKwPUvUDZXgA0ejXO/BK2LdGuk2IjL0ZTgRCEyJXOjPtarXkNOKBdK4r
         u9x0Y8kbRqXQb8jw4Tl4Q6qv/APVTEDZXZsnKeE7M5a7kDyXzu65CxnMVXeMwuq99345
         QoFY9KMwjlOy2nTdqzTKDbm3k6vScEcyYNrEothU7yfgp3qkXg3X25X1uPx7kqWKyXDk
         nJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G8Wsf4BanCeOfla3xsfSnoOdB+NpmOPJTeCm4R9KGig=;
        b=i8KwNW0N3wv8f7yezc00fkzzjddg5qO8UIuVrrNuqoSPAwUwHqeXfgGMaNedC0wJV1
         3Rv/t2l9fmA+hqfs9x4rb23IeSJUig4xnclxqqUPjuEr1frjN2Dn72E9iT0+pZ/Zffvs
         ouwFEEQovqfwekZOL1fiO8EN/t5/4eWxFaIpdAUKHnpQtpLOBlU5hat3SPrBGU1q4pHt
         fmiVejZvTOcAMGlwblWQH/5IrihYy1YGdEf6khs0dTkwRoQk0uvAXaORPbUUcTb+nu3+
         VVlzkvoA8LvtKtt1OJ5T+SB1ItS78MbjF16m/H+oYuwxETXTitD+xLGAKzPT5wt5gzLO
         2qgA==
X-Gm-Message-State: AOAM532zdSSJM7eF8R/LCg1j+h+WabWgdlA9s8KfopX8PAAX0jxR//bv
        GFW1YCF58Ed8Gdg8M3sfrUmt0A==
X-Google-Smtp-Source: ABdhPJzHiLS+iahY6B7WctvubZj9C1PLB4G0n2IxgVhBJ+CYoVg3X6Ma9If/5BwfSMN1EbT1o5/w7w==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr36462098wrw.123.1593096324648;
        Thu, 25 Jun 2020 07:45:24 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id u186sm13062706wmu.10.2020.06.25.07.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 07:45:24 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] thermal: core: Get thermal zone by id
Date:   Thu, 25 Jun 2020 16:45:06 +0200
Message-Id: <20200625144509.17918-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625144509.17918-1-daniel.lezcano@linaro.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
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
index e2f8d2550ecd..58c95aeafb7f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -662,6 +662,20 @@ int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *, void *),
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

