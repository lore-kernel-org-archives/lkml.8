Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D89CC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752C0217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2IagIBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgATQau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:30:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55210 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgATQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:30:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so194603wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qsI/xaPXMqNdKm9K1igbwkE2PA4fRpWtUntr4tiEc9c=;
        b=G2IagIBOWzh/x16MmgeTD8wsIydKubQXPVKg1rv4Z4RR14LDQWt4zUhDU1HfrMHczS
         g2r9eRIVi4i/ydvfIil0I54FM5sMKiwf39RnsBZSyhht06aVtE2SnZ0ieVphedo49NHE
         jyM9X8ahmWECdxjbEEEKkrA8C6jqWVGjCx3+mWK3UP1CKmMc7ZJeoiUO+sWU5PGFXemw
         zpIi9XvkZfWSNzY6KYAnoZbZJ4XiUdOJl7/BKzSETmz/GahtWUPtDVdmLoNqDJwfDswp
         38kre8EH+B9ShaUuYJ3dKFx96kX7u04ZL+AN6b+ayfcCPPkyHlf/ntH6qcrqH+/Dk+05
         LwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qsI/xaPXMqNdKm9K1igbwkE2PA4fRpWtUntr4tiEc9c=;
        b=Q+jZmT7b96bz4zImmbWpTdiuuGb/SOLAMPj7oskj21E5QztnkqWYE1lFg0CzdhvXVH
         pfMgQg6bvDVuvu7HG7BTtDPYF9GRdNOSs7ZwiWgp6XvnOl8SQK6ms4ZVBmuY7hG57Wy7
         NbxrPYqXOr9P+a1/ya7QHdciAkr8RGBTs8WVsYJ799ZeimCrLO9/DLDKaUK/fn6wwSdU
         1S0ithCb4P7tOAyrUBAY2fv1HVtvq6WpfP08253PjuJvENPJ+kTmlXBi0LdmFiWBT/tS
         1FY1anMQouEKzUr/FbQRHq4GeVP8Dqo5p33NMohprrCMZcWU4dBT3+ra46orKakTRHEn
         elAA==
X-Gm-Message-State: APjAAAVBUBQzQ/rbbZAUyspVD8uZRDCTzHdGNKDQTlCzKTg4taS8Mo14
        AsBd81JbMNZoQexwCkeEq0pKFw==
X-Google-Smtp-Source: APXvYqzzFJTUL2uBj8UC6wtxz6N+1fzM94B2exU3q07GUKuUf2SDhArGvq1P2gzxo5nwlVOdim5jTg==
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr165624wmi.15.1579537847957;
        Mon, 20 Jan 2020 08:30:47 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id p26sm22631756wmc.24.2020.01.20.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:30:47 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v2 01/19] dt-bindings: phy: remove qcom-dwc3-usb-phy
Date:   Mon, 20 Jan 2020 16:30:58 +0000
Message-Id: <20200120163116.1197682-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
References: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
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

