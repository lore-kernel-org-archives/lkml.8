Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2744EC54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC48F20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHwm7rXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgCWMbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:31:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33775 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgCWMbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:31:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id g18so5873682plq.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OevnXq7eEYKHASkGViX/6POF5UwCr/O5lLFLTc/N8U0=;
        b=mHwm7rXlDkbiGbH9lni18Ooi5wyruE2ZC8wwJTbyamVNy4cOpp1yUvUkdAJUGLwcvB
         gFy+MHZ6zCSRAaCGuqUImMy8HYooVqc2o0QaR0NAVOTRoi30XVq2kIZlZJm7AAFl6yNv
         6sAjwJg8jiA+XwdEx91wECyX4OT8G/LUgHgCHN8yWCwTSqU/VAlx8vPx89gJGRZF+cbQ
         eYuQwVQnVWRVssqrWEIk8TIA5X24m8J0ZW2XxzALtFGHLIcPFdoWO4UjwPrPkUKXKg20
         fvRIzwX+lULwweLUnpcwx+glP0Q5kBcpf6k6hT4NRUXBW0yJdx6FN2/J8kv1Mlqgwf8+
         RT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OevnXq7eEYKHASkGViX/6POF5UwCr/O5lLFLTc/N8U0=;
        b=L4hGR+n0LiJz3w38AVDb6cLrPhdfDBeI3taymNREO7ZlTh2EqDhF0gpNlGekpBxpDn
         0zO0frUgUI4z/lq5SXVghgU455z/+ZDWk/7xAFvwaydCcbkQiWGGgxHS0G3uKqtp4ODP
         ElwwkedvHMbOkG8NGLNWuFpNEJB1W4ryuSuilNvID1TAkb8fhNRyqdDN+VHdsBeoYNtz
         6VN91ucSqTYur2jU/M5MEZvYMo32RRCkZDAGNHLwChk3hrnLP17Ptv40tVqDct2iSKRu
         aW4hKaNVDVfbcwuFpHLae98nINbLF08/qO7q/SbqvkjRG+nxoAXE75vK5u3UguzMY/p6
         5i3Q==
X-Gm-Message-State: ANhLgQ0Sndu4hoXnd6EG0ZJVSgjATh5t2bxV2OG29T+Mj+feksvTGmrj
        mC5kXDQ3RplOs3+U2DHE5LTh
X-Google-Smtp-Source: ADFU+vvWE0EJxVM+nOcooo5S+IzJifzzK5rEhbb9pGmxbRIR7tGARZLY6jgVl+NTEnXlOdkTjrg5BA==
X-Received: by 2002:a17:902:bc47:: with SMTP id t7mr21982260plz.47.1584966675212;
        Mon, 23 Mar 2020 05:31:15 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 144sm3590131pgd.29.2020.03.23.05.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 05:31:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/7] bus: mhi: core: Pass module owner during client driver registration
Date:   Mon, 23 Mar 2020 18:00:56 +0530
Message-Id: <20200323123102.13992-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323123102.13992-1-manivannan.sadhasivam@linaro.org>
References: <20200323123102.13992-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module owner field can be used to prevent the removal of kernel
modules when there are any device files associated with it opened in
userspace. Hence, modify the API to pass module owner field. For
convenience, module_mhi_driver() macro is used which takes care of
passing the module owner through THIS_MODULE of the module of the
driver and also avoiding the use of specifying the default MHI client
driver register/unregister routines.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c |  5 +++--
 include/linux/mhi.h         | 21 +++++++++++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 5fb756ca335e..eb7f556a8531 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -1189,7 +1189,7 @@ static int mhi_driver_remove(struct device *dev)
 	return 0;
 }
 
-int mhi_driver_register(struct mhi_driver *mhi_drv)
+int __mhi_driver_register(struct mhi_driver *mhi_drv, struct module *owner)
 {
 	struct device_driver *driver = &mhi_drv->driver;
 
@@ -1197,12 +1197,13 @@ int mhi_driver_register(struct mhi_driver *mhi_drv)
 		return -EINVAL;
 
 	driver->bus = &mhi_bus_type;
+	driver->owner = owner;
 	driver->probe = mhi_driver_probe;
 	driver->remove = mhi_driver_remove;
 
 	return driver_register(driver);
 }
-EXPORT_SYMBOL_GPL(mhi_driver_register);
+EXPORT_SYMBOL_GPL(__mhi_driver_register);
 
 void mhi_driver_unregister(struct mhi_driver *mhi_drv)
 {
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 79cb9f898544..d83e7772681b 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -514,11 +514,28 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
  */
 void mhi_unregister_controller(struct mhi_controller *mhi_cntrl);
 
+/*
+ * module_mhi_driver() - Helper macro for drivers that don't do
+ * anything special other than using default mhi_driver_register() and
+ * mhi_driver_unregister().  This eliminates a lot of boilerplate.
+ * Each module may only use this macro once.
+ */
+#define module_mhi_driver(mhi_drv) \
+	module_driver(mhi_drv, mhi_driver_register, \
+		      mhi_driver_unregister)
+
+/*
+ * Macro to avoid include chaining to get THIS_MODULE
+ */
+#define mhi_driver_register(mhi_drv) \
+	__mhi_driver_register(mhi_drv, THIS_MODULE)
+
 /**
- * mhi_driver_register - Register driver with MHI framework
+ * __mhi_driver_register - Register driver with MHI framework
  * @mhi_drv: Driver associated with the device
+ * @owner: The module owner
  */
-int mhi_driver_register(struct mhi_driver *mhi_drv);
+int __mhi_driver_register(struct mhi_driver *mhi_drv, struct module *owner);
 
 /**
  * mhi_driver_unregister - Unregister a driver for mhi_devices
-- 
2.17.1

