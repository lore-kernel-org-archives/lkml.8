Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E972C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E3722314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iZhYOgHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgBNNyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:54:09 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13408 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbgBNNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:54:09 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e46a63d0000>; Fri, 14 Feb 2020 05:53:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 14 Feb 2020 05:54:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 14 Feb 2020 05:54:08 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 13:54:08 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 14 Feb 2020 13:54:07 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.133.51]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e46a67d0001>; Fri, 14 Feb 2020 05:54:07 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] ARM64: tegra: Fix Tegra194 PCIe compatible string
Date:   Fri, 14 Feb 2020 13:53:53 +0000
Message-ID: <20200214135353.31334-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581688381; bh=S/RFy4FJST5kVRAYMx9GpBNAntAYNupBOBr7JKDRlcg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=iZhYOgHRE0dxNg+1Oi9qTf9O4s3Tv7/r92CSC+qF36p2UXRIECHg2v3XaTamR4T5C
         FdqJju8E7bpHLV6vbXy/stfJICZNOrnK8j+ggmW6t3N/N3njr2etUybjKGgiOlzFgv
         WorlFV6Oih4O318T4jfFFRgztBtReUfuRKHbjRz9qyIOpS62ROBQYrzz8YIpWsn5JH
         vqxdfR3uWRAomuwZhI0PV/tvH2Czt8j6rgv8g+VBA5pPoQ2Kx4IXszy1ookSg2hgHp
         uwk/4AFfH/1vF2LpLAa60AxxNx+HB4vJAtJymIEeGFYDXkLqu3u2HOaZGA9ieP0XeW
         9gCo5ORcetLBA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel configuration option CONFIG_PCIE_DW_PLAT_HOST is enabled
then this can cause the kernel to incorrectly probe the generic
designware PCIe platform driver instead of the Tegra194 designware PCIe
driver. This causes a boot failure on Tegra194 because the necessary
configuration to access the hardware is not performed.

The order in which the compatible strings are populated in Device-Tree
is not relevant in this case, because the kernel will attempt to probe
the device as soon as a driver is loaded and if the generic designware
PCIe driver is loaded first, then this driver will be probed first.
Therefore, to fix this problem, remove the "snps,dw-pcie" string from
the compatible string as we never want this driver to be probe on
Tegra194.

Fixes: 2602c32f15e7 ("arm64: tegra: Add P2U and PCIe controller nodes to Tegra194 DT")

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../devicetree/bindings/pci/nvidia,tegra194-pcie.txt |  2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi             | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
index b739f92da58e..1f90eb39870b 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
@@ -118,7 +118,7 @@ Tegra194:
 --------
 
 	pcie@14180000 {
-		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		compatible = "nvidia,tegra194-pcie";
 		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
 		reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
 		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index ccac43be12ac..4c58cb10fb9c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1208,7 +1208,7 @@
 	};
 
 	pcie@14100000 {
-		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		compatible = "nvidia,tegra194-pcie";
 		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
 		reg = <0x00 0x14100000 0x0 0x00020000   /* appl registers (128K)      */
 		       0x00 0x30000000 0x0 0x00040000   /* configuration space (256K) */
@@ -1253,7 +1253,7 @@
 	};
 
 	pcie@14120000 {
-		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		compatible = "nvidia,tegra194-pcie";
 		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
 		reg = <0x00 0x14120000 0x0 0x00020000   /* appl registers (128K)      */
 		       0x00 0x32000000 0x0 0x00040000   /* configuration space (256K) */
@@ -1298,7 +1298,7 @@
 	};
 
 	pcie@14140000 {
-		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		compatible = "nvidia,tegra194-pcie";
 		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
 		reg = <0x00 0x14140000 0x0 0x00020000   /* appl registers (128K)      */
 		       0x00 0x34000000 0x0 0x00040000   /* configuration space (256K) */
@@ -1343,7 +1343,7 @@
 	};
 
 	pcie@14160000 {
-		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		compatible = "nvidia,tegra194-pcie";
 		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX4A>;
 		reg = <0x00 0x14160000 0x0 0x00020000   /* appl registers (128K)      */
 		       0x00 0x36000000 0x0 0x00040000   /* configuration space (256K) */
@@ -1388,7 +1388,7 @@
 	};
 
 	pcie@14180000 {
-		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		compatible = "nvidia,tegra194-pcie";
 		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
 		reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
 		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
@@ -1433,7 +1433,7 @@
 	};
 
 	pcie@141a0000 {
-		compatible = "nvidia,tegra194-pcie", "snps,dw-pcie";
+		compatible = "nvidia,tegra194-pcie";
 		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
 		reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
 		       0x00 0x3a000000 0x0 0x00040000   /* configuration space (256K) */
-- 
2.17.1

