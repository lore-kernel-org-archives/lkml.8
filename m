Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C9BC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E252D20872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PDsM7ei1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgH1BM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:12:58 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6772 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgH1BMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:12:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4859e40003>; Thu, 27 Aug 2020 18:12:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 18:12:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 27 Aug 2020 18:12:18 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 01:12:16 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 28 Aug 2020 01:12:16 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.4]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4859ee0000>; Thu, 27 Aug 2020 18:12:15 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH 10/12] arm64: tegra210/tegra186/tegra194: XUSB PADCTL irq
Date:   Fri, 28 Aug 2020 09:10:54 +0800
Message-ID: <20200828011056.1067559-11-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828011056.1067559-1-jckuo@nvidia.com>
References: <20200828011056.1067559-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598577124; bh=5xHfZPttdwW7Er6d1zUMfgP3rWvN2dNH9BKH/oThNWo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=PDsM7ei1l8uxxgf63WsYrPojptM5wjoH9ZWvjpUukakuZIXuE8wNWnBbhv/l8GJ1j
         yWlhR8VOX55VNXLxCSJzuSfbqTpL9Al0WlguVcJdg7yHbhEhvzop4pPZEHpSVVjN2N
         YI5562sjKcv0oMvZHSQLRdLqnFLjTVfGUIns8251u3t8ywixjS/F4N00/oP1JbwBCB
         zoRXDFOk3ZX5lGqy+x8veQ29It7mgIi7OYVTsiq4xHVQnHpV8BmnBq69z1Z9cQPRip
         4UkWj3IbO+bbKE0gQ8uQo5ygRW4x0D/5i46cYEQEHZd5q48SduYo4lIFim6UrSqkL+
         PvbbUipAxx4Eg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds "interrupts" property to Tegra210/Tegra186/Tegra194
XUSB PADCTL node. XUSB PADCTL interrupt will be raised when USB wake
event happens. This is required for supporting XUSB host controller
ELPG.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 1 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts=
/nvidia/tegra186.dtsi
index 34d249d85da7..454a857e5e56 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -466,6 +466,7 @@ padctl: padctl@3520000 {
 		reg =3D <0x0 0x03520000 0x0 0x1000>,
 		      <0x0 0x03540000 0x0 0x1000>;
 		reg-names =3D "padctl", "ao";
+		interrupts =3D <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
=20
 		resets =3D <&bpmp TEGRA186_RESET_XUSB_PADCTL>;
 		reset-names =3D "padctl";
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts=
/nvidia/tegra194.dtsi
index 48160f48003a..2b5216a34c06 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -561,6 +561,7 @@ xusb_padctl: padctl@3520000 {
 			reg =3D <0x03520000 0x1000>,
 			      <0x03540000 0x1000>;
 			reg-names =3D "padctl", "ao";
+			interrupts =3D <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
=20
 			resets =3D <&bpmp TEGRA194_RESET_XUSB_PADCTL>;
 			reset-names =3D "padctl";
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts=
/nvidia/tegra210.dtsi
index 67c90a0ea32e..2ba526779ee5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1041,6 +1041,7 @@ padctl: padctl@7009f000 {
 		resets =3D <&tegra_car 142>;
 		reset-names =3D "padctl";
 		nvidia,pmc =3D  <&tegra_pmc>;
+		interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
=20
 		status =3D "disabled";
=20
--=20
2.25.1

