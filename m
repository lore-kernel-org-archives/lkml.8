Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF0CC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F8822240
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qRg50FMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410729AbgDPQP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:15:56 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:49567 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1414566AbgDPQPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:15:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587053739; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=uiTtZTUVcrXfRLw4Pyx+w5Ah1e9TiEjRyiJheqElgkA=; b=qRg50FMSPBXrpZgzv9r/h1UMMSiL1xcC7Y/FClpB4uGre0cPgu0CIGpUqqXCtZu519T+9Vpp
 PMb3H/xhds1cyOS5acq/u1hIkv90rax9Ps7AqxJSjMLFOaRiH7Eq3wmHexhvH36fcQlWmyu/
 NMgQdx7z1O9Kbn5QBYGCS+jP7oA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e988498.7fe87ecc82d0-smtp-out-n01;
 Thu, 16 Apr 2020 16:15:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 860AEC44792; Thu, 16 Apr 2020 16:15:19 +0000 (UTC)
Received: from blr-ubuntu-311.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62E86C433CB;
        Thu, 16 Apr 2020 16:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62E86C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        mike.leach@linaro.org, Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCHv2] coresight: tmc: Fix TMC mode read in tmc_read_prepare_etb()
Date:   Thu, 16 Apr 2020 21:44:59 +0530
Message-Id: <20200416161459.29855-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some QCOM platforms like SC7180, SDM845 and SM8150,
reading TMC mode register without proper coresight power
management can lead to async exceptions like the one in
the call trace below in tmc_read_prepare_etb(). This can
happen if the user tries to read the TMC etf data via
device node without setting up source and the sink first.
Fix this by having a check for coresight sysfs mode
before reading TMC mode management register.

 Kernel panic - not syncing: Asynchronous SError Interrupt
 CPU: 7 PID: 2605 Comm: hexdump Tainted: G S                5.4.30 #122
 Call trace:
  dump_backtrace+0x0/0x188
  show_stack+0x20/0x2c
  dump_stack+0xdc/0x144
  panic+0x168/0x36c
  panic+0x0/0x36c
  arm64_serror_panic+0x78/0x84
  do_serror+0x130/0x138
  el1_error+0x84/0xf8
  tmc_read_prepare_etb+0x88/0xb8
  tmc_open+0x40/0xd8
  misc_open+0x120/0x158
  chrdev_open+0xb8/0x1a4
  do_dentry_open+0x268/0x3a0
  vfs_open+0x34/0x40
  path_openat+0x39c/0xdf4
  do_filp_open+0x90/0x10c
  do_sys_open+0x150/0x3e8
  __arm64_compat_sys_openat+0x28/0x34
  el0_svc_common+0xa8/0x160
  el0_svc_compat_handler+0x2c/0x38
  el0_svc_compat+0x8/0x10

Fixes: 4525412a5046 ("coresight: tmc: making prepare/unprepare functions generic")
Reported-by: Stephen Boyd <swboyd@chromium.org>
Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
v2:
 * Move the TMC mode read under CS_MODE_SYSFS as per Mathieu
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d0cc3985b72a..36cce2bfb744 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -596,13 +596,6 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 		goto out;
 	}
 
-	/* There is no point in reading a TMC in HW FIFO mode */
-	mode = readl_relaxed(drvdata->base + TMC_MODE);
-	if (mode != TMC_MODE_CIRCULAR_BUFFER) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	/* Don't interfere if operated from Perf */
 	if (drvdata->mode == CS_MODE_PERF) {
 		ret = -EINVAL;
@@ -616,8 +609,15 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	/* Disable the TMC if need be */
-	if (drvdata->mode == CS_MODE_SYSFS)
+	if (drvdata->mode == CS_MODE_SYSFS) {
+		/* There is no point in reading a TMC in HW FIFO mode */
+		mode = readl_relaxed(drvdata->base + TMC_MODE);
+		if (mode != TMC_MODE_CIRCULAR_BUFFER) {
+			ret = -EINVAL;
+			goto out;
+		}
 		__tmc_etb_disable_hw(drvdata);
+	}
 
 	drvdata->reading = true;
 out:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
