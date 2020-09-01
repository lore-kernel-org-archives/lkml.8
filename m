Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7256EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B082087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XeBK6nUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgIAGdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:33:25 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:55915 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbgIAGdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:33:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598942004; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=0UTVYmFpASnVkM9xfwrgbT4cyV5d3QjCO5z9/QLwDYo=; b=XeBK6nUyRF3YOxqpBzu5WFfUPxdlBdvuDjTFqpqq0/94fqG3VQjRQE09bRtrTMuHuOHE50VH
 xKUPvE/WrXhPlmhOPQh6cHjoYfo+8rsoFXMgq9/3Dxidt5frQCsbh6oVI2zKCAos4W07R2Qa
 YKcIrPcxHWQVXLYVSAQ02HZiouU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f4deb32885efaea0a70848c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 06:33:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ACF8FC433A0; Tue,  1 Sep 2020 06:33:21 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E15C4C433CA;
        Tue,  1 Sep 2020 06:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E15C4C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] coresight: cti: write regsiters directly in cti_enable_hw()
Date:   Tue,  1 Sep 2020 14:33:09 +0800
Message-Id: <20200901063309.13739-1-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deadlock as below is triggered by one CPU holds drvdata->spinlock
and calls cti_enable_hw(). Smp_call_function_single() is called
in cti_enable_hw() and tries to let another CPU write CTI registers.
That CPU is trying to get drvdata->spinlock in cti_cpu_pm_notify()
and doesn't response to IPI from smp_call_function_single().

[  988.335937] CPU: 6 PID: 10258 Comm: sh Tainted: G        W    L
5.8.0-rc6-mainline-16783-gc38daa79b26b-dirty #1
[  988.346364] Hardware name: Thundercomm Dragonboard 845c (DT)
[  988.352073] pstate: 20400005 (nzCv daif +PAN -UAO BTYPE=--)
[  988.357689] pc : smp_call_function_single+0x158/0x1b8
[  988.362782] lr : smp_call_function_single+0x124/0x1b8
...
[  988.451638] Call trace:
[  988.454119]  smp_call_function_single+0x158/0x1b8
[  988.458866]  cti_enable+0xb4/0xf8 [coresight_cti]
[  988.463618]  coresight_control_assoc_ectdev+0x6c/0x128 [coresight]
[  988.469855]  coresight_enable+0x1f0/0x364 [coresight]
[  988.474957]  enable_source_store+0x5c/0x9c [coresight]
[  988.480140]  dev_attr_store+0x14/0x28
[  988.483839]  sysfs_kf_write+0x38/0x4c
[  988.487532]  kernfs_fop_write+0x1c0/0x2b0
[  988.491585]  vfs_write+0xfc/0x300
[  988.494931]  ksys_write+0x78/0xe0
[  988.498283]  __arm64_sys_write+0x18/0x20
[  988.502240]  el0_svc_common+0x98/0x160
[  988.506024]  do_el0_svc+0x78/0x80
[  988.509377]  el0_sync_handler+0xd4/0x270
[  988.513337]  el0_sync+0x164/0x180

This change write CTI registers directly in cti_enable_hw().
Config->hw_powered has been checked to be true with spinlock holded.
CTI is powered and can be programmed until spinlock is released.

Fixes: 6a0953ce7de9 ("coresight: cti: Add CPU idle pm notifer to CTI devices")
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight-cti.c | 24 +++++----------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index c4e9cc7034ab..d04181c12a7f 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -86,22 +86,16 @@ void cti_write_all_hw_regs(struct cti_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static void cti_enable_hw_smp_call(void *info)
-{
-	struct cti_drvdata *drvdata = info;
-
-	cti_write_all_hw_regs(drvdata);
-}
-
 /* write regs to hardware and enable */
 static int cti_enable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
 	struct device *dev = &drvdata->csdev->dev;
 	int rc = 0;
+	unsigned long flags;
 
 	pm_runtime_get_sync(dev->parent);
-	spin_lock(&drvdata->spinlock);
+	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* no need to do anything if enabled or unpowered*/
 	if (config->hw_enabled || !config->hw_powered)
@@ -112,19 +106,11 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
 	if (rc)
 		goto cti_err_not_enabled;
 
-	if (drvdata->ctidev.cpu >= 0) {
-		rc = smp_call_function_single(drvdata->ctidev.cpu,
-					      cti_enable_hw_smp_call,
-					      drvdata, 1);
-		if (rc)
-			goto cti_err_not_enabled;
-	} else {
-		cti_write_all_hw_regs(drvdata);
-	}
+	cti_write_all_hw_regs(drvdata);
 
 	config->hw_enabled = true;
 	atomic_inc(&drvdata->config.enable_req_count);
-	spin_unlock(&drvdata->spinlock);
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return rc;
 
 cti_state_unchanged:
@@ -132,7 +118,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
 
 	/* cannot enable due to error */
 cti_err_not_enabled:
-	spin_unlock(&drvdata->spinlock);
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	pm_runtime_put(dev->parent);
 	return rc;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

