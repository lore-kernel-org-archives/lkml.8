Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F88FC55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F66206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BdVhKtLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgDZS6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726165AbgDZS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:58:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8AAC061A10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t9so6436627pjw.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Nh28scNPsJXa8VBHQt4qXLeY3lEoVVK2enXEW037c0=;
        b=BdVhKtLAP0JExFZ1sxuVIzCP4UamXqGzOA3++lUZEsFGktO/3zTuXEeXwpJHFRA6FY
         3avnihY1WBEmDoPBBzZ1g4DoNSlELeEHrnEHsEGR8DPCqyyjvzRl13d4R0OJMzKE9a93
         13WwOc+ATON9XvG0YCvzqL5Da1nr39Jbr0gNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Nh28scNPsJXa8VBHQt4qXLeY3lEoVVK2enXEW037c0=;
        b=EK3rwgtR4nX/8fNeQcMAqneSKOg72kHSutdJDTHe7Br2peCYLbMDSA2Z6wQUSxkM8q
         uiQ3TqGv6fUMXvqbnJhrmv82BywQF44iINmzwOy1tEJ47JP4Ofo4zzy+s8QvWp8L+ppj
         mPqsTryPAdVxCFtoJ9lK5PYvaslTQoyYOMlKaTH79kwY4iQYurPkI79981hyGhnMt34m
         mzvsWEz72QhG0mbI30/64iVjjF3iqrra5EMp6SBbUaUCeGIahtblUW0UjNsfk3fZCC0u
         vTb/YrF/j1nce6M9mdtfzSF2uH2TLN3LOFy011jgcviKrIkTBpAehvY8pl0qh131jaHg
         ybWA==
X-Gm-Message-State: AGi0PuZiLWamySBnhbn+q4KNUZa9GoXlVyzsCotnm3rthjo5Vj8BfxXA
        HzBZVpb7KEDBhEtwBJwMmXqkMQ==
X-Google-Smtp-Source: APiQypJBNQXj9WHyF+IHGBzdHYcC2ttp7i7C/jxQ8C7MxpSFBYk7GD5NVXVTP8g1XaGKZmouC3xE1Q==
X-Received: by 2002:a17:90a:6fe4:: with SMTP id e91mr19725593pjk.28.1587927487680;
        Sun, 26 Apr 2020 11:58:07 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h27sm9425153pgb.90.2020.04.26.11.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 11:58:07 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 1/5] coresight: Include required headers in C files
Date:   Sun, 26 Apr 2020 11:58:01 -0700
Message-Id: <20200426185805.14923-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200426185805.14923-1-swboyd@chromium.org>
References: <20200426185805.14923-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should include headers that C files use in the C files that use them
and avoid relying on implicit includes as much as possible. This helps
avoid compiler errors in the future about missing declarations when
header files change includes in the future.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hwtracing/coresight/coresight-cti-platform.c |  8 +++++++-
 drivers/hwtracing/coresight/coresight-cti-sysfs.c    |  7 +++++++
 drivers/hwtracing/coresight/coresight-cti.h          | 10 +++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
index b44d83142b62..245f16c61af8 100644
--- a/drivers/hwtracing/coresight/coresight-cti-platform.c
+++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
@@ -2,11 +2,17 @@
 /*
  * Copyright (c) 2019, The Linaro Limited. All rights reserved.
  */
+#include <linux/coresight.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/slab.h>
 
 #include <dt-bindings/arm/coresight-cti-dt.h>
-#include <linux/of.h>
 
 #include "coresight-cti.h"
+#include "coresight-priv.h"
 
 /* Number of CTI signals in the v8 architecturally defined connection */
 #define NR_V8PE_IN_SIGS		2
diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index 1f8fb7c15e80..bed460541f15 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -4,7 +4,14 @@
  * Author: Mike Leach <mike.leach@linaro.org>
  */
 
+#include <linux/atomic.h>
 #include <linux/coresight.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/sysfs.h>
 
 #include "coresight-cti.h"
 
diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
index 004df3ab9dd0..d80123b905a8 100644
--- a/drivers/hwtracing/coresight/coresight-cti.h
+++ b/drivers/hwtracing/coresight/coresight-cti.h
@@ -7,8 +7,10 @@
 #ifndef _CORESIGHT_CORESIGHT_CTI_H
 #define _CORESIGHT_CORESIGHT_CTI_H
 
-#include <asm/local.h>
+#include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
+
 #include "coresight-priv.h"
 
 /*
@@ -52,6 +54,12 @@
  */
 #define CTIINOUTEN_MAX		32
 
+struct attribute;
+struct attribute_group;
+struct coresight_device;
+struct device;
+struct fwnode_handle;
+
 /**
  * Group of related trigger signals
  *
-- 
Sent by a computer, using git, on the internet

