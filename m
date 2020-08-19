Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DB5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330EE206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vmLqJLLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgHSKJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:09:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55157 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgHSKJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:09:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597831764; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Ss165PFmLfrUltmfdxLdXxBgXxOxl/dVF2U4JC6NEFM=; b=vmLqJLLPq6L9iv6s1guDnu1v56RY70pz7LSzCKD6lxiHVbaWfymvlJjLjY0KHD0T0hMlcQQ3
 7lKy481+wVZwUtRbZKcrJEVnFdpN0VVRWbu77yi8xMSDRw+mW+tn2KKmhlMO7lRCpROi7Y4c
 LBKgfKLPFeBlW7TCKp5z72l8By0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f3cfa2d4c787f237be64bdb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 10:08:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C488C433AD; Wed, 19 Aug 2020 10:08:45 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A4EDC433CA;
        Wed, 19 Aug 2020 10:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A4EDC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ulf.hansson@linaro.org, swboyd@chromium.org, dianders@chromium.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 2/2] Revert "Revert "soc: qcom: rpmh: Allow RPMH driver to be loaded as a module""
Date:   Wed, 19 Aug 2020 15:37:50 +0530
Message-Id: <1597831670-17401-3-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597831670-17401-1-git-send-email-mkshah@codeaurora.org>
References: <1597831670-17401-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _rcuidle tracepoints are removed from RPMH driver which prevented
to compile it as module. Bring back the change to make it module.

This reverts commit 1f7a3eb785e4a4e196729cd3d5ec97bd5f9f2940.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/soc/qcom/Kconfig    | 2 +-
 drivers/soc/qcom/rpmh-rsc.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 3dc3e3d..892bdc7 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -92,7 +92,7 @@ config QCOM_RMTFS_MEM
 	  Say y here if you intend to boot the modem remoteproc.
 
 config QCOM_RPMH
-	bool "Qualcomm RPM-Hardened (RPMH) Communication"
+	tristate "Qualcomm RPM-Hardened (RPMH) Communication"
 	depends on ARCH_QCOM || COMPILE_TEST
 	help
 	  Support for communication with the hardened-RPM blocks in
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index fabe390d..5fce87c 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -13,6 +13,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -1025,6 +1026,7 @@ static const struct of_device_id rpmh_drv_match[] = {
 	{ .compatible = "qcom,rpmh-rsc", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, rpmh_drv_match);
 
 static struct platform_driver rpmh_driver = {
 	.probe = rpmh_rsc_probe,
@@ -1040,3 +1042,6 @@ static int __init rpmh_driver_init(void)
 	return platform_driver_register(&rpmh_driver);
 }
 arch_initcall(rpmh_driver_init);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPMh Driver");
+MODULE_LICENSE("GPL v2");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

