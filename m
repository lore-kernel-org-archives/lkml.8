Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CFEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D2620772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="mGVQsM1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgGBURJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgGBURG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:17:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE3CC08C5DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:17:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 9so33832554ljv.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gzH+omRURB7g5dnoNMP6PMHslLf/Y7F/kj6XzNA/QUw=;
        b=mGVQsM1OHmkNMuQKfEJYsFI5quyzsuJsFTAUZWJ/6KyBegagF4WknJv8hivqEbilbd
         0iqCOMqN0lqbLtp6iy0H6LpC2Me+ocoD+Q2lm7mfie7rwf/yhiPBDkl60nOiuIs9/1JV
         Q6l/zKH9YBlnHxcV2R6Bp/FhIh+Jimc5V+21skqNt29/8oNAgjYRHEGBxLqlUdG9NsiB
         842yg9EimH7LtQKfGIM2EptqxVipxSrbMkoYSSiRpUsZEUPtdud1fFvHZ6ex+csGIwai
         TaKVOpdNjWEhMuAaqmf+XoPlc45UO6X/u9lb8TRI3aUJgBeA2CGOhduk3EnpZsnB1vc2
         8/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gzH+omRURB7g5dnoNMP6PMHslLf/Y7F/kj6XzNA/QUw=;
        b=cHwsvp9OQJ9Dv/m4mnXSe3vZ72eRIjhlFIeg10I8tkTR/hGNLHgZF50J57LH5dIpNL
         O8DqQpDsHdnAo246pjvKqxLuL9/E7TO9B3lLj0xAp2E12bDAKxi/3HkGiEFLFCCbOTos
         2Dtde+IAJ+Dg4goe1Fuv957C9jEJ/tP8Lu0R1pLswTQN0LGaSK93Pofg0u7ZKZzELF/Z
         D+Vr/HaWBOeIQ49bdJ17Trmu0sxjFJ4eklMmacDEVk/xwvHvKU/ELbBMq14ZAjsh9lYw
         JYrwJcYWedtq9E70hbh6VbI3BF71eNdxaNdOLuNmtx6NcTNFnLRAqm3VKVMyx1fKDCvu
         VttA==
X-Gm-Message-State: AOAM531pcOqFIyRUv/34wJPqcLPJvFcbEL3LT/pdrdk2BG5p4W8jLiSi
        Q11pkoA7GHx+3bDU+p+9yZrYhg==
X-Google-Smtp-Source: ABdhPJyAEBFVxmo+Nfl2SUUNGRJI1G7JcT5WyW5G2pp8pha1D7djhhHUEvpahtR9RO3iOMUzRApxJg==
X-Received: by 2002:a2e:98d0:: with SMTP id s16mr7703772ljj.457.1593721024303;
        Thu, 02 Jul 2020 13:17:04 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
        by smtp.gmail.com with ESMTPSA id y2sm3320372lji.8.2020.07.02.13.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:17:03 -0700 (PDT)
From:   Tomasz Nowicki <tn@semihalf.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH v3 4/4] arm64: dts: marvell: add SMMU support
Date:   Thu,  2 Jul 2020 22:16:33 +0200
Message-Id: <20200702201633.22693-5-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702201633.22693-1-tn@semihalf.com>
References: <20200702201633.22693-1-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>

Add IOMMU node for Marvell AP806 based SoCs together with platform
and PCI device Stream ID mapping.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 36 +++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 17 +++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
index 7699b19224c2..25c1df709f72 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
@@ -23,3 +23,39 @@
 &cp0_rtc {
 	status = "disabled";
 };
+
+&cp0_usb3_0 {
+	iommus = <&smmu 0x440>;
+};
+
+&cp0_usb3_1 {
+	iommus = <&smmu 0x441>;
+};
+
+&cp0_sata0 {
+	iommus = <&smmu 0x444>;
+};
+
+&cp0_sdhci0 {
+	iommus = <&smmu 0x445>;
+};
+
+&cp1_sata0 {
+	iommus = <&smmu 0x454>;
+};
+
+&cp1_usb3_0 {
+	iommus = <&smmu 0x450>;
+};
+
+&cp1_usb3_1 {
+	iommus = <&smmu 0x451>;
+};
+
+&cp0_pcie0 {
+	iommu-map =
+		<0x0   &smmu 0x480 0x20>,
+		<0x100 &smmu 0x4a0 0x20>,
+		<0x200 &smmu 0x4c0 0x20>;
+	iommu-map-mask = <0x031f>;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index 7f9b9a647717..ded8b8082d79 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -56,6 +56,23 @@
 			compatible = "simple-bus";
 			ranges = <0x0 0x0 0xf0000000 0x1000000>;
 
+			smmu: iommu@5000000 {
+				compatible = "marvell,ap806-smmu-500", "arm,mmu-500";
+				reg = <0x100000 0x100000>;
+				dma-coherent;
+				#iommu-cells = <1>;
+				#global-interrupts = <1>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			gic: interrupt-controller@210000 {
 				compatible = "arm,gic-400";
 				#interrupt-cells = <3>;
-- 
2.17.1

