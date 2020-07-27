Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D03C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75E220714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XRVfLbXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgG0I0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:26:47 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:24694 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbgG0I0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:26:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595838406; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=kBkNocMKuKYfy5D9SSp5xG3xYJZjERRpJB7Zd5wVkQI=; b=XRVfLbXgcQZUDFqI98cnbCmVJXxXZBYSFBnx7qHL4o94zwjAZpWm6YUT0kPanWvI4dPEJut2
 SQbBBaiCB6YGbToOxDuNz3BQvJrEAeyLXMv4D/4N7x4SYIcaNyGa95dD37jVSvfb2YE9CSRI
 Q8z/DAAL3aPHCHPY7W/34Wo2IKI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5f1e8fa47186ea1ee140f213 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Jul 2020 08:26:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D4684C43391; Mon, 27 Jul 2020 08:26:11 +0000 (UTC)
Received: from akashast-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CC0CC433C9;
        Mon, 27 Jul 2020 08:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CC0CC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
From:   Akash Asthana <akashast@codeaurora.org>
To:     wsa@the-dreams.de
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, msavaliy@codeaurora.org,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH] MAINTAINERS: Update GENI I2C maintainers list
Date:   Mon, 27 Jul 2020 13:56:00 +0530
Message-Id: <1595838360-3242-1-git-send-email-akashast@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alok Chauhan has moved out of GENI team, he no longer supports GENI I2C
driver, remove him from maintainer list.

Add Akash Asthana & Mukesh Savaliya as maintainers for GENI I2C drivers.

Signed-off-by: Akash Asthana <akashast@codeaurora.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 235ab38..d216344 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13845,7 +13845,8 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
 F:	Documentation/devicetree/bindings/net/qcom,ethqos.txt
 
 QUALCOMM GENERIC INTERFACE I2C DRIVER
-M:	Alok Chauhan <alokc@codeaurora.org>
+M:	Akash Asthana <akashast@codeaurora.org>
+M:	Mukesh Savaliya <msavaliy@codeaurora.org>
 L:	linux-i2c@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Supported
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

