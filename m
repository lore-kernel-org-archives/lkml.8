Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498A9C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7F420786
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kQCW/XCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbgDPSjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:39:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37308 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728841AbgDPSjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:39:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587062363; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=v/buFpzpjL4mG4kIZ2jrF/IKuzqpxNBjnqkVAVckdOo=; b=kQCW/XCKoVlYxF8wzhJ0Yvl2Uvj18DN1CMRxlQw90zsPB9J0jPnsNLAq8+ZypbzPP8cFJM08
 UQ7FUCU93HgaCEmuv9GZ3Er2EpGdC0N7cR1NjsvadrTBVrCWCbf27manQmbWjhujjzCjNOOC
 dnF9HHoMyTJU1g+Oq8EbngFFAmA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e98a64b.7fb20023ff10-smtp-out-n05;
 Thu, 16 Apr 2020 18:39:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DD6DBC44788; Thu, 16 Apr 2020 18:39:06 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E93D9C433CB;
        Thu, 16 Apr 2020 18:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E93D9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mathieu.poirier@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH 3/3] remoteproc: Add coredump sysfs attribute
Date:   Thu, 16 Apr 2020 11:38:32 -0700
Message-Id: <1587062312-4939-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
References: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add coredump sysfs attribute to configure the type of memory dump.
User can select between default or inline coredump functionality.
Also coredump collection can be disabled through this interface.
This functionality can be configured differently for different
remote processors.
This provides an option to dynamically configure the dump type
based on userpsace capability.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/remoteproc_sysfs.c | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 7f8536b..d112664 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -9,6 +9,62 @@
 
 #define to_rproc(d) container_of(d, struct rproc, dev)
 
+/*
+ * A coredump-configuration-to-string lookup table, for exposing a
+ * human readable configuration via sysfs. Always keep in sync with
+ * enum rproc_coredump_conf
+ */
+static const char * const rproc_coredump_str[] = {
+	[COREDUMP_DEFAULT]	= "default",
+	[COREDUMP_INLINE]	= "inline",
+	[COREDUMP_DISABLED]	= "disabled",
+};
+
+/* Expose the current coredump configuration via sysfs */
+static ssize_t coredump_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct rproc *rproc = to_rproc(dev);
+
+	return sprintf(buf, "%s\n", rproc_coredump_str[rproc->coredump_conf]);
+}
+
+/* Change the coredump configuration via sysfs */
+static ssize_t coredump_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct rproc *rproc = to_rproc(dev);
+	int err;
+
+	err = mutex_lock_interruptible(&rproc->lock);
+	if (err) {
+		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, err);
+		return -EINVAL;
+	}
+
+	if (rproc->state == RPROC_CRASHED) {
+		dev_err(dev, "can't change coredump configuration\n");
+		err = -EBUSY;
+		goto out;
+	}
+
+	if (sysfs_streq(buf, "disable"))
+		rproc->coredump_conf = COREDUMP_DISABLED;
+	else if (sysfs_streq(buf, "inline"))
+		rproc->coredump_conf = COREDUMP_INLINE;
+	else if (sysfs_streq(buf, "default"))
+		rproc->coredump_conf = COREDUMP_DEFAULT;
+	else {
+		dev_err(dev, "Invalid coredump configuration\n");
+		err = -EINVAL;
+	}
+out:
+	mutex_unlock(&rproc->lock);
+
+	return err ? err : count;
+}
+static DEVICE_ATTR_RW(coredump);
+
 /* Expose the loaded / running firmware name via sysfs */
 static ssize_t firmware_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
@@ -127,6 +183,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 	&dev_attr_firmware.attr,
 	&dev_attr_state.attr,
 	&dev_attr_name.attr,
+	&dev_attr_coredump.attr,
 	NULL
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
