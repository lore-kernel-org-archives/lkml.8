Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52445C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4082080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EaGv/boa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgBJINQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:13:16 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3752 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgBJINO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:13:14 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e41105b000e>; Mon, 10 Feb 2020 00:12:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 10 Feb 2020 00:13:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 10 Feb 2020 00:13:14 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Feb
 2020 08:13:13 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 10 Feb 2020 08:13:13 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e4110960000>; Mon, 10 Feb 2020 00:13:13 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V5 14/21] arm64: tegra: update OTG port entries for jetson-tx2
Date:   Mon, 10 Feb 2020 13:41:40 +0530
Message-ID: <1581322307-11140-15-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581322331; bh=1mOqK38ps+hsD+Ul8Gk7rLKw6ywaAU5LTrr/1IVxF7M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=EaGv/boab6DONdtsB7oIlmTK1PjiTqzbp8Zj9NmeSNWVmUEe1XwyWsMRvGZbLqjxT
         cdnCp/HJQ8g/nggLn6Cytemy12yjbidYPWLJPcq7KMhDeoEjXuiI5CjJHWSbcHbKT+
         Akswf86SCYatbJpgWp+8sC7+58E0rDoT90rX3fD4voMFn3RPIz3EMigPwyszWymEvm
         QCuJKR3KpPnprcCFD1myoFTe6vTmYlxrQaggZriNrNIvYja3Puh21aqy6KTWRaOt/V
         wOCc8ZhSANPL7oi2CCPauKLKgjp47OgWXbFKJ6z0uMUoSvkmyh5zwJD1yTlseXPxnE
         GhAOXvCoxsRqQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb-role-switch entry to OTG usb port and add corresponding connector
details.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2-V5:
 - No changes in this version
---
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index f1de4ff..a1dcdb9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -174,8 +174,20 @@
 			usb2-0 {
 				status = "okay";
 				mode = "otg";
-
 				vbus-supply = <&vdd_usb0>;
+
+				usb-role-switch;
+				connector {
+					compatible = "usb-b-connector",
+						     "gpio-usb-b-connector";
+					label = "micro-USB";
+					type = "micro";
+					vbus-gpio = <&gpio
+						     TEGRA186_MAIN_GPIO(X, 7)
+						     GPIO_ACTIVE_LOW>;
+					id-gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
+				};
+
 			};
 
 			usb2-1 {
-- 
2.7.4

