Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A77C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CF120848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cF/jWvYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgBLGLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 01:11:46 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8031 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgBLGLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:11:46 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4397120000>; Tue, 11 Feb 2020 22:11:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 11 Feb 2020 22:11:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 11 Feb 2020 22:11:44 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Feb
 2020 06:11:44 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 12 Feb 2020 06:11:44 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.125]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e43971e0000>; Tue, 11 Feb 2020 22:11:44 -0800
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v6 3/5] dt-bindings: phy: tegra: Add Tegra194 support
Date:   Wed, 12 Feb 2020 14:11:31 +0800
Message-ID: <20200212061133.11665-4-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212061133.11665-1-jckuo@nvidia.com>
References: <20200212061133.11665-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581487890; bh=/bPsWm6lzrFeJllXyHhoDkwlj5b0xeQanPfCSz1aozk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=cF/jWvYH/VrYkealmiTYRYN1Y0j6ZvkQLQZ9T0Cr0bhfKnrrzMIpJ+76pUGxkhnyF
         DXU8bxMVGjEQRT8VX+H88RiYgbSuMe0l5OqpCCi3Ke08crA6gW1/VuA8dsD2hNf1KO
         jeJ1aa25pQ6CL7Yy/ffcTNotnMONzo963SNlE0L6gAnE0wLToo3BEoU0ZPNip5UCMA
         /c1tuoidxde4pBBPVWpFtQQk2EtWyzbc6rfaH0P2KiOdTdpn4t/5+Kq/jidqfStSoX
         QUnaURDf6yqp7q/HV8OdPT+8yNIghZzOdKYJTsgxQQwa2RkiTYuCy5ksMBMWSGD/Uc
         fR0CeManWf7Bg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the bindings to cover the set of features found in Tegra194.
Note that, technically, there are four more supplies connected to the
XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL)
, but the power sequencing requirements of Tegra194 require these to be
under the control of the PMIC.

Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it
is possible for some platforms have long signal trace that could not
provide sufficient electrical environment for Gen 2 speed. This patch
adds a "maximum-speed" property to usb3 ports which can be used to
specify the maximum supported speed for any particular USB 3.1 port.
For a port that is not capable of SuperSpeedPlus, "maximum-speed"
property should carry "super-speed".

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
Changes in v6: none
Changes in v5:
- re-use "maximum-speed" instead of adding "nvidia,disable-gen2"
Changes in v4: none
Changes in v3: none
Changes in v2:
- fix a typo

 .../phy/nvidia,tegra124-xusb-padctl.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
index 9fb682e47c29..7d0089006e67 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
@@ -37,6 +37,7 @@ Required properties:
   - Tegra132: "nvidia,tegra132-xusb-padctl", "nvidia,tegra124-xusb-padctl"
   - Tegra210: "nvidia,tegra210-xusb-padctl"
   - Tegra186: "nvidia,tegra186-xusb-padctl"
+  - Tegra194: "nvidia,tegra194-xusb-padctl"
 - reg: Physical base address and length of the controller's registers.
 - resets: Must contain an entry for each entry in reset-names.
 - reset-names: Must include the following entries:
@@ -62,6 +63,10 @@ For Tegra186:
 - vclamp-usb-supply: Bias rail for USB pad. Must supply 1.8 V.
 - vddio-hsic-supply: HSIC PHY power supply. Must supply 1.2 V.
 
+For Tegra194:
+- avdd-usb-supply: USB I/Os, VBUS, ID, REXT, D+/D- power supply. Must supply
+  3.3 V.
+- vclamp-usb-supply: Bias rail for USB pad. Must supply 1.8 V.
 
 Pad nodes:
 ==========
@@ -154,6 +159,11 @@ For Tegra210, the list of valid PHY nodes is given below:
 - sata: sata-0
   - functions: "usb3-ss", "sata"
 
+For Tegra194, the list of valid PHY nodes is given below:
+- usb2: usb2-0, usb2-1, usb2-2, usb2-3
+  - functions: "xusb"
+- usb3: usb3-0, usb3-1, usb3-2, usb3-3
+  - functions: "xusb"
 
 Port nodes:
 ===========
@@ -221,6 +231,11 @@ Optional properties:
   is internal. In the absence of this property the port is considered to be
   external.
 
+- maximum-speed: Only for Tegra194. A string property that specifies maximum
+  supported speed of a usb3 port. Valid values are:
+  - "super-speed-plus": default, the usb3 port supports USB 3.1 Gen 2 speed.
+  - "super-speed": the usb3 port supports USB 3.1 Gen 1 speed only.
+
 For Tegra124 and Tegra132, the XUSB pad controller exposes the following
 ports:
 - 3x USB2: usb2-0, usb2-1, usb2-2
@@ -233,6 +248,9 @@ For Tegra210, the XUSB pad controller exposes the following ports:
 - 2x HSIC: hsic-0, hsic-1
 - 4x super-speed USB: usb3-0, usb3-1, usb3-2, usb3-3
 
+For Tegra194, the XUSB pad controller exposes the following ports:
+- 4x USB2: usb2-0, usb2-1, usb2-2, usb2-3
+- 4x super-speed USB: usb3-0, usb3-1, usb3-2, usb3-3
 
 Examples:
 =========
-- 
2.17.1

