Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B587C5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A0024673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="nFjmZT3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgBTCMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:12:16 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:22203 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727864AbgBTCMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:12:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582164735; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=G0N2LK4yBTzqvnQc6T2DASLm9WXe508wiQLbyaNYBZI=; b=nFjmZT3ymnHg2MwS0V+meuhtgBBcLTUkEBF719DayZ78apiNrrg8H+UWle2VbF9/dOsirDEH
 mpF+aRcX4VS98oZOz7oFdLpSr/k2xlSn2Cp1pxrnp90oQk4/RxaNMcngWPyJKnaeH2c70yCo
 CM/+WAq1q9kVALNdfugpEQsrBlk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4deaf4.7fc054e3d308-smtp-out-n01;
 Thu, 20 Feb 2020 02:12:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 454E1C447A4; Thu, 20 Feb 2020 02:12:03 +0000 (UTC)
Received: from sidgup-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 56F5EC433A2;
        Thu, 20 Feb 2020 02:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56F5EC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sidgup@codeaurora.org
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org
Subject: [PATCH 1/2] remoteproc: core: Add an API for booting with firmware name
Date:   Wed, 19 Feb 2020 18:11:52 -0800
Message-Id: <1582164713-6413-2-git-send-email-sidgup@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582164713-6413-1-git-send-email-sidgup@codeaurora.org>
References: <1582164713-6413-1-git-send-email-sidgup@codeaurora.org>
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
 drivers/remoteproc/remoteproc_core.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e..5ab65a4 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1779,6 +1779,40 @@ int rproc_boot(struct rproc *rproc)
 EXPORT_SYMBOL(rproc_boot);
 
 /**
+ * rproc_boot_with_fw() - boot a remote processor with the specified firmware
+ * @rproc: handle of a remote processor
+ * @firmware: name of the firmware to boot with
+ *
+ * Change the name of the firmware to be loaded to @firmware in the rproc
+ * structure, and call rproc_boot().
+ *
+ * Returns 0 on success, and an appropriate error value otherwise.
+ */
+int rproc_boot_with_fw(struct rproc *rproc, const char *firmware)
+{
+	char *p;
+
+	if (!rproc) {
+		pr_err("invalid rproc handle\n");
+		return -EINVAL;
+	}
+
+	if (firmware) {
+		p = kstrdup(firmware, GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+
+		mutex_lock(&rproc->lock);
+		kfree(rproc->firmware);
+		rproc->firmware = p;
+		mutex_unlock(&rproc->lock);
+	}
+
+	return rproc_boot(rproc);
+}
+EXPORT_SYMBOL(rproc_boot_with_fw);
+
+/**
  * rproc_shutdown() - power off the remote processor
  * @rproc: the remote processor
  *
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 16ad666..e2eaba9 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -609,6 +609,7 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, int len,
 			     u32 da, const char *name, ...);
 
 int rproc_boot(struct rproc *rproc);
+int rproc_boot_with_fw(struct rproc *rproc, const char *firmware);
 void rproc_shutdown(struct rproc *rproc);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
