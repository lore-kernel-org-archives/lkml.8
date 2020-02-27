Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A73C35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E982246B0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfPEalD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgB0SPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:15:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43345 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbgB0SPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:15:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so110337oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/fceep5tK7g/cQy1ebhtOFWEM+NoOwKfSWVqLp3Aas=;
        b=NfPEalD3gnGcIvoGVMrqUf/THI/PvhfS1WFvlfFpZ7wwE9F9w0AnL+WK0ycy7SYPph
         lxOjCTyMPeyt/LMS/wKBV8651zX5X9G/qTG3YRY/8ilIW9HDbuwIo+UwhheBQ8vwYiCR
         VfVvGehkkXb5OYH0zUoKKc1m9KTRuVNJ7s9pHshsiCP9JiR2SotpegRzDEdA3+x+RxTB
         KD8KdY8gqdDwG4Ecl++s/UxwKXVWkJKVNNG21EIUgJvLWzXtp7cd29rFNwisqJ41FFu9
         isH6xKVfobo9lHzeBxkzu2eAN7AG2PWAeu31I3sv1hXNg1lWCmDxeOaD5YS3gSiC42ia
         l5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/fceep5tK7g/cQy1ebhtOFWEM+NoOwKfSWVqLp3Aas=;
        b=H8az9R6rgLI2nJZmH5YKEyWk07LR9/M28tBQiTtctqidFrhnsKyWaLEZMLH3uo1FDI
         /YMjPk7cwqIlr/M7BzNNgIab9oy4V906EiM7aaj9+aXMTomqtb7DKCI+CrehZ1bqap2Y
         pw+WEwFapjaM08/r8qfLjMwNoOxRHFRQ8aAIy6CcYsPYF9OjKBpZ6+GdHfhRSM7/1QXN
         VqSPwvAhHCgZumvOzj4utyIowW2LZupMnbuJVKcpFeqvCWu6usPxNpq8v0gbjqbTLtSN
         rkVRq+nPjXWcT45Ej6I9dSEog1VhZUxcN+c+ZLFhPSns16ltHsPFt/ta1K/py0tQkMuc
         vHOg==
X-Gm-Message-State: APjAAAVKC20SisoBWDDGTc1F4zljp5xPcdVombVmUt9Rd8EMmrGn+nDb
        KYQKQvdIZ5ZwQsTTFHP3vIk=
X-Google-Smtp-Source: APXvYqx4Ed9tiaIKgk51556LtCRi2y2AR/CnZ49Y36HioYpfhDeeaUOWsXCscaC+2pLcDKop+mfFcQ==
X-Received: by 2002:aca:48cd:: with SMTP id v196mr269114oia.102.1582827299702;
        Thu, 27 Feb 2020 10:14:59 -0800 (PST)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id t203sm2205534oig.39.2020.02.27.10.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:14:59 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 4/5] ARM: suniv: add USB-related device nodes
Date:   Thu, 27 Feb 2020 12:14:51 -0600
Message-Id: <20200227181452.31558-5-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227181452.31558-1-thirtythreeforty@gmail.com>
References: <20200227181452.31558-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The suniv SoC has a USB OTG controller and a USB PHY like other
Allwinner SoCs.

Add their device tree node.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index 6100d3b75f61..ec9f248ba889 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -4,6 +4,9 @@
  * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
  */
 
+#include <dt-bindings/clock/suniv-ccu-f1c100s.h>
+#include <dt-bindings/reset/suniv-ccu-f1c100s.h>
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -140,5 +143,31 @@ uart2: serial@1c25800 {
 			resets = <&ccu 26>;
 			status = "disabled";
 		};
+
+		usb_otg: usb@1c13000 {
+			compatible = "allwinner,suniv-f1c100s-musb";
+			reg = <0x01c13000 0x0400>;
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			interrupts = <26>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			extcon = <&usbphy 0>;
+			allwinner,sram = <&otg_sram 1>;
+			status = "disabled";
+		};
+
+		usbphy: phy@1c13400 {
+			compatible = "allwinner,suniv-f1c100s-usb-phy";
+			reg = <0x01c13400 0x10>;
+			reg-names = "phy_ctrl";
+			clocks = <&ccu CLK_USB_PHY0>;
+			clock-names = "usb0_phy";
+			resets = <&ccu RST_USB_PHY0>;
+			reset-names = "usb0_reset";
+			#phy-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.25.0

