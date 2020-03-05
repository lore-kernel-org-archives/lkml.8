Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02479C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B86208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="neFlY3Az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgCEFmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:42:52 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46239 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCEFmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:42:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id o24so2182688pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 21:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cNQGrNZI2YLBUBgRppVQ1AFH/YzUKaKdzB/7ZzNdnn8=;
        b=neFlY3AzXQwk38I3fCwFvt5ea+6QcafBvcuXUQgf6wn1h9Fmksg+lwGVKtbXUdFpbD
         iFrEvVLJ/nqm6IVqw2M5/CBrwEwFT94PjdZvxzC4JVTewsKmQokKrRj2IesC0+TfNwxZ
         D2c7SVFaLJaNIbTfn/sTDXldlYxLgmUzHjZhrpNjINbtV+y6ydgeH3ht+VB7S5wiDGIh
         VoKXTeRH9KSswYCSw7P7clX+pqRm+m+MKtHDg65bPZ0FItepMfaNvZzlthJfF/vtn6i5
         kEm0pKmcN8BTcDjq8ABJ6Ts6CXGRI7C4hYuG6l0X9Y/orblbcgQ0GPzMEzCw+Z9DvHHp
         DBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cNQGrNZI2YLBUBgRppVQ1AFH/YzUKaKdzB/7ZzNdnn8=;
        b=WuPFuAIjMWPwLLfzlrjDD1Px7GNBS8RfiHKcU16d9Vdf04Xb79XhwRWPz40hwQW5U0
         nEOEUSr3uSDYH93HylAE9FfR4eYDPePTb4VnL72VUl0pKg9HQxke+kwkcz3wjVcmKK63
         nqmTYds4klmtXtOnE4QzMV+1B5VicrklOVW2lNbxshZavKY/FHuTNvsOn068/+Ie/PFT
         c6sqmmn4nxvQt1JDBuIhLClCCAClwZhnvezbjmDT2eD5Iz2SQzwUa8LXp17Mmd5b5eRE
         Zb3JNhxZYD2ZcPjc/de5VxI9kcP+C+ahqHID3F/FR9K6S2CljEPbdr98l5VYDl+2FNc4
         ru3g==
X-Gm-Message-State: ANhLgQ1/Gp/OneRfpj1wrFUTNnCVUx6eV3F4B7J5NWEDT66N/mBSElMg
        8VcsDPz5rDuV2DVEPtV5hNmhB+XDxTA=
X-Google-Smtp-Source: ADFU+vvzjkS9TGRcblpeqpN0ZPT+dotszbngZ5ty0l0O8K/HOOu6mUTWyw5dOp04GzZet7pPJd+gNA==
X-Received: by 2002:a62:37c7:: with SMTP id e190mr6745679pfa.165.1583386970893;
        Wed, 04 Mar 2020 21:42:50 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id w17sm25177400pfg.33.2020.03.04.21.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 21:42:50 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [RFC][PATCH] soc: qcom: rpmpd: Allow RPMPD driver to be loaded as a module
Date:   Thu,  5 Mar 2020 05:42:44 +0000
Message-Id: <20200305054244.128950-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the rpmpd driver to be loaded as a module.

Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/soc/qcom/Kconfig | 4 ++--
 drivers/soc/qcom/rpmpd.c | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index d0a73e76d563..af774555b9d2 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -123,8 +123,8 @@ config QCOM_RPMHPD
 	  for the voltage rail.
 
 config QCOM_RPMPD
-	bool "Qualcomm RPM Power domain driver"
-	depends on QCOM_SMD_RPM=y
+	tristate "Qualcomm RPM Power domain driver"
+	depends on QCOM_SMD_RPM
 	help
 	  QCOM RPM Power domain driver to support power-domains with
 	  performance states. The driver communicates a performance state
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 2b1834c5609a..9c0834913f3f 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -5,6 +5,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
+#include <linux/module.h>
 #include <linux/pm_domain.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -226,6 +227,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, rpmpd_match_table);
 
 static int rpmpd_send_enable(struct rpmpd *pd, bool enable)
 {
@@ -421,4 +423,5 @@ static int __init rpmpd_init(void)
 {
 	return platform_driver_register(&rpmpd_driver);
 }
-core_initcall(rpmpd_init);
+module_init(rpmpd_init);
+MODULE_LICENSE("GPL");
-- 
2.17.1

