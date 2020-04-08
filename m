Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46987C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 22:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2CC206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 22:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XQ+j2Ts1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDHWSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 18:18:54 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:13345 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726534AbgDHWSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 18:18:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586384332; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=nxckJHsYlH6PpUyv1QAJtQ0NRWLvH1oUQd2EinXVQSg=; b=XQ+j2Ts1YMk9DBu4mt1cMYmvApJ5ZcRWsa+iuFPnHfADNYmYuRY5OCuZIjgCeGUjqrPicsuA
 w+CvrJLxeQPGf7wP2vzwuJi9e0rlOiZ507qHXVCKBDCkfSDCMlNPyUrouyk2cbIztM1vUc8u
 GCnPQAP8sdABNq2/GE1ZGMPOuHQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8e4dcb.7fcf59ae6260-smtp-out-n04;
 Wed, 08 Apr 2020 22:18:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7CA9EC433D2; Wed,  8 Apr 2020 22:18:51 +0000 (UTC)
Received: from sidgup-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C7EDCC433BA;
        Wed,  8 Apr 2020 22:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7EDCC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sidgup@codeaurora.org
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: [PATCH v2 1/2] remoteproc: core: Add an API for changing firmware name
Date:   Wed,  8 Apr 2020 15:18:24 -0700
Message-Id: <1586384305-7825-2-git-send-email-sidgup@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586384305-7825-1-git-send-email-sidgup@codeaurora.org>
References: <1586384305-7825-1-git-send-email-sidgup@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an API which allows to change the name of the firmware to be booted on
the specified rproc. This change gives us the flixibility to change the
firmware at run-time depending on the usecase. Some remoteprocs might use
a different firmware for testing, production and development purposes,
which may be selected based on the fuse settings during bootup.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 43 ++++++++++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index fb9c813..9f99fe2 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1796,6 +1796,49 @@ int rproc_boot(struct rproc *rproc)
 EXPORT_SYMBOL(rproc_boot);
 
 /**
+ * rproc_set_firmware_name() - change the firmware name for specified remoteproc
+ * @rproc: handle of a remote processor
+ * @firmware: name of the firmware to boot with
+ *
+ * Change the name of the firmware to be loaded to @firmware in the rproc
+ * structure. We should ensure that the remoteproc is not running.
+ *
+ * Returns 0 on success, and an appropriate error value otherwise.
+ */
+int rproc_set_firmware_name(struct rproc *rproc, const char *firmware)
+{
+	int len, ret = 0;
+	char *p;
+
+	if (!rproc || !firmware)
+		return -EINVAL;
+
+	len = strcspn(firmware, "\n");
+	if (!len)
+		return -EINVAL;
+
+	mutex_lock(&rproc->lock);
+
+	if (rproc->state != RPROC_OFFLINE) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	p = kstrndup(firmware, len, GFP_KERNEL);
+	if (!p) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	kfree(rproc->firmware);
+	rproc->firmware = p;
+out:
+	mutex_unlock(&rproc->lock);
+	return ret;
+}
+EXPORT_SYMBOL(rproc_set_firmware_name);
+
+/**
  * rproc_shutdown() - power off the remote processor
  * @rproc: the remote processor
  *
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 9c07d79..c5d36e6 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -613,6 +613,7 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, size_t len,
 			     u32 da, const char *name, ...);
 
 int rproc_boot(struct rproc *rproc);
+int rproc_set_firmware_name(struct rproc *rproc, const char *firmware);
 void rproc_shutdown(struct rproc *rproc);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
