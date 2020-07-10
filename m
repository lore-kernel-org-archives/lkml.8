Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA326C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8776E207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="KzKTkdDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGJIT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:19:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28820 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgGJITz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:19:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594369194; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vGFq8+SDWbSoLaUEsdWRBZ5B/xzlk5TMY3fHbjDOCR8=; b=KzKTkdDOn6w/1pI21I6i53VegOpvMlbCHh7p5yhGUwn8QbsmMmvRY0RqIybQ0H9eHgfii/8k
 NZdAhEpX/D32/irotsF7RdaejjDQmF7eA+d8yJq/mgNJULPBjGpUBlLW9oGSsGi3cE+JzNQq
 VeedtJ6YWDLtUNfmfrwTbYNDqcI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f0824aa0082b278488b5be9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 10 Jul 2020 08:19:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BC0C8C43387; Fri, 10 Jul 2020 08:19:53 +0000 (UTC)
Received: from akashast-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0591AC433CA;
        Fri, 10 Jul 2020 08:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0591AC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, saipraka@codeaurora.org,
        msavaliy@codeaurora.org, Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH] of: Add stub for of_get_next_parent
Date:   Fri, 10 Jul 2020 13:49:32 +0530
Message-Id: <1594369172-27278-1-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes compilation error reported on x86 platform:

drivers/soc/qcom/qcom-geni-se.c:819:11: error: implicit declaration of
function 'of_get_next_parent'.

drivers/soc/qcom/qcom-geni-se.c:819:9: warning: incompatible integer to
pointer conversion assigning to 'struct device_node *' from 'int'

Fixes: 048eb908a1f2 ("soc: qcom-geni-se: Add interconnect support to fix
			earlycon crash")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
 include/linux/of.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index c669c0a..72e7198 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -630,6 +630,12 @@ static inline struct device_node *of_get_parent(const struct device_node *node)
 	return NULL;
 }
 
+static inline struct device_node *of_get_next_parent(
+	const struct device_node *node)
+{
+	return NULL;
+}
+
 static inline struct device_node *of_get_next_child(
 	const struct device_node *node, struct device_node *prev)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

