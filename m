Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71360C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413A22076A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8lXHlji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgCXGLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:11:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32978 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgCXGLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:11:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id d17so7938092pgo.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 23:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CWXhPTqqgepnsjPzgYIPAI8S04yC8VZS0reJOBbfgeg=;
        b=Y8lXHljihHsfPKuEdYKtmDrsZdDaz9wsEapDt3e8zKF0S/5gLZIU10e9EcZloh+sNp
         LvVOZo0gn6ylWSiKDmLVrZUt5xbegyhi6GzOFavzrKgFG6q7cYM8NxMcGsewfIaewakw
         Ygx+OM6hrFIjFItSy+mz0MuGHIcSyu1cu4RyoV2SvN5P0lqpnN//OdN5p787PlNgDOLR
         hzjlncNMhx3QSPE3iwlcvzpBfyOhRRxR+cmn6yqCrHIzy05eYUyleCx6mK3EkeMKhwc0
         9OOtXf5iDDDC5HlXweWRnIZjE76AFCCDgKq/XKiBW8AUaiHZw4Z45QY7Fc86b+4bXFag
         QJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CWXhPTqqgepnsjPzgYIPAI8S04yC8VZS0reJOBbfgeg=;
        b=rZmzipx61/BFcbp0uSpovpWqMGP0ytT43unIy7glp/jqxTNZgKEWZOkUNv5fsI143W
         c2ipXQ6JZMzqKhPUodISITLkWPcLa/3fa6xlVna8XAlZyymSOxAEQ0PpBAwxu7PL9LiK
         MwbdYaEds33AZWkvM0eMesOgWS3Vq76I9e5YqagHsqW52vcI0mzdqjzOwQQPQvuNl5ZK
         zLnCnlGiFtjroFrBF/2/EL4qscG6TwwepMaB0nDuQmcGSjXUdtG//kfxHHAYJNYOjeKG
         2du5ubvb5vpvVVZUZFXzqdU04O4JhQrvCRvVhXZyK8/+eLsQaLIqfxgBtSNrljo2Lb2n
         FwFg==
X-Gm-Message-State: ANhLgQ3uuarAExSe5x3XGc+rZHexUOpxZEtetG6IXN3tf7Zg07Y1x2c+
        lSPsHLrzUZq5suBk5PKtH4o6
X-Google-Smtp-Source: ADFU+vtstP2kvPuqcNqNKvrS1i71Dq5mSEmTtY4nnQSokaKvEMztcUtG8h+nY48r6P5HSPyjEHmDMA==
X-Received: by 2002:a63:f258:: with SMTP id d24mr26529837pgk.307.1585030266451;
        Mon, 23 Mar 2020 23:11:06 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:59b:91e:2dd6:dffe:3569:b473])
        by smtp.gmail.com with ESMTPSA id d3sm1198230pjc.42.2020.03.23.23.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:11:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/7] bus: mhi: core: Pass module owner during client driver registration
Date:   Tue, 24 Mar 2020 11:40:44 +0530
Message-Id: <20200324061050.14845-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
References: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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

