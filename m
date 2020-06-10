Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A29C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E1820835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SfrZUwq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgFJGCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:02:52 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11205 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFJGCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:02:45 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee077290002>; Tue, 09 Jun 2020 23:01:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 09 Jun 2020 23:02:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 09 Jun 2020 23:02:45 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Jun
 2020 06:02:45 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 10 Jun 2020 06:02:44 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.70]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ee077840000>; Tue, 09 Jun 2020 23:02:44 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <robh+dt@kernel.org>,
        <helen.koike@collabora.com>
CC:     <digetx@gmail.com>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>
Subject: [RFC PATCH v1 02/18] arm64: tegra: Add missing clocks and power-domains to Tegra210 VI I2C
Date:   Tue, 9 Jun 2020 23:02:24 -0700
Message-ID: <1591768960-31648-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591768960-31648-1-git-send-email-skomatineni@nvidia.com>
References: <1591768960-31648-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591768873; bh=aZpfEHCdQO79JYgaC0ZbsOUqg2JPUB+AZNA7nau630I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=SfrZUwq0QbUFnEh+2mW1hBfrysLvlhF6RwRmdezH1QkEG85lHpyROhUwiWDqf8W+r
         GSHBw33OCuWGt072Nnz8stoyMkm4/UsdmTELHQWpHGKepSOWdrA64J9OoHAnCNwxQn
         D2oswMmu2yF76RaSkKE9KZpwyPQ2lPR53JpZFJ6gh3F16O8XebkaOJ7ys5q/6IIeTH
         Qouz8I7d5qgwqaoeae4xKtSAPCPJteqyP1M2NFXlK1x3rC/R2oMqGS1WgbQzI+xflS
         O5RXCIlXaBcckNbC1AfFoW4P8EKdB5rTIodjA2wCDTFiD8Un8yNoUdC0FYeyd1TJQN
         MT7oWQNjPtAlg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 VI I2C is in VE power domain and i2c-vi node should have
power-domains property.

Current Tegra210 i2c-vi device node is missing both VI I2C clocks
and power-domains property.

This patch adds them.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 0865508..3a4ed10 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -376,6 +376,12 @@
 			compatible = "nvidia,tegra210-i2c-vi";
 			reg = <0x0 0x546c0000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA210_CLK_VI_I2C>,
+				 <&tegra_car TEGRA210_CLK_I2CSLOW>;
+			clock-names = "div-clk", "slow";
+			resets = <&tegra_car TEGRA210_CLK_VI_I2C>;
+			reset-names = "i2c";
+			power-domains = <&pd_venc>;
 			status = "disabled";
 		};
 	};
-- 
2.7.4

