Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509A2C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206C92073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flZpKzNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCZWpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:45:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33393 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgCZWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:45:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id j1so3539549pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BibBtGLwvmKQbx0thQsTKW+m6NhfuyqCvXSj60tccDo=;
        b=flZpKzNJcKTxocpBQsnbos0dcK3aTkIvYGIK9dtTslwcM1iiJ1s0l8VJhBlBLG8UQ6
         I/3J/RcTYzwclhVvm5EYqR/ZzX09Kh/SxlvtdomLiMb4PQlqY1/ROIUCrxYdNGUHP/6p
         oDEfMDj32AHSQGD0IPXy4cC2zDHC6wH1EzS5T1Zej6ehS5fTjqwrjxmsfUeotYtcH0H/
         WCqTEoyC5Wqc2ghhQV0GM5GoLw9o2Omrx1xtAb9WlAjy7RukGMNbXYGynHB0h/TiVxnE
         Jlr0yYuGZo6VPMKx8aZiGnMWRwfWYclIexDl7oKyEAlyRhkwYGd4JZe3ufZXEEqYDeQ7
         yQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BibBtGLwvmKQbx0thQsTKW+m6NhfuyqCvXSj60tccDo=;
        b=GuFyBhAQsF+kxrYyc1nDFYsr92tDqtHnN5jPwCSyWYca5KH1tpjmX64GK5B7vr6jtU
         NSjoDEHB64HzYHACv/buFi9sn/Wp3gApDxEW4NA9TRNL3YUXDNYLEnVBMwBhPdM0FXk4
         T+ZXSNbwaT+0qQ+B3twyFXXMF3oTxVnTX+RO7rgQ+Xhsob0L+dDspj2ZicD8fZm1qm7q
         DNJq1Bc7jMRmEkgo8YDDdb+uoU2KCVENbmuANrgNz2P+9q70H6t7IlQCoaY25JwnyvaN
         aivKhmmbHEF6aRnezfVRHTYqvZUA8llT+V346FNt6L/echi4FoCfEdmSnjFn+S+beejx
         IaaA==
X-Gm-Message-State: ANhLgQ2NSaAY/mbJ4HBu+tu9mfeZi4MEImvrZsnBAS/PWR2eT9rc578Q
        L/L9njGRLjkD5Fs0IikiV2oPQizT938=
X-Google-Smtp-Source: ADFU+vsJ1o2UHUr5ZHKd/XXcN8AZhYuiYsHkoVFN14N8MhOoYypiyukKcfGgQMCKoQycbMrNm8DnWg==
X-Received: by 2002:a63:a55d:: with SMTP id r29mr11142296pgu.248.1585262705086;
        Thu, 26 Mar 2020 15:45:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id g10sm2592788pfk.90.2020.03.26.15.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 15:45:04 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 2/3] soc: qcom: rpmh: Allow RPMH driver to be loaded as a module
Date:   Thu, 26 Mar 2020 22:44:58 +0000
Message-Id: <20200326224459.105170-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326224459.105170-1-john.stultz@linaro.org>
References: <20200326224459.105170-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allow the rpmh driver to be loaded as a permenent
module. Meaning it can be loaded from a module, but then cannot
be unloaded.

Ideally, it would include a remove hook and related logic, but
the rpmh driver is fairly core to the system, so once its loaded
with almost anythign else to get the system to go, the dependencies
are not likely to ever also be removed.

So making it a permenent module at least improves things slightly
over requiring it to be a built in driver.

Feedback would be appreciated!

Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/soc/qcom/Kconfig    | 2 +-
 drivers/soc/qcom/rpmh-rsc.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index af774555b9d2..ac91eaf810f7 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -104,7 +104,7 @@ config QCOM_RMTFS_MEM
 	  Say y here if you intend to boot the modem remoteproc.
 
 config QCOM_RPMH
-	bool "Qualcomm RPM-Hardened (RPMH) Communication"
+	tristate "Qualcomm RPM-Hardened (RPMH) Communication"
 	depends on ARCH_QCOM && ARM64 || COMPILE_TEST
 	help
 	  Support for communication with the hardened-RPM blocks in
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index e278fc11fe5c..30585d98fdf1 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -679,6 +680,8 @@ static const struct of_device_id rpmh_drv_match[] = {
 	{ .compatible = "qcom,rpmh-rsc", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, rpmh_drv_match);
+
 
 static struct platform_driver rpmh_driver = {
 	.probe = rpmh_rsc_probe,
@@ -693,3 +696,6 @@ static int __init rpmh_driver_init(void)
 	return platform_driver_register(&rpmh_driver);
 }
 arch_initcall(rpmh_driver_init);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPMh Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

