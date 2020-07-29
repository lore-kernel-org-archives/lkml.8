Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC1DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49DB520829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii8Ctz3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgG2MBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgG2MBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:01:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D177C061794;
        Wed, 29 Jul 2020 05:01:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f1so20825878wro.2;
        Wed, 29 Jul 2020 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/lXxR/NY5u0DlFOjxBacWTF69g+Zu3unhXyQAhYQnSE=;
        b=Ii8Ctz3D1uiaERNJl48OkBtwTsKK2ZgNHo2JVCi0umqh5bVDAWfQnOGPkwcZ2P973I
         0yKCKXDQMyUc74/kyskmDD/DDtzue58n914mjexDJIivrZyiJlimdxt/OJIHqrIv6mwA
         rHA3uhRVeX/X358AkqMxCVTm6ZfbVcGn4loRE53biVZ2iY6dazW1LKfbtCtrAIPrXT0v
         AHkOarc6wpIX0p2UlWoaweASjy6au/fKTH6rn58VO6KFfgtKfjmATOX86d0arEkw6u+h
         XAWL41doIVAg8QETx34xKQvYPrQCot28RRfIY2J7BKrnfyjsC1Sh8TbodjKcgdYZOZPq
         Ltqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lXxR/NY5u0DlFOjxBacWTF69g+Zu3unhXyQAhYQnSE=;
        b=sN76ac2729+S4L9Bo7EoMLjcXnjU7JP+SbjGEdJq/Pk8DpBpxaNkxNePmcRgwT+hFU
         C+IaCFtGp2vIXaBFXvT1zO2STqsPw5PBNF3l0daEmBC4DcDAGFpklUYSRQMl/ljVyAE1
         +nPl2+RiDpEwmxo9Iar66txrMJIK4XLxD85Pr98g6s8jK03Q+fOAnMao1C1A7UgyqpTe
         iSW/lLtbBa7aaPa9USDUmFGB9A5hYntAL9as4IN0QOC+4J8nE77zrq0wccMvC8SW16Eh
         RQMBpg94wLHqv6MlQldnzWcJwicjXgGPW/o7b6A+z5pqJzdLQ2dktgaTni88hmEr6u04
         K2EA==
X-Gm-Message-State: AOAM532kmMIA8u0iZ8OewLtpDMDi7TsSlnROyeQMqjPUc63pgLWqo4Ld
        IggbNzXNTEwQ5+yf3KzPwCM=
X-Google-Smtp-Source: ABdhPJxaKldZOn68WQ/doouvGxrGEYEWjbgALmqtHMS66sqTK2JQ8XMWs+RYhCzLTZ0pkwMmX0ptvw==
X-Received: by 2002:a5d:54ca:: with SMTP id x10mr21919524wrv.36.1596024079094;
        Wed, 29 Jul 2020 05:01:19 -0700 (PDT)
Received: from localhost.localdomain (abad207.neoplus.adsl.tpnet.pl. [83.6.167.207])
        by smtp.googlemail.com with ESMTPSA id l67sm5426000wml.13.2020.07.29.05.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 05:01:18 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
To:     konradybcio@gmail.com
Cc:     lauren.kelly@msn.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 07/10] arm64: dts: qcom: msm8994: Add SDHCI2 node
Date:   Wed, 29 Jul 2020 14:00:53 +0200
Message-Id: <20200729120057.35079-8-konradybcio@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729120057.35079-1-konradybcio@gmail.com>
References: <20200729120057.35079-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SDHCI2 to enable use of uSD cards on msm8994.

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 58 +++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 69c99a4cd817..58fc8b0321c3 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -336,6 +336,28 @@ sdhc1: sdhci@f9824900 {
 			status = "disabled";
 		};
 
+		sdhc2: sdhci@f98a4900 {
+			compatible = "qcom,sdhci-msm-v4";
+			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
+			reg-names = "hc_mem", "core_mem";
+
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
+				<&gcc GCC_SDCC2_AHB_CLK>,
+				<&xo_board>;
+			clock-names = "core", "iface", "xo";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
+			pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
+
+			bus-width = <4>;
+			status = "disabled";
+		};
+
 		blsp1_dma: dma@f9904000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0xf9904000 0x19000>;
@@ -714,6 +736,42 @@ sdc1_rclk_off: rclk-off {
 				pins = "sdc1_rclk";
 				bias-pull-down;
 			};
+
+			sdc2_clk_on: sdc2-clk-on {
+				pins = "sdc2_clk";
+				bias-disable;
+				drive-strength = <10>;
+			};
+
+			sdc2_clk_off: sdc2-clk-off {
+				pins = "sdc2_clk";
+				bias-disable;
+				drive-strength = <2>;
+			};
+
+			sdc2_cmd_on: sdc2-cmd-on {
+				pins = "sdc2_cmd";
+				bias-pull-up;
+				drive-strength = <10>;
+			};
+
+			sdc2_cmd_off: sdc2-cmd-off {
+				pins = "sdc2_cmd";
+				bias-pull-up;
+				drive-strength = <2>;
+			};
+
+			sdc2_data_on: sdc2-data-on {
+				pins = "sdc2_data";
+				bias-pull-up;
+				drive-strength = <10>;
+			};
+
+			sdc2_data_off: sdc2-data-off {
+				pins = "sdc2_data";
+				bias-pull-up;
+				drive-strength = <2>;
+			};
 		};
 	};
 
-- 
2.27.0

