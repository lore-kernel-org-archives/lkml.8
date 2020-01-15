Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C40CC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B6924656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6Xz4MLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgAOOPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:15:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37960 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgAOONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:13:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so15906818wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f2EHRYMI/TrUMZiwdhRPG+CtjBM6dg1rcU2ZvEhaaRU=;
        b=b6Xz4MLjpNeovyf0j/n3jNiTMyMKIbYXWa+8HcRWYqQOMTWOyIEWH4h1uo0njlqPOm
         4GEheSsQF2cON7MQC3DutbDhgEX9EOFRtRTrM/j8VnF55rISfOZMvh6MwgvBeMGCrt0x
         8hlc832sNeke+deccGiXMylyEhm17cBLEdfzMt0A8ToezBTwKrgBBzyJxhUAapOEZBmr
         6AOoYVgngMt2QH+n1pbWzTNNuweb0ZfZp0Y9uAUFzxrnhPJqURjzdR4K/LEzi3TY7hGF
         THU9dLU8hseyu97IlLTjmmpKxL3YsrTghAqgJqy0GXY6MYFV8TyyrefNFE7ph/oF877v
         JYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2EHRYMI/TrUMZiwdhRPG+CtjBM6dg1rcU2ZvEhaaRU=;
        b=mukSKn5HtBNTqhzBQ2PDwBx3jLqS2WN1bkkU78b/J0d+nBa3JrWKLtRYAuqiVTRxI3
         zVkUAEizZMAx9F4Yi3fJTV7kZ3EVGsDJFqpFN2J9sxE8O1AhVadiXPStf+YfW9sMjB/k
         72vXXQOWanGCdQQPvyHvpGEZFI90ptoMjnzjhwt2+FWz7ZP85X7iF2SsjuJXmFycGUJO
         2GIdV/x9/RAHuBoeYdo4fe02L3n1eVFmtrE1BnuWDPFRguMEE7tYN6NOhUGSf4MxZFhp
         SDScQoCxVMTWORpSZbpChHhAZFHVca0uEsoxNiM4ZTNj79hJTiItQcEMMMoYzq7diua6
         2xCA==
X-Gm-Message-State: APjAAAVVezfex1lZAkBtpTzRcKz94g6pRtiaZAokqDByNAypWjedYTVr
        RpEBUzNQJK5Hgjg/Fj/PMY7sHQ==
X-Google-Smtp-Source: APXvYqzxzRlw2U5aBlUnoLp9Qf+6/vSSV796tAM/I8yuqlr7588woX0Svjra55WW5pbW9B+PNOsMRw==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr29951658wrk.53.1579097586435;
        Wed, 15 Jan 2020 06:13:06 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id m21sm23730720wmi.27.2020.01.15.06.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:13:05 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 01/19] dt-bindings: phy: remove qcom-dwc3-usb-phy
Date:   Wed, 15 Jan 2020 14:13:15 +0000
Message-Id: <20200115141333.1222676-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
References: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
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
2.24.0

