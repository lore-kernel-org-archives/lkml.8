Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62D8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A626321835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRG9LBmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgAVS57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:57:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52467 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgAVS4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:56:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so198056wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qsI/xaPXMqNdKm9K1igbwkE2PA4fRpWtUntr4tiEc9c=;
        b=pRG9LBmdA77QlahXYh5Nus9tfRpUo5AFbdSWsL+0XT3QJab1WATu+dxyKUmFctjySd
         cCVa6wsti27lRJxiioGev4IaUCPVhT+SayO6oRbsS3fiZ9PG8eRVpQYhLhGFA+2d26CR
         9OkSiazpoxuBtrrdZdCqh4WXsrmLo/baSXWwLhI0pXU2F0kwnJCQDRlvrT8a/ChIZgot
         KzzkbFTtuJlb/UPUa1jElGVzZUy4+YS1zMnqaZMzBTrCJcIF6YJKLvWwHr6Owl2YvX8K
         WYf+7CVoqub8kXXef4++H/qZzFF+5BWVCyZlYRdEzqOs61AcuNSeb8pOAJrPtGqufF5e
         97Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qsI/xaPXMqNdKm9K1igbwkE2PA4fRpWtUntr4tiEc9c=;
        b=DxGYc743/wxfGXlwopJ3Ct+/l8nfJKYvpp1yci6Ary3fgxWlch+3svtd+157g8uSM5
         6Egd51s2dOxTo3/KsjcWD9XJewXaMUX+oMh1LTLMdo6M8S0/cyo3Dx+hTxi3c54tNxUD
         i5pD3vA6sH0GsCj4V5fJ0ucfGX5vLQphf9IzvG/DATrReBdMxqilataIyS/VONywO5Nt
         LCJ/lhos6SXpNSnRaRQEAlNnjlktMRM1/fISmS/wNVNTE7ZMpQ/l2872o36aEB/xApuJ
         /a4wnmjGKXRTIfS7qsY8lslmOLFcDg/AgMeY82GizW7gR99yalFLk39Qd2HmRMyyyUMm
         Fo0Q==
X-Gm-Message-State: APjAAAVpM4TFKVM5qRHlRveSAcjj39DFE+NBxaonkXnB33Oti9QZhTh/
        44ogRSNf87Hcblz56ihUcyM2jA==
X-Google-Smtp-Source: APXvYqz0IDlDRIP7S8I1GgGAZ46OxkvhlJ5Sti9+qcfPPbVXc+gCXCq1gA5S77046vns0gcYtT/wSw==
X-Received: by 2002:a7b:cfc2:: with SMTP id f2mr4211199wmm.44.1579719374319;
        Wed, 22 Jan 2020 10:56:14 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q15sm58590390wrr.11.2020.01.22.10.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 10:56:13 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v3 01/19] dt-bindings: phy: remove qcom-dwc3-usb-phy
Date:   Wed, 22 Jan 2020 18:55:52 +0000
Message-Id: <20200122185610.131930-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122185610.131930-1-bryan.odonoghue@linaro.org>
References: <20200122185610.131930-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

This binding is not used by any driver.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/phy/qcom-dwc3-usb-phy.txt        | 37 -------------------
 1 file changed, 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt b/Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
deleted file mode 100644
index a1697c27aecd..000000000000
--- a/Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Qualcomm DWC3 HS AND SS PHY CONTROLLER
---------------------------------------
-
-DWC3 PHY nodes are defined to describe on-chip Synopsis Physical layer
-controllers.  Each DWC3 PHY controller should have its own node.
-
-Required properties:
-- compatible: should contain one of the following:
-	- "qcom,dwc3-hs-usb-phy" for High Speed Synopsis PHY controller
-	- "qcom,dwc3-ss-usb-phy" for Super Speed Synopsis PHY controller
-- reg: offset and length of the DWC3 PHY controller register set
-- #phy-cells: must be zero
-- clocks: a list of phandles and clock-specifier pairs, one for each entry in
-  clock-names.
-- clock-names: Should contain "ref" for the PHY reference clock
-
-Optional clocks:
-  "xo"		External reference clock
-
-Example:
-		phy@100f8800 {
-			compatible = "qcom,dwc3-hs-usb-phy";
-			reg = <0x100f8800 0x30>;
-			clocks = <&gcc USB30_0_UTMI_CLK>;
-			clock-names = "ref";
-			#phy-cells = <0>;
-
-		};
-
-		phy@100f8830 {
-			compatible = "qcom,dwc3-ss-usb-phy";
-			reg = <0x100f8830 0x30>;
-			clocks = <&gcc USB30_0_MASTER_CLK>;
-			clock-names = "ref";
-			#phy-cells = <0>;
-
-		};
-- 
2.25.0

