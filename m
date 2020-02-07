Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCA9C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AAF20715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nzKvmZJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgBGUQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:16:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39214 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgBGUQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:16:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so4146249wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qsI/xaPXMqNdKm9K1igbwkE2PA4fRpWtUntr4tiEc9c=;
        b=nzKvmZJ9aAV/JW+8pzm2E70BKhQcS23xS0CYkXUr7Z3bAxJaRv8nqWz2cj1SSddqpQ
         uoYVkYCmGAhg2yBA3YBHi+G5uSEerEuFW1eFYWObrz4OwI2Vxvli+j8E5/Vu6vdXOJOr
         Xm4L3nC2KO8US8RWWLmptOE/87ngvdNCkoKchUjMlhtqsfcqnvbuTDKCI25tJFt4h+6i
         nEYJ2A26wYgCpQMR2JBl/f4WYvfkFQ6Qer3IcjqHeNEkZ6TYgEH4WjCIhDmQ813wcrcf
         R2WSvjmTqnJ2S3kYlnM4Fd4m+EhFRIsP/FBWi+R1hYNrj+qBCuL1emw0a2SrjBhGkPMv
         sjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qsI/xaPXMqNdKm9K1igbwkE2PA4fRpWtUntr4tiEc9c=;
        b=hcdVAi8fd6s51L5ZuvQH22KXUKxeDaDDSlKrMj0DPLwOJXzh1PWgUMpdKt8RIUacOl
         X+gh9LtjviWl85ZwcaRvSRl+ptK1GL6gI8OTGuHA3OMMzxQ0hqv+nfFR6jIAxYZUoT4L
         0vyJZ62dQShrTFIXdfibQWl5ew7M9Net/JHDTzeSOm35IWM9DXVb7heuF3zAHIoitgS1
         pz5gvFjtjKOTEWl01mlsSIq6nhWs2F0UC3g/ab13r3Dw2iWR/s2Kju06OzGdo754teOT
         7vqd2vdXBnHThtb3inHUJ5U05NlGrn6/HkxH5O+l4wlQgYUwDssjc4kjvv5ARrPbEhM+
         TfHw==
X-Gm-Message-State: APjAAAVAPTmzwiwF3Er0Lut1cWY96wSZBBJPvipg6QEnZCJ+FE+Fitf2
        EMC9QKTv3s1AxB1kSJdCS9DRHw==
X-Google-Smtp-Source: APXvYqw9qXEd9607sipcwdF14YHooE/RA/yasD/GDtyTLNkUEQwkjXe4Bpi0gslaJ+gT36M7lapfbg==
X-Received: by 2002:a7b:cab1:: with SMTP id r17mr47670wml.116.1581106610849;
        Fri, 07 Feb 2020 12:16:50 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id h2sm5018542wrt.45.2020.02.07.12.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:16:50 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v5 01/18] dt-bindings: phy: remove qcom-dwc3-usb-phy
Date:   Fri,  7 Feb 2020 20:16:37 +0000
Message-Id: <20200207201654.641525-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
References: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
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

