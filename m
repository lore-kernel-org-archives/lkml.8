Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41BAC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85831208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jdkX6l3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgD1SKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgD1SKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:10:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DCC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:10:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n16so10758543pgb.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzR0VAatcGCv2TaFAPhug2WYMJZ8JLRsVVUKQdZJepo=;
        b=jdkX6l3UqUCLDCTewHorQRjMf21oxTo6rOvLVMIJNk2uIdHTHZzvqWa5kgmcPOrxUi
         NWQEMSjo6yk0IWsdl+dHB1UVJNpsjboN+5JgTrsmDUL1lhFMxR4mEfucfx3Ejm52yNJq
         4AVDhISobCn3yLHKS0nzOIqhewaE+HztbgNOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzR0VAatcGCv2TaFAPhug2WYMJZ8JLRsVVUKQdZJepo=;
        b=qWXU3acLeSSq5I4vpiGFTbDqOk83raqBQ8yILuf2CSIFEaGFVM3Coeeb/ATUlJigfn
         PvJ2pwb+JRFKxmZTi9THbAawFOqLqBaRSuKASNhQH4/RGiO9ZWJ+Kj1N+acZsn4bSnkl
         /S4QI1v7ty+GZ2UyPaahzV680rvbV6OXVCmO66kqEVFKNjuVNfgQk2U7lOMVh8Z29cCG
         pevN1ricQEvkwqKaDn2NPi2xth+FDudocz5w0Jn5W6DAbxM0L8Z5l9lPXnnqPdqkKlxM
         5LKIzQ8jJCwG3nZE6xSr9+2htm6QLkyqOWNLD606YhTGYG/We8fkAuIOFCHYv+3GyxPC
         NcsA==
X-Gm-Message-State: AGi0PuYGOMoEwvNlTt3hcJFE8/74SiNOmsKvvGB3jwhXpy9V5HpRbqBf
        hfNDaxzQh+XCNpibEfDfOHI40A==
X-Google-Smtp-Source: APiQypIbQFQdy+iWWUMbbuNFGA5jRE5oHCH/IGvzlWQeCyuF1u6U87LYpWBmIbmboyJidQzTnibkxQ==
X-Received: by 2002:aa7:9ac9:: with SMTP id x9mr12944651pfp.304.1588097412814;
        Tue, 28 Apr 2020 11:10:12 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h197sm16260910pfe.208.2020.04.28.11.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 11:10:12 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 1/2] coresight: Include required headers in C files
Date:   Tue, 28 Apr 2020 11:10:09 -0700
Message-Id: <20200428181010.170568-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200428181010.170568-1-swboyd@chromium.org>
References: <20200428181010.170568-1-swboyd@chromium.org>
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
 .../hwtracing/coresight/coresight-cti-platform.c    |  8 +++++++-
 drivers/hwtracing/coresight/coresight-cti-sysfs.c   |  7 +++++++
 drivers/hwtracing/coresight/coresight-cti.c         | 13 +++++++++++++
 drivers/hwtracing/coresight/coresight-cti.h         |  8 +++++++-
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
index c6c0c9b4827e..ab3bd4ed0910 100644
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
index aeea39cbd161..77e14e770806 100644
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
 
diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index 7fc1fc8d7738..be61c1705916 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -4,7 +4,20 @@
  * Author: Mike Leach <mike.leach@linaro.org>
  */
 
+#include <linux/amba/bus.h>
+#include <linux/atomic.h>
+#include <linux/bits.h>
+#include <linux/coresight.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/spinlock.h>
+
+#include "coresight-priv.h"
 #include "coresight-cti.h"
 
 /**
diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
index 004df3ab9dd0..acf7b545e6b9 100644
--- a/drivers/hwtracing/coresight/coresight-cti.h
+++ b/drivers/hwtracing/coresight/coresight-cti.h
@@ -7,8 +7,14 @@
 #ifndef _CORESIGHT_CORESIGHT_CTI_H
 #define _CORESIGHT_CORESIGHT_CTI_H
 
-#include <asm/local.h>
+#include <linux/coresight.h>
+#include <linux/device.h>
+#include <linux/fwnode.h>
+#include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
 #include "coresight-priv.h"
 
 /*
-- 
Sent by a computer, using git, on the internet

