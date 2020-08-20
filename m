Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3916C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A4E2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="rWevVd6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgHTFvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:51:05 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13055 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726795AbgHTFvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:51:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597902663; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6f3nW8BB3LD77B8rxJL28CQ6zCWJVGq7xudazlaiolw=; b=rWevVd6Xg+qwMV00tYqFAywVV4AQ2ewwE7njSNbgLVKdHghnAjYI9140X+4nXe/J68kM3JrZ
 9pz4SjsXYWlik5BsIMgY0HGqg1VWi3WSFWyOBogDAjl8hsCyzxopquzPBXX/X9BfJyTXmyO2
 dJ/5+W2TGgcKjrXJyG2buj1P2bQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f3e0f3e7e76db358ef855aa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 05:50:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1573C4344C; Thu, 20 Aug 2020 05:50:53 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B07BC433CA;
        Thu, 20 Aug 2020 05:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B07BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 19/24] coresight: cti: don't disable ect device if it's not enabled
Date:   Thu, 20 Aug 2020 13:47:13 +0800
Message-Id: <20200820054718.20115-20-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200820054718.20115-1-tingwei@codeaurora.org>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If associated ect device is not enabled at first place, disable
routine should not be called. Add ect_enabled flag to check whether
ect device is enabled. Fix the issue in below case.  Ect device is
not available when associated coresight device enabled and the
association is established after coresight device is enabled.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight.c | 11 ++++++++---
 include/linux/coresight.h               |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 6c09be15d60c..d354fd57474e 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -244,13 +244,18 @@ coresight_control_assoc_ectdev(struct coresight_device *csdev, bool enable)
 
 	if (!ect_csdev)
 		return 0;
+	if ((!ect_ops(ect_csdev)->enable) || (!ect_ops(ect_csdev)->disable))
+		return 0;
 
 	if (enable) {
-		if (ect_ops(ect_csdev)->enable)
-			ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
+		ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
+		if (!ect_ret)
+			csdev->ect_enabled = true;
 	} else {
-		if (ect_ops(ect_csdev)->disable)
+		if (csdev->ect_enabled) {
 			ect_ret = ect_ops(ect_csdev)->disable(ect_csdev);
+			csdev->ect_enabled = false;
+		}
 	}
 
 	/* output warning if ECT enable is preventing trace operation */
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 3bb738f9a326..7d3c87e5b97c 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -208,6 +208,7 @@ struct coresight_device {
 	/* sysfs links between components */
 	int nr_links;
 	bool has_conns_grp;
+	bool ect_enabled; /* true only if associated ect device is enabled */
 };
 
 /*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

