Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C16C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CE4208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G9GUxZPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgCXKVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:21:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40019 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgCXKU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:20:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id u10so319409wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67sFvVtkG1ivlSk+fGwbgHaYe6cmIRn/pWHBZ0lu9g4=;
        b=G9GUxZPZnPhLAajMtiZxgmUxpYrGOcJIkPozWgUDMvAuy8EBmZbwC30xlR9wHUDnJV
         ALFika3tbYFYgOcbEy6lLg62lZVK5VultjcamVietFmwqmduFKScAs2xljobVRPKpRXB
         i+0XwLWm2dPB3T/cVEbeziTgctq2IaB8JoXEKasglnWC/N+nQosrtmb+n8kp06GIIR0w
         30OWNQB2zwjvbXX5cMH+cNlV+3NUfzEfVtxBP2DaojGqjDvF5egj+tn0DSOrKutBLBFj
         t77PxOjT7DJ0Obl93NXUkDItQyzWrNOnIQ9JmQ3KbXHMtLKZy6nVXVOBML4RvL87vvDb
         rSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67sFvVtkG1ivlSk+fGwbgHaYe6cmIRn/pWHBZ0lu9g4=;
        b=Y8T+AL1OF+rD/S4LpW/Mx37beMW0rOqREN/6l+XQHs0SMcDjZQj6OgCBsmavOxGGYk
         zjDahGxeSzCCvv7RaLdMGzc0sG7PkLFVFkCAHDkHqfWNZ4Ul6u2EOoIPtQwDcBprgUto
         r+XrvROtk5820T5uIo5XPl58Nky5OR8jdoS4u2+WhSrBlbRWIZUMJsNoDNF01NJcUKJT
         CCNhCvKcSfCZMQwJVPNzj8JJdtRrDMKilwJCVaYsincNauPTXGgz6dehDOq3OlrjECjo
         AAt6Z8bKVuL9sknvHiJPHxgxsY8R62JmtCmYFrT23za4aRECT/P5sj7TFcgUhL/vjAdA
         rErw==
X-Gm-Message-State: ANhLgQ0SRNzI8v1pfU2DFXEYsHLW3OA9DCgP6q3SGmjuunFNqYmcE+wE
        cxUU/bD0hcwr0/M79fM7COLlSQ==
X-Google-Smtp-Source: ADFU+vuGwhRTHhtQBh24wMOPnFqWmD8WEDTDqhBcn0GQZbxNq7+HwZ5AGbojto+87MT0Z8I4IEGjhQ==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr35578867wrr.393.1585045255321;
        Tue, 24 Mar 2020 03:20:55 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h5sm2879527wro.83.2020.03.24.03.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 03:20:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 13/13] dt-bindings: usb: amlogic,dwc3: remove old DWC3 wrapper
Date:   Tue, 24 Mar 2020 11:20:30 +0100
Message-Id: <20200324102030.31000-14-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200324102030.31000-1-narmstrong@baylibre.com>
References: <20200324102030.31000-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

There is now an updated bindings for these SoCs making the old
compatible obsolete.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/usb/amlogic,dwc3.txt  | 42 -------------------
 1 file changed, 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/amlogic,dwc3.txt

diff --git a/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt b/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
deleted file mode 100644
index 9a8b631904fd..000000000000
--- a/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Amlogic Meson GX DWC3 USB SoC controller
-
-Required properties:
-- compatible:	depending on the SoC this should contain one of:
-			* amlogic,meson-axg-dwc3
-			* amlogic,meson-gxl-dwc3
-- clocks:	a handle for the "USB general" clock
-- clock-names:	must be "usb_general"
-- resets:	a handle for the shared "USB OTG" reset line
-- reset-names:	must be "usb_otg"
-
-Required child node:
-A child node must exist to represent the core DWC3 IP block. The name of
-the node is not important. The content of the node is defined in dwc3.txt.
-
-PHY documentation is provided in the following places:
-- Documentation/devicetree/bindings/phy/meson-gxl-usb2-phy.txt
-- Documentation/devicetree/bindings/phy/meson-gxl-usb3-phy.txt
-
-Example device nodes:
-		usb0: usb@ff500000 {
-			compatible = "amlogic,meson-axg-dwc3";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-
-			clocks = <&clkc CLKID_USB>;
-			clock-names = "usb_general";
-			resets = <&reset RESET_USB_OTG>;
-			reset-names = "usb_otg";
-
-			dwc3: dwc3@ff500000 {
-				compatible = "snps,dwc3";
-				reg = <0x0 0xff500000 0x0 0x100000>;
-				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-				dr_mode = "host";
-				maximum-speed = "high-speed";
-				snps,dis_u2_susphy_quirk;
-				phys = <&usb3_phy>, <&usb2_phy0>;
-				phy-names = "usb2-phy", "usb3-phy";
-			};
-		};
-- 
2.22.0

