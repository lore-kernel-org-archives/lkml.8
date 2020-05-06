Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E278C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA62206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lp9albrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgEFI0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:26:39 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:16879 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728595AbgEFI0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:26:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588753598; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+e/hn/YJWiH0dL4r0I+5eUSTGJwUxUv6Ig6xc3EC2tk=; b=lp9albrlhRpShukcN39TYB1igGT5IgqRUtRPkbHBdUtXrrHBfC7FCThhP5DAZEcEcwfL28/D
 vG6pPTnEW4TXcfxCOfP0MOp76ih5QoWjxFhzozXXkvIAYVE99Tl5FYBnIrqB/mr2K3ybQYU9
 lhHMSvTlY7G7UuAjkKmCO7ylqOE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb274bb.7fc2faca4ca8-smtp-out-n05;
 Wed, 06 May 2020 08:26:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6DD6EC44788; Wed,  6 May 2020 08:26:34 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 675E6C433BA;
        Wed,  6 May 2020 08:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 675E6C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh+dt@kernel.org, vkoul@kernel.org, sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jackp@codeaurora.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH] dt-bindings: phy: usb-snps-femto-v2: Add regulator entries to example
Date:   Wed,  6 May 2020 01:26:29 -0700
Message-Id: <1588753589-22673-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix errors reported by dt_binding_check, due to missing required
regulators in the example node.

Fixes: f06b9fc9a814 ("dt-bindings: phy: Add binding for qcom,usb-snps-femto-v2")
Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
Reported-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 984242f..574f890 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -72,5 +72,9 @@ examples:
         clock-names = "ref";
 
         resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+
+        vdda-pll-supply = <&vdd_usb_hs_core>;
+        vdda33-supply = <&vdda_usb_hs_3p1>;
+        vdda18-supply = <&vdda_usb_hs_1p8>;
     };
 ...
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
