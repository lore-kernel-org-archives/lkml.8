Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A90C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80760206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bz50d4RF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgDZS6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726208AbgDZS6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:58:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82BAC061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fu13so5782350pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gpZt5E1cSry4QDL3jmZLHdrOTZu3mS+7CXPfuznfxa0=;
        b=bz50d4RFZxXlsiYmc7eURFKnPKA8T97a4cJLMR9MKiedXJK661qh2I+r0rKGBepfSu
         dI0iNH4GSNHq7CJKJKinUa1pL3VmdVdxyoDAoum4WFs9CkQ5nsUaWc90rCKNPhIBv2C7
         pxn8MIthIPm3ObUUy5SyaegcU/VqLPeW3FRc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gpZt5E1cSry4QDL3jmZLHdrOTZu3mS+7CXPfuznfxa0=;
        b=J2AC8u3AY4AADVrtie+DT5khE9O2PYxfgxCzNAEjtjQ6auSwHBhBSXAZ0ZRgqIi7CB
         zQTFwgxy25MXuxbMjHN+CP1/lwLIbPZMqSqWbFzR6SA79RipDHC3bH3cBo9KIVMQNXjv
         lf2gl5BQk4i7Tolnm1JGemPm7Mt7IBc1eRC/Vcv2ln68P6KavNMse0isTrpgGSsBT97/
         WwZiOXMjAL//TnL7BnKMxc0m9WCIMZfZniFctm9CEN4ERVG6tLRfLSrphqSr2zBtlbZH
         qt+MZIHkYMmZ+5iAT2sWK1LsO/dgyxLBrDMuiwwiKzkRtB4BP72gQxNBfLWsvTX3XNlw
         /LAQ==
X-Gm-Message-State: AGi0PubGJ01HzSmWnPI+mEgy7YI4gUu3ygnpsnOHHdd59o4D8SCjg5qK
        +V+TNHEKgIm+/0Fz7wDHImeA0g==
X-Google-Smtp-Source: APiQypLSk4G4qJYhxhL3iDl2db9jRsm+BPlCR5fOXBSFr23B/iAKgpxCxjBmCxA4xcH9swcCmtX5tw==
X-Received: by 2002:a17:90a:9295:: with SMTP id n21mr19939827pjo.195.1587927490198;
        Sun, 26 Apr 2020 11:58:10 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h27sm9425153pgb.90.2020.04.26.11.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 11:58:09 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 4/5] coresight: Initialize arg in sparse friendly way
Date:   Sun, 26 Apr 2020 11:58:04 -0700
Message-Id: <20200426185805.14923-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200426185805.14923-1-swboyd@chromium.org>
References: <20200426185805.14923-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse gets annoyed when this initializer is 0 but the first struct
member is a pointer. Just use { } to initialize instead so that sparse
is quiet.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 2 +-
 drivers/hwtracing/coresight/coresight-etm4x.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index e2cb6873c3f2..bf22dcfd3327 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -504,7 +504,7 @@ static int etm_enable_perf(struct coresight_device *csdev,
 static int etm_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	struct etm_enable_arg arg = { 0 };
+	struct etm_enable_arg arg = { };
 	int ret;
 
 	spin_lock(&drvdata->spinlock);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index a90d757f7043..0f850efc1c82 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -412,7 +412,7 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 static int etm4_enable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	struct etm4_enable_arg arg = { 0 };
+	struct etm4_enable_arg arg = { };
 	int ret;
 
 	spin_lock(&drvdata->spinlock);
-- 
Sent by a computer, using git, on the internet

