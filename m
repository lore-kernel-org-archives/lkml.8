Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5135FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251272076C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tQXQJTTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbgFWFSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 01:18:39 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:40659 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730568AbgFWFSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 01:18:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592889516; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=oY//RZQu/ZBXoaB1wnRWWN6fmOy85NmZaAUiK3spi0c=; b=tQXQJTTnwowQXgranNMxg9HAkTNka55td67mHESOrGsByZzKC+jymYHBHBdWJ5l4jQDhyb1X
 iBmh2FSylAdkFEgq+MOnjz7Kxcd4Ftp/B5C2RByWpieUrgOalGfF9UFtRWkga/3cNkrl3t65
 hBE6v9FMWjPqHbK1jeODsIIgwB0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5ef190996bebe35deb5ac496 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 05:18:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3AC2AC433CA; Tue, 23 Jun 2020 05:18:17 +0000 (UTC)
Received: from kathirav-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05F9FC433CA;
        Tue, 23 Jun 2020 05:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05F9FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kathirav@codeaurora.org
From:   Kathiravan T <kathirav@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, kathirav@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     sivaprak@codeaurora.org
Subject: [PATCH V2 3/6] dt-bindings: regulator: add MP5496 regulator compatible
Date:   Tue, 23 Jun 2020 10:47:49 +0530
Message-Id: <1592889472-6843-4-git-send-email-kathirav@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592889472-6843-1-git-send-email-kathirav@codeaurora.org>
References: <1592889472-6843-1-git-send-email-kathirav@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ6018 uses the PMIC MP5496. Add the binding for the same.

Signed-off-by: Kathiravan T <kathirav@codeaurora.org>
---
 Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
index dea4384..728c001 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
@@ -19,6 +19,7 @@ Regulator nodes are identified by their compatible:
 	Usage: required
 	Value type: <string>
 	Definition: must be one of:
+		    "qcom,rpm-mp5496-regulators"
 		    "qcom,rpm-pm8841-regulators"
 		    "qcom,rpm-pm8916-regulators"
 		    "qcom,rpm-pm8941-regulators"
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

