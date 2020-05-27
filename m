Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76DFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F6520899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590608219;
	bh=VVCdXP3NNPa4Va2mfBBQ2aGZhnDaopT3gzY7ZePkmeQ=;
	h=From:To:Subject:Date:List-ID:From;
	b=h79/1HZ0ef7TMww+ZCCQOO4O34KxNlbMcaSVNpIETdM84HKmOfuKq/V8JG0d0p76R
	 ALQDkENkqMkAaEEX6bQrma8wNdjgteVFqZfr3+WqmVI9DYZjQTORTX9jbUMla1fUSm
	 1sUaHmdwxYkECzA26bQYaCTUFMQJsr12Rx4X8Nn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgE0Tg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgE0Tg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:36:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25AD62088E;
        Wed, 27 May 2020 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590608218;
        bh=VVCdXP3NNPa4Va2mfBBQ2aGZhnDaopT3gzY7ZePkmeQ=;
        h=From:To:Subject:Date:From;
        b=j3eqKeYZUqe5PyYNz8sqv/XXe+Rcf9Pmp3chLAC4mvnUnDou/c4FgmH8819OEb+7S
         aqI58qpU2WLtsIIeM9cI3NjXr4UqL2FnLhmrpNLnd8CzCFutTLUB+un6dqbob8KRJl
         ktRepybTYbjLyxJnmoCSYerLNV6YP1eh31Goet58=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3 1/2] arm64: dts: tegra: Rename sysram node to "sram"
Date:   Wed, 27 May 2020 21:36:49 +0200
Message-Id: <20200527193650.17617-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node name should reflect generic class of a device so rename
the "sysram" node to "sram".  This will be also in sync with upcoming DT
schema.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 58100fb9cd8b..3ed7d7a26219 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1213,7 +1213,7 @@
 		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_GPU>;
 	};
 
-	sysram@30000000 {
+	sram@30000000 {
 		compatible = "nvidia,tegra186-sysram", "mmio-sram";
 		reg = <0x0 0x30000000 0x0 0x50000>;
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 4bc187a4eacd..0533c45b9237 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1737,7 +1737,7 @@
 		nvidia,aspm-l0s-entrance-latency-us = <3>;
 	};
 
-	sysram@40000000 {
+	sram@40000000 {
 		compatible = "nvidia,tegra194-sysram", "mmio-sram";
 		reg = <0x0 0x40000000 0x0 0x50000>;
 		#address-cells = <1>;
-- 
2.17.1

