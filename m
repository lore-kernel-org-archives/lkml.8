Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0221C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE12206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+2JlAdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405471AbgFYOpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405428AbgFYOp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:45:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6EEC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:45:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so5830841wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PKPieQCHF+nm/iYn6FAQVcl/MzY/rRP6qinUb5RW81I=;
        b=j+2JlAdRSRFZfAnfxCM0CrpTZ+bahzEHxSfrfwFu0Zuve3qUAEZ4rSirAGqN4PwK1T
         PpBvFuCOHUh3nOd8Mkrac43OY9760SfUTQnf3fOzt1lJFIkNKC+c/uStRxegVgPN3kv8
         QSvhUbx2GGGTkgnndzpda8np1tboP8eifIbPrUpgwF+wdUSF0DfOu9GIE4h532YABufs
         sVboxLHAoWYbp8VU2YKtIBNmZmlVSGGzk1I9wJT/mNusrjWnmwbqqLSKmpQ9kH/GcGDt
         FBl7MSVOO7DCnSBS301HHbhicSmgV7gmB+L9+rFpLe+cbypd/nCU0EQg7EysRRuCE5yt
         uwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PKPieQCHF+nm/iYn6FAQVcl/MzY/rRP6qinUb5RW81I=;
        b=YvXbrk34+n3tRCoxC1+mn5MA0Mv7VG/EIH/5VTdbm42+flUYsMSSKeF6nRLgSlDzk9
         XtRsmmLe+4jTnjWTBg1anRINaAtPuZIlDwA/UEUC3AlshuOoisJL+x+vMoL544IB0VwE
         X8urDm3mgpZbaydzlpCGFQ0PAaonEOla9alasUvb5zQTSR7X7iQvfzDEH6NXhaWnXajn
         T6llQ0tFMVokyycOAZ8voU+jx4h/A/ZmFjl/2Heo7dSWXgde7A5U676isO+FH1CepULL
         YlUOTN2MfCbS3ZEZdJgQpSSpYHAla2wSWNMJRD+R8tiFlWcBnweq5GUxmuYZ1xe6MH0e
         AL6g==
X-Gm-Message-State: AOAM531NxmQZqKPBj+6itrzhyeGZy6wGXA6/khMkL9k/C2DwXlvDYQNX
        Bt0qREnD/jOXpADER1c4rttG3g==
X-Google-Smtp-Source: ABdhPJzffN5+QlD/Xdx8ngAfeI3sfiXOJrUqwwi0JLiohDrlOfiAwvWDHzYRVxLJqA5aEL2xZwcwlw==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr3644775wmb.119.1593096326264;
        Thu, 25 Jun 2020 07:45:26 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id u186sm13062706wmu.10.2020.06.25.07.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 07:45:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] thermal: core: Remove old uapi generic netlink
Date:   Thu, 25 Jun 2020 16:45:07 +0200
Message-Id: <20200625144509.17918-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625144509.17918-1-daniel.lezcano@linaro.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
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

