Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9638BC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D03C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV6ESjvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgCJTtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:49:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42870 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:49:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id h8so6775247pgs.9;
        Tue, 10 Mar 2020 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=emQ/yaW/q4/ovb1N6uLBO7edbmwlmGSYTgLz5DT87lA=;
        b=EV6ESjvMWVAvTDBujuWToM6fGI3hSCL2aCgcuSqMgAc8yycZzHOC7OHaPIsAiB713o
         O/Y0aZQJKvNIJjiF8siDeNtT636r09VfJU6Yd9CiAe5EJ170hoiWEXi/Z1DxnPZt4MGI
         L9me3kaVwfNRlFe6A8UuV3qHHJhTgGd3YObjOhAgOOu50a39FWrGcYTIZttalqZq8fmk
         OwXkGP/mgJVMvjpBc4asDsjBUXVyND9oa+PcwKfJpfYg+477WFUjU2uCAIGagz8wJuna
         YCy2P6DTgxZT6a6ZJ6/gMl5DTJniwhkupAh/Vu4DcgpjvcickHR23AVoJW9WbVGUWGRj
         BxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emQ/yaW/q4/ovb1N6uLBO7edbmwlmGSYTgLz5DT87lA=;
        b=HYAwhsUBdDfc3Mid7DuihZYq16FDU7JRQKj/Kce4i8X9xf7dw6R/Yw4thJ3m1KlNHx
         1N5qaunKlWL5eHMb6/Ggav7VhYVqTROWPoDkE6lE8TWC87N5gu6O+6xcbn/Nd4lxtWUC
         l+ntN9josktTRRR4PbBOn/wLa8+MjDRQzn0uD4ZrNiG44SppldtAcQMnk8HKn8C7eqHI
         2enSZykPbazimU/JhvmOLMhHT3Hu4bHvRs1VDzawG58oGs7LHW7CxX4AGch1xhc9h7VJ
         sT7xEQLF5HQj18cgLIS0yN9jb6i3f7vxp4JnWPs3RdmtavRhC0U9U/wZUrJGsyJ5bRN3
         vlag==
X-Gm-Message-State: ANhLgQ3YESKSlsjOxZ4MUIsaqSHwxeyepQR75gkogotWRsgOhyA4E3KD
        2pOzJBcvT7MUT4l0qVpxpRCNuqZI
X-Google-Smtp-Source: ADFU+vtDBYANFwpiHqzazrotjATDf0coh4Fl5OzSUKLN06VFFAld3h6QHUGXG0wvNEoqt2bc+hC5wg==
X-Received: by 2002:a62:3086:: with SMTP id w128mr2539561pfw.63.1583869778145;
        Tue, 10 Mar 2020 12:49:38 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.228])
        by smtp.gmail.com with ESMTPSA id d19sm3784490pfd.82.2020.03.10.12.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:49:37 -0700 (PDT)
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
Subject: [PATCHv3 3/5] ARM: dts: exynos: Add FSYS power domain to Exynos542x USB nodes
Date:   Tue, 10 Mar 2020 19:48:52 +0000
Message-Id: <20200310194854.831-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310194854.831-1-linux.amoon@gmail.com>
References: <20200310194854.831-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a power domain FSYS for USB 3.0 and USB 2.0 and pdma nodes present
on Exynos542x/5800 SoCs.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch in this series.
---
 arch/arm/boot/dts/exynos5420.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index bd505256a223..4046b669b105 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -396,6 +396,13 @@ msc_pd: power-domain@10044120 {
 			label = "MSC";
 		};
 
+		fsys_pd: power-domain@10044140 {
+			compatible = "samsung,exynos4210-pd";
+			reg = <0x10044140 0x20>;
+			#power-domain-cells = <0>;
+			label = "FSYS";
+		};
+
 		pinctrl_0: pinctrl@13400000 {
 			compatible = "samsung,exynos5420-pinctrl";
 			reg = <0x13400000 0x1000>;
@@ -461,6 +468,7 @@ pdma0: pdma@121a0000 {
 				#dma-cells = <1>;
 				#dma-channels = <8>;
 				#dma-requests = <32>;
+				power-domains = <&fsys_pd>;
 			};
 
 			pdma1: pdma@121b0000 {
@@ -472,6 +480,7 @@ pdma1: pdma@121b0000 {
 				#dma-cells = <1>;
 				#dma-channels = <8>;
 				#dma-requests = <32>;
+				power-domains = <&fsys_pd>;
 			};
 
 			mdma0: mdma@10800000 {
@@ -1374,17 +1383,20 @@ &trng {
 &usbdrd3_0 {
 	clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBD300>;
 	clock-names = "usbdrd30", "usbdrd30_susp_clk";
+	power-domains = <&fsys_pd>;
 };
 
 &usbdrd_phy0 {
 	clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
 	clock-names = "phy", "ref";
 	samsung,pmu-syscon = <&pmu_system_controller>;
+	power-domains = <&fsys_pd>;
 };
 
 &usbdrd3_1 {
 	clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBD301>;
 	clock-names = "usbdrd30", "usbdrd30_susp_clk";
+	power-domains = <&fsys_pd>;
 };
 
 &usbdrd_dwc3_1 {
@@ -1395,16 +1407,19 @@ &usbdrd_phy1 {
 	clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
 	clock-names = "phy", "ref";
 	samsung,pmu-syscon = <&pmu_system_controller>;
+	power-domains = <&fsys_pd>;
 };
 
 &usbhost1 {
 	clocks = <&clock CLK_USBH20>;
 	clock-names = "usbhost";
+	power-domains = <&fsys_pd>;
 };
 
 &usbhost2 {
 	clocks = <&clock CLK_USBH20>;
 	clock-names = "usbhost";
+	power-domains = <&fsys_pd>;
 };
 
 &usb2_phy {
@@ -1412,6 +1427,7 @@ &usb2_phy {
 	clock-names = "phy", "ref";
 	samsung,sysreg-phandle = <&sysreg_system_controller>;
 	samsung,pmureg-phandle = <&pmu_system_controller>;
+	power-domains = <&fsys_pd>;
 };
 
 &watchdog {
-- 
2.25.1

