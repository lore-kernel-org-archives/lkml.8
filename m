Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0712C3F2D4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CE524695
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQMUrVN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCAVUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 16:20:44 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:41715 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgCAVUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:20:42 -0500
Received: by mail-pg1-f169.google.com with SMTP id b1so4367631pgm.8;
        Sun, 01 Mar 2020 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rc9J+Cmf71xfajfNUuMMuICeYb/kHr4TudELbJoBD3U=;
        b=AQMUrVN/O+R6rAjAo1vv4GsivdtxeED67OT3d0xxSkrDvt3fYq+Yel4+P7Y3Q/peOq
         k5uX0o66W1+HYmLyIYOB/oxZxnXQ2e16d9RDQwIK/V3SyUWwnz3vWstf/fZMZqZj26Uo
         hf5TPTXaorYnBzBwVXurSfLjYLcuwNZPSgO8HLjmZWYIc8S+HfSwvJm2zkj6sdRgpgvu
         kkITrVOyk1GplF4ZAXZDEfgnjzlkSQ2qUT0Dz4JjNfY20neR/+vRgGnZmJuq8xnhN72g
         G+Za/Wgfw+yvRIIrbYh4ZGb/9Ir9+Sf6iP6dQxDpf+m7ZzsipE4gBj6n4NTQ5t1NB6RK
         NKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rc9J+Cmf71xfajfNUuMMuICeYb/kHr4TudELbJoBD3U=;
        b=NZVljGT5uclsOHhScgxrOO13UkZTIUBvDdFu8Ma7VjRl50BdbDkj346G1v9iLXSN1o
         7qFfZHmyuqx8nQfyA5U2yI3prwj5Zc4XPnrfhsge6HD8OwiNQWYzdaWpBXh+BqLHWOa/
         T/e124JA/Ad9asFN6O4ybj610VHNvQV4JTpzQSyIg4elZs+/nZpb3d44dCM+p5zr6CRr
         BmGobYInqKP2swJbhdk1+kgZ5MQBbWO2QmG+8XLh334SLZReRM6XdZpiQSupqXlyAhpR
         vYDBEvg78vjb9qFK/j4k1eW/WuYkUcfRmha5WGy6xZg9SjiS9UXbdlabh9z4FWzcXQDP
         Aaqw==
X-Gm-Message-State: APjAAAUbHN2qUToO3E/9zdeQNxIJiQlXfVazirHxpu/JtPC2mMoUsA21
        hKDfMoNwRMoBOk5rwEakqIFD+ko2
X-Google-Smtp-Source: APXvYqx6mpbuec4O7HMvIyBfEoEAnpVGqr1liKpxzSafteugww+5sx6T9X6KQolbli+jWf31t10u8w==
X-Received: by 2002:aa7:971c:: with SMTP id a28mr15117532pfg.152.1583097641365;
        Sun, 01 Mar 2020 13:20:41 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.208])
        by smtp.gmail.com with ESMTPSA id u19sm4547686pgf.11.2020.03.01.13.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 13:20:40 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 2/3] ARM: dts: exynos: Add missing usbdrd3 suspend clk
Date:   Sun,  1 Mar 2020 21:20:17 +0000
Message-Id: <20200301212019.2248-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200301212019.2248-1-linux.amoon@gmail.com>
References: <20200301212019.2248-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new combatible strings for USBDRD3
for adding missing suspend clk, exynos5422 usbdrd3
support two clk USBD300 and SCLK_USBD300, so add missing
suspemd_clk for Exynos542x DWC3 nodes.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Previous changes:
	Added missing suspend clk name Exynos5410 SoC.
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

