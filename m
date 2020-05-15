Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D42FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB942075F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Das9pl01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgEOOLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726275AbgEOOLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:11:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A55C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:11:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f13so2457264wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PKPieQCHF+nm/iYn6FAQVcl/MzY/rRP6qinUb5RW81I=;
        b=Das9pl01gBCsp1gGCbQcY1KZ1UFy97GIBpNJBqvH/Awn51perczGgth8S4CeOAhzAP
         wGe0X1exwRTLH60MlculCA+31NYczsae4pTkldI+iugU0PKRFlmC7+WYDolDVZWOw2lD
         QYh1w4oZrMCCfO+9vGwKudbEGpf3q7AZ1TbsCoSPBUghb1iiSLa7UGX/VWJgPzW6XNQp
         QzNpzf743a5dS89YPm9dMHWJ9DxQ0TOtsgTo+gkJtyzdOPGyjOXBtMCIT2OkEGvmuCWp
         w/C1gOomtr4YvD7lpKGrrfIulHzxFNWC9UdIX3eknuqsLgiO8k4PDD9SZSSYxTQzKoc/
         e+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PKPieQCHF+nm/iYn6FAQVcl/MzY/rRP6qinUb5RW81I=;
        b=U0+UpYp0W2zEgkbrrO0BxV5bdImVXlduLFcgDfl5ull/w54a7ePsD/+OdLnt70QTHp
         b39rV70diNjLHlKLN/jY/R0nTjWSsDaGYXzONR1zHckEjlmqJr90wEEJaU7ekSezCiXv
         fuhhlp43cKEhL5VpeWli9XI2wU7MSmrtW+mhLtai+BW9LNatJMnsQxwsDgr5FRxTgZPU
         s8/6TEn0vbDSoOOp57NyJAdz6OQbI1K62us8DRnCD3V28og99sh/Zw/qeJYcV3PX/xE7
         OVUpEpnsU3hOhdJIq5g9gtvL5ayjH73wtubJ3NeZFeEdQUP4qScUZR+REndTyjXlOfg3
         aglw==
X-Gm-Message-State: AOAM532FQEvvvTGce/geIBDaVJupfjbek3tfalR0mJsNAgCcVJslAY61
        96Pp0DS3X5K2eKSVPsQldTYuVi8HFUQ=
X-Google-Smtp-Source: ABdhPJy9Gia2ZS1ien6LmcmxFdsWEHYPQ+Zkigj3OCeK7I0PgfUjljQPj9SPuCt6ryozsZsXKTdapw==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr4504714wma.159.1589551868914;
        Fri, 15 May 2020 07:11:08 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id d6sm4432438wra.63.2020.05.15.07.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 07:11:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, srinivas.pandruvada@linux.intel.com,
        arnd@arndb.de, rkumbako@codeaurora.org, ilina@codeaurora.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] thermal: core: Remove old uapi generic netlink
Date:   Fri, 15 May 2020 16:10:32 +0200
Message-Id: <20200515141034.19154-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515141034.19154-1-daniel.lezcano@linaro.org>
References: <20200515141034.19154-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to set the scene for the new generic netlink thermal
management and notifications, let remove the old dead code remaining
in the uapi headers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/thermal.h      |  5 -----
 include/uapi/linux/thermal.h | 12 +-----------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index faf7ad031e42..fc93a6348082 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -302,11 +302,6 @@ struct thermal_zone_params {
 	int offset;
 };
 
-struct thermal_genl_event {
-	u32 orig;
-	enum events event;
-};
-
 /**
  * struct thermal_zone_of_device_ops - scallbacks for handling DT based zones
  *
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index 96218378dda8..22df67ed9e9c 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -6,21 +6,12 @@
 
 /* Adding event notification support elements */
 #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
-#define THERMAL_GENL_VERSION                    0x01
+#define THERMAL_GENL_VERSION                    0x02
 #define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_grp"
 
-/* Events supported by Thermal Netlink */
-enum events {
-	THERMAL_AUX0,
-	THERMAL_AUX1,
-	THERMAL_CRITICAL,
-	THERMAL_DEV_FAULT,
-};
-
 /* attributes of thermal_genl_family */
 enum {
 	THERMAL_GENL_ATTR_UNSPEC,
-	THERMAL_GENL_ATTR_EVENT,
 	__THERMAL_GENL_ATTR_MAX,
 };
 #define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
@@ -28,7 +19,6 @@ enum {
 /* commands supported by the thermal_genl_family */
 enum {
 	THERMAL_GENL_CMD_UNSPEC,
-	THERMAL_GENL_CMD_EVENT,
 	__THERMAL_GENL_CMD_MAX,
 };
 #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
-- 
2.17.1

