Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23294C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA70520702
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YVom8lFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgGFRPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:15:07 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19335 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgGFRPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:15:06 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f035be40001>; Mon, 06 Jul 2020 10:14:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 06 Jul 2020 10:15:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 06 Jul 2020 10:15:05 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 17:15:01 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 6 Jul 2020 17:15:01 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f035c110000>; Mon, 06 Jul 2020 10:15:00 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <robh+dt@kernel.org>, <treding@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <lorenzo.pieralisi@arm.com>, <amurray@thegoodpenguin.co.uk>,
        <bhelgaas@google.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH] arm64: tegra: Re-order PCIe aperture mappings
Date:   Mon, 6 Jul 2020 22:44:54 +0530
Message-ID: <20200706171454.11316-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594055652; bh=HXtWj3LVP+XSdF9JsC03QCj7zdWKkGYPzJ5wNbRbP04=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=YVom8lFwRwbSQMNkbudA/cWC5MN/0S7+zdRcwdGJ1OuevF+4RisPUDSC4mRGBCrcV
         eV+QVDai1UCGXXoes7efkoNEYUMCYlDmlNHwJytSosNfAilui5MFX/I+pSiIn4/vJ6
         F/XInpd4v6Kmh8RbkVXXZBh8LOPXNTFjCIJ9nZqKuZhmkifxsNyxEuu309ceg43BUh
         3uN7CXjWaY85UXKc9mfMsIMV9Bs02l9BrseP00Pp94h2i9PyFw7/YuzB2hsmkl7EvO
         nGngoIJ+n/9xnOM9u1Uex1jsemncSMKtL/4rn5yDBY3faUtyvls7VFsMN8g3uE05va
         asIr7B4gawhnA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-order Tegra194's PCIe aperture mappings to have IO window moved to
64-bit aperture and have the entire 32-bit aperture used for accessing
the configuration space. This makes it to use the entire 32MB of the 32-bit
aperture for ECAM purpose while booting through ACPI.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 36 ++++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 4bc187a4eacd..2b378fa06d19 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1404,9 +1404,9 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x30100000 0x0  0x30100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc3000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* prefetchable memory (768MB) */
-			  0x82000000 0x0  0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
+		ranges = <0xc3000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* prefetchable memory (768MB) */
+			  0x82000000 0x00 0x40000000 0x12 0x30000000 0x0 0x0fff0000   /* non-prefetchable memory (256MB - 64KB) */
+			  0x81000000 0x00 0x00000000 0x12 0x3fff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
 	};
 
 	pcie@14120000 {
@@ -1449,9 +1449,9 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x32100000 0x0  0x32100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc3000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* prefetchable memory (768MB) */
-			  0x82000000 0x0  0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
+		ranges = <0xc3000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* prefetchable memory (768MB) */
+			  0x82000000 0x00 0x40000000 0x12 0x70000000 0x0 0x0fff0000   /* non-prefetchable memory (256MB - 64KB) */
+			  0x81000000 0x00 0x00000000 0x12 0x7fff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
 	};
 
 	pcie@14140000 {
@@ -1494,9 +1494,9 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x34100000 0x0  0x34100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc3000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* prefetchable memory (768MB) */
-			  0x82000000 0x0  0x40000000 0x12 0xb0000000 0x0 0x10000000>; /* non-prefetchable memory (256MB) */
+		ranges = <0xc3000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* prefetchable memory (768MB) */
+			  0x82000000 0x00 0x40000000 0x12 0xb0000000 0x0 0x0fff0000   /* non-prefetchable memory (256MB - 64KB) */
+			  0x81000000 0x00 0x00000000 0x12 0xbfff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
 	};
 
 	pcie@14160000 {
@@ -1539,9 +1539,9 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x36100000 0x0  0x36100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc3000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
-			  0x82000000 0x0  0x40000000 0x17 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
+		ranges = <0xc3000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
+			  0x82000000 0x00 0x40000000 0x17 0x40000000 0x0 0xbfff0000   /* non-prefetchable memory (3GB - 64KB) */
+			  0x81000000 0x00 0x00000000 0x17 0xffff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
 	};
 
 	pcie@14180000 {
@@ -1584,9 +1584,9 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc3000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
-			  0x82000000 0x0  0x40000000 0x1b 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
+		ranges = <0xc3000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
+			  0x82000000 0x00 0x40000000 0x1b 0x40000000 0x0 0xbfff0000   /* non-prefetchable memory (3GB - 64KB) */
+			  0x81000000 0x00 0x00000000 0x1b 0xffff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
 	};
 
 	pcie@141a0000 {
@@ -1633,9 +1633,9 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x3a100000 0x0  0x3a100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc3000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
-			  0x82000000 0x0  0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
+		ranges = <0xc3000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
+			  0x82000000 0x00 0x40000000 0x1f 0x40000000 0x0 0xbfff0000   /* non-prefetchable memory (3GB - 64KB) */
+			  0x81000000 0x00 0x00000000 0x1f 0xffff0000 0x0 0x00010000>; /* downstream I/O (64KB) */
 	};
 
 	pcie_ep@14160000 {
-- 
2.17.1

