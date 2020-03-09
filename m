Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0B2C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6722253D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz2vFwc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgCIUoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:44:12 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38111 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgCIUoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:44:01 -0400
Received: by mail-yw1-f66.google.com with SMTP id 10so11552740ywv.5;
        Mon, 09 Mar 2020 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/fceep5tK7g/cQy1ebhtOFWEM+NoOwKfSWVqLp3Aas=;
        b=Hz2vFwc0nYdeV5cd546SsYwQDnc6xvKjsYhz9+iARd6xTUmC+dKt2Uz46n/7Bb7bgk
         hIoX0r6POdCmsZVB4KFJsOr2JUJuofE/M1mICkLwSyLMs/MXlvn1VU8GNiJfkMCsrE6Z
         aT+vHyDRafh8vLTeqARgh1iCaJ8vVH85VLoqi2fRHRJllMDe/vH3Jg69Cg+LwUeI6+J2
         3ByoOCYoAJx0riAfyjbERcckrVqxnUSzkF5iGn8/ZA0hEHL0gc8VRrgLLBhg+NKpo748
         zxIOYQVf/aA06RaE73lOcqtb94dPKCAEg4GvKuM3nF2AnAU9HbF7hvQ4rFoNGP1pjE0f
         mfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/fceep5tK7g/cQy1ebhtOFWEM+NoOwKfSWVqLp3Aas=;
        b=HKmF67j1UzxHBiMco8rLlFuzvbCkoZXnKdVwtwFefMKWblJz+D2N+r4MqVTyv9omoK
         CDdhw3HdmmiLWRGeVWkm/L4x9AQEwiQd7gJn+d808fexcotFc5o0OWULKPvCiwCwIlvo
         7yZTlbUonmimo4g9EQCLN5DUMVZ7EY7kFdDPaU2bDhptxFHMaaAcv06S01QBjRy0ks2U
         jrePzBmYgjPuGnvG38qiEYfZPq6KP4LLQGSydoPH9cRkVCjuI0FcKdsgz5Ig0rK90Aok
         W0hyvUIjIFBlAyG5lFPpO5lEgTHpayM9i6QKuljXIww/Vvd4vUfyGH0IpAWrmoVDwZM5
         hzuQ==
X-Gm-Message-State: ANhLgQ0M8uHZJJdsANbBcXIh4g2XyBhwdd5E3YDsR1vZvs9PGrV6AkaZ
        eeefrIxGzHDgidgPHuOLfms=
X-Google-Smtp-Source: ADFU+vuVvvHYjwOnjefwzxrZhA+8mJhrosC/3BG4D4ARSmu8fOt3CsQ1Tzv8g+xFANVj3y7QuViFWA==
X-Received: by 2002:a81:a3c9:: with SMTP id a192mr2854047ywh.244.1583786638964;
        Mon, 09 Mar 2020 13:43:58 -0700 (PDT)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id s63sm17998768ywd.82.2020.03.09.13.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:43:58 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [RESEND PATCH 4/5] ARM: suniv: add USB-related device nodes
Date:   Mon,  9 Mar 2020 15:43:25 -0500
Message-Id: <20200309204326.27403-5-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200309204326.27403-1-thirtythreeforty@gmail.com>
References: <20200309204326.27403-1-thirtythreeforty@gmail.com>
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

