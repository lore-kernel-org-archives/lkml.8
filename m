Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429C1C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C7C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhryD9cR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCJTtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:49:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40790 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJTte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:49:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id t24so6781003pgj.7;
        Tue, 10 Mar 2020 12:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BlRRGob7J72IN5GyJz6pdMyom8cMcGq7qyRKyuALUpg=;
        b=rhryD9cRP9JWGlYM8BmlNtISu5pjR9nG0ynqwsbi6rIQ85sDJW03idDEW23s+vAirS
         WMX7E0seO5cpkiDSidLDDQJ/p/IdhM6inTTy9NNR6PHYvav6Jl5Ewuosa+e7jVL54r8p
         N3TT6tp9tBm9wlWi/XGfiWkyyUSYqm4nyzeYzEKfybMl6Fy/hV40g5/UwrTfg2fHW3Qx
         XoTkiIPQ7RVeP2dpTVuzBRhxGGtBR7QEZZAEPQ5B6Dsz9UfDSQS+m7PrF7/NajedMuOO
         XEIFHu0sY/dWoqSsCr1cY8IDT79KmBbVkAeJZqVMGSjVA9RaKBeHxaonyE0DH7vbFFhc
         bo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlRRGob7J72IN5GyJz6pdMyom8cMcGq7qyRKyuALUpg=;
        b=JmWQaSAkOJuyaxmAFNeeYfEryEcy3dTqHp1hRiiyPh2XIcu0QhYxl+k5h5k3qUnXso
         uEvJFJ4HTUyrV5EC/AnBV/CCJisL4vO1qEToSpMlD3QfdaOB/YEYYYr16S2i1ReqPvZ8
         F2mTW6Bnof5ZoxUybLkHfkLH0LS2CAcv7K0J+TyaRt/8Q2awhpWBPtS+0CwZtD5ZzQ55
         VehxljqRPz4SkxKDR9UElvtOkZembf+94RzO6lPgItnC599Bo5Qyvvda2//T2MqroRtt
         imYMyLl1Onzl3EFWF55rMSeZ1Ulva8wvKcR4vbUqfJLX1QveBKBFF+ywl/L5BMCK2tdJ
         ShOA==
X-Gm-Message-State: ANhLgQ2IhxOGRi3Z5KU1V6zpXy67uIKPw1/rwzSI3Pbr6bt/hHhf7cuq
        3iYm3sA8J7UM/uGC5v60bI6RY2Yt
X-Google-Smtp-Source: ADFU+vtmfAWTjZEtzSy0EMp+kn2zIUsbV2u8IvW/1uuQblViS/0RtEbYS8Ss0AIaLMQ1+5H/3oUNAQ==
X-Received: by 2002:a63:fe58:: with SMTP id x24mr19572503pgj.170.1583869773118;
        Tue, 10 Mar 2020 12:49:33 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.228])
        by smtp.gmail.com with ESMTPSA id d19sm3784490pfd.82.2020.03.10.12.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:49:32 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCHv3 2/5] ARM: dts: exynos: Add missing usbdrd3 suspend clk
Date:   Tue, 10 Mar 2020 19:48:51 +0000
Message-Id: <20200310194854.831-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310194854.831-1-linux.amoon@gmail.com>
References: <20200310194854.831-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible strings for USBDRD3 for adding missing
suspend clk, exynos5422 usbdrd3 support two clk USBD300 and
SCLK_USBD300, so add missing suspemd_clk for Exynos542x DWC3 nodes.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
fix the commit message
---
 arch/arm/boot/dts/exynos5410.dtsi | 8 ++++----
 arch/arm/boot/dts/exynos5420.dtsi | 8 ++++----
 arch/arm/boot/dts/exynos54xx.dtsi | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 2eab80bf5f3a..19845dcd528f 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -396,8 +396,8 @@ &trng {
 };
 
 &usbdrd3_0 {
-	clocks = <&clock CLK_USBD300>;
-	clock-names = "usbdrd30";
+	clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBD300>;
+	clock-names = "usbdrd30", "usbdrd30_susp_clk";
 };
 
 &usbdrd_phy0 {
@@ -407,8 +407,8 @@ &usbdrd_phy0 {
 };
 
 &usbdrd3_1 {
-	clocks = <&clock CLK_USBD301>;
-	clock-names = "usbdrd30";
+	clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBD301>;
+	clock-names = "usbdrd30", "usbdrd30_susp_clk";
 };
 
 &usbdrd_dwc3_1 {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index b672080e7469..bd505256a223 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1372,8 +1372,8 @@ &trng {
 };
 
 &usbdrd3_0 {
-	clocks = <&clock CLK_USBD300>;
-	clock-names = "usbdrd30";
+	clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBD300>;
+	clock-names = "usbdrd30", "usbdrd30_susp_clk";
 };
 
 &usbdrd_phy0 {
@@ -1383,8 +1383,8 @@ &usbdrd_phy0 {
 };
 
 &usbdrd3_1 {
-	clocks = <&clock CLK_USBD301>;
-	clock-names = "usbdrd30";
+	clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBD301>;
+	clock-names = "usbdrd30", "usbdrd30_susp_clk";
 };
 
 &usbdrd_dwc3_1 {
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 8aa5117e58ce..0aac6255de5d 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -143,7 +143,7 @@ hsi2c_7: i2c@12cd0000 {
 		};
 
 		usbdrd3_0: usb3-0 {
-			compatible = "samsung,exynos5250-dwusb3";
+			compatible = "samsung,exynos5420-dwusb3";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -165,7 +165,7 @@ usbdrd_phy0: phy@12100000 {
 		};
 
 		usbdrd3_1: usb3-1 {
-			compatible = "samsung,exynos5250-dwusb3";
+			compatible = "samsung,exynos5420-dwusb3";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
2.25.1

