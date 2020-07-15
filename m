Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA24C433ED
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81A32065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="M5yRZ7ZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgGOHHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgGOHHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:07:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA80C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:07:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so1374543ljp.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VY6/nDkB+l4D8VdfNdnYyBq9q17cRBW9+cu/3oGCNgQ=;
        b=M5yRZ7ZNspTd64Y3T6EJeSR8BEe9OMlQ4XzMqNsOL1aKRBkPYizWm15squLSNLr9f4
         rBa60eFJit6+maotnQ0qwVNmkkLEr4LVlSlzvj50dEO69YdHS5LGWqgTJl3WaayqMB8R
         Ss6sFZTMqqjWmVvbOlQURv3BkEDVa/Hs+YtYv7dc6MrmaUbbM4HVBY0SmwiSfe+i3cFi
         4+58toaeQyrLor5BcsThGO+Y+N1NOvzG0UskCEa6PKcaO3ky/HnQ0o061JCSBoKZf7Da
         9TPt7j8CUVnAL6og2kyuNqRC+YEboLTL+BgBpgFEUYvj2Or8EzdjCQuqd1NoOSsGkyTI
         wmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VY6/nDkB+l4D8VdfNdnYyBq9q17cRBW9+cu/3oGCNgQ=;
        b=Y2mOrxaCYIgj5VdjsAaYub2d9/mHXgDZsQQXAvXrqRYjXTaNPRA2a36mGlOrPmjZyD
         Ia1OXdruk0IXAjhutnSa6thOg2usXGm5SV1eGKWZ8+v6RItLU+Lic0lRrYaF9z3mbWjW
         ZXQrOdPzJAjq2KbfbT7VNV1Fq3+RowqKHuwsqTwAK1ixmI6LMpX9JwdJFMwnU442YdSk
         IVJlXwxUgSV4wrADNc+QE+8uCQXHpveSW60G4Y8Zy/J69GBEQgjyEOvciioBTa5I4B7Y
         vQQlrtcr29ph+Wf2Ii2MCwfmSqoI4ZbRPndiulorsfUYyX9Lspk1AR6SV5/MmW6iESXx
         uf5w==
X-Gm-Message-State: AOAM532QFuyhkXaM9uKS8oIRTMMztDK6IU8+GTKf/vjGE/hIut9+zHei
        rlTHdFZGubv7wl/7Tm84Y9EHQA==
X-Google-Smtp-Source: ABdhPJwrpgLAN7Afl7yoGdK1hqq6n9x3hw3elslWkLxcDk1FTatcRnB2CeQPdKz7PyWfn5zgrTCMAQ==
X-Received: by 2002:a2e:859a:: with SMTP id b26mr4332777lji.241.1594796825939;
        Wed, 15 Jul 2020 00:07:05 -0700 (PDT)
Received: from localhost.localdomain ([83.68.95.66])
        by smtp.gmail.com with ESMTPSA id 83sm276040ljj.51.2020.07.15.00.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 00:07:05 -0700 (PDT)
From:   Tomasz Nowicki <tn@semihalf.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH v4 4/4] arm64: dts: marvell: add SMMU support
Date:   Wed, 15 Jul 2020 09:06:49 +0200
Message-Id: <20200715070649.18733-5-tn@semihalf.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715070649.18733-1-tn@semihalf.com>
References: <20200715070649.18733-1-tn@semihalf.com>
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
 arch/arm64/boot/dts/marvell/armada-7040.dtsi  | 28 +++++++++++++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 40 +++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 18 +++++++++
 3 files changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040.dtsi b/arch/arm64/boot/dts/marvell/armada-7040.dtsi
index 47247215770d..7a3198cd7a07 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-7040.dtsi
@@ -14,3 +14,31 @@
 	compatible = "marvell,armada7040", "marvell,armada-ap806-quad",
 		     "marvell,armada-ap806";
 };
+
+&smmu {
+	status = "okay";
+};
+
+&cp0_pcie0 {
+	iommu-map =
+		<0x0   &smmu 0x480 0x20>,
+		<0x100 &smmu 0x4a0 0x20>,
+		<0x200 &smmu 0x4c0 0x20>;
+	iommu-map-mask = <0x031f>;
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
+&cp0_usb3_0 {
+	iommus = <&smmu 0x440>;
+};
+
+&cp0_usb3_1 {
+	iommus = <&smmu 0x441>;
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
index 7699b19224c2..79e8ce59baa8 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
@@ -15,6 +15,18 @@
 		     "marvell,armada-ap806";
 };
 
+&smmu {
+	status = "okay";
+};
+
+&cp0_pcie0 {
+	iommu-map =
+		<0x0   &smmu 0x480 0x20>,
+		<0x100 &smmu 0x4a0 0x20>,
+		<0x200 &smmu 0x4c0 0x20>;
+	iommu-map-mask = <0x031f>;
+};
+
 /* The RTC requires external oscillator. But on Aramda 80x0, the RTC clock
  * in CP master is not connected (by package) to the oscillator. So
  * disable it. However, the RTC clock in CP slave is connected to the
@@ -23,3 +35,31 @@
 &cp0_rtc {
 	status = "disabled";
 };
+
+&cp0_sata0 {
+	iommus = <&smmu 0x444>;
+};
+
+&cp0_sdhci0 {
+	iommus = <&smmu 0x445>;
+};
+
+&cp0_usb3_0 {
+	iommus = <&smmu 0x440>;
+};
+
+&cp0_usb3_1 {
+	iommus = <&smmu 0x441>;
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
diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index 7f9b9a647717..12e477f1aeb9 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -56,6 +56,24 @@
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
+				status = "disabled";
+			};
+
 			gic: interrupt-controller@210000 {
 				compatible = "arm,gic-400";
 				#interrupt-cells = <3>;
-- 
2.17.1

