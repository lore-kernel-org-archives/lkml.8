Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2AAC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BEC2206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AqUT1+BC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgHaElm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:41:42 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9187 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgHaEkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:40:53 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4c7f460004>; Sun, 30 Aug 2020 21:40:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 30 Aug 2020 21:40:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 30 Aug 2020 21:40:52 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 04:40:48 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 31 Aug 2020 04:40:48 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.4]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4c7f4e0001>; Sun, 30 Aug 2020 21:40:47 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v2 07/12] arm64: tegra210: XUSB PADCTL add "nvidia,pmc" prop
Date:   Mon, 31 Aug 2020 12:40:38 +0800
Message-ID: <20200831044043.1561074-8-jckuo@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831044043.1561074-1-jckuo@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598848839; bh=ULNJL432P9gTH+qGQQEOhfds0zQ9eDoNC9eYcP0k/AM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=AqUT1+BC3oYARfTzbnBbwwsHBQi2GGPSieXZurEq2/+IcH9G5ubmtn0G8HBgiB+4n
         R8nzs34J+a70PoJPWotoMSL4j5MLbBCdQikUSo1xrDko7ugOWCl3FolZaUlF5CAUZj
         2jTcHiWu62jtNxr6qLrSMC1ZcHHyh+gxGrpW+wMcLBXdJy15YobPdW90I8zVIcldat
         iWhhIzRzGpCJy23w7dNJmxuWDnNhqQjtYtb11qMb0YxTbol4b3o2Ww9CzIpSYNTBfd
         PT+5cgeqJ6tTQ6cO2sesWn++tjOKNdvTs8/zGzeNvbioslIRwdQYuGqGRmT50bW3qM
         k4VlaWwF1yK7Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMC driver provides USB sleepwalk registers access to XUSB PADCTL
driver. This commit adds a "nvidia,pmc" property which points to
PMC node to XUSB PADCTL device node.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts=
/nvidia/tegra210.dtsi
index 829f786af133..67c90a0ea32e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1040,6 +1040,7 @@ padctl: padctl@7009f000 {
 		reg =3D <0x0 0x7009f000 0x0 0x1000>;
 		resets =3D <&tegra_car 142>;
 		reset-names =3D "padctl";
+		nvidia,pmc =3D  <&tegra_pmc>;
=20
 		status =3D "disabled";
=20
--=20
2.25.1

