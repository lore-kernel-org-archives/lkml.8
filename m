Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE29C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218CF20752
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="J6gb8ana"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgCTXgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:36:38 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:26250 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726851AbgCTXgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:36:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584747395; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=kWl2oYWfBPVLMLG1p4eJPUX2txbmOHZxIQKSjE0B98E=; b=J6gb8ana4ZhKc8b/D+sV8tv6RBsrgRopPxINkaMBsfHO4uZCWjBqniUK0a+zpglTGzOeO8c/
 UFmla/66bWmpN+618hRgcnwsxplCETysn6wFyugw7YHZD76ALEVW7vp6DS1JqmpjvRDX2srv
 xU6W/ZR3jXueSiEOOuvhD7BT7j0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e75537d.7f6bc1a32b58-smtp-out-n02;
 Fri, 20 Mar 2020 23:36:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E6158C4478F; Fri, 20 Mar 2020 23:36:28 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F2FDC43637;
        Fri, 20 Mar 2020 23:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F2FDC43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org
Cc:     psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH 2/2] remoteproc: core: Register the character device interface
Date:   Fri, 20 Mar 2020 16:36:17 -0700
Message-Id: <1584747377-14824-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584747377-14824-1-git-send-email-rishabhb@codeaurora.org>
References: <1584747377-14824-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the character device during rproc_add. This would create
a character device node at /dev/subsys_<rproc_name>. Userspace
applications can interact with the remote processor using this
interface rather than using sysfs node. To distinguish between
different remote processor nodes the device name has been changed
to include the rproc name appended to "subsys_" string.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e..48a3932 100644
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
+	dev_set_name(&rproc->dev, "subsys_%s", rproc->name);
 
 	atomic_set(&rproc->power, 0);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
