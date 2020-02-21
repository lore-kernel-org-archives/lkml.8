Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D0C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A342C20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="klf7Vo8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBUJcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:32:43 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:25343 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727957AbgBUJcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:32:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582277561; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=emh5A6mkF9IlRNLF9/kdYwlLasTRTZIXQ0xT8fk6B3w=; b=klf7Vo8DMRrYHSht1NefvGRaq8hs5a4NZlRevizJqb2Atcpvjmg+6SSGmCC9/VmvwR45RyNP
 cRGHFXawRgFvfBxRYktZHaVILurrZhCVBCDP/j/Uwfz98jbRxW/qx2j9H9V+jsQex7I9oZMf
 404l51Y4vOioto2ewVBsajUsB+M=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4fa3ac.7fc39da61030-smtp-out-n03;
 Fri, 21 Feb 2020 09:32:28 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CF6DFC43383; Fri, 21 Feb 2020 09:32:28 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B136FC4479F;
        Fri, 21 Feb 2020 09:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B136FC4479F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v6 3/3] soc: qcom: rpmh: Invoke rpmh_flush for dirty caches
Date:   Fri, 21 Feb 2020 15:02:07 +0530
Message-Id: <1582277527-19638-4-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582277527-19638-1-git-send-email-mkshah@codeaurora.org>
References: <1582277527-19638-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add changes to invoke rpmh flush when the data in cache is dirty.

This is done only if OSI is not supported in PSCI. If OSI is supported
rpmh_flush will get invoked by power domain off call when the last cpu
in the domain is going to power collapse.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/soc/qcom/rpmh.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 83ba4e0..839af8d 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/psci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -163,6 +164,9 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 unlock:
 	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
 
+	if (ctrlr->dirty && !psci_has_osi_support())
+		return rpmh_flush(ctrlr) ? ERR_PTR(-EINVAL) : req;
+
 	return req;
 }
 
@@ -391,6 +395,8 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 
 	if (state != RPMH_ACTIVE_ONLY_STATE) {
 		cache_batch(ctrlr, req);
+		if (!psci_has_osi_support())
+			return rpmh_flush(ctrlr);
 		return 0;
 	}
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
