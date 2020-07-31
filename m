Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1322FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC392087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WhNIr7eD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgGaWRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:17:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40942 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgGaWRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:17:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596233856; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=NpTfXolbL0lyqzMnsq42xtYh8Y23Uv9eM0QiVytiCZ4=; b=WhNIr7eDOY5FLHCfmjybkGKA2vEMMoosvJImdIiXljywz7lP4IXEOFl1FsYpmgvIdNfqlyLb
 Fepu+2wmLkmBAnKuONYnDbL6VOBeMSwxOkUQ0utUJ5biwxvnb02P5WRLkaMoSfZjaxiqdmG5
 WY1lOKtc/gCYQneY7p8PJzNPMzY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5f249880498d610239f0e19e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 31 Jul 2020 22:17:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B076C433CB; Fri, 31 Jul 2020 22:17:35 +0000 (UTC)
Received: from sidgup-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AD9EBC433C9;
        Fri, 31 Jul 2020 22:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD9EBC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sidgup@codeaurora.org
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: core: Add coredump ops to remoteproc
Date:   Fri, 31 Jul 2020 15:17:23 -0700
Message-Id: <1596233843-26576-1-git-send-email-sidgup@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each remoteproc might have different requirements for coredumps and might
want to choose the type of dumps it wants to collect. This change allows
remoteproc drivers to specify their own custom dump function to be executed
in place of rproc_coredump. If the coredump op is not specified by the
remoteproc driver it will be set to rproc_coredump by default.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++++-
 include/linux/remoteproc.h           | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 277d3bf..8ea61b0 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1681,7 +1681,8 @@ int rproc_trigger_recovery(struct rproc *rproc)
 		goto unlock_mutex;
 
 	/* generate coredump */
-	rproc_coredump(rproc);
+	if (rproc->ops->coredump)
+		rproc->ops->coredump(rproc);
 
 	/* load firmware */
 	ret = request_firmware(&firmware_p, rproc->firmware, dev);
@@ -2098,6 +2099,9 @@ static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
 	if (!rproc->ops)
 		return -ENOMEM;
 
+	if (rproc->ops->coredump)
+		rproc->ops->coredump = rproc_coredump;
+
 	if (rproc->ops->load)
 		return 0;
 
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 0e8d2ff..d22c33d 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -374,6 +374,7 @@ enum rsc_handling_status {
  * @get_boot_addr:	get boot address to entry point specified in firmware
  * @panic:	optional callback to react to system panic, core will delay
  *		panic at least the returned number of milliseconds
+ * @coredump:	do coredump for the specified remoteproc
  */
 struct rproc_ops {
 	int (*prepare)(struct rproc *rproc);
@@ -392,6 +393,7 @@ struct rproc_ops {
 	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
 	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
 	unsigned long (*panic)(struct rproc *rproc);
+	void (*coredump)(struct rproc *rproc);
 };
 
 /**
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

