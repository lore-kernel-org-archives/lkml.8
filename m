Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A1CC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D392078E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NTCciXFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgCZGtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 02:49:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37602 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgCZGti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:49:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id d1so5742658wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 23:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OVO9bKocQbOQc1/49KmYXs6ZePtPJP+gvN7tmpCfXfU=;
        b=NTCciXFrFmPV8p/p7Se0wRVKia7DN88jm5uIeaKNbyAlic+RsUF+B7vKYzASobnevi
         jjh8FsbzDj+k+HLucITbhLuKXFdhd8C42j/wwzeBhZpArOU9pu9KKR+Z8TCMjERkhgRO
         Sc868Vb47o/i+zLzdfPZYJlnzEff1j5Yq1hdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OVO9bKocQbOQc1/49KmYXs6ZePtPJP+gvN7tmpCfXfU=;
        b=ECCkGPLhuyjBvBTq30gs22AZb4Ymc5zD2KH0fXBTh22fCMoKKH0ZbqRYYhlE0LvuIk
         Xaz06TJT9pC/WQYBGgSDI9AAh9WT2ab/YjhSwd3iC1t2CoHxj3SIrbHRz3JKt90sm9jn
         aFyV7sqh5os3Ws8qbka9OVWYYu4YEzn+9Sr/sTmxEqUqF4ZZPsh+O66DbRfsZZEBJEWI
         59z68QfjSQ8WHDV2LvIapfSK98ENaSSH44Tjd9enmvKlqanp0NXJiU6VbkcnBtp5vJ/2
         Gda4bBkK2yCnp0hw7hHL36f00d2iriAhpjIZCOAk3wQJwSyauCg6y5aw6ic4xbM4a8lH
         bivQ==
X-Gm-Message-State: ANhLgQ386hRwnktApD+0D6+aPaRLcuv3WbZ47hpD/WF6Wz0PvLjKkh5i
        Hz8y7lxU7oKlzt4yKjonrenqAw==
X-Google-Smtp-Source: ADFU+vtPQW2fLjN0Jb2qkD9Ufe80DstHs3fBKYta9Yd//1Td0RCacNfRNc3cx/4XWzWkCZufQuUagQ==
X-Received: by 2002:a1c:408b:: with SMTP id n133mr1410962wma.182.1585205376914;
        Wed, 25 Mar 2020 23:49:36 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id v21sm2069137wmj.8.2020.03.25.23.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 23:49:36 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 4/6] arm: dts: Change PCIe INTx mapping for NSP
Date:   Thu, 26 Mar 2020 12:18:44 +0530
Message-Id: <1585205326-25326-5-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585205326-25326-1-git-send-email-srinath.mannam@broadcom.com>
References: <1585205326-25326-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ray Jui <ray.jui@broadcom.com>

Change the PCIe INTx mapping to model the 4 INTx interrupts in the
IRQ domain of the iProc PCIe controller itself.

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 45 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index da6d70f..6d73221 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -529,8 +529,11 @@
 		reg = <0x18012000 0x1000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+				<0 0 0 2 &pcie0_intc 1>,
+				<0 0 0 3 &pcie0_intc 2>,
+				<0 0 0 4 &pcie0_intc 3>;
 
 		linux,pci-domain = <0>;
 
@@ -559,6 +562,14 @@
 				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
+
+		pcie0_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	pcie1: pcie@18013000 {
@@ -566,8 +577,11 @@
 		reg = <0x18013000 0x1000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+				<0 0 0 2 &pcie1_intc 1>,
+				<0 0 0 3 &pcie1_intc 2>,
+				<0 0 0 4 &pcie1_intc 3>;
 
 		linux,pci-domain = <1>;
 
@@ -596,6 +610,14 @@
 				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
+
+		pcie1_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	pcie2: pcie@18014000 {
@@ -603,8 +625,11 @@
 		reg = <0x18014000 0x1000>;
 
 		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie2_intc 0>,
+				<0 0 0 2 &pcie2_intc 1>,
+				<0 0 0 3 &pcie2_intc 2>,
+				<0 0 0 4 &pcie2_intc 3>;
 
 		linux,pci-domain = <2>;
 
@@ -633,6 +658,14 @@
 				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
+
+		pcie2_intc: interrupt-controller {
+			compatible = "brcm,iproc-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	thermal-zones {
-- 
2.7.4

