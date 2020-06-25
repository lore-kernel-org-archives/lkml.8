Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F381AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD3C20663
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvo+DFOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405426AbgFYOp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405300AbgFYOpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:45:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1293EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:45:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h15so6111972wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bo4xi/0Bx+XFg3im2nhz/8W/RRRM3sogtNr3wocc+Wk=;
        b=zvo+DFOfAZQ/oaCUq+P4yrrb5XLzEu/RYOJYw1Z1GpdjHNjHqYoxAkL201ZNImBMGh
         ZtbRBvEjC1MzV3ZWlOdZIZfM+n/0qZOvPdriNpuwpZ0ChfTHocESNRon6wouJHyq3sFa
         h7i1yf315lZpnsZzX+HMURGOiYo/5y7jdAW+iubXew36e/zHIjrYlPCjB2Hr6PEA5e4z
         CvXqQL+8no0uSTSuihO0gQcjaglKCTOSmzLzTuKb4yc+KMi+1/7sPAFiWg4CRqd+hnRX
         hWgfBM7nU21llXIBg6FIZ1yKqkhnbOfDf3ID9gLXfNBWhNls5AGTxT/8c2VMbHQnkRAZ
         rWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bo4xi/0Bx+XFg3im2nhz/8W/RRRM3sogtNr3wocc+Wk=;
        b=SiePkKtz0k8rHcWS8oWnC4SHN2g5JKbW/r1b4BcrF4iX+rzGWT33n1/AqvoHNZ9hWL
         mHBOCrOFeu7vMEg6lsUzzK2LVQ3C3sUAkq3mbuWHl6apztbBJRQVhCqcQ2Cyy+RCsgH/
         tRVMGY2ZzybN9O+J1SFba5S2Bn710Q7ugrjcrGY7oUIqet4Hfd351BcOZOwVDMDCMV+Q
         OcvC0BaJa1xRCqqPHyU645rk8b6KRq+1wkwgt4uS2QRkCxLroDYWZ7JhW/Vz1NMZwk1V
         9waTaoSjHNBSDrGc4pX+96L18kLrI+z0cnGr0ehsKIkuB20f39bUnSa5xe9/+Yk8Z22i
         I0vw==
X-Gm-Message-State: AOAM530PXBpUrg4hQaF4yOdymw6uPAZHhkz+mZ68N9nrFcG+E08/m+Xi
        wPsB/R5pGFtY8NMJAZIjKdMxow==
X-Google-Smtp-Source: ABdhPJxttvWtD/N+NqZ6N6jSDWnSZOn5hE5xsLRSD9PlyGwK/T8O52c5CNNP3WXOb13WCESBBA8HYQ==
X-Received: by 2002:adf:e908:: with SMTP id f8mr13783328wrm.3.1593096323600;
        Thu, 25 Jun 2020 07:45:23 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id u186sm13062706wmu.10.2020.06.25.07.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 07:45:22 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     srinivas.pandruvada@linux.intel.com, rkumbako@codeaurora.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] thermal: core: Add helpers to browse the cdev, tz and governor list
Date:   Thu, 25 Jun 2020 16:45:05 +0200
Message-Id: <20200625144509.17918-1-daniel.lezcano@linaro.org>
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
index 2a3f83265d8b..e2f8d2550ecd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -611,6 +611,57 @@ void thermal_zone_device_rebind_exception(struct thermal_zone_device *tz,
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

