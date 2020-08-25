Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF05C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983AF20715
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MHoY2Hw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgHYLWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:22:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13195 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729981AbgHYLWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:22:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598354528; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=KLf2zBaDDS5tD2z7RxlmoPAxmVgtqNHM5SLIOWEITKI=; b=MHoY2Hw6oqNQq7Ga9Y0Vvx+cKUnavpWoyLJzJXU7x4t43BoiClkrbcZWq4NocRJ+arSO46xE
 mcgI9t0pS0wWg1ekKgU+VC1+F//06AvVd0ttrB2CNZP9wDuctyBVx2Os3XAVoLOomr4qb2Rv
 VOF4kvEvXUghvsNrEfpbBIucp9w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f44f4504413b7d5db475923 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 Aug 2020 11:21:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 096F3C43391; Tue, 25 Aug 2020 11:21:52 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA220C433CA;
        Tue, 25 Aug 2020 11:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA220C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ulf.hansson@linaro.org, swboyd@chromium.org, dianders@chromium.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        John Stultz <john.stultz@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v2 2/2] soc: qcom: rpmh: Allow RPMH driver to be loaded as a module
Date:   Tue, 25 Aug 2020 16:51:22 +0530
Message-Id: <1598354482-15491-3-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598354482-15491-1-git-send-email-mkshah@codeaurora.org>
References: <1598354482-15491-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <john.stultz@linaro.org>

This patch allow the rpmh driver to be loaded as a permenent
module. Meaning it can be loaded from a module, but then cannot
be unloaded.

Ideally, it would include a remove hook and related logic, but
the rpmh driver is fairly core to the system, so once its loaded
with almost anything else to get the system to go, the dependencies
are not likely to ever also be removed.

So making it a permanent module at least improves things slightly
over requiring it to be a built in driver.

Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
[mkshah: Fix typos in commit message, send after removing _rcuidle trace]
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

