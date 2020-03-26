Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CC4C2D0EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A7D2074D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="dKQ15067"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgCZQuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:50:50 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:26389 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727548AbgCZQuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:50:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585241449; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=oRDpgNgHb3P2llPWeY3N6gtLAEuwg4sVWEX58vo5LEE=; b=dKQ15067BzoQ8nkF4uXeDAd8yOdmksxi0PnzGzL1M4i4uXFKK0JvW+yZhru1ABfCu9h6zhAp
 vSOPYy0alybbHGtyLs40QNs1NPIsq2yuGAck+Ix+dX/3Jm5zkgBGBzooOoqxPgwJckFBi44p
 ZWoE6N0oAM0VPvZbK/GoUW42PBU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7cdd69.7f3685436d50-smtp-out-n02;
 Thu, 26 Mar 2020 16:50:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 05D5AC433F2; Thu, 26 Mar 2020 16:50:48 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12206C433F2;
        Thu, 26 Mar 2020 16:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12206C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH 2/2] remoteproc: core: Register the character device interface
Date:   Thu, 26 Mar 2020 09:50:40 -0700
Message-Id: <1585241440-7572-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585241440-7572-1-git-send-email-rishabhb@codeaurora.org>
References: <1585241440-7572-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the character device during rproc_add. This would create
a character device node at /dev/subsys_<rproc_name>. Userspace
applications can interact with the remote processor using this
interface rather than using sysfs node. To distinguish between
different remote processor nodes the device name has been changed
to include the rproc name appended to "rproc_" string.

Change-Id: I2114f77f8d2b5fd97e281021ec9905ef5c2fb54c
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e..f657983 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1907,6 +1907,12 @@ int rproc_add(struct rproc *rproc)
 	struct device *dev = &rproc->dev;
 	int ret;
 
+	ret = rproc_char_device_add(rproc);
+	if (ret) {
+		pr_err("error while adding character device\n");
+		return ret;
+	}
+
 	ret = device_add(dev);
 	if (ret < 0)
 		return ret;
@@ -2044,7 +2050,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
 		return NULL;
 	}
 
-	dev_set_name(&rproc->dev, "remoteproc%d", rproc->index);
+	dev_set_name(&rproc->dev, "rproc_%s", rproc->name);
 
 	atomic_set(&rproc->power, 0);
 
@@ -2220,6 +2226,7 @@ static int __init remoteproc_init(void)
 {
 	rproc_init_sysfs();
 	rproc_init_debugfs();
+	rproc_init_cdev();
 
 	return 0;
 }
@@ -2231,6 +2238,7 @@ static void __exit remoteproc_exit(void)
 
 	rproc_exit_debugfs();
 	rproc_exit_sysfs();
+	rproc_exit_cdev();
 }
 module_exit(remoteproc_exit);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
