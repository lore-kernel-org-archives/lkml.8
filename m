Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B640C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D649214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5gEYlBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBJKva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:51:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40008 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJKv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:51:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id z7so3720333pgk.7;
        Mon, 10 Feb 2020 02:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p42+ttO1ACEDu5FtoT82sx8qB9cgNKUTPXb7H+w5L8U=;
        b=e5gEYlBGSlInNn4AZG1XTTS46MWPOqap/JFR+eiDitC23urRR1tMrP7R9ZoWSgwxos
         VhXUL0/zA89byw0SjgSZhCNCl6jZ0sDpmsFIhzehBmVW+x1DddG7cP6RPkkIga8lHQls
         VVtXMDpAOzYiGQS6EmZ7QPCmu3hUtRFGMwC5RjsD36sGfWXXGYYKOg+gbfjPprlULXfu
         GCeLwGczRH9f1NKxXmPm50Q9qN2NGTjxn0mHy7V7P4J00GrT6WvtQfqfnO/xcdxk63WE
         gjLB/VhZDCG2QJ4jOVpzKiadFYkVo9ezckoTAppoH3N/F9g42TBErZ6u2HbDi92iRU1u
         nJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p42+ttO1ACEDu5FtoT82sx8qB9cgNKUTPXb7H+w5L8U=;
        b=XHMDVmpNrXnQsdq1A/9wthV3g8w9cavL7SXJqUbIpfHLXidYtwHZ12k6LuS/yv/O4U
         1hpW/LLfaJlujfACvwZR+ALyx41KD+u9oSO3U9lpiRDPGmlwNAQuuUVsTViEtgbNoZr3
         esU8QSKl0PjVL8AylKIZXBLHAxfpfK9N64BKvyG0XUyxcYq6H/HCB8Uwsk4TazHarmWL
         8HEz05M9SYnN1THhLwiCjandMciCmBWWXh5zsrSdCSs5RddOFrse/yKlnJM8ktAoiVhN
         shZPvf0itX6FXF8n0HYJ9GijPk/zmTvIoq2wx29K+PBvqMJ5UcDX5p0zJJjnB+wTNLKI
         CpQA==
X-Gm-Message-State: APjAAAVnFqbDrgzM0qsxKYH2K4dBcaoAOeLQ7Uyz95MGe5Tm45obZame
        rvx+BRqyegu2bJy6DZEXFINIFM1D
X-Google-Smtp-Source: APXvYqw8iY+vqIud8Ioh0QjR3WQXowpWGR+Hec/dOvsjTK0/PQfZW5BgsXFAwnUGmQz4TSoCS7H3NQ==
X-Received: by 2002:a65:5283:: with SMTP id y3mr1032908pgp.370.1581331886236;
        Mon, 10 Feb 2020 02:51:26 -0800 (PST)
Received: from localhost.localdomain ([45.114.62.33])
        by smtp.gmail.com with ESMTPSA id g18sm12104833pfi.80.2020.02.10.02.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 02:51:25 -0800 (PST)
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
Subject: [PATCHv3 2/3] ARM: dts: exynos: Add missing usbdrd3 suspend clk
Date:   Mon, 10 Feb 2020 10:51:07 +0000
Message-Id: <20200210105108.1128-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210105108.1128-1-linux.amoon@gmail.com>
References: <20200210105108.1128-1-linux.amoon@gmail.com>
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
 arch/arm/boot/dts/exynos5420.dtsi | 8 ++++----
 arch/arm/boot/dts/exynos54xx.dtsi | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

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
2.25.0

