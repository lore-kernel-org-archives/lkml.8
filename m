Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52867C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAC12074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="An4+U/De"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbgCKTOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:14:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33359 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731070AbgCKTOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:14:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so4143488wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxX1GjYK2mYAhDxWyH3Jl9eH43r2oqZEhGTxg8X6wQQ=;
        b=An4+U/DeXJbHhJCJ194FOdmvQdQOz12Yqw0WEwCGxzl5G0VcndenTzjnuVPTzOXN1t
         oFqRxpFwRPox5e4vH6FuaajxjOlrHD8k+AlQLIPM42p2mZI6ecpgLwWdgtlCuJaMzknm
         d7L4M25l7v7WKDUESIIHClpHBS0BFp1X3XJhsvYZJCaKIByYMv6RHn0wh/hkwpRQgvRX
         IEBwsS8W3A7krXOnN1jp/PSJrOVJWCuyxAT9CiWhspL5ht/O9WLCv1Nu98M1R7zbFNp7
         Qxaf6ywShSeR55YHmfYkcNiuOwSVNDe792qIfb0egxC/5uk71fQl2eNBmt0ZHTqV8RhA
         OleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxX1GjYK2mYAhDxWyH3Jl9eH43r2oqZEhGTxg8X6wQQ=;
        b=p9cH+NKFptRowDVqAemIoatFZjQOYdlH4zbqFHMzDr0WMVzIFlZ9g3g1VylaKKNgHn
         BffBQHw+zGNyizONFDHjPNlXvXznFgSEwTz/+LHUJ0sI5uuy1l4qru3Ff7OwNFhZPVp0
         7ZybQHW/GER4wkZLoaUq3YLFX0iCYGsE63cmel8wwXQTZzam/pXVhgad4i0ee7Q4wNFe
         tUSmD4HXTpzYPPEzN/1SDVCTGXbzbKkz3xbB9VP7efmcUeRG5tbTmu6EmI6AFrfK+UDn
         WK+aq0Bx7IXtnKquTe2UpUVyLq7wGIgi6Zn/QzdiNmuO8bbKv2yc77Ey6189xhR7JdfB
         JQxw==
X-Gm-Message-State: ANhLgQ01PpvOX19/sgqjlWZ/fQNyZA39eWGwQCGh+RgzQDo8HqxwpHnP
        bOYUbYJap4OM1kRghCdNGEuWUw==
X-Google-Smtp-Source: ADFU+vu7lAgSh6YsSeOtORoJm/fQQHhzZy0uBHdINcMB/k2JjiAqigl61CrHBKTzU79uLdsF4RDrgw==
X-Received: by 2002:a05:6000:1186:: with SMTP id g6mr5876280wrx.331.1583954040659;
        Wed, 11 Mar 2020 12:14:00 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v8sm69443919wrw.2.2020.03.11.12.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:14:00 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jackp@codeaurora.org,
        robh@kernel.org, bjorn.andersson@linaro.org,
        p.zabel@pengutronix.de,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 1/5] dt-bindings: phy: remove qcom-dwc3-usb-phy
Date:   Wed, 11 Mar 2020 19:13:54 +0000
Message-Id: <20200311191358.8102-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311191358.8102-1-bryan.odonoghue@linaro.org>
References: <20200311191358.8102-1-bryan.odonoghue@linaro.org>
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
2.25.1

