Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D089C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644E020700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 18:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gcArO+Ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgDZS6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 14:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726208AbgDZS6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 14:58:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA400C061A41
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s18so4859049pgl.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noMrbgL1v2kzIBYfD0+OneUE3HearHlx1xTI8N0UkeU=;
        b=gcArO+IbQ1Yfcn/7FcXBVLKjbmyJ5VuBH/upO/eC6zjYuLDLsPIwqrgw/uQm4n9D8J
         hM7YhOGJBsrM5Q6Dkh2na9vKhr6sTp96HDvdrz9okTXc5FbVRReGVGJ0lAlCsAg/qjod
         Rz+HszoxhcEhePkfbqNlsrUvvYk5OiNwpVa6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noMrbgL1v2kzIBYfD0+OneUE3HearHlx1xTI8N0UkeU=;
        b=H5W6UMqn4Z76EyooLON00vfPTqDK3NtffVACe/yKTUE5+uvJhltVNeFZ8xV9mJgsmC
         felh7WRO/O2hEskYvY/ItyfivoNqjKo6gdi79htXuKkB3f8TU0eM3IYe15/qpnD7RcXa
         AP9JlRsVe6DsuwhXDaKWjKKrO2CknCRO/gaZV/mypEo++x07Z9kL7AxW6sNP6YXOpwQ9
         0Jzexbo9Z8/RykKYqjJixZOzsB7Sli4hYxOnVP9uiqUGf897hKq9G54qk1WpTkw06Quv
         Vi/jx5MtUhAjWtnXtF44Hx6VigRvuQfLNEt+LAr2i2nyBoZsRMEaNfk2442kX5V5CDhH
         MHHg==
X-Gm-Message-State: AGi0PuYd9ogYeSu0aPXs4Iai+Yfg1AwGnQVZsV+DCgD3XAswQdEoWZ4B
        bHc482Wy8JWRjJfrsHSq3VInkA==
X-Google-Smtp-Source: APiQypItWeQCh4VuQPKDIWC8ZjlXOMK1Td48DeJ/E5GZYS7IzEcCDPmQ3cfILg8YZ2ZI69Pu9KJRNw==
X-Received: by 2002:a63:c241:: with SMTP id l1mr3014492pgg.42.1587927488448;
        Sun, 26 Apr 2020 11:58:08 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h27sm9425153pgb.90.2020.04.26.11.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 11:58:08 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 2/5] coresight: Mark some functions static
Date:   Sun, 26 Apr 2020 11:58:02 -0700
Message-Id: <20200426185805.14923-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200426185805.14923-1-swboyd@chromium.org>
References: <20200426185805.14923-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions aren't used outside the file they're in. Mark them
static to indicate as such and silence tools like sparse.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hwtracing/coresight/coresight-cti-platform.c | 3 +--
 drivers/hwtracing/coresight/coresight-cti-sysfs.c    | 2 +-
 drivers/hwtracing/coresight/coresight-cti.c          | 6 +++---
 drivers/hwtracing/coresight/coresight-etb10.c        | 2 +-
 drivers/hwtracing/coresight/coresight-platform.c     | 4 ++--
 drivers/hwtracing/coresight/coresight-tmc.c          | 2 +-
 6 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
index 245f16c61af8..ab3bd4ed0910 100644
--- a/drivers/hwtracing/coresight/coresight-cti-platform.c
+++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
@@ -435,8 +435,7 @@ static int cti_plat_create_impdef_connections(struct device *dev,
 }
 
 /* get the hardware configuration & connection data. */
-int cti_plat_get_hw_data(struct device *dev,
-			 struct cti_drvdata *drvdata)
+static int cti_plat_get_hw_data(struct device *dev, struct cti_drvdata *drvdata)
 {
 	int rc = 0;
 	struct cti_device *cti_dev = &drvdata->ctidev;
diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index bed460541f15..7da846a3a829 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -1146,7 +1146,7 @@ static int cti_create_con_attr_set(struct device *dev, int con_idx,
 }
 
 /* create the array of group pointers for the CTI sysfs groups */
-int cti_create_cons_groups(struct device *dev, struct cti_device *ctidev)
+static int cti_create_cons_groups(struct device *dev, struct cti_device *ctidev)
 {
 	int nr_groups;
 
diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index aa6e0249bd70..aac9a0d91e19 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -19,7 +19,7 @@
  */
 
 /* net of CTI devices connected via CTM */
-LIST_HEAD(ect_net);
+static LIST_HEAD(ect_net);
 
 /* protect the list */
 static DEFINE_MUTEX(ect_mutex);
@@ -578,12 +578,12 @@ int cti_disable(struct coresight_device *csdev)
 	return cti_disable_hw(drvdata);
 }
 
-const struct coresight_ops_ect cti_ops_ect = {
+static const struct coresight_ops_ect cti_ops_ect = {
 	.enable = cti_enable,
 	.disable = cti_disable,
 };
 
-const struct coresight_ops cti_ops = {
+static const struct coresight_ops cti_ops = {
 	.ect_ops = &cti_ops_ect,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 3810290e6d07..03e3f2590191 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -717,7 +717,7 @@ static const struct attribute_group coresight_etb_mgmt_group = {
 	.name = "mgmt",
 };
 
-const struct attribute_group *coresight_etb_groups[] = {
+static const struct attribute_group *coresight_etb_groups[] = {
 	&coresight_etb_group,
 	&coresight_etb_mgmt_group,
 	NULL,
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 43418a2126ff..8639f6981794 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -501,7 +501,7 @@ static inline bool acpi_validate_dsd_graph(const union acpi_object *graph)
 }
 
 /* acpi_get_dsd_graph	- Find the _DSD Graph property for the given device. */
-const union acpi_object *
+static const union acpi_object *
 acpi_get_dsd_graph(struct acpi_device *adev)
 {
 	int i;
@@ -564,7 +564,7 @@ acpi_validate_coresight_graph(const union acpi_object *cs_graph)
  * Returns the pointer to the CoreSight Graph Package when found. Otherwise
  * returns NULL.
  */
-const union acpi_object *
+static const union acpi_object *
 acpi_get_coresight_graph(struct acpi_device *adev)
 {
 	const union acpi_object *graph_list, *graph;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 1cf82fa58289..39fba1d16e6e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -361,7 +361,7 @@ static const struct attribute_group coresight_tmc_mgmt_group = {
 	.name = "mgmt",
 };
 
-const struct attribute_group *coresight_tmc_groups[] = {
+static const struct attribute_group *coresight_tmc_groups[] = {
 	&coresight_tmc_group,
 	&coresight_tmc_mgmt_group,
 	NULL,
-- 
Sent by a computer, using git, on the internet

