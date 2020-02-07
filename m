Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BA7C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 01:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E0F20715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 01:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PTe8riw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgBGB7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 20:59:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37640 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgBGB7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 20:59:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so788007wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 17:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qsI/xaPXMqNdKm9K1igbwkE2PA4fRpWtUntr4tiEc9c=;
        b=PTe8riw6U8bDW2BD/CxQgvv/9t4tl0U1Prhqr54tyU/g1/UMk7Tqd6sniHUl/w5azG
         H8Sfs1vXxDHfScvBYzbH4HTjk/PsxN4+jnzWHUs0YqYitvkT29Mm1h8bZ+IoSP+mSsS+
         p5KXsB/qvGU5nAqs+s042/nU8m6svRfIqTQFa0X3sGQcx9cnwhkhtQTF4CNHa20FGdsb
         /4obbf3seLL+I6G2XzsD4dHF7SRF+TLHNPZ/655SBBGozgcrpXmDL98qLHnaNTxsX+WW
         4qf8GdIzwWSBBzA0HzLJ7Crhh483zO4XdjGz923Zg0yV3A1qzKcmuAS3wQ+0cusp00by
         SpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qsI/xaPXMqNdKm9K1igbwkE2PA4fRpWtUntr4tiEc9c=;
        b=cspOB3Vscq9Jj+B4GMTH+gSQ5jmTXYwrJLVgf9xPvnybDMu0BLkKZSFkj1mi6iRXX6
         K2QLALYz/t62GqpLezSM3P2k1E2AfixEyUWCPkcfCamjYniiw75k9WtFFnCL16xV7zlI
         er3NaZ55+fb4I/0vex0z8UqUA2jOLubnMrsdPnmCoYgdWBbHpWbdTyM8oD4iOubJFMQI
         DhwM/TYf0kkzAFW5Yvz1vro6tnajG42MUErHNlgs4lxe/mUZKbISThB6qJXvG0L9Bbda
         HFpCsa2dxS/m5SfFovilBOvrZCco++/0TPf7flHNqYqQi4SDnWH21nRzEO5lIT5A2rsI
         oU9g==
X-Gm-Message-State: APjAAAXJAshI0LeePd9eEeVnL7SUjXsqnF9lpKpCj0q9X9//hczW3kDg
        YjdGs5j1s9B8GWZ0Z9zbaTJU8Q==
X-Google-Smtp-Source: APXvYqwPD2xq9B+Yz+WYnoPdj9yJUADJMolqYgcUq0fL+IXijMX6pa9HamJKV5V3OS6P4C32RhJO1w==
X-Received: by 2002:a5d:5263:: with SMTP id l3mr1162751wrc.405.1581040747220;
        Thu, 06 Feb 2020 17:59:07 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id a62sm1490095wmh.33.2020.02.06.17.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 17:59:06 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v4 01/18] dt-bindings: phy: remove qcom-dwc3-usb-phy
Date:   Fri,  7 Feb 2020 01:58:50 +0000
Message-Id: <20200207015907.242991-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
References: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
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

