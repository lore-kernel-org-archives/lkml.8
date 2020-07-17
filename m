Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F9CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCF12070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="n5PLSLPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGQOdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:33:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:17196 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgGQOdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:33:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594996379; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5k+ghKVmw+O+VKXqIuYFx2XlCkmZh/fDZ2QkLdasXUw=; b=n5PLSLPairafEqQidUQ32B+WcW43ddTPbe6i3yMqfsg97Be+7mlfHx4EPYFl3P+5uT2D6/uJ
 FYUigNsx72LRdh5B2ZdTmeB4z9Izab5KmLvhgRiANvEFgxQTOavQaIV4PlvVlCh8oSMRbHHs
 wxEbXK/SinpnGVNSZn396b6vX30=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5f11b685c9bd2efa2e17d642 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 17 Jul 2020 14:32:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69E0EC43391; Fri, 17 Jul 2020 14:32:36 +0000 (UTC)
Received: from akashast-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E89AC433C9;
        Fri, 17 Jul 2020 14:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E89AC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        saipraka@codeaurora.org, msavaliy@codeaurora.org,
        Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH] soc: qcom: geni: Fix NULL pointer dereference
Date:   Fri, 17 Jul 2020 20:02:22 +0530
Message-Id: <1594996342-26964-1-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pdev struct doesn't exits for the devices whose status are disabled
from DT node, in such cases NULL is returned from 'of_find_device_by_node'
Later when we try to get drvdata from pdev struct NULL pointer dereference
is triggered.

Add a NULL check for return values to fix the issue.

We were hitting this issue when one of QUP is disabled.

Fixes: 048eb908a1f2 ("soc: qcom-geni-se: Add interconnect support to fix earlycon crash")
Reported-by: Sai Prakash Ranjan <saipraka@codeaurora.org>
Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
 drivers/soc/qcom/qcom-geni-se.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 355d503..6e5fe65 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -820,6 +820,7 @@ void geni_remove_earlycon_icc_vote(void)
 	struct geni_wrapper *wrapper;
 	struct device_node *parent;
 	struct device_node *child;
+	struct platform_device *wrapper_pdev;
 
 	if (!earlycon_wrapper)
 		return;
@@ -829,7 +830,12 @@ void geni_remove_earlycon_icc_vote(void)
 	for_each_child_of_node(parent, child) {
 		if (!of_device_is_compatible(child, "qcom,geni-se-qup"))
 			continue;
-		wrapper = platform_get_drvdata(of_find_device_by_node(child));
+
+		wrapper_pdev = of_find_device_by_node(child);
+		if (!wrapper_pdev)
+			continue;
+
+		wrapper = platform_get_drvdata(wrapper_pdev);
 		icc_put(wrapper->to_core.path);
 		wrapper->to_core.path = NULL;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

