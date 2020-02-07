Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEE9C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6413721741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opy2TZYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgBGIQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:16:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37052 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGIQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:16:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so1666625wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 00:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NP0P19WY2zs9xXoJo02DB7SfKBjYPB/LJ3N84P0Fams=;
        b=Opy2TZYfQQ2Ad7XjaUUL3886p5hXJ50/nJGknAlkErDvqky5kM7Y7jK8Z+du064BdE
         tEYI0c4DxMeXLsQgCyFJxUYAhAeJbi8uFb1Z9Qp0tW1Kwjn88X/+FreN8r/E0LDeYJLn
         MsLbYHdV7Ur6zWM6eAIhSRpqV7UdYYOG8Kt+47d4I5NHqVSxne8eKthTDOi12JdS/f5A
         6JJsDWBU0C6647/jXF38TwY6UAlCw2U0xMty8nShMttBy5RF4W8WR2pnQxywuRQJlNHs
         baS05WJCt0tnGItewQkMvGDxmTbuPyIsn/1hCNpeXSV5mfo+k5B0/xq8lRzHZOvfFD1j
         AdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NP0P19WY2zs9xXoJo02DB7SfKBjYPB/LJ3N84P0Fams=;
        b=cdC0pM40Aev6aLs/n0CY+OxQiADOT09oZQf/tMouJYOk6US2DxtPxzLJidagYP8tuv
         lWY54SyQShBDDi+26PdeukAhr7x+2W0KylNj0rIqt1DcdmwqJsfOH8Urz1JwM9OQrpUu
         ucNKWyYM3w5QCtjacTx8xoTwuMtL+hEA1saKUXNqF1hktDoenYihsqgiE9kN5whKTrr0
         azyvYZnB8SBVJnpnawfPeuRQIUjJ/t+Lq+xZG3jtNB/CawJABxgWCwDXWi9kEGJv16Lk
         d05R965Pp68JI3XO1PxdhmMcrQBqX9UdtVAqO1UmvbuQn/K2WV4B87jKcprfvFJoe/yJ
         V28Q==
X-Gm-Message-State: APjAAAXhWo//DNTQWHQcUeYY6jiHhNIYkPANLtb9RmAajGrQQEhTIRc3
        Pkn+vkBuuQoKLMkJ3PUrVF9DRT99Yrc=
X-Google-Smtp-Source: APXvYqwYqtK9AGV6S60VM157S9sl0X++kCzTeFNQrw3j7Y5/uioL3eQMaYDlJq/y8i4UJ1NOxBR55g==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr3055528wmf.189.1581063378072;
        Fri, 07 Feb 2020 00:16:18 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o4sm2466182wrx.25.2020.02.07.00.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 00:16:17 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org,
        Christine Gharzuzi <cgharzuzi@habana.ai>
Subject: [PATCH 5/5] habanalabs: provide historical maximum of various sensors
Date:   Fri,  7 Feb 2020 10:15:20 +0200
Message-Id: <20200207081520.5368-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207081520.5368-1-oded.gabbay@gmail.com>
References: <20200207081520.5368-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christine Gharzuzi <cgharzuzi@habana.ai>

Add support for hwmon_in_highest, hwmon_temp_highest and hwmon_curr_highest
attributes. These attributes retrieve the historical maximum voltage,
temperature and current that were sampled, respectively.

Signed-off-by: Christine Gharzuzi <cgharzuzi@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/hwmon.c            | 6 ++++++
 drivers/misc/habanalabs/include/armcp_if.h | 9 ++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index 3539190b1caa..a21a26e07c3b 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -127,6 +127,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_temp_max_hyst:
 		case hwmon_temp_crit_hyst:
 		case hwmon_temp_offset:
+		case hwmon_temp_highest:
 			break;
 		default:
 			return -EINVAL;
@@ -139,6 +140,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_in_input:
 		case hwmon_in_min:
 		case hwmon_in_max:
+		case hwmon_in_highest:
 			break;
 		default:
 			return -EINVAL;
@@ -151,6 +153,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_curr_input:
 		case hwmon_curr_min:
 		case hwmon_curr_max:
+		case hwmon_curr_highest:
 			break;
 		default:
 			return -EINVAL;
@@ -230,6 +233,7 @@ static umode_t hl_is_visible(const void *data, enum hwmon_sensor_types type,
 		case hwmon_temp_max_hyst:
 		case hwmon_temp_crit:
 		case hwmon_temp_crit_hyst:
+		case hwmon_temp_highest:
 			return 0444;
 		case hwmon_temp_offset:
 			return 0644;
@@ -240,6 +244,7 @@ static umode_t hl_is_visible(const void *data, enum hwmon_sensor_types type,
 		case hwmon_in_input:
 		case hwmon_in_min:
 		case hwmon_in_max:
+		case hwmon_in_highest:
 			return 0444;
 		}
 		break;
@@ -248,6 +253,7 @@ static umode_t hl_is_visible(const void *data, enum hwmon_sensor_types type,
 		case hwmon_curr_input:
 		case hwmon_curr_min:
 		case hwmon_curr_max:
+		case hwmon_curr_highest:
 			return 0444;
 		}
 		break;
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index 014549eaf919..bdd0a4c3a9cf 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -287,19 +287,22 @@ enum armcp_temp_type {
 	armcp_temp_max_hyst,
 	armcp_temp_crit,
 	armcp_temp_crit_hyst,
-	armcp_temp_offset = 19
+	armcp_temp_offset = 19,
+	armcp_temp_highest = 22
 };
 
 enum armcp_in_attributes {
 	armcp_in_input,
 	armcp_in_min,
-	armcp_in_max
+	armcp_in_max,
+	armcp_in_highest = 7
 };
 
 enum armcp_curr_attributes {
 	armcp_curr_input,
 	armcp_curr_min,
-	armcp_curr_max
+	armcp_curr_max,
+	armcp_curr_highest = 7
 };
 
 enum armcp_fan_attributes {
-- 
2.17.1

