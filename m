Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D072C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D953C21473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ruxO2Ylg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEHK3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:29:12 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:18831 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbgEHK3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:29:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588933749; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ELjWYl2rDY4OEsO5E0EnrFKtBC0Z0iB83Va1Wzta/3E=; b=ruxO2YlgbE5X5VW0yh2QYc6nCOmWerudx10/8iBvvauu7Tl8T8nMHDUEud2vgEV8t/htA0WR
 XBlaFV6t8qUZcfmOAbZ/Z4mYO8kimzXiyhF5KyhxFpeg/elDvzAi1EOQPAcbQ5hrplydRj5e
 ZM6ZKpJ3dMERK6/rIrJ7W8KtW0M=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb53474.7f35305f2030-smtp-out-n01;
 Fri, 08 May 2020 10:29:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 424E9C4478C; Fri,  8 May 2020 10:29:07 +0000 (UTC)
Received: from kathirav-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D0F3C433D2;
        Fri,  8 May 2020 10:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D0F3C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kathirav@codeaurora.org
From:   Kathiravan T <kathirav@codeaurora.org>
To:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kathiravan T <kathirav@codeaurora.org>
Subject: [PATCH] coresight: platform: use dev_warn instead of dev_warn_once
Date:   Fri,  8 May 2020 15:58:41 +0530
Message-Id: <1588933721-18700-1-git-send-email-kathirav@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When more than one coresight components uses the obsolete DT bindings,
warning is displayed for only one component and not for the others.
Lets warn it for all components by replacing dev_warn_once with dev_warn.

Signed-off-by: Kathiravan T <kathirav@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 43418a2..b7d9a02 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -284,7 +284,7 @@ static int of_get_coresight_platform_data(struct device *dev,
 	if (!parent) {
 		legacy_binding = true;
 		parent = node;
-		dev_warn_once(dev, "Uses obsolete Coresight DT bindings\n");
+		dev_warn(dev, "Uses obsolete Coresight DT bindings\n");
 	}
 
 	conn = pdata->conns;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
